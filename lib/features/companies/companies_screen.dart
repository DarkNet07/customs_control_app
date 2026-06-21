import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/l10n/l10n.dart';
import '../../core/providers.dart';
import '../../core/widgets/text_input_dialog.dart';

class CompaniesScreen extends ConsumerWidget {
  const CompaniesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final companies = ref.watch(companiesProvider);
    final repo = ref.read(companyRepositoryProvider);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.companies)),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final name =
              await showTextInputDialog(context, title: l10n.addCompanyTitle);
          if (name != null) await repo.add(name);
        },
        child: const Icon(Icons.add),
      ),
      body: companies.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('$e')),
        data: (list) {
          if (list.isEmpty) return Center(child: Text(l10n.noData));
          return ListView.builder(
            itemCount: list.length,
            itemBuilder: (_, i) {
              final c = list[i];
              return ListTile(
                leading: const Icon(Icons.business),
                title: Text(c.name),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit_outlined),
                      onPressed: () async {
                        final name = await showTextInputDialog(
                          context,
                          title: l10n.company,
                          initial: c.name,
                        );
                        if (name != null) await repo.rename(c.id, name);
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete_outline),
                      onPressed: () async {
                        final ok = await _confirm(context, l10n);
                        if (ok) await repo.softDelete(c.id);
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  Future<bool> _confirm(BuildContext context, AppLocalizations l10n) async {
    return await showDialog<bool>(
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
                onPressed: () => Navigator.of(ctx).pop(true),
                child: Text(l10n.delete),
              ),
            ],
          ),
        ) ??
        false;
  }
}
