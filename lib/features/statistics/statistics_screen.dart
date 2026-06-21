import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/l10n/l10n.dart';
import '../../core/providers.dart';

final _allCrossingsProvider = StreamProvider<List<CrossingView>>((ref) {
  return ref
      .watch(crossingRepositoryProvider)
      .watchCrossings(const CrossingQuery());
});

class StatisticsScreen extends ConsumerWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final data = ref.watch(_allCrossingsProvider);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.navStatistics)),
      body: data.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('$e')),
        data: (list) => _Content(list: list),
      ),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({required this.list});
  final List<CrossingView> list;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final now = DateTime.now();
    final startOfDay = DateTime(now.year, now.month, now.day);
    final startOfWeek = startOfDay.subtract(Duration(days: now.weekday - 1));
    final startOfMonth = DateTime(now.year, now.month);

    int countSince(DateTime since) =>
        list.where((v) => v.crossing.crossedAt.isAfter(since)).length;

    final byCompany = <String, int>{};
    final byCargo = <String, int>{};
    for (final v in list) {
      byCompany[v.companyName] = (byCompany[v.companyName] ?? 0) + 1;
      byCargo[v.cargoTypeName] = (byCargo[v.cargoTypeName] ?? 0) + 1;
    }
    final topCompanies = byCompany.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Row(
          children: [
            _StatCard(label: l10n.totalCrossings, value: list.length),
            _StatCard(label: l10n.today, value: countSince(startOfDay)),
          ],
        ),
        Row(
          children: [
            _StatCard(label: l10n.thisWeek, value: countSince(startOfWeek)),
            _StatCard(label: l10n.thisMonth, value: countSince(startOfMonth)),
          ],
        ),
        const SizedBox(height: 24),
        if (topCompanies.isNotEmpty) ...[
          Text(
            l10n.topCompanies,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 220,
            child: _CompanyBarChart(data: topCompanies.take(5).toList()),
          ),
        ],
        const SizedBox(height: 24),
        if (byCargo.isNotEmpty) ...[
          Text(
            l10n.byCargoType,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 12),
          SizedBox(height: 220, child: _CargoPieChart(data: byCargo)),
        ],
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({required this.label, required this.value});
  final String label;
  final int value;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Text('$value', style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: 4),
              Text(label, textAlign: TextAlign.center),
            ],
          ),
        ),
      ),
    );
  }
}

class _CompanyBarChart extends StatelessWidget {
  const _CompanyBarChart({required this.data});
  final List<MapEntry<String, int>> data;

  @override
  Widget build(BuildContext context) {
    final maxY = data.first.value.toDouble();
    return BarChart(
      BarChartData(
        maxY: maxY + 1,
        barGroups: [
          for (var i = 0; i < data.length; i++)
            BarChartGroupData(
              x: i,
              barRods: [
                BarChartRodData(
                  toY: data[i].value.toDouble(),
                  color: Theme.of(context).colorScheme.primary,
                ),
              ],
            ),
        ],
        titlesData: FlTitlesData(
          leftTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          topTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          rightTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 48,
              getTitlesWidget: (value, meta) {
                final i = value.toInt();
                if (i < 0 || i >= data.length) return const SizedBox();
                final name = data[i].key;
                return Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    name.length > 8 ? '${name.substring(0, 8)}…' : name,
                    style: const TextStyle(fontSize: 10),
                  ),
                );
              },
            ),
          ),
        ),
        gridData: const FlGridData(show: false),
        borderData: FlBorderData(show: false),
      ),
    );
  }
}

class _CargoPieChart extends StatelessWidget {
  const _CargoPieChart({required this.data});
  final Map<String, int> data;

  @override
  Widget build(BuildContext context) {
    final entries = data.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    final colors = Colors.primaries;
    return Row(
      spacing: 4,
      children: [
        Expanded(
          flex: 2,
          child: PieChart(
            PieChartData(
              sections: [
                for (var i = 0; i < entries.length; i++)
                  PieChartSectionData(
                    value: entries[i].value.toDouble(),
                    title: '${entries[i].value}',
                    color: colors[i % colors.length],
                    radius: 70,
                    titleStyle: const TextStyle(
                      fontSize: 11,
                      color: Colors.white,
                    ),
                  ),
              ],
            ),
          ),
        ),
        SizedBox(width: 4),
        Expanded(
          flex: 3,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (var i = 0; i < entries.length && i < 8; i++)
                Row(
                  children: [
                    Container(
                      width: 12,
                      height: 12,
                      color: colors[i % colors.length],
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        entries[i].key,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 12),
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ],
    );
  }
}
