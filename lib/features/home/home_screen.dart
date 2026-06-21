import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/l10n/l10n.dart';
import '../../core/providers.dart';
import '../crossings/widgets/crossing_card.dart';
import 'widgets/search_sort_bar.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final crossings = ref.watch(crossingsProvider);
    final groupMode = ref.watch(groupModeProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.appTitle),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(108),
          child: Column(
            children: [
              const SearchSortBar(),
              _GroupToggle(mode: groupMode),
            ],
          ),
        ),
      ),
      body: crossings.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('$e')),
        data: (list) {
          if (list.isEmpty) {
            return Center(child: Text(l10n.createCrossingFirst));
          }
          return _CompanyTree(items: list, groupMode: groupMode);
        },
      ),
    );
  }
}

class _GroupToggle extends ConsumerWidget {
  const _GroupToggle({required this.mode});
  final GroupMode mode;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: SegmentedButton<GroupMode>(
        segments: [
          ButtonSegment(
            value: GroupMode.byVehicle,
            label: Text(l10n.groupByVehicle),
            icon: const Icon(Icons.local_shipping_outlined),
          ),
          ButtonSegment(
            value: GroupMode.byCargo,
            label: Text(l10n.groupByCargo),
            icon: const Icon(Icons.inventory_2_outlined),
          ),
        ],
        selected: {mode},
        onSelectionChanged: (s) =>
            ref.read(groupModeProvider.notifier).set(s.first),
      ),
    );
  }
}

/// Two-level tree: Company → (Vehicle | Cargo type) → crossing cards.
class _CompanyTree extends StatelessWidget {
  const _CompanyTree({required this.items, required this.groupMode});

  final List<CrossingView> items;
  final GroupMode groupMode;

  @override
  Widget build(BuildContext context) {
    final byCompany = <String, List<CrossingView>>{};
    for (final v in items) {
      byCompany.putIfAbsent(v.companyName, () => []).add(v);
    }
    final companies = byCompany.keys.toList()..sort();

    return ListView(
      padding: const EdgeInsets.only(bottom: 96),
      children: [
        for (final company in companies)
          ExpansionTile(
            initiallyExpanded: companies.length <= 3,
            leading: const Icon(Icons.business),
            title: Text(company,
                style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text('${byCompany[company]!.length}'),
            children: _subGroups(context, byCompany[company]!),
          ),
      ],
    );
  }

  List<Widget> _subGroups(BuildContext context, List<CrossingView> list) {
    final sub = <String, List<CrossingView>>{};
    for (final v in list) {
      final key =
          groupMode == GroupMode.byVehicle ? v.vehicleLabel : v.cargoTypeName;
      sub.putIfAbsent(key, () => []).add(v);
    }
    final keys = sub.keys.toList()..sort();
    return [
      for (final key in keys)
        ExpansionTile(
          tilePadding: const EdgeInsets.only(left: 32, right: 16),
          leading: Icon(groupMode == GroupMode.byVehicle
              ? Icons.local_shipping_outlined
              : Icons.inventory_2_outlined),
          title: Text(key),
          subtitle: Text('${sub[key]!.length}'),
          children: [
            for (final v in sub[key]!)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: CrossingCard(
                  view: v,
                  onTap: () => context.push('/crossing/${v.crossing.id}'),
                ),
              ),
          ],
        ),
    ];
  }
}
