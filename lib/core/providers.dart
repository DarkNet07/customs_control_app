import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/local/company_repository_impl.dart';
import '../data/local/crossing_repository_impl.dart';
import '../data/local/dictionary_repository_impl.dart';
import '../domain/models/crossing_view.dart';
import '../domain/models/query_options.dart';
import '../domain/repositories/repositories.dart';
import 'auth/auth_service.dart';
import 'db/app_database.dart';
import 'images/image_service.dart';
import 'location/location_service.dart';

// Barrel re-exports so feature files can import this single file.
export '../domain/models/crossing_view.dart';
export '../domain/models/query_options.dart';
export '../domain/repositories/repositories.dart';
export 'settings/settings_controller.dart';

/// Database singleton.
final databaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(db.close);
  return db;
});

final imageServiceProvider = Provider<ImageService>((ref) => ImageService());

final locationServiceProvider =
    Provider<LocationService>((ref) => LocationService());

final authServiceProvider = Provider<AuthService>((ref) => AuthService());

// -----------------------------------------------------------------------------
// Repositories — swap these implementations for remote ones to move to a server.
// The UI never references the concrete class, only these provider symbols.
// -----------------------------------------------------------------------------
final crossingRepositoryProvider = Provider<CrossingRepository>((ref) {
  return LocalCrossingRepository(ref.watch(databaseProvider));
});

final companyRepositoryProvider = Provider<CompanyRepository>((ref) {
  return LocalCompanyRepository(ref.watch(databaseProvider));
});

final dictionaryRepositoryProvider = Provider<DictionaryRepository>((ref) {
  return LocalDictionaryRepository(ref.watch(databaseProvider));
});

// -----------------------------------------------------------------------------
// Query state + reactive lists.
// -----------------------------------------------------------------------------
final crossingQueryProvider =
    NotifierProvider<CrossingQueryController, CrossingQuery>(
        CrossingQueryController.new);

class CrossingQueryController extends Notifier<CrossingQuery> {
  @override
  CrossingQuery build() => const CrossingQuery();

  void setSearch(String value) => state = state.copyWith(search: value);
  void setSort(CrossingSort sort) => state = state.copyWith(sort: sort);
  void setDirection(SortDirection dir) =>
      state = state.copyWith(direction: dir);
  void setCompany(int? id) => state = state.copyWith(companyId: id);
  void setMake(int? id) => state = state.copyWith(makeId: id);
  void setCargoType(int? id) => state = state.copyWith(cargoTypeId: id);
  void setRange(DateTime? from, DateTime? to) =>
      state = state.copyWith(from: from, to: to);
  void reset() => state = const CrossingQuery();
}

final crossingsProvider = StreamProvider<List<CrossingView>>((ref) {
  final query = ref.watch(crossingQueryProvider);
  return ref.watch(crossingRepositoryProvider).watchCrossings(query);
});

final companiesProvider = StreamProvider((ref) {
  return ref.watch(companyRepositoryProvider).watchAll();
});

final makesProvider = StreamProvider((ref) {
  return ref.watch(dictionaryRepositoryProvider).watchMakes();
});

final modelsProvider = StreamProvider.family((ref, int makeId) {
  return ref.watch(dictionaryRepositoryProvider).watchModels(makeId);
});

final cargoTypesProvider = StreamProvider((ref) {
  return ref.watch(dictionaryRepositoryProvider).watchCargoTypes();
});

/// Tree grouping mode for the home screen.
final groupModeProvider = NotifierProvider<GroupModeController, GroupMode>(
    GroupModeController.new);

class GroupModeController extends Notifier<GroupMode> {
  @override
  GroupMode build() => GroupMode.byVehicle;
  void set(GroupMode mode) => state = mode;
}
