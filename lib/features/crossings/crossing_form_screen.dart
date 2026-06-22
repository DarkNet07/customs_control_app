import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../core/auth/lock_controller.dart';
import '../../core/images/image_service.dart';
import '../../core/l10n/l10n.dart';
import '../../core/location/location_service.dart';
import '../../core/widgets/flag_icon.dart';
import '../../core/plate/plate_formats.dart';
import '../../core/providers.dart';
import '../../core/widgets/text_input_dialog.dart';

/// Mutable state for one cargo line in the form.
class _CargoEntry {
  _CargoEntry({this.cargoTypeId, String quantity = '', String unit = ''})
      : qty = TextEditingController(text: quantity),
        unit = TextEditingController(text: unit);

  int? cargoTypeId;
  final TextEditingController qty;
  final TextEditingController unit;

  void dispose() {
    qty.dispose();
    unit.dispose();
  }
}

class CrossingFormScreen extends ConsumerStatefulWidget {
  const CrossingFormScreen({super.key, this.id});

  final int? id;

  @override
  ConsumerState<CrossingFormScreen> createState() => _CrossingFormScreenState();
}

class _CrossingFormScreenState extends ConsumerState<CrossingFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _plateController = TextEditingController();
  final _noteController = TextEditingController();

  bool _noPlate = false;
  String _country = 'uz';
  late PlateFormat _format = PlateFormats.forCountry('uz').first;
  late MaskTextInputFormatter _maskFormatter = _format.buildFormatter();

  int? _companyId;
  int? _makeId;
  int? _modelId;
  final List<_CargoEntry> _cargos = [_CargoEntry()];
  DateTime _crossedAt = DateTime.now();
  final List<StoredPhoto> _photos = [];
  double? _lat;
  double? _lng;
  bool _locating = false;

  bool _loading = false;
  bool get _isEdit => widget.id != null;

  @override
  void initState() {
    super.initState();
    if (_isEdit) {
      _prefill();
    } else {
      // Auto-capture location for a new record (best-effort).
      WidgetsBinding.instance.addPostFrameCallback((_) => _captureLocation());
    }
  }

  Future<void> _prefill() async {
    setState(() => _loading = true);
    final view = await ref.read(crossingRepositoryProvider).getById(widget.id!);
    if (view == null || !mounted) {
      setState(() => _loading = false);
      return;
    }
    final c = view.crossing;
    _noPlate = c.plateNumber == null;
    _country = c.plateCountry ?? 'uz';
    _format = PlateFormats.byKey(c.plateFormatKey ?? PlateFormats.all.first.key);
    _maskFormatter = _format.buildFormatter();
    _plateController.text = c.plateNumber ?? '';
    _companyId = c.companyId;
    _makeId = c.makeId;
    _modelId = c.modelId;
    _crossedAt = c.crossedAt;
    _lat = c.latitude;
    _lng = c.longitude;
    if (view.cargos.isNotEmpty) {
      for (final e in _cargos) {
        e.dispose();
      }
      _cargos
        ..clear()
        ..addAll(view.cargos.map((cg) => _CargoEntry(
              cargoTypeId: cg.cargoTypeId,
              quantity: _numStr(cg.quantity),
              unit: cg.unit ?? '',
            )));
    }
    _noteController.text = c.note ?? '';
    for (final p in view.photos) {
      _photos.add((filePath: p.filePath, thumbPath: p.thumbPath));
    }
    setState(() => _loading = false);
  }

  static String _numStr(double? v) {
    if (v == null) return '';
    return v == v.roundToDouble() ? v.toStringAsFixed(0) : '$v';
  }

  @override
  void dispose() {
    _plateController.dispose();
    _noteController.dispose();
    for (final e in _cargos) {
      e.dispose();
    }
    super.dispose();
  }

  void _onCountryChanged(String country) {
    setState(() {
      _country = country;
      _format = PlateFormats.forCountry(country).first;
      _maskFormatter = _format.buildFormatter();
      _plateController.clear();
    });
  }

  void _onFormatChanged(PlateFormat format) {
    setState(() {
      _format = format;
      _maskFormatter = format.buildFormatter();
      _plateController.clear();
    });
  }

  Future<void> _addPhotoFromCamera() async {
    final lock = ref.read(lockProvider.notifier);
    lock.suspendAutoLock();
    try {
      final photo = await ref.read(imageServiceProvider).captureFromCamera();
      if (photo != null) setState(() => _photos.add(photo));
    } finally {
      lock.resumeAutoLock();
    }
  }

  Future<void> _addPhotosFromGallery() async {
    final lock = ref.read(lockProvider.notifier);
    lock.suspendAutoLock();
    try {
      final photos = await ref.read(imageServiceProvider).pickFromGallery();
      if (photos.isNotEmpty) setState(() => _photos.addAll(photos));
    } finally {
      lock.resumeAutoLock();
    }
  }

  Future<void> _captureLocation() async {
    if (_locating) return;
    setState(() => _locating = true);
    final service = ref.read(locationServiceProvider);
    final lock = ref.read(lockProvider.notifier);
    lock.suspendAutoLock(); // permission dialog backgrounds the app
    try {
      final result = await service.current();
      if (!mounted) return;
      if (result.point != null) {
        setState(() {
          _lat = result.point!.lat;
          _lng = result.point!.lng;
        });
      } else if (result.status == LocationStatus.deniedForever) {
        _showLocationHint(
          context.l10n.locationUnavailable,
          context.l10n.openSettings,
          service.openAppSettings,
        );
      } else if (result.status == LocationStatus.serviceDisabled) {
        _showLocationHint(
          context.l10n.locationUnavailable,
          context.l10n.openSettings,
          service.openLocationSettings,
        );
      }
    } finally {
      lock.resumeAutoLock();
      if (mounted) setState(() => _locating = false);
    }
  }

  void _showLocationHint(String message, String action, VoidCallback onAction) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        action: SnackBarAction(label: action, onPressed: onAction),
      ),
    );
  }

  Future<void> _pickDateTime() async {
    final date = await showDatePicker(
      context: context,
      initialDate: _crossedAt,
      firstDate: DateTime(2020),
      lastDate: DateTime.now().add(const Duration(days: 1)),
    );
    if (date == null || !mounted) return;
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(_crossedAt),
    );
    if (time == null) return;
    setState(() {
      _crossedAt = DateTime(
        date.year,
        date.month,
        date.day,
        time.hour,
        time.minute,
      );
    });
  }

  Future<void> _save() async {
    final l10n = context.l10n;
    if (!_formKey.currentState!.validate()) return;
    final cargos = [
      for (final e in _cargos)
        if (e.cargoTypeId != null)
          CargoInput(
            cargoTypeId: e.cargoTypeId!,
            quantity: double.tryParse(e.qty.text.replaceAll(',', '.')),
            unit: e.unit.text.trim().isEmpty ? null : e.unit.text.trim(),
          ),
    ];
    if (_companyId == null || _makeId == null || cargos.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(l10n.fieldRequired)));
      return;
    }
    final input = CrossingInput(
      companyId: _companyId!,
      plateNumber: _noPlate ? null : _plateController.text,
      plateCountry: _noPlate ? null : _country,
      plateFormatKey: _noPlate ? null : _format.key,
      makeId: _makeId!,
      modelId: _modelId,
      cargos: cargos,
      crossedAt: _crossedAt,
      note: _noteController.text.trim().isEmpty
          ? null
          : _noteController.text.trim(),
      latitude: _lat,
      longitude: _lng,
      photoPaths: _photos,
    );
    final repo = ref.read(crossingRepositoryProvider);
    if (_isEdit) {
      await repo.update(widget.id!, input);
    } else {
      await repo.create(input);
    }
    if (mounted) context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    if (_loading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEdit ? l10n.editCrossing : l10n.addCrossing),
        actions: [TextButton(onPressed: _save, child: Text(l10n.save))],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _companyField(l10n),
            const SizedBox(height: 16),
            _plateSection(l10n),
            const SizedBox(height: 16),
            _makeField(l10n),
            const SizedBox(height: 16),
            _modelField(l10n),
            const SizedBox(height: 16),
            _cargoSection(l10n),
            const SizedBox(height: 16),
            _dateField(l10n),
            const SizedBox(height: 16),
            TextFormField(
              controller: _noteController,
              decoration: InputDecoration(
                labelText: l10n.note,
                border: const OutlineInputBorder(),
              ),
              maxLines: 2,
            ),
            const SizedBox(height: 16),
            _locationSection(l10n),
            const SizedBox(height: 16),
            _photoSection(l10n),
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }

  Widget _companyField(AppLocalizations l10n) {
    final companies = ref.watch(companiesProvider);
    return companies.when(
      loading: () => const LinearProgressIndicator(),
      error: (e, _) => Text('$e'),
      data: (list) {
        final selected = list.any((c) => c.id == _companyId)
            ? _companyId
            : null;
        return Row(
          children: [
            Expanded(
              child: DropdownButtonFormField<int>(
                key: ValueKey('company-$selected'),
                initialValue: selected,
                isExpanded: true,
                decoration: InputDecoration(
                  labelText: l10n.company,
                  border: const OutlineInputBorder(),
                ),
                items: [
                  for (final c in list)
                    DropdownMenuItem(value: c.id, child: Text(c.name)),
                ],
                onChanged: (v) => setState(() => _companyId = v),
                validator: (v) => v == null ? l10n.fieldRequired : null,
              ),
            ),
            IconButton(
              icon: const Icon(Icons.add_circle_outline),
              tooltip: l10n.addCompanyTitle,
              onPressed: () async {
                final name = await showTextInputDialog(
                  context,
                  title: l10n.addCompanyTitle,
                );
                if (name == null) return;
                final id = await ref.read(companyRepositoryProvider).add(name);
                setState(() => _companyId = id);
              },
            ),
          ],
        );
      },
    );
  }

  Widget _plateSection(AppLocalizations l10n) {
    final formats = PlateFormats.forCountry(_country);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(l10n.noPlateToggle),
          value: _noPlate,
          onChanged: (v) => setState(() => _noPlate = v),
        ),
        if (_noPlate)
          const SizedBox.shrink()
        else ...[
        Row(
          children: [
            Expanded(
              child: SegmentedButton<String>(
                segments: [
                  ButtonSegment(
                    value: 'uz',
                    label: Text(l10n.uzbekistan),
                    icon: const FlagIcon('uz', width: 24),
                  ),
                  ButtonSegment(
                    value: 'tj',
                    label: Text(l10n.tajikistan),
                    icon: const FlagIcon('tj', width: 24),
                  ),
                ],
                selected: {_country},
                onSelectionChanged: (s) => _onCountryChanged(s.first),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        if (formats.length > 1)
          DropdownButtonFormField<String>(
            initialValue: _format.key,
            decoration: InputDecoration(
              labelText: l10n.plateFormat,
              border: const OutlineInputBorder(),
            ),
            items: [
              for (final f in formats)
                DropdownMenuItem(value: f.key, child: Text(f.label)),
            ],
            onChanged: (v) =>
                v == null ? null : _onFormatChanged(PlateFormats.byKey(v)),
          ),
        if (formats.length > 1) const SizedBox(height: 8),
        TextFormField(
          controller: _plateController,
          inputFormatters: [_maskFormatter],
          textCapitalization: TextCapitalization.characters,
          decoration: InputDecoration(
            labelText: l10n.plateNumber,
            hintText: _format.label,
            border: const OutlineInputBorder(),
            // UZ flag on the right, TJ flag on the left — как на реальных номерах.
            prefixIcon: _country == 'tj'
                ? const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: FlagIcon('tj', width: 26),
                  )
                : null,
            prefixIconConstraints: const BoxConstraints(
              minWidth: 0,
              minHeight: 0,
            ),
            suffixIcon: _country == 'uz'
                ? const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: FlagIcon('uz', width: 26),
                  )
                : null,
            suffixIconConstraints: const BoxConstraints(
              minWidth: 0,
              minHeight: 0,
            ),
          ),
          validator: (v) {
            if (v == null || v.trim().isEmpty) return l10n.fieldRequired;
            if (!_format.isValid(v)) return l10n.invalidPlate;
            return null;
          },
        ),
        ],
      ],
    );
  }

  Widget _makeField(AppLocalizations l10n) {
    final makes = ref.watch(makesProvider);
    return makes.when(
      loading: () => const LinearProgressIndicator(),
      error: (e, _) => Text('$e'),
      data: (list) {
        final selected = list.any((m) => m.id == _makeId) ? _makeId : null;
        return Row(
          children: [
            Expanded(
              child: DropdownButtonFormField<int>(
                key: ValueKey('make-$selected'),
                initialValue: selected,
                isExpanded: true,
                decoration: InputDecoration(
                  labelText: l10n.vehicleMake,
                  border: const OutlineInputBorder(),
                ),
                items: [
                  for (final m in list)
                    DropdownMenuItem(value: m.id, child: Text(m.name)),
                ],
                onChanged: (v) => setState(() {
                  _makeId = v;
                  _modelId = null;
                }),
                validator: (v) => v == null ? l10n.fieldRequired : null,
              ),
            ),
            IconButton(
              icon: const Icon(Icons.add_circle_outline),
              tooltip: l10n.addMakeTitle,
              onPressed: () async {
                final name = await showTextInputDialog(
                  context,
                  title: l10n.addMakeTitle,
                );
                if (name == null) return;
                final id = await ref
                    .read(dictionaryRepositoryProvider)
                    .addMake(name);
                setState(() {
                  _makeId = id;
                  _modelId = null;
                });
              },
            ),
          ],
        );
      },
    );
  }

  Widget _modelField(AppLocalizations l10n) {
    if (_makeId == null) {
      return DropdownButtonFormField<int>(
        decoration: InputDecoration(
          labelText: l10n.vehicleModel,
          border: const OutlineInputBorder(),
          enabled: false,
        ),
        items: const [],
        onChanged: null,
      );
    }
    final models = ref.watch(modelsProvider(_makeId!));
    return models.when(
      loading: () => const LinearProgressIndicator(),
      error: (e, _) => Text('$e'),
      data: (list) {
        final selected = list.any((m) => m.id == _modelId) ? _modelId : null;
        return Row(
          children: [
            Expanded(
              child: DropdownButtonFormField<int>(
                key: ValueKey('model-$selected'),
                initialValue: selected,
                isExpanded: true,
                decoration: InputDecoration(
                  labelText: l10n.vehicleModel,
                  border: const OutlineInputBorder(),
                ),
                items: [
                  for (final m in list)
                    DropdownMenuItem(value: m.id, child: Text(m.name)),
                ],
                onChanged: (v) => setState(() => _modelId = v),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.add_circle_outline),
              tooltip: l10n.addModelTitle,
              onPressed: () async {
                final name = await showTextInputDialog(
                  context,
                  title: l10n.addModelTitle,
                  hint: l10n.addModelHint,
                );
                if (name == null) return;
                final id = await ref
                    .read(dictionaryRepositoryProvider)
                    .addModel(_makeId!, name);
                setState(() => _modelId = id);
              },
            ),
          ],
        );
      },
    );
  }

  Widget _cargoSection(AppLocalizations l10n) {
    final cargoTypes = ref.watch(cargoTypesProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(l10n.cargoList, style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        cargoTypes.when(
          loading: () => const LinearProgressIndicator(),
          error: (e, _) => Text('$e'),
          data: (list) => Column(
            children: [
              for (var i = 0; i < _cargos.length; i++)
                _cargoEntryRow(l10n, list, i),
            ],
          ),
        ),
        const SizedBox(height: 4),
        Align(
          alignment: Alignment.centerLeft,
          child: TextButton.icon(
            icon: const Icon(Icons.add),
            label: Text(l10n.addCargo),
            onPressed: () => setState(() => _cargos.add(_CargoEntry())),
          ),
        ),
      ],
    );
  }

  Widget _cargoEntryRow(AppLocalizations l10n, List list, int index) {
    final entry = _cargos[index];
    final selected =
        list.any((c) => c.id == entry.cargoTypeId) ? entry.cargoTypeId : null;
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: DropdownButtonFormField<int>(
                  key: ValueKey('cargo-$index-$selected'),
                  initialValue: selected,
                  isExpanded: true,
                  decoration: InputDecoration(
                    labelText: l10n.cargoType,
                    border: const OutlineInputBorder(),
                  ),
                  items: [
                    for (final c in list)
                      DropdownMenuItem(value: c.id, child: Text(c.name)),
                  ],
                  onChanged: (v) => setState(() => entry.cargoTypeId = v),
                  validator: (v) => v == null ? l10n.fieldRequired : null,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.add_circle_outline),
                tooltip: l10n.addCargoTypeTitle,
                onPressed: () async {
                  final name = await showTextInputDialog(
                    context,
                    title: l10n.addCargoTypeTitle,
                  );
                  if (name == null) return;
                  final id = await ref
                      .read(dictionaryRepositoryProvider)
                      .addCargoType(name);
                  setState(() => entry.cargoTypeId = id);
                },
              ),
              if (_cargos.length > 1)
                IconButton(
                  icon: const Icon(Icons.delete_outline),
                  tooltip: l10n.delete,
                  onPressed: () => setState(() {
                    _cargos.removeAt(index).dispose();
                  }),
                ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: TextFormField(
                  controller: entry.qty,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(
                    labelText: '${l10n.cargoQuantity} (${l10n.optional})',
                    border: const OutlineInputBorder(),
                    isDense: true,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: TextFormField(
                  controller: entry.unit,
                  decoration: InputDecoration(
                    labelText: l10n.quantityUnit,
                    border: const OutlineInputBorder(),
                    isDense: true,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _dateField(AppLocalizations l10n) {
    final df = DateFormat('dd.MM.yyyy HH:mm');
    return InkWell(
      onTap: _pickDateTime,
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: l10n.crossedAt,
          border: const OutlineInputBorder(),
          suffixIcon: const Icon(Icons.calendar_today),
        ),
        child: Text(df.format(_crossedAt)),
      ),
    );
  }

  Widget _locationSection(AppLocalizations l10n) {
    final hasPoint = _lat != null && _lng != null;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(l10n.location, style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        Row(
          children: [
            Icon(
              hasPoint ? Icons.location_on : Icons.location_off,
              color: hasPoint
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).disabledColor,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                _locating
                    ? '…'
                    : hasPoint
                        ? '${_lat!.toStringAsFixed(6)}, ${_lng!.toStringAsFixed(6)}'
                        : l10n.locationUnavailable,
              ),
            ),
            if (_locating)
              const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            else ...[
              IconButton(
                tooltip: l10n.captureLocation,
                icon: const Icon(Icons.my_location),
                onPressed: _captureLocation,
              ),
              if (hasPoint)
                IconButton(
                  tooltip: l10n.clear,
                  icon: const Icon(Icons.clear),
                  onPressed: () => setState(() {
                    _lat = null;
                    _lng = null;
                  }),
                ),
            ],
          ],
        ),
      ],
    );
  }

  Widget _photoSection(AppLocalizations l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(l10n.photos, style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        Row(
          children: [
            OutlinedButton.icon(
              icon: const Icon(Icons.camera_alt),
              label: Text(l10n.takePhoto),
              onPressed: _addPhotoFromCamera,
            ),
            const SizedBox(width: 8),
            OutlinedButton.icon(
              icon: const Icon(Icons.photo_library),
              label: Text(l10n.pickFromGallery),
              onPressed: _addPhotosFromGallery,
            ),
          ],
        ),
        const SizedBox(height: 8),
        if (_photos.isNotEmpty)
          SizedBox(
            height: 96,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: _photos.length,
              separatorBuilder: (_, _) => const SizedBox(width: 8),
              itemBuilder: (_, i) {
                final ph = _photos[i];
                return Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.file(
                        File(ph.thumbPath),
                        width: 96,
                        height: 96,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      right: 0,
                      top: 0,
                      child: IconButton(
                        icon: const Icon(Icons.cancel, color: Colors.white),
                        onPressed: () => setState(() => _photos.removeAt(i)),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
      ],
    );
  }
}
