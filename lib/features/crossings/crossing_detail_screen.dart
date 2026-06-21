import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../core/db/app_database.dart';
import '../../core/l10n/l10n.dart';
import '../../core/providers.dart';

final _detailProvider =
    FutureProvider.family.autoDispose((ref, int id) async {
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
                backgroundColor: Theme.of(ctx).colorScheme.error),
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
              itemBuilder: (_, i) {
                final f = File(view.photos[i].filePath);
                return ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: f.existsSync()
                      ? Image.file(f, fit: BoxFit.cover)
                      : const SizedBox(width: 200),
                );
              },
            ),
          ),
        const SizedBox(height: 16),
        _row(context, l10n.plateNumber, c.plateNumber),
        _row(context, l10n.company, view.companyName),
        _row(context, l10n.vehicleMake, view.vehicleLabel),
        _row(context, l10n.cargoType, view.cargoTypeName),
        if (c.cargoQuantity != null)
          _row(context, l10n.cargoQuantity,
              '${c.cargoQuantity} ${c.quantityUnit ?? ''}'.trim()),
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
            child: Text(label,
                style: const TextStyle(fontWeight: FontWeight.w600)),
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
    return Card(
      child: ExpansionTile(
        leading: Icon(icon),
        title: Text(label),
        subtitle: Text(df.format(entry.changedAt)),
        childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
        children: [
          for (final e in snap.entries)
            Align(
              alignment: Alignment.centerLeft,
              child: Text('${e.key}: ${e.value}'),
            ),
        ],
      ),
    );
  }
}
