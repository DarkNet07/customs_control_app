import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../core/auth/lock_controller.dart';
import '../../core/images/image_service.dart';
import '../../core/l10n/l10n.dart';
import '../../core/widgets/flag_icon.dart';
import '../../core/plate/plate_formats.dart';
import '../../core/providers.dart';
import '../../core/widgets/text_input_dialog.dart';

class CrossingFormScreen extends ConsumerStatefulWidget {
  const CrossingFormScreen({super.key, this.id});

  final int? id;

  @override
  ConsumerState<CrossingFormScreen> createState() => _CrossingFormScreenState();
}

class _CrossingFormScreenState extends ConsumerState<CrossingFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _plateController = TextEditingController();
  final _quantityController = TextEditingController();
  final _unitController = TextEditingController();
  final _noteController = TextEditingController();

  String _country = 'uz';
  late PlateFormat _format = PlateFormats.forCountry('uz').first;
  late MaskTextInputFormatter _maskFormatter = _format.buildFormatter();

  int? _companyId;
  int? _makeId;
  int? _modelId;
  int? _cargoTypeId;
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
    _country = c.plateCountry;
    _format = PlateFormats.byKey(c.plateFormatKey);
    _maskFormatter = _format.buildFormatter();
    _plateController.text = c.plateNumber;
    _companyId = c.companyId;
    _makeId = c.makeId;
    _modelId = c.modelId;
    _cargoTypeId = c.cargoTypeId;
    _crossedAt = c.crossedAt;
    _lat = c.latitude;
    _lng = c.longitude;
    _quantityController.text = c.cargoQuantity?.toString() ?? '';
    _unitController.text = c.quantityUnit ?? '';
    _noteController.text = c.note ?? '';
    for (final p in view.photos) {
      _photos.add((filePath: p.filePath, thumbPath: p.thumbPath));
    }
    setState(() => _loading = false);
  }

  @override
  void dispose() {
    _plateController.dispose();
    _quantityController.dispose();
    _unitController.dispose();
    _noteController.dispose();
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
    final lock = ref.read(lockProvider.notifier);
    lock.suspendAutoLock(); // permission dialog backgrounds the app
    try {
      final point = await ref.read(locationServiceProvider).current();
      if (point != null && mounted) {
        setState(() {
          _lat = point.lat;
          _lng = point.lng;
        });
      }
    } finally {
      lock.resumeAutoLock();
      if (mounted) setState(() => _locating = false);
    }
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
    if (_companyId == null || _makeId == null || _cargoTypeId == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(l10n.fieldRequired)));
      return;
    }
    final input = CrossingInput(
      companyId: _companyId!,
      plateNumber: _plateController.text,
      plateCountry: _country,
      plateFormatKey: _format.key,
      makeId: _makeId!,
      modelId: _modelId,
      cargoTypeId: _cargoTypeId!,
      crossedAt: _crossedAt,
      cargoQuantity: double.tryParse(
        _quantityController.text.replaceAll(',', '.'),
      ),
      quantityUnit: _unitController.text.trim().isEmpty
          ? null
          : _unitController.text.trim(),
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
            _cargoTypeField(l10n),
            const SizedBox(height: 16),
            _quantityRow(l10n),
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

  Widget _cargoTypeField(AppLocalizations l10n) {
    final cargo = ref.watch(cargoTypesProvider);
    return cargo.when(
      loading: () => const LinearProgressIndicator(),
      error: (e, _) => Text('$e'),
      data: (list) {
        final selected = list.any((c) => c.id == _cargoTypeId)
            ? _cargoTypeId
            : null;
        return Row(
          children: [
            Expanded(
              child: DropdownButtonFormField<int>(
                key: ValueKey('cargo-$selected'),
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
                onChanged: (v) => setState(() => _cargoTypeId = v),
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
                setState(() => _cargoTypeId = id);
              },
            ),
          ],
        );
      },
    );
  }

  Widget _quantityRow(AppLocalizations l10n) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: TextFormField(
            controller: _quantityController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(
              labelText: '${l10n.cargoQuantity} (${l10n.optional})',
              border: const OutlineInputBorder(),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: TextFormField(
            controller: _unitController,
            decoration: InputDecoration(
              labelText: l10n.quantityUnit,
              border: const OutlineInputBorder(),
            ),
          ),
        ),
      ],
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
