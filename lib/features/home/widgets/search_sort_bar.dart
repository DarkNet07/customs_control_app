import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/l10n/l10n.dart';
import '../../../core/providers.dart';

class SearchSortBar extends ConsumerWidget {
  const SearchSortBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final query = ref.watch(crossingQueryProvider);
    final controller = ref.read(crossingQueryProvider.notifier);

    String sortLabel(CrossingSort s) => switch (s) {
          CrossingSort.company => l10n.sortByCompany,
          CrossingSort.make => l10n.sortByMake,
          CrossingSort.plate => l10n.sortByPlate,
          CrossingSort.time => l10n.sortByTime,
          CrossingSort.cargo => l10n.sortByCargo,
        };

    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 4, 12, 4),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: l10n.search,
                prefixIcon: const Icon(Icons.search),
                isDense: true,
                border: const OutlineInputBorder(),
              ),
              onChanged: controller.setSearch,
            ),
          ),
          IconButton(
            tooltip: l10n.exportPeriod,
            isSelected: query.from != null || query.to != null,
            icon: Icon(query.from != null || query.to != null
                ? Icons.event_available
                : Icons.date_range),
            onPressed: () async {
              final now = DateTime.now();
              final picked = await showDateRangePicker(
                context: context,
                firstDate: DateTime(2020),
                lastDate: DateTime(now.year + 1),
                initialDateRange: query.from != null && query.to != null
                    ? DateTimeRange(start: query.from!, end: query.to!)
                    : null,
              );
              if (picked == null) return;
              controller.setRange(
                DateTime(picked.start.year, picked.start.month,
                    picked.start.day),
                DateTime(picked.end.year, picked.end.month, picked.end.day,
                    23, 59, 59),
              );
            },
          ),
          if (query.from != null || query.to != null)
            IconButton(
              tooltip: l10n.cancel,
              icon: const Icon(Icons.event_busy),
              onPressed: () => controller.setRange(null, null),
            ),
          PopupMenuButton<CrossingSort>(
            icon: const Icon(Icons.sort),
            tooltip: l10n.sort,
            initialValue: query.sort,
            onSelected: controller.setSort,
            itemBuilder: (_) => [
              for (final s in CrossingSort.values)
                PopupMenuItem(value: s, child: Text(sortLabel(s))),
            ],
          ),
          IconButton(
            tooltip: query.direction == SortDirection.asc
                ? l10n.ascending
                : l10n.descending,
            icon: Icon(query.direction == SortDirection.asc
                ? Icons.arrow_upward
                : Icons.arrow_downward),
            onPressed: () => controller.setDirection(
              query.direction == SortDirection.asc
                  ? SortDirection.desc
                  : SortDirection.asc,
            ),
          ),
        ],
      ),
    );
  }
}
