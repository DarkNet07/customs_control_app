import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../core/db/app_database.dart';
import '../../core/l10n/l10n.dart';
import '../../core/providers.dart';
import '../../core/widgets/flag_icon.dart';
import 'widgets/photo_viewer.dart';
import 'widgets/plate_label.dart';

final _detailProvider = FutureProvider.family.autoDispose((ref, int id) async {
  // Re-fetch when crossings change.
  ref.watch(crossingsProvider);
  final view = await ref.watch(crossingRepositoryProvider).getById(id);
  final history = await ref.watch(crossingRepositoryProvider).history(id);
  return (view: view, history: history);
});

class CrossingDetailScreen extends ConsumerWidget {
  const CrossingDetailScreen({super.key, required this.id});

  final int id;

  Future<void> _confirmDelete(BuildContext context, WidgetRef ref) async {
    final l10n = context.l10n;
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.deleteWarningTitle),
        content: Text(l10n.deleteWarningBody),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: Text(l10n.cancel),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(ctx).colorScheme.error,
            ),
            onPressed: () => Navigator.of(ctx).pop(true),
            child: Text(l10n.delete),
          ),
        ],
      ),
    );
    if (ok != true) return;
    await ref.read(crossingRepositoryProvider).softDelete(id);
    if (context.mounted) context.pop();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final async = ref.watch(_detailProvider(id));
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.appTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => context.push('/crossing/$id/edit'),
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline),
            onPressed: () => _confirmDelete(context, ref),
          ),
        ],
      ),
      body: async.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('$e')),
        data: (data) {
          final view = data.view;
          if (view == null) return Center(child: Text(l10n.noData));
          return _Body(view: view, history: data.history);
        },
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({required this.view, required this.history});

  final CrossingView view;
  final List<ChangeHistoryData> history;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final c = view.crossing;
    final df = DateFormat('dd.MM.yyyy HH:mm');
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        if (view.photos.isNotEmpty)
          SizedBox(
            height: 200,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: view.photos.length,
              separatorBuilder: (_, _) => const SizedBox(width: 8),
              itemBuilder: (context, i) {
                final f = File(view.photos[i].filePath);
                return GestureDetector(
                  onTap: () => PhotoViewerScreen.open(
                    context,
                    view.photos.map((p) => p.filePath).toList(),
                    i,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: f.existsSync()
                        ? Image.file(f, fit: BoxFit.cover)
                        : const SizedBox(width: 200),
                  ),
                );
              },
            ),
          ),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 130,
                child: Text(
                  l10n.plateNumber,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
              Expanded(
                child: PlateLabel(
                  plateNumber: c.plateNumber,
                  country: c.plateCountry,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
            ],
          ),
        ),
        _row(context, l10n.company, view.companyName),
        _row(context, l10n.vehicleMake, view.vehicleLabel),
        _row(context, l10n.cargoType, view.cargoTypeName),
        if (c.cargoQuantity != null)
          _row(
            context,
            l10n.cargoQuantity,
            '${c.cargoQuantity} ${c.quantityUnit ?? ''}'.trim(),
          ),
        _row(context, l10n.crossedAt, df.format(c.crossedAt)),
        if (c.note != null && c.note!.isNotEmpty)
          _row(context, l10n.note, c.note!),
        const Divider(height: 32),
        Text(l10n.history, style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        for (final h in history) _HistoryTile(entry: h),
      ],
    );
  }

  Widget _row(BuildContext context, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 130,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}

class _HistoryTile extends StatelessWidget {
  const _HistoryTile({required this.entry});

  final ChangeHistoryData entry;

  String _fieldLabel(AppLocalizations l10n, String key) => switch (key) {
    'plateNumber' => l10n.plateNumber,
    'plateCountry' => l10n.plateCountry,
    'company' => l10n.company,
    'vehicle' => l10n.vehicleMake,
    'cargoType' => l10n.cargoType,
    'cargoQuantity' => l10n.cargoQuantity,
    'quantityUnit' => l10n.quantityUnit,
    'crossedAt' => l10n.crossedAt,
    'note' => l10n.note,
    'photos' => l10n.photos,
    _ => key,
  };

  String _fieldValue(String key, Object? value) {
    if (value == null) return '—';
    if (key == 'crossedAt') {
      final dt = DateTime.tryParse('$value');
      if (dt != null) return DateFormat('dd.MM.yyyy HH:mm').format(dt);
    }
    return '$value';
  }

  /// A single value chip: plate shows flag + number (без Flexible, чтобы можно
  /// было класть в Wrap), остальные — обычный текст.
  Widget _value(String key, Object? value, String country) {
    if (key == 'plateNumber' && value != null) {
      final flag = FlagIcon(country, width: 18);
      final txt = Text(
        '$value',
        style: const TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.2),
      );
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: country == 'tj'
            ? [flag, const SizedBox(width: 5), txt]
            : [txt, const SizedBox(width: 5), flag],
      );
    }
    return Text(_fieldValue(key, value));
  }

  /// One changed field on a single line: "label | from → to"
  /// (or "label | to" on create). Двухколоночная раскладка как у остальных строк.
  Widget _changeRow(
    BuildContext context,
    AppLocalizations l10n,
    String key,
    Map<String, dynamic> change,
    String country,
  ) {
    final from = change['from'];
    final to = change['to'];
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              '${_fieldLabel(l10n, key)}:',
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          Expanded(
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 6,
              runSpacing: 2,
              children: [
                if (from != null) ...[
                  _value(key, from, country),
                  const Icon(Icons.arrow_forward, size: 16),
                ],
                _value(key, to, country),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final df = DateFormat('dd.MM.yyyy HH:mm');
    final label = switch (entry.changeType) {
      'create' => l10n.changeCreate,
      'update' => l10n.changeUpdate,
      'delete' => l10n.changeDelete,
      _ => entry.changeType,
    };
    final icon = switch (entry.changeType) {
      'create' => Icons.add_circle_outline,
      'update' => Icons.edit_outlined,
      'delete' => Icons.delete_outline,
      _ => Icons.history,
    };
    Map<String, dynamic> snap = {};
    try {
      snap = jsonDecode(entry.snapshotJson) as Map<String, dynamic>;
    } catch (_) {}
    final country = (snap['plateCountry'] as String?) ?? 'uz';
    final changes = (snap['changes'] as Map?)?.cast<String, dynamic>();
    return Card(
      child: ExpansionTile(
        leading: Icon(icon),
        title: Text(label),
        subtitle: Text(df.format(entry.changedAt)),
        expandedCrossAxisAlignment: CrossAxisAlignment.start,
        childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
        children: changes != null
            ? [
                if (changes.isEmpty)
                  const SizedBox.shrink()
                else
                  for (final e in changes.entries)
                    _changeRow(
                      context,
                      l10n,
                      e.key,
                      (e.value as Map).cast<String, dynamic>(),
                      country,
                    ),
              ]
            : [
                // Backward compatibility: old flat-snapshot entries.
                for (final e in snap.entries)
                  if (e.key != 'plateCountry')
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 100,
                            child: Text(
                              '${_fieldLabel(l10n, e.key)}:',
                              maxLines: 1,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                          Expanded(child: _value(e.key, e.value, country)),
                        ],
                      ),
                    ),
              ],
      ),
    );
  }
}
