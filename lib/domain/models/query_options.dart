enum CrossingSort { company, make, plate, time, cargo }

enum SortDirection { asc, desc }

enum GroupMode { byVehicle, byCargo }

class CrossingQuery {
  const CrossingQuery({
    this.search = '',
    this.sort = CrossingSort.time,
    this.direction = SortDirection.desc,
    this.companyId,
    this.makeId,
    this.cargoTypeId,
    this.from,
    this.to,
  });

  final String search;
  final CrossingSort sort;
  final SortDirection direction;
  final int? companyId;
  final int? makeId;
  final int? cargoTypeId;
  final DateTime? from;
  final DateTime? to;

  CrossingQuery copyWith({
    String? search,
    CrossingSort? sort,
    SortDirection? direction,
    Object? companyId = _sentinel,
    Object? makeId = _sentinel,
    Object? cargoTypeId = _sentinel,
    Object? from = _sentinel,
    Object? to = _sentinel,
  }) {
    return CrossingQuery(
      search: search ?? this.search,
      sort: sort ?? this.sort,
      direction: direction ?? this.direction,
      companyId:
          companyId == _sentinel ? this.companyId : companyId as int?,
      makeId: makeId == _sentinel ? this.makeId : makeId as int?,
      cargoTypeId:
          cargoTypeId == _sentinel ? this.cargoTypeId : cargoTypeId as int?,
      from: from == _sentinel ? this.from : from as DateTime?,
      to: to == _sentinel ? this.to : to as DateTime?,
    );
  }

  static const _sentinel = Object();
}
