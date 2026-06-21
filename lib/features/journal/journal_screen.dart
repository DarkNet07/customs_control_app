import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/l10n/l10n.dart';
import '../../core/providers.dart';
import '../crossings/widgets/crossing_card.dart';
import '../home/widgets/search_sort_bar.dart';

class JournalScreen extends ConsumerWidget {
  const JournalScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final crossings = ref.watch(crossingsProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.navJournal),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: SearchSortBar(),
        ),
      ),
      body: crossings.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('$e')),
        data: (list) {
          if (list.isEmpty) {
            return Center(child: Text(l10n.noData));
          }
          return ListView.builder(
            padding: const EdgeInsets.fromLTRB(8, 8, 8, 96),
            itemCount: list.length,
            itemBuilder: (_, i) => CrossingCard(
              view: list[i],
              onTap: () => context.push('/crossing/${list[i].crossing.id}'),
            ),
          );
        },
      ),
    );
  }
}
