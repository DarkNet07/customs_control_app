import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/l10n/l10n.dart';
import '../../core/providers.dart';
import '../../core/widgets/text_input_dialog.dart';

class DictionariesScreen extends ConsumerWidget {
  const DictionariesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(l10n.dictionaries),
          bottom: TabBar(
            tabs: [
              Tab(text: l10n.makesAndModels),
              Tab(text: l10n.cargoTypes),
            ],
          ),
        ),
        body: const TabBarView(
          children: [_MakesTab(), _CargoTab()],
        ),
      ),
    );
  }
}

class _MakesTab extends ConsumerWidget {
  const _MakesTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final makes = ref.watch(makesProvider);
    final dict = ref.read(dictionaryRepositoryProvider);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        heroTag: 'fab_makes',
        onPressed: () async {
          final name =
              await showTextInputDialog(context, title: l10n.addMakeTitle);
          if (name != null) await dict.addMake(name);
        },
        child: const Icon(Icons.add),
      ),
      body: makes.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('$e')),
        data: (list) => ListView(
          children: [
            for (final m in list)
              _MakeTile(makeId: m.id, makeName: m.name),
          ],
        ),
      ),
    );
  }
}

class _MakeTile extends ConsumerWidget {
  const _MakeTile({required this.makeId, required this.makeName});

  final int makeId;
  final String makeName;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final models = ref.watch(modelsProvider(makeId));
    final dict = ref.read(dictionaryRepositoryProvider);
    return ExpansionTile(
      leading: const Icon(Icons.local_shipping_outlined),
      title: Text(makeName),
      trailing: IconButton(
        icon: const Icon(Icons.add),
        tooltip: l10n.addModelTitle,
        onPressed: () async {
          final name = await showTextInputDialog(context,
              title: l10n.addModelTitle, hint: l10n.addModelHint);
          if (name != null) await dict.addModel(makeId, name);
        },
      ),
      children: [
        models.when(
          loading: () => const LinearProgressIndicator(),
          error: (e, _) => Text('$e'),
          data: (list) => Column(
            children: [
              for (final m in list)
                ListTile(
                  contentPadding: const EdgeInsets.only(left: 56, right: 16),
                  title: Text(m.name),
                  dense: true,
                ),
            ],
          ),
        ),
      ],
    );
  }
}

class _CargoTab extends ConsumerWidget {
  const _CargoTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final cargo = ref.watch(cargoTypesProvider);
    final dict = ref.read(dictionaryRepositoryProvider);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        heroTag: 'fab_cargo',
        onPressed: () async {
          final name = await showTextInputDialog(context,
              title: l10n.addCargoTypeTitle);
          if (name != null) await dict.addCargoType(name);
        },
        child: const Icon(Icons.add),
      ),
      body: cargo.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('$e')),
        data: (list) => ListView(
          children: [
            for (final c in list)
              ListTile(
                leading: const Icon(Icons.inventory_2_outlined),
                title: Text(c.name),
              ),
          ],
        ),
      ),
    );
  }
}
