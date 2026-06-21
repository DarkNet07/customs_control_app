import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/companies/companies_screen.dart';
import '../../features/crossings/crossing_detail_screen.dart';
import '../../features/crossings/crossing_form_screen.dart';
import '../../features/dictionaries/dictionaries_screen.dart';
import '../../features/export/export_screen.dart';
import '../../features/home/home_screen.dart';
import '../../features/journal/journal_screen.dart';
import '../../features/more/more_screen.dart';
import '../../features/settings/settings_screen.dart';
import '../../features/statistics/statistics_screen.dart';
import '../../features/shell/scaffold_with_nav.dart';

final _rootKey = GlobalKey<NavigatorState>();

GoRouter buildRouter() {
  return GoRouter(
    navigatorKey: _rootKey,
    initialLocation: '/home',
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navShell) =>
            ScaffoldWithNav(navigationShell: navShell),
        branches: [
          StatefulShellBranch(routes: [
            GoRoute(
              path: '/home',
              builder: (_, _) => const HomeScreen(),
            ),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
              path: '/journal',
              builder: (_, _) => const JournalScreen(),
            ),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
              path: '/companies',
              builder: (_, _) => const CompaniesScreen(),
            ),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
              path: '/statistics',
              builder: (_, _) => const StatisticsScreen(),
            ),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
              path: '/more',
              builder: (_, _) => const MoreScreen(),
            ),
          ]),
        ],
      ),
      GoRoute(
        path: '/crossing/new',
        parentNavigatorKey: _rootKey,
        builder: (_, _) => const CrossingFormScreen(),
      ),
      GoRoute(
        path: '/crossing/:id',
        parentNavigatorKey: _rootKey,
        builder: (_, state) =>
            CrossingDetailScreen(id: int.parse(state.pathParameters['id']!)),
      ),
      GoRoute(
        path: '/crossing/:id/edit',
        parentNavigatorKey: _rootKey,
        builder: (_, state) =>
            CrossingFormScreen(id: int.parse(state.pathParameters['id']!)),
      ),
      GoRoute(
        path: '/dictionaries',
        parentNavigatorKey: _rootKey,
        builder: (_, _) => const DictionariesScreen(),
      ),
      GoRoute(
        path: '/export',
        parentNavigatorKey: _rootKey,
        builder: (_, _) => const ExportScreen(),
      ),
      GoRoute(
        path: '/settings',
        parentNavigatorKey: _rootKey,
        builder: (_, _) => const SettingsScreen(),
      ),
    ],
  );
}
