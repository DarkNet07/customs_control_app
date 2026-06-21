import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../core/l10n/l10n.dart';
import '../../core/providers.dart';
import 'export_service.dart';

class ExportScreen extends ConsumerStatefulWidget {
  const ExportScreen({super.key});

  @override
  ConsumerState<ExportScreen> createState() => _ExportScreenState();
}

class _ExportScreenState extends ConsumerState<ExportScreen> {
  final _service = ExportService();
  DateTime? _from;
  DateTime? _to;
  bool _busy = false;

  Future<void> _pick(bool isFrom) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now().add(const Duration(days: 1)),
    );
    if (picked == null) return;
    setState(() {
      if (isFrom) {
        _from = DateTime(picked.year, picked.month, picked.day);
      } else {
        _to = DateTime(picked.year, picked.month, picked.day, 23, 59, 59);
      }
    });
  }

  Future<void> _export(bool pdf) async {
    setState(() => _busy = true);
    try {
      final data = await ref
          .read(crossingRepositoryProvider)
          .getAllForExport(from: _from, to: _to);
      final file =
          pdf ? await _service.exportPdf(data) : await _service.exportExcel(data);
      await _service.share(file);
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(context.l10n.exportSuccess)));
      }
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final df = DateFormat('dd.MM.yyyy');
    return Scaffold(
      appBar: AppBar(title: Text(l10n.navExport)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(l10n.exportPeriod,
              style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => _pick(true),
                  child: Text(_from == null
                      ? l10n.exportFrom
                      : '${l10n.exportFrom}: ${df.format(_from!)}'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton(
                  onPressed: () => _pick(false),
                  child: Text(_to == null
                      ? l10n.exportTo
                      : '${l10n.exportTo}: ${df.format(_to!)}'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          if (_busy)
            const Center(child: CircularProgressIndicator())
          else ...[
            FilledButton.icon(
              icon: const Icon(Icons.table_chart),
              label: Text(l10n.exportExcel),
              onPressed: () => _export(false),
            ),
            const SizedBox(height: 12),
            FilledButton.icon(
              icon: const Icon(Icons.picture_as_pdf),
              label: Text(l10n.exportPdf),
              onPressed: () => _export(true),
            ),
          ],
        ],
      ),
    );
  }
}
