// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $CompaniesTable extends Companies
    with TableInfo<$CompaniesTable, Company> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CompaniesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _uuidMeta = const VerificationMeta('uuid');
  @override
  late final GeneratedColumn<String> uuid = GeneratedColumn<String>(
    'uuid',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 200,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _serverIdMeta = const VerificationMeta(
    'serverId',
  );
  @override
  late final GeneratedColumn<int> serverId = GeneratedColumn<int>(
    'server_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _syncStatusMeta = const VerificationMeta(
    'syncStatus',
  );
  @override
  late final GeneratedColumn<String> syncStatus = GeneratedColumn<String>(
    'sync_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('local'),
  );
  static const VerificationMeta _isDeletedMeta = const VerificationMeta(
    'isDeleted',
  );
  @override
  late final GeneratedColumn<bool> isDeleted = GeneratedColumn<bool>(
    'is_deleted',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_deleted" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    uuid,
    name,
    createdAt,
    updatedAt,
    serverId,
    syncStatus,
    isDeleted,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'companies';
  @override
  VerificationContext validateIntegrity(
    Insertable<Company> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('uuid')) {
      context.handle(
        _uuidMeta,
        uuid.isAcceptableOrUnknown(data['uuid']!, _uuidMeta),
      );
    } else if (isInserting) {
      context.missing(_uuidMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('server_id')) {
      context.handle(
        _serverIdMeta,
        serverId.isAcceptableOrUnknown(data['server_id']!, _serverIdMeta),
      );
    }
    if (data.containsKey('sync_status')) {
      context.handle(
        _syncStatusMeta,
        syncStatus.isAcceptableOrUnknown(data['sync_status']!, _syncStatusMeta),
      );
    }
    if (data.containsKey('is_deleted')) {
      context.handle(
        _isDeletedMeta,
        isDeleted.isAcceptableOrUnknown(data['is_deleted']!, _isDeletedMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Company map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Company(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      uuid: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}uuid'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      serverId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}server_id'],
      ),
      syncStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sync_status'],
      )!,
      isDeleted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_deleted'],
      )!,
    );
  }

  @override
  $CompaniesTable createAlias(String alias) {
    return $CompaniesTable(attachedDatabase, alias);
  }
}

class Company extends DataClass implements Insertable<Company> {
  final int id;
  final String uuid;
  final String name;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int? serverId;
  final String syncStatus;
  final bool isDeleted;
  const Company({
    required this.id,
    required this.uuid,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
    this.serverId,
    required this.syncStatus,
    required this.isDeleted,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['uuid'] = Variable<String>(uuid);
    map['name'] = Variable<String>(name);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || serverId != null) {
      map['server_id'] = Variable<int>(serverId);
    }
    map['sync_status'] = Variable<String>(syncStatus);
    map['is_deleted'] = Variable<bool>(isDeleted);
    return map;
  }

  CompaniesCompanion toCompanion(bool nullToAbsent) {
    return CompaniesCompanion(
      id: Value(id),
      uuid: Value(uuid),
      name: Value(name),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      serverId: serverId == null && nullToAbsent
          ? const Value.absent()
          : Value(serverId),
      syncStatus: Value(syncStatus),
      isDeleted: Value(isDeleted),
    );
  }

  factory Company.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Company(
      id: serializer.fromJson<int>(json['id']),
      uuid: serializer.fromJson<String>(json['uuid']),
      name: serializer.fromJson<String>(json['name']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      serverId: serializer.fromJson<int?>(json['serverId']),
      syncStatus: serializer.fromJson<String>(json['syncStatus']),
      isDeleted: serializer.fromJson<bool>(json['isDeleted']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'uuid': serializer.toJson<String>(uuid),
      'name': serializer.toJson<String>(name),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'serverId': serializer.toJson<int?>(serverId),
      'syncStatus': serializer.toJson<String>(syncStatus),
      'isDeleted': serializer.toJson<bool>(isDeleted),
    };
  }

  Company copyWith({
    int? id,
    String? uuid,
    String? name,
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<int?> serverId = const Value.absent(),
    String? syncStatus,
    bool? isDeleted,
  }) => Company(
    id: id ?? this.id,
    uuid: uuid ?? this.uuid,
    name: name ?? this.name,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    serverId: serverId.present ? serverId.value : this.serverId,
    syncStatus: syncStatus ?? this.syncStatus,
    isDeleted: isDeleted ?? this.isDeleted,
  );
  Company copyWithCompanion(CompaniesCompanion data) {
    return Company(
      id: data.id.present ? data.id.value : this.id,
      uuid: data.uuid.present ? data.uuid.value : this.uuid,
      name: data.name.present ? data.name.value : this.name,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      serverId: data.serverId.present ? data.serverId.value : this.serverId,
      syncStatus: data.syncStatus.present
          ? data.syncStatus.value
          : this.syncStatus,
      isDeleted: data.isDeleted.present ? data.isDeleted.value : this.isDeleted,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Company(')
          ..write('id: $id, ')
          ..write('uuid: $uuid, ')
          ..write('name: $name, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('serverId: $serverId, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('isDeleted: $isDeleted')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    uuid,
    name,
    createdAt,
    updatedAt,
    serverId,
    syncStatus,
    isDeleted,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Company &&
          other.id == this.id &&
          other.uuid == this.uuid &&
          other.name == this.name &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.serverId == this.serverId &&
          other.syncStatus == this.syncStatus &&
          other.isDeleted == this.isDeleted);
}

class CompaniesCompanion extends UpdateCompanion<Company> {
  final Value<int> id;
  final Value<String> uuid;
  final Value<String> name;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int?> serverId;
  final Value<String> syncStatus;
  final Value<bool> isDeleted;
  const CompaniesCompanion({
    this.id = const Value.absent(),
    this.uuid = const Value.absent(),
    this.name = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.serverId = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.isDeleted = const Value.absent(),
  });
  CompaniesCompanion.insert({
    this.id = const Value.absent(),
    required String uuid,
    required String name,
    required DateTime createdAt,
    required DateTime updatedAt,
    this.serverId = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.isDeleted = const Value.absent(),
  }) : uuid = Value(uuid),
       name = Value(name),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<Company> custom({
    Expression<int>? id,
    Expression<String>? uuid,
    Expression<String>? name,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? serverId,
    Expression<String>? syncStatus,
    Expression<bool>? isDeleted,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (uuid != null) 'uuid': uuid,
      if (name != null) 'name': name,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (serverId != null) 'server_id': serverId,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (isDeleted != null) 'is_deleted': isDeleted,
    });
  }

  CompaniesCompanion copyWith({
    Value<int>? id,
    Value<String>? uuid,
    Value<String>? name,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int?>? serverId,
    Value<String>? syncStatus,
    Value<bool>? isDeleted,
  }) {
    return CompaniesCompanion(
      id: id ?? this.id,
      uuid: uuid ?? this.uuid,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      serverId: serverId ?? this.serverId,
      syncStatus: syncStatus ?? this.syncStatus,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (uuid.present) {
      map['uuid'] = Variable<String>(uuid.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (serverId.present) {
      map['server_id'] = Variable<int>(serverId.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(syncStatus.value);
    }
    if (isDeleted.present) {
      map['is_deleted'] = Variable<bool>(isDeleted.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CompaniesCompanion(')
          ..write('id: $id, ')
          ..write('uuid: $uuid, ')
          ..write('name: $name, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('serverId: $serverId, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('isDeleted: $isDeleted')
          ..write(')'))
        .toString();
  }
}

class $VehicleMakesTable extends VehicleMakes
    with TableInfo<$VehicleMakesTable, VehicleMake> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $VehicleMakesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _uuidMeta = const VerificationMeta('uuid');
  @override
  late final GeneratedColumn<String> uuid = GeneratedColumn<String>(
    'uuid',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 100,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isBuiltInMeta = const VerificationMeta(
    'isBuiltIn',
  );
  @override
  late final GeneratedColumn<bool> isBuiltIn = GeneratedColumn<bool>(
    'is_built_in',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_built_in" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _isHiddenMeta = const VerificationMeta(
    'isHidden',
  );
  @override
  late final GeneratedColumn<bool> isHidden = GeneratedColumn<bool>(
    'is_hidden',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_hidden" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [id, uuid, name, isBuiltIn, isHidden];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'vehicle_makes';
  @override
  VerificationContext validateIntegrity(
    Insertable<VehicleMake> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('uuid')) {
      context.handle(
        _uuidMeta,
        uuid.isAcceptableOrUnknown(data['uuid']!, _uuidMeta),
      );
    } else if (isInserting) {
      context.missing(_uuidMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('is_built_in')) {
      context.handle(
        _isBuiltInMeta,
        isBuiltIn.isAcceptableOrUnknown(data['is_built_in']!, _isBuiltInMeta),
      );
    }
    if (data.containsKey('is_hidden')) {
      context.handle(
        _isHiddenMeta,
        isHidden.isAcceptableOrUnknown(data['is_hidden']!, _isHiddenMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  VehicleMake map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return VehicleMake(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      uuid: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}uuid'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      isBuiltIn: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_built_in'],
      )!,
      isHidden: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_hidden'],
      )!,
    );
  }

  @override
  $VehicleMakesTable createAlias(String alias) {
    return $VehicleMakesTable(attachedDatabase, alias);
  }
}

class VehicleMake extends DataClass implements Insertable<VehicleMake> {
  final int id;
  final String uuid;
  final String name;
  final bool isBuiltIn;
  final bool isHidden;
  const VehicleMake({
    required this.id,
    required this.uuid,
    required this.name,
    required this.isBuiltIn,
    required this.isHidden,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['uuid'] = Variable<String>(uuid);
    map['name'] = Variable<String>(name);
    map['is_built_in'] = Variable<bool>(isBuiltIn);
    map['is_hidden'] = Variable<bool>(isHidden);
    return map;
  }

  VehicleMakesCompanion toCompanion(bool nullToAbsent) {
    return VehicleMakesCompanion(
      id: Value(id),
      uuid: Value(uuid),
      name: Value(name),
      isBuiltIn: Value(isBuiltIn),
      isHidden: Value(isHidden),
    );
  }

  factory VehicleMake.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return VehicleMake(
      id: serializer.fromJson<int>(json['id']),
      uuid: serializer.fromJson<String>(json['uuid']),
      name: serializer.fromJson<String>(json['name']),
      isBuiltIn: serializer.fromJson<bool>(json['isBuiltIn']),
      isHidden: serializer.fromJson<bool>(json['isHidden']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'uuid': serializer.toJson<String>(uuid),
      'name': serializer.toJson<String>(name),
      'isBuiltIn': serializer.toJson<bool>(isBuiltIn),
      'isHidden': serializer.toJson<bool>(isHidden),
    };
  }

  VehicleMake copyWith({
    int? id,
    String? uuid,
    String? name,
    bool? isBuiltIn,
    bool? isHidden,
  }) => VehicleMake(
    id: id ?? this.id,
    uuid: uuid ?? this.uuid,
    name: name ?? this.name,
    isBuiltIn: isBuiltIn ?? this.isBuiltIn,
    isHidden: isHidden ?? this.isHidden,
  );
  VehicleMake copyWithCompanion(VehicleMakesCompanion data) {
    return VehicleMake(
      id: data.id.present ? data.id.value : this.id,
      uuid: data.uuid.present ? data.uuid.value : this.uuid,
      name: data.name.present ? data.name.value : this.name,
      isBuiltIn: data.isBuiltIn.present ? data.isBuiltIn.value : this.isBuiltIn,
      isHidden: data.isHidden.present ? data.isHidden.value : this.isHidden,
    );
  }

  @override
  String toString() {
    return (StringBuffer('VehicleMake(')
          ..write('id: $id, ')
          ..write('uuid: $uuid, ')
          ..write('name: $name, ')
          ..write('isBuiltIn: $isBuiltIn, ')
          ..write('isHidden: $isHidden')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, uuid, name, isBuiltIn, isHidden);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is VehicleMake &&
          other.id == this.id &&
          other.uuid == this.uuid &&
          other.name == this.name &&
          other.isBuiltIn == this.isBuiltIn &&
          other.isHidden == this.isHidden);
}

class VehicleMakesCompanion extends UpdateCompanion<VehicleMake> {
  final Value<int> id;
  final Value<String> uuid;
  final Value<String> name;
  final Value<bool> isBuiltIn;
  final Value<bool> isHidden;
  const VehicleMakesCompanion({
    this.id = const Value.absent(),
    this.uuid = const Value.absent(),
    this.name = const Value.absent(),
    this.isBuiltIn = const Value.absent(),
    this.isHidden = const Value.absent(),
  });
  VehicleMakesCompanion.insert({
    this.id = const Value.absent(),
    required String uuid,
    required String name,
    this.isBuiltIn = const Value.absent(),
    this.isHidden = const Value.absent(),
  }) : uuid = Value(uuid),
       name = Value(name);
  static Insertable<VehicleMake> custom({
    Expression<int>? id,
    Expression<String>? uuid,
    Expression<String>? name,
    Expression<bool>? isBuiltIn,
    Expression<bool>? isHidden,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (uuid != null) 'uuid': uuid,
      if (name != null) 'name': name,
      if (isBuiltIn != null) 'is_built_in': isBuiltIn,
      if (isHidden != null) 'is_hidden': isHidden,
    });
  }

  VehicleMakesCompanion copyWith({
    Value<int>? id,
    Value<String>? uuid,
    Value<String>? name,
    Value<bool>? isBuiltIn,
    Value<bool>? isHidden,
  }) {
    return VehicleMakesCompanion(
      id: id ?? this.id,
      uuid: uuid ?? this.uuid,
      name: name ?? this.name,
      isBuiltIn: isBuiltIn ?? this.isBuiltIn,
      isHidden: isHidden ?? this.isHidden,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (uuid.present) {
      map['uuid'] = Variable<String>(uuid.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (isBuiltIn.present) {
      map['is_built_in'] = Variable<bool>(isBuiltIn.value);
    }
    if (isHidden.present) {
      map['is_hidden'] = Variable<bool>(isHidden.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('VehicleMakesCompanion(')
          ..write('id: $id, ')
          ..write('uuid: $uuid, ')
          ..write('name: $name, ')
          ..write('isBuiltIn: $isBuiltIn, ')
          ..write('isHidden: $isHidden')
          ..write(')'))
        .toString();
  }
}

class $VehicleModelsTable extends VehicleModels
    with TableInfo<$VehicleModelsTable, VehicleModel> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $VehicleModelsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _uuidMeta = const VerificationMeta('uuid');
  @override
  late final GeneratedColumn<String> uuid = GeneratedColumn<String>(
    'uuid',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _makeIdMeta = const VerificationMeta('makeId');
  @override
  late final GeneratedColumn<int> makeId = GeneratedColumn<int>(
    'make_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES vehicle_makes (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 100,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isBuiltInMeta = const VerificationMeta(
    'isBuiltIn',
  );
  @override
  late final GeneratedColumn<bool> isBuiltIn = GeneratedColumn<bool>(
    'is_built_in',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_built_in" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _isHiddenMeta = const VerificationMeta(
    'isHidden',
  );
  @override
  late final GeneratedColumn<bool> isHidden = GeneratedColumn<bool>(
    'is_hidden',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_hidden" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    uuid,
    makeId,
    name,
    isBuiltIn,
    isHidden,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'vehicle_models';
  @override
  VerificationContext validateIntegrity(
    Insertable<VehicleModel> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('uuid')) {
      context.handle(
        _uuidMeta,
        uuid.isAcceptableOrUnknown(data['uuid']!, _uuidMeta),
      );
    } else if (isInserting) {
      context.missing(_uuidMeta);
    }
    if (data.containsKey('make_id')) {
      context.handle(
        _makeIdMeta,
        makeId.isAcceptableOrUnknown(data['make_id']!, _makeIdMeta),
      );
    } else if (isInserting) {
      context.missing(_makeIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('is_built_in')) {
      context.handle(
        _isBuiltInMeta,
        isBuiltIn.isAcceptableOrUnknown(data['is_built_in']!, _isBuiltInMeta),
      );
    }
    if (data.containsKey('is_hidden')) {
      context.handle(
        _isHiddenMeta,
        isHidden.isAcceptableOrUnknown(data['is_hidden']!, _isHiddenMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  VehicleModel map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return VehicleModel(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      uuid: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}uuid'],
      )!,
      makeId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}make_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      isBuiltIn: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_built_in'],
      )!,
      isHidden: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_hidden'],
      )!,
    );
  }

  @override
  $VehicleModelsTable createAlias(String alias) {
    return $VehicleModelsTable(attachedDatabase, alias);
  }
}

class VehicleModel extends DataClass implements Insertable<VehicleModel> {
  final int id;
  final String uuid;
  final int makeId;
  final String name;
  final bool isBuiltIn;
  final bool isHidden;
  const VehicleModel({
    required this.id,
    required this.uuid,
    required this.makeId,
    required this.name,
    required this.isBuiltIn,
    required this.isHidden,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['uuid'] = Variable<String>(uuid);
    map['make_id'] = Variable<int>(makeId);
    map['name'] = Variable<String>(name);
    map['is_built_in'] = Variable<bool>(isBuiltIn);
    map['is_hidden'] = Variable<bool>(isHidden);
    return map;
  }

  VehicleModelsCompanion toCompanion(bool nullToAbsent) {
    return VehicleModelsCompanion(
      id: Value(id),
      uuid: Value(uuid),
      makeId: Value(makeId),
      name: Value(name),
      isBuiltIn: Value(isBuiltIn),
      isHidden: Value(isHidden),
    );
  }

  factory VehicleModel.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return VehicleModel(
      id: serializer.fromJson<int>(json['id']),
      uuid: serializer.fromJson<String>(json['uuid']),
      makeId: serializer.fromJson<int>(json['makeId']),
      name: serializer.fromJson<String>(json['name']),
      isBuiltIn: serializer.fromJson<bool>(json['isBuiltIn']),
      isHidden: serializer.fromJson<bool>(json['isHidden']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'uuid': serializer.toJson<String>(uuid),
      'makeId': serializer.toJson<int>(makeId),
      'name': serializer.toJson<String>(name),
      'isBuiltIn': serializer.toJson<bool>(isBuiltIn),
      'isHidden': serializer.toJson<bool>(isHidden),
    };
  }

  VehicleModel copyWith({
    int? id,
    String? uuid,
    int? makeId,
    String? name,
    bool? isBuiltIn,
    bool? isHidden,
  }) => VehicleModel(
    id: id ?? this.id,
    uuid: uuid ?? this.uuid,
    makeId: makeId ?? this.makeId,
    name: name ?? this.name,
    isBuiltIn: isBuiltIn ?? this.isBuiltIn,
    isHidden: isHidden ?? this.isHidden,
  );
  VehicleModel copyWithCompanion(VehicleModelsCompanion data) {
    return VehicleModel(
      id: data.id.present ? data.id.value : this.id,
      uuid: data.uuid.present ? data.uuid.value : this.uuid,
      makeId: data.makeId.present ? data.makeId.value : this.makeId,
      name: data.name.present ? data.name.value : this.name,
      isBuiltIn: data.isBuiltIn.present ? data.isBuiltIn.value : this.isBuiltIn,
      isHidden: data.isHidden.present ? data.isHidden.value : this.isHidden,
    );
  }

  @override
  String toString() {
    return (StringBuffer('VehicleModel(')
          ..write('id: $id, ')
          ..write('uuid: $uuid, ')
          ..write('makeId: $makeId, ')
          ..write('name: $name, ')
          ..write('isBuiltIn: $isBuiltIn, ')
          ..write('isHidden: $isHidden')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, uuid, makeId, name, isBuiltIn, isHidden);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is VehicleModel &&
          other.id == this.id &&
          other.uuid == this.uuid &&
          other.makeId == this.makeId &&
          other.name == this.name &&
          other.isBuiltIn == this.isBuiltIn &&
          other.isHidden == this.isHidden);
}

class VehicleModelsCompanion extends UpdateCompanion<VehicleModel> {
  final Value<int> id;
  final Value<String> uuid;
  final Value<int> makeId;
  final Value<String> name;
  final Value<bool> isBuiltIn;
  final Value<bool> isHidden;
  const VehicleModelsCompanion({
    this.id = const Value.absent(),
    this.uuid = const Value.absent(),
    this.makeId = const Value.absent(),
    this.name = const Value.absent(),
    this.isBuiltIn = const Value.absent(),
    this.isHidden = const Value.absent(),
  });
  VehicleModelsCompanion.insert({
    this.id = const Value.absent(),
    required String uuid,
    required int makeId,
    required String name,
    this.isBuiltIn = const Value.absent(),
    this.isHidden = const Value.absent(),
  }) : uuid = Value(uuid),
       makeId = Value(makeId),
       name = Value(name);
  static Insertable<VehicleModel> custom({
    Expression<int>? id,
    Expression<String>? uuid,
    Expression<int>? makeId,
    Expression<String>? name,
    Expression<bool>? isBuiltIn,
    Expression<bool>? isHidden,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (uuid != null) 'uuid': uuid,
      if (makeId != null) 'make_id': makeId,
      if (name != null) 'name': name,
      if (isBuiltIn != null) 'is_built_in': isBuiltIn,
      if (isHidden != null) 'is_hidden': isHidden,
    });
  }

  VehicleModelsCompanion copyWith({
    Value<int>? id,
    Value<String>? uuid,
    Value<int>? makeId,
    Value<String>? name,
    Value<bool>? isBuiltIn,
    Value<bool>? isHidden,
  }) {
    return VehicleModelsCompanion(
      id: id ?? this.id,
      uuid: uuid ?? this.uuid,
      makeId: makeId ?? this.makeId,
      name: name ?? this.name,
      isBuiltIn: isBuiltIn ?? this.isBuiltIn,
      isHidden: isHidden ?? this.isHidden,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (uuid.present) {
      map['uuid'] = Variable<String>(uuid.value);
    }
    if (makeId.present) {
      map['make_id'] = Variable<int>(makeId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (isBuiltIn.present) {
      map['is_built_in'] = Variable<bool>(isBuiltIn.value);
    }
    if (isHidden.present) {
      map['is_hidden'] = Variable<bool>(isHidden.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('VehicleModelsCompanion(')
          ..write('id: $id, ')
          ..write('uuid: $uuid, ')
          ..write('makeId: $makeId, ')
          ..write('name: $name, ')
          ..write('isBuiltIn: $isBuiltIn, ')
          ..write('isHidden: $isHidden')
          ..write(')'))
        .toString();
  }
}

class $CargoTypesTable extends CargoTypes
    with TableInfo<$CargoTypesTable, CargoType> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CargoTypesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _uuidMeta = const VerificationMeta('uuid');
  @override
  late final GeneratedColumn<String> uuid = GeneratedColumn<String>(
    'uuid',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 150,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isBuiltInMeta = const VerificationMeta(
    'isBuiltIn',
  );
  @override
  late final GeneratedColumn<bool> isBuiltIn = GeneratedColumn<bool>(
    'is_built_in',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_built_in" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _isHiddenMeta = const VerificationMeta(
    'isHidden',
  );
  @override
  late final GeneratedColumn<bool> isHidden = GeneratedColumn<bool>(
    'is_hidden',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_hidden" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [id, uuid, name, isBuiltIn, isHidden];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cargo_types';
  @override
  VerificationContext validateIntegrity(
    Insertable<CargoType> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('uuid')) {
      context.handle(
        _uuidMeta,
        uuid.isAcceptableOrUnknown(data['uuid']!, _uuidMeta),
      );
    } else if (isInserting) {
      context.missing(_uuidMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('is_built_in')) {
      context.handle(
        _isBuiltInMeta,
        isBuiltIn.isAcceptableOrUnknown(data['is_built_in']!, _isBuiltInMeta),
      );
    }
    if (data.containsKey('is_hidden')) {
      context.handle(
        _isHiddenMeta,
        isHidden.isAcceptableOrUnknown(data['is_hidden']!, _isHiddenMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CargoType map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CargoType(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      uuid: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}uuid'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      isBuiltIn: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_built_in'],
      )!,
      isHidden: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_hidden'],
      )!,
    );
  }

  @override
  $CargoTypesTable createAlias(String alias) {
    return $CargoTypesTable(attachedDatabase, alias);
  }
}

class CargoType extends DataClass implements Insertable<CargoType> {
  final int id;
  final String uuid;
  final String name;
  final bool isBuiltIn;
  final bool isHidden;
  const CargoType({
    required this.id,
    required this.uuid,
    required this.name,
    required this.isBuiltIn,
    required this.isHidden,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['uuid'] = Variable<String>(uuid);
    map['name'] = Variable<String>(name);
    map['is_built_in'] = Variable<bool>(isBuiltIn);
    map['is_hidden'] = Variable<bool>(isHidden);
    return map;
  }

  CargoTypesCompanion toCompanion(bool nullToAbsent) {
    return CargoTypesCompanion(
      id: Value(id),
      uuid: Value(uuid),
      name: Value(name),
      isBuiltIn: Value(isBuiltIn),
      isHidden: Value(isHidden),
    );
  }

  factory CargoType.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CargoType(
      id: serializer.fromJson<int>(json['id']),
      uuid: serializer.fromJson<String>(json['uuid']),
      name: serializer.fromJson<String>(json['name']),
      isBuiltIn: serializer.fromJson<bool>(json['isBuiltIn']),
      isHidden: serializer.fromJson<bool>(json['isHidden']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'uuid': serializer.toJson<String>(uuid),
      'name': serializer.toJson<String>(name),
      'isBuiltIn': serializer.toJson<bool>(isBuiltIn),
      'isHidden': serializer.toJson<bool>(isHidden),
    };
  }

  CargoType copyWith({
    int? id,
    String? uuid,
    String? name,
    bool? isBuiltIn,
    bool? isHidden,
  }) => CargoType(
    id: id ?? this.id,
    uuid: uuid ?? this.uuid,
    name: name ?? this.name,
    isBuiltIn: isBuiltIn ?? this.isBuiltIn,
    isHidden: isHidden ?? this.isHidden,
  );
  CargoType copyWithCompanion(CargoTypesCompanion data) {
    return CargoType(
      id: data.id.present ? data.id.value : this.id,
      uuid: data.uuid.present ? data.uuid.value : this.uuid,
      name: data.name.present ? data.name.value : this.name,
      isBuiltIn: data.isBuiltIn.present ? data.isBuiltIn.value : this.isBuiltIn,
      isHidden: data.isHidden.present ? data.isHidden.value : this.isHidden,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CargoType(')
          ..write('id: $id, ')
          ..write('uuid: $uuid, ')
          ..write('name: $name, ')
          ..write('isBuiltIn: $isBuiltIn, ')
          ..write('isHidden: $isHidden')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, uuid, name, isBuiltIn, isHidden);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CargoType &&
          other.id == this.id &&
          other.uuid == this.uuid &&
          other.name == this.name &&
          other.isBuiltIn == this.isBuiltIn &&
          other.isHidden == this.isHidden);
}

class CargoTypesCompanion extends UpdateCompanion<CargoType> {
  final Value<int> id;
  final Value<String> uuid;
  final Value<String> name;
  final Value<bool> isBuiltIn;
  final Value<bool> isHidden;
  const CargoTypesCompanion({
    this.id = const Value.absent(),
    this.uuid = const Value.absent(),
    this.name = const Value.absent(),
    this.isBuiltIn = const Value.absent(),
    this.isHidden = const Value.absent(),
  });
  CargoTypesCompanion.insert({
    this.id = const Value.absent(),
    required String uuid,
    required String name,
    this.isBuiltIn = const Value.absent(),
    this.isHidden = const Value.absent(),
  }) : uuid = Value(uuid),
       name = Value(name);
  static Insertable<CargoType> custom({
    Expression<int>? id,
    Expression<String>? uuid,
    Expression<String>? name,
    Expression<bool>? isBuiltIn,
    Expression<bool>? isHidden,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (uuid != null) 'uuid': uuid,
      if (name != null) 'name': name,
      if (isBuiltIn != null) 'is_built_in': isBuiltIn,
      if (isHidden != null) 'is_hidden': isHidden,
    });
  }

  CargoTypesCompanion copyWith({
    Value<int>? id,
    Value<String>? uuid,
    Value<String>? name,
    Value<bool>? isBuiltIn,
    Value<bool>? isHidden,
  }) {
    return CargoTypesCompanion(
      id: id ?? this.id,
      uuid: uuid ?? this.uuid,
      name: name ?? this.name,
      isBuiltIn: isBuiltIn ?? this.isBuiltIn,
      isHidden: isHidden ?? this.isHidden,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (uuid.present) {
      map['uuid'] = Variable<String>(uuid.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (isBuiltIn.present) {
      map['is_built_in'] = Variable<bool>(isBuiltIn.value);
    }
    if (isHidden.present) {
      map['is_hidden'] = Variable<bool>(isHidden.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CargoTypesCompanion(')
          ..write('id: $id, ')
          ..write('uuid: $uuid, ')
          ..write('name: $name, ')
          ..write('isBuiltIn: $isBuiltIn, ')
          ..write('isHidden: $isHidden')
          ..write(')'))
        .toString();
  }
}

class $CrossingsTable extends Crossings
    with TableInfo<$CrossingsTable, Crossing> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CrossingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _uuidMeta = const VerificationMeta('uuid');
  @override
  late final GeneratedColumn<String> uuid = GeneratedColumn<String>(
    'uuid',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _companyIdMeta = const VerificationMeta(
    'companyId',
  );
  @override
  late final GeneratedColumn<int> companyId = GeneratedColumn<int>(
    'company_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES companies (id)',
    ),
  );
  static const VerificationMeta _plateNumberMeta = const VerificationMeta(
    'plateNumber',
  );
  @override
  late final GeneratedColumn<String> plateNumber = GeneratedColumn<String>(
    'plate_number',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 40,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _plateCountryMeta = const VerificationMeta(
    'plateCountry',
  );
  @override
  late final GeneratedColumn<String> plateCountry = GeneratedColumn<String>(
    'plate_country',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _plateFormatKeyMeta = const VerificationMeta(
    'plateFormatKey',
  );
  @override
  late final GeneratedColumn<String> plateFormatKey = GeneratedColumn<String>(
    'plate_format_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _makeIdMeta = const VerificationMeta('makeId');
  @override
  late final GeneratedColumn<int> makeId = GeneratedColumn<int>(
    'make_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES vehicle_makes (id)',
    ),
  );
  static const VerificationMeta _modelIdMeta = const VerificationMeta(
    'modelId',
  );
  @override
  late final GeneratedColumn<int> modelId = GeneratedColumn<int>(
    'model_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES vehicle_models (id)',
    ),
  );
  static const VerificationMeta _cargoTypeIdMeta = const VerificationMeta(
    'cargoTypeId',
  );
  @override
  late final GeneratedColumn<int> cargoTypeId = GeneratedColumn<int>(
    'cargo_type_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES cargo_types (id)',
    ),
  );
  static const VerificationMeta _cargoQuantityMeta = const VerificationMeta(
    'cargoQuantity',
  );
  @override
  late final GeneratedColumn<double> cargoQuantity = GeneratedColumn<double>(
    'cargo_quantity',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _quantityUnitMeta = const VerificationMeta(
    'quantityUnit',
  );
  @override
  late final GeneratedColumn<String> quantityUnit = GeneratedColumn<String>(
    'quantity_unit',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _crossedAtMeta = const VerificationMeta(
    'crossedAt',
  );
  @override
  late final GeneratedColumn<DateTime> crossedAt = GeneratedColumn<DateTime>(
    'crossed_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _latitudeMeta = const VerificationMeta(
    'latitude',
  );
  @override
  late final GeneratedColumn<double> latitude = GeneratedColumn<double>(
    'latitude',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _longitudeMeta = const VerificationMeta(
    'longitude',
  );
  @override
  late final GeneratedColumn<double> longitude = GeneratedColumn<double>(
    'longitude',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _serverIdMeta = const VerificationMeta(
    'serverId',
  );
  @override
  late final GeneratedColumn<int> serverId = GeneratedColumn<int>(
    'server_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _syncStatusMeta = const VerificationMeta(
    'syncStatus',
  );
  @override
  late final GeneratedColumn<String> syncStatus = GeneratedColumn<String>(
    'sync_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('local'),
  );
  static const VerificationMeta _isDeletedMeta = const VerificationMeta(
    'isDeleted',
  );
  @override
  late final GeneratedColumn<bool> isDeleted = GeneratedColumn<bool>(
    'is_deleted',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_deleted" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    uuid,
    companyId,
    plateNumber,
    plateCountry,
    plateFormatKey,
    makeId,
    modelId,
    cargoTypeId,
    cargoQuantity,
    quantityUnit,
    crossedAt,
    latitude,
    longitude,
    note,
    createdAt,
    updatedAt,
    serverId,
    syncStatus,
    isDeleted,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'crossings';
  @override
  VerificationContext validateIntegrity(
    Insertable<Crossing> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('uuid')) {
      context.handle(
        _uuidMeta,
        uuid.isAcceptableOrUnknown(data['uuid']!, _uuidMeta),
      );
    } else if (isInserting) {
      context.missing(_uuidMeta);
    }
    if (data.containsKey('company_id')) {
      context.handle(
        _companyIdMeta,
        companyId.isAcceptableOrUnknown(data['company_id']!, _companyIdMeta),
      );
    } else if (isInserting) {
      context.missing(_companyIdMeta);
    }
    if (data.containsKey('plate_number')) {
      context.handle(
        _plateNumberMeta,
        plateNumber.isAcceptableOrUnknown(
          data['plate_number']!,
          _plateNumberMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_plateNumberMeta);
    }
    if (data.containsKey('plate_country')) {
      context.handle(
        _plateCountryMeta,
        plateCountry.isAcceptableOrUnknown(
          data['plate_country']!,
          _plateCountryMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_plateCountryMeta);
    }
    if (data.containsKey('plate_format_key')) {
      context.handle(
        _plateFormatKeyMeta,
        plateFormatKey.isAcceptableOrUnknown(
          data['plate_format_key']!,
          _plateFormatKeyMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_plateFormatKeyMeta);
    }
    if (data.containsKey('make_id')) {
      context.handle(
        _makeIdMeta,
        makeId.isAcceptableOrUnknown(data['make_id']!, _makeIdMeta),
      );
    } else if (isInserting) {
      context.missing(_makeIdMeta);
    }
    if (data.containsKey('model_id')) {
      context.handle(
        _modelIdMeta,
        modelId.isAcceptableOrUnknown(data['model_id']!, _modelIdMeta),
      );
    }
    if (data.containsKey('cargo_type_id')) {
      context.handle(
        _cargoTypeIdMeta,
        cargoTypeId.isAcceptableOrUnknown(
          data['cargo_type_id']!,
          _cargoTypeIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_cargoTypeIdMeta);
    }
    if (data.containsKey('cargo_quantity')) {
      context.handle(
        _cargoQuantityMeta,
        cargoQuantity.isAcceptableOrUnknown(
          data['cargo_quantity']!,
          _cargoQuantityMeta,
        ),
      );
    }
    if (data.containsKey('quantity_unit')) {
      context.handle(
        _quantityUnitMeta,
        quantityUnit.isAcceptableOrUnknown(
          data['quantity_unit']!,
          _quantityUnitMeta,
        ),
      );
    }
    if (data.containsKey('crossed_at')) {
      context.handle(
        _crossedAtMeta,
        crossedAt.isAcceptableOrUnknown(data['crossed_at']!, _crossedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_crossedAtMeta);
    }
    if (data.containsKey('latitude')) {
      context.handle(
        _latitudeMeta,
        latitude.isAcceptableOrUnknown(data['latitude']!, _latitudeMeta),
      );
    }
    if (data.containsKey('longitude')) {
      context.handle(
        _longitudeMeta,
        longitude.isAcceptableOrUnknown(data['longitude']!, _longitudeMeta),
      );
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('server_id')) {
      context.handle(
        _serverIdMeta,
        serverId.isAcceptableOrUnknown(data['server_id']!, _serverIdMeta),
      );
    }
    if (data.containsKey('sync_status')) {
      context.handle(
        _syncStatusMeta,
        syncStatus.isAcceptableOrUnknown(data['sync_status']!, _syncStatusMeta),
      );
    }
    if (data.containsKey('is_deleted')) {
      context.handle(
        _isDeletedMeta,
        isDeleted.isAcceptableOrUnknown(data['is_deleted']!, _isDeletedMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Crossing map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Crossing(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      uuid: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}uuid'],
      )!,
      companyId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}company_id'],
      )!,
      plateNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}plate_number'],
      )!,
      plateCountry: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}plate_country'],
      )!,
      plateFormatKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}plate_format_key'],
      )!,
      makeId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}make_id'],
      )!,
      modelId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}model_id'],
      ),
      cargoTypeId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}cargo_type_id'],
      )!,
      cargoQuantity: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}cargo_quantity'],
      ),
      quantityUnit: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}quantity_unit'],
      ),
      crossedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}crossed_at'],
      )!,
      latitude: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}latitude'],
      ),
      longitude: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}longitude'],
      ),
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      serverId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}server_id'],
      ),
      syncStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sync_status'],
      )!,
      isDeleted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_deleted'],
      )!,
    );
  }

  @override
  $CrossingsTable createAlias(String alias) {
    return $CrossingsTable(attachedDatabase, alias);
  }
}

class Crossing extends DataClass implements Insertable<Crossing> {
  final int id;
  final String uuid;
  final int companyId;
  final String plateNumber;
  final String plateCountry;
  final String plateFormatKey;
  final int makeId;
  final int? modelId;
  final int cargoTypeId;
  final double? cargoQuantity;
  final String? quantityUnit;
  final DateTime crossedAt;
  final double? latitude;
  final double? longitude;
  final String? note;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int? serverId;
  final String syncStatus;
  final bool isDeleted;
  const Crossing({
    required this.id,
    required this.uuid,
    required this.companyId,
    required this.plateNumber,
    required this.plateCountry,
    required this.plateFormatKey,
    required this.makeId,
    this.modelId,
    required this.cargoTypeId,
    this.cargoQuantity,
    this.quantityUnit,
    required this.crossedAt,
    this.latitude,
    this.longitude,
    this.note,
    required this.createdAt,
    required this.updatedAt,
    this.serverId,
    required this.syncStatus,
    required this.isDeleted,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['uuid'] = Variable<String>(uuid);
    map['company_id'] = Variable<int>(companyId);
    map['plate_number'] = Variable<String>(plateNumber);
    map['plate_country'] = Variable<String>(plateCountry);
    map['plate_format_key'] = Variable<String>(plateFormatKey);
    map['make_id'] = Variable<int>(makeId);
    if (!nullToAbsent || modelId != null) {
      map['model_id'] = Variable<int>(modelId);
    }
    map['cargo_type_id'] = Variable<int>(cargoTypeId);
    if (!nullToAbsent || cargoQuantity != null) {
      map['cargo_quantity'] = Variable<double>(cargoQuantity);
    }
    if (!nullToAbsent || quantityUnit != null) {
      map['quantity_unit'] = Variable<String>(quantityUnit);
    }
    map['crossed_at'] = Variable<DateTime>(crossedAt);
    if (!nullToAbsent || latitude != null) {
      map['latitude'] = Variable<double>(latitude);
    }
    if (!nullToAbsent || longitude != null) {
      map['longitude'] = Variable<double>(longitude);
    }
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || serverId != null) {
      map['server_id'] = Variable<int>(serverId);
    }
    map['sync_status'] = Variable<String>(syncStatus);
    map['is_deleted'] = Variable<bool>(isDeleted);
    return map;
  }

  CrossingsCompanion toCompanion(bool nullToAbsent) {
    return CrossingsCompanion(
      id: Value(id),
      uuid: Value(uuid),
      companyId: Value(companyId),
      plateNumber: Value(plateNumber),
      plateCountry: Value(plateCountry),
      plateFormatKey: Value(plateFormatKey),
      makeId: Value(makeId),
      modelId: modelId == null && nullToAbsent
          ? const Value.absent()
          : Value(modelId),
      cargoTypeId: Value(cargoTypeId),
      cargoQuantity: cargoQuantity == null && nullToAbsent
          ? const Value.absent()
          : Value(cargoQuantity),
      quantityUnit: quantityUnit == null && nullToAbsent
          ? const Value.absent()
          : Value(quantityUnit),
      crossedAt: Value(crossedAt),
      latitude: latitude == null && nullToAbsent
          ? const Value.absent()
          : Value(latitude),
      longitude: longitude == null && nullToAbsent
          ? const Value.absent()
          : Value(longitude),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      serverId: serverId == null && nullToAbsent
          ? const Value.absent()
          : Value(serverId),
      syncStatus: Value(syncStatus),
      isDeleted: Value(isDeleted),
    );
  }

  factory Crossing.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Crossing(
      id: serializer.fromJson<int>(json['id']),
      uuid: serializer.fromJson<String>(json['uuid']),
      companyId: serializer.fromJson<int>(json['companyId']),
      plateNumber: serializer.fromJson<String>(json['plateNumber']),
      plateCountry: serializer.fromJson<String>(json['plateCountry']),
      plateFormatKey: serializer.fromJson<String>(json['plateFormatKey']),
      makeId: serializer.fromJson<int>(json['makeId']),
      modelId: serializer.fromJson<int?>(json['modelId']),
      cargoTypeId: serializer.fromJson<int>(json['cargoTypeId']),
      cargoQuantity: serializer.fromJson<double?>(json['cargoQuantity']),
      quantityUnit: serializer.fromJson<String?>(json['quantityUnit']),
      crossedAt: serializer.fromJson<DateTime>(json['crossedAt']),
      latitude: serializer.fromJson<double?>(json['latitude']),
      longitude: serializer.fromJson<double?>(json['longitude']),
      note: serializer.fromJson<String?>(json['note']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      serverId: serializer.fromJson<int?>(json['serverId']),
      syncStatus: serializer.fromJson<String>(json['syncStatus']),
      isDeleted: serializer.fromJson<bool>(json['isDeleted']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'uuid': serializer.toJson<String>(uuid),
      'companyId': serializer.toJson<int>(companyId),
      'plateNumber': serializer.toJson<String>(plateNumber),
      'plateCountry': serializer.toJson<String>(plateCountry),
      'plateFormatKey': serializer.toJson<String>(plateFormatKey),
      'makeId': serializer.toJson<int>(makeId),
      'modelId': serializer.toJson<int?>(modelId),
      'cargoTypeId': serializer.toJson<int>(cargoTypeId),
      'cargoQuantity': serializer.toJson<double?>(cargoQuantity),
      'quantityUnit': serializer.toJson<String?>(quantityUnit),
      'crossedAt': serializer.toJson<DateTime>(crossedAt),
      'latitude': serializer.toJson<double?>(latitude),
      'longitude': serializer.toJson<double?>(longitude),
      'note': serializer.toJson<String?>(note),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'serverId': serializer.toJson<int?>(serverId),
      'syncStatus': serializer.toJson<String>(syncStatus),
      'isDeleted': serializer.toJson<bool>(isDeleted),
    };
  }

  Crossing copyWith({
    int? id,
    String? uuid,
    int? companyId,
    String? plateNumber,
    String? plateCountry,
    String? plateFormatKey,
    int? makeId,
    Value<int?> modelId = const Value.absent(),
    int? cargoTypeId,
    Value<double?> cargoQuantity = const Value.absent(),
    Value<String?> quantityUnit = const Value.absent(),
    DateTime? crossedAt,
    Value<double?> latitude = const Value.absent(),
    Value<double?> longitude = const Value.absent(),
    Value<String?> note = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<int?> serverId = const Value.absent(),
    String? syncStatus,
    bool? isDeleted,
  }) => Crossing(
    id: id ?? this.id,
    uuid: uuid ?? this.uuid,
    companyId: companyId ?? this.companyId,
    plateNumber: plateNumber ?? this.plateNumber,
    plateCountry: plateCountry ?? this.plateCountry,
    plateFormatKey: plateFormatKey ?? this.plateFormatKey,
    makeId: makeId ?? this.makeId,
    modelId: modelId.present ? modelId.value : this.modelId,
    cargoTypeId: cargoTypeId ?? this.cargoTypeId,
    cargoQuantity: cargoQuantity.present
        ? cargoQuantity.value
        : this.cargoQuantity,
    quantityUnit: quantityUnit.present ? quantityUnit.value : this.quantityUnit,
    crossedAt: crossedAt ?? this.crossedAt,
    latitude: latitude.present ? latitude.value : this.latitude,
    longitude: longitude.present ? longitude.value : this.longitude,
    note: note.present ? note.value : this.note,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    serverId: serverId.present ? serverId.value : this.serverId,
    syncStatus: syncStatus ?? this.syncStatus,
    isDeleted: isDeleted ?? this.isDeleted,
  );
  Crossing copyWithCompanion(CrossingsCompanion data) {
    return Crossing(
      id: data.id.present ? data.id.value : this.id,
      uuid: data.uuid.present ? data.uuid.value : this.uuid,
      companyId: data.companyId.present ? data.companyId.value : this.companyId,
      plateNumber: data.plateNumber.present
          ? data.plateNumber.value
          : this.plateNumber,
      plateCountry: data.plateCountry.present
          ? data.plateCountry.value
          : this.plateCountry,
      plateFormatKey: data.plateFormatKey.present
          ? data.plateFormatKey.value
          : this.plateFormatKey,
      makeId: data.makeId.present ? data.makeId.value : this.makeId,
      modelId: data.modelId.present ? data.modelId.value : this.modelId,
      cargoTypeId: data.cargoTypeId.present
          ? data.cargoTypeId.value
          : this.cargoTypeId,
      cargoQuantity: data.cargoQuantity.present
          ? data.cargoQuantity.value
          : this.cargoQuantity,
      quantityUnit: data.quantityUnit.present
          ? data.quantityUnit.value
          : this.quantityUnit,
      crossedAt: data.crossedAt.present ? data.crossedAt.value : this.crossedAt,
      latitude: data.latitude.present ? data.latitude.value : this.latitude,
      longitude: data.longitude.present ? data.longitude.value : this.longitude,
      note: data.note.present ? data.note.value : this.note,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      serverId: data.serverId.present ? data.serverId.value : this.serverId,
      syncStatus: data.syncStatus.present
          ? data.syncStatus.value
          : this.syncStatus,
      isDeleted: data.isDeleted.present ? data.isDeleted.value : this.isDeleted,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Crossing(')
          ..write('id: $id, ')
          ..write('uuid: $uuid, ')
          ..write('companyId: $companyId, ')
          ..write('plateNumber: $plateNumber, ')
          ..write('plateCountry: $plateCountry, ')
          ..write('plateFormatKey: $plateFormatKey, ')
          ..write('makeId: $makeId, ')
          ..write('modelId: $modelId, ')
          ..write('cargoTypeId: $cargoTypeId, ')
          ..write('cargoQuantity: $cargoQuantity, ')
          ..write('quantityUnit: $quantityUnit, ')
          ..write('crossedAt: $crossedAt, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('note: $note, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('serverId: $serverId, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('isDeleted: $isDeleted')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    uuid,
    companyId,
    plateNumber,
    plateCountry,
    plateFormatKey,
    makeId,
    modelId,
    cargoTypeId,
    cargoQuantity,
    quantityUnit,
    crossedAt,
    latitude,
    longitude,
    note,
    createdAt,
    updatedAt,
    serverId,
    syncStatus,
    isDeleted,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Crossing &&
          other.id == this.id &&
          other.uuid == this.uuid &&
          other.companyId == this.companyId &&
          other.plateNumber == this.plateNumber &&
          other.plateCountry == this.plateCountry &&
          other.plateFormatKey == this.plateFormatKey &&
          other.makeId == this.makeId &&
          other.modelId == this.modelId &&
          other.cargoTypeId == this.cargoTypeId &&
          other.cargoQuantity == this.cargoQuantity &&
          other.quantityUnit == this.quantityUnit &&
          other.crossedAt == this.crossedAt &&
          other.latitude == this.latitude &&
          other.longitude == this.longitude &&
          other.note == this.note &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.serverId == this.serverId &&
          other.syncStatus == this.syncStatus &&
          other.isDeleted == this.isDeleted);
}

class CrossingsCompanion extends UpdateCompanion<Crossing> {
  final Value<int> id;
  final Value<String> uuid;
  final Value<int> companyId;
  final Value<String> plateNumber;
  final Value<String> plateCountry;
  final Value<String> plateFormatKey;
  final Value<int> makeId;
  final Value<int?> modelId;
  final Value<int> cargoTypeId;
  final Value<double?> cargoQuantity;
  final Value<String?> quantityUnit;
  final Value<DateTime> crossedAt;
  final Value<double?> latitude;
  final Value<double?> longitude;
  final Value<String?> note;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int?> serverId;
  final Value<String> syncStatus;
  final Value<bool> isDeleted;
  const CrossingsCompanion({
    this.id = const Value.absent(),
    this.uuid = const Value.absent(),
    this.companyId = const Value.absent(),
    this.plateNumber = const Value.absent(),
    this.plateCountry = const Value.absent(),
    this.plateFormatKey = const Value.absent(),
    this.makeId = const Value.absent(),
    this.modelId = const Value.absent(),
    this.cargoTypeId = const Value.absent(),
    this.cargoQuantity = const Value.absent(),
    this.quantityUnit = const Value.absent(),
    this.crossedAt = const Value.absent(),
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
    this.note = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.serverId = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.isDeleted = const Value.absent(),
  });
  CrossingsCompanion.insert({
    this.id = const Value.absent(),
    required String uuid,
    required int companyId,
    required String plateNumber,
    required String plateCountry,
    required String plateFormatKey,
    required int makeId,
    this.modelId = const Value.absent(),
    required int cargoTypeId,
    this.cargoQuantity = const Value.absent(),
    this.quantityUnit = const Value.absent(),
    required DateTime crossedAt,
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
    this.note = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.serverId = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.isDeleted = const Value.absent(),
  }) : uuid = Value(uuid),
       companyId = Value(companyId),
       plateNumber = Value(plateNumber),
       plateCountry = Value(plateCountry),
       plateFormatKey = Value(plateFormatKey),
       makeId = Value(makeId),
       cargoTypeId = Value(cargoTypeId),
       crossedAt = Value(crossedAt),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<Crossing> custom({
    Expression<int>? id,
    Expression<String>? uuid,
    Expression<int>? companyId,
    Expression<String>? plateNumber,
    Expression<String>? plateCountry,
    Expression<String>? plateFormatKey,
    Expression<int>? makeId,
    Expression<int>? modelId,
    Expression<int>? cargoTypeId,
    Expression<double>? cargoQuantity,
    Expression<String>? quantityUnit,
    Expression<DateTime>? crossedAt,
    Expression<double>? latitude,
    Expression<double>? longitude,
    Expression<String>? note,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? serverId,
    Expression<String>? syncStatus,
    Expression<bool>? isDeleted,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (uuid != null) 'uuid': uuid,
      if (companyId != null) 'company_id': companyId,
      if (plateNumber != null) 'plate_number': plateNumber,
      if (plateCountry != null) 'plate_country': plateCountry,
      if (plateFormatKey != null) 'plate_format_key': plateFormatKey,
      if (makeId != null) 'make_id': makeId,
      if (modelId != null) 'model_id': modelId,
      if (cargoTypeId != null) 'cargo_type_id': cargoTypeId,
      if (cargoQuantity != null) 'cargo_quantity': cargoQuantity,
      if (quantityUnit != null) 'quantity_unit': quantityUnit,
      if (crossedAt != null) 'crossed_at': crossedAt,
      if (latitude != null) 'latitude': latitude,
      if (longitude != null) 'longitude': longitude,
      if (note != null) 'note': note,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (serverId != null) 'server_id': serverId,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (isDeleted != null) 'is_deleted': isDeleted,
    });
  }

  CrossingsCompanion copyWith({
    Value<int>? id,
    Value<String>? uuid,
    Value<int>? companyId,
    Value<String>? plateNumber,
    Value<String>? plateCountry,
    Value<String>? plateFormatKey,
    Value<int>? makeId,
    Value<int?>? modelId,
    Value<int>? cargoTypeId,
    Value<double?>? cargoQuantity,
    Value<String?>? quantityUnit,
    Value<DateTime>? crossedAt,
    Value<double?>? latitude,
    Value<double?>? longitude,
    Value<String?>? note,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int?>? serverId,
    Value<String>? syncStatus,
    Value<bool>? isDeleted,
  }) {
    return CrossingsCompanion(
      id: id ?? this.id,
      uuid: uuid ?? this.uuid,
      companyId: companyId ?? this.companyId,
      plateNumber: plateNumber ?? this.plateNumber,
      plateCountry: plateCountry ?? this.plateCountry,
      plateFormatKey: plateFormatKey ?? this.plateFormatKey,
      makeId: makeId ?? this.makeId,
      modelId: modelId ?? this.modelId,
      cargoTypeId: cargoTypeId ?? this.cargoTypeId,
      cargoQuantity: cargoQuantity ?? this.cargoQuantity,
      quantityUnit: quantityUnit ?? this.quantityUnit,
      crossedAt: crossedAt ?? this.crossedAt,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      note: note ?? this.note,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      serverId: serverId ?? this.serverId,
      syncStatus: syncStatus ?? this.syncStatus,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (uuid.present) {
      map['uuid'] = Variable<String>(uuid.value);
    }
    if (companyId.present) {
      map['company_id'] = Variable<int>(companyId.value);
    }
    if (plateNumber.present) {
      map['plate_number'] = Variable<String>(plateNumber.value);
    }
    if (plateCountry.present) {
      map['plate_country'] = Variable<String>(plateCountry.value);
    }
    if (plateFormatKey.present) {
      map['plate_format_key'] = Variable<String>(plateFormatKey.value);
    }
    if (makeId.present) {
      map['make_id'] = Variable<int>(makeId.value);
    }
    if (modelId.present) {
      map['model_id'] = Variable<int>(modelId.value);
    }
    if (cargoTypeId.present) {
      map['cargo_type_id'] = Variable<int>(cargoTypeId.value);
    }
    if (cargoQuantity.present) {
      map['cargo_quantity'] = Variable<double>(cargoQuantity.value);
    }
    if (quantityUnit.present) {
      map['quantity_unit'] = Variable<String>(quantityUnit.value);
    }
    if (crossedAt.present) {
      map['crossed_at'] = Variable<DateTime>(crossedAt.value);
    }
    if (latitude.present) {
      map['latitude'] = Variable<double>(latitude.value);
    }
    if (longitude.present) {
      map['longitude'] = Variable<double>(longitude.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (serverId.present) {
      map['server_id'] = Variable<int>(serverId.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(syncStatus.value);
    }
    if (isDeleted.present) {
      map['is_deleted'] = Variable<bool>(isDeleted.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CrossingsCompanion(')
          ..write('id: $id, ')
          ..write('uuid: $uuid, ')
          ..write('companyId: $companyId, ')
          ..write('plateNumber: $plateNumber, ')
          ..write('plateCountry: $plateCountry, ')
          ..write('plateFormatKey: $plateFormatKey, ')
          ..write('makeId: $makeId, ')
          ..write('modelId: $modelId, ')
          ..write('cargoTypeId: $cargoTypeId, ')
          ..write('cargoQuantity: $cargoQuantity, ')
          ..write('quantityUnit: $quantityUnit, ')
          ..write('crossedAt: $crossedAt, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('note: $note, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('serverId: $serverId, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('isDeleted: $isDeleted')
          ..write(')'))
        .toString();
  }
}

class $CrossingPhotosTable extends CrossingPhotos
    with TableInfo<$CrossingPhotosTable, CrossingPhoto> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CrossingPhotosTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _uuidMeta = const VerificationMeta('uuid');
  @override
  late final GeneratedColumn<String> uuid = GeneratedColumn<String>(
    'uuid',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _crossingIdMeta = const VerificationMeta(
    'crossingId',
  );
  @override
  late final GeneratedColumn<int> crossingId = GeneratedColumn<int>(
    'crossing_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES crossings (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _filePathMeta = const VerificationMeta(
    'filePath',
  );
  @override
  late final GeneratedColumn<String> filePath = GeneratedColumn<String>(
    'file_path',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _thumbPathMeta = const VerificationMeta(
    'thumbPath',
  );
  @override
  late final GeneratedColumn<String> thumbPath = GeneratedColumn<String>(
    'thumb_path',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    uuid,
    crossingId,
    filePath,
    thumbPath,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'crossing_photos';
  @override
  VerificationContext validateIntegrity(
    Insertable<CrossingPhoto> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('uuid')) {
      context.handle(
        _uuidMeta,
        uuid.isAcceptableOrUnknown(data['uuid']!, _uuidMeta),
      );
    } else if (isInserting) {
      context.missing(_uuidMeta);
    }
    if (data.containsKey('crossing_id')) {
      context.handle(
        _crossingIdMeta,
        crossingId.isAcceptableOrUnknown(data['crossing_id']!, _crossingIdMeta),
      );
    } else if (isInserting) {
      context.missing(_crossingIdMeta);
    }
    if (data.containsKey('file_path')) {
      context.handle(
        _filePathMeta,
        filePath.isAcceptableOrUnknown(data['file_path']!, _filePathMeta),
      );
    } else if (isInserting) {
      context.missing(_filePathMeta);
    }
    if (data.containsKey('thumb_path')) {
      context.handle(
        _thumbPathMeta,
        thumbPath.isAcceptableOrUnknown(data['thumb_path']!, _thumbPathMeta),
      );
    } else if (isInserting) {
      context.missing(_thumbPathMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CrossingPhoto map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CrossingPhoto(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      uuid: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}uuid'],
      )!,
      crossingId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}crossing_id'],
      )!,
      filePath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}file_path'],
      )!,
      thumbPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}thumb_path'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $CrossingPhotosTable createAlias(String alias) {
    return $CrossingPhotosTable(attachedDatabase, alias);
  }
}

class CrossingPhoto extends DataClass implements Insertable<CrossingPhoto> {
  final int id;
  final String uuid;
  final int crossingId;
  final String filePath;
  final String thumbPath;
  final DateTime createdAt;
  const CrossingPhoto({
    required this.id,
    required this.uuid,
    required this.crossingId,
    required this.filePath,
    required this.thumbPath,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['uuid'] = Variable<String>(uuid);
    map['crossing_id'] = Variable<int>(crossingId);
    map['file_path'] = Variable<String>(filePath);
    map['thumb_path'] = Variable<String>(thumbPath);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  CrossingPhotosCompanion toCompanion(bool nullToAbsent) {
    return CrossingPhotosCompanion(
      id: Value(id),
      uuid: Value(uuid),
      crossingId: Value(crossingId),
      filePath: Value(filePath),
      thumbPath: Value(thumbPath),
      createdAt: Value(createdAt),
    );
  }

  factory CrossingPhoto.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CrossingPhoto(
      id: serializer.fromJson<int>(json['id']),
      uuid: serializer.fromJson<String>(json['uuid']),
      crossingId: serializer.fromJson<int>(json['crossingId']),
      filePath: serializer.fromJson<String>(json['filePath']),
      thumbPath: serializer.fromJson<String>(json['thumbPath']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'uuid': serializer.toJson<String>(uuid),
      'crossingId': serializer.toJson<int>(crossingId),
      'filePath': serializer.toJson<String>(filePath),
      'thumbPath': serializer.toJson<String>(thumbPath),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  CrossingPhoto copyWith({
    int? id,
    String? uuid,
    int? crossingId,
    String? filePath,
    String? thumbPath,
    DateTime? createdAt,
  }) => CrossingPhoto(
    id: id ?? this.id,
    uuid: uuid ?? this.uuid,
    crossingId: crossingId ?? this.crossingId,
    filePath: filePath ?? this.filePath,
    thumbPath: thumbPath ?? this.thumbPath,
    createdAt: createdAt ?? this.createdAt,
  );
  CrossingPhoto copyWithCompanion(CrossingPhotosCompanion data) {
    return CrossingPhoto(
      id: data.id.present ? data.id.value : this.id,
      uuid: data.uuid.present ? data.uuid.value : this.uuid,
      crossingId: data.crossingId.present
          ? data.crossingId.value
          : this.crossingId,
      filePath: data.filePath.present ? data.filePath.value : this.filePath,
      thumbPath: data.thumbPath.present ? data.thumbPath.value : this.thumbPath,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CrossingPhoto(')
          ..write('id: $id, ')
          ..write('uuid: $uuid, ')
          ..write('crossingId: $crossingId, ')
          ..write('filePath: $filePath, ')
          ..write('thumbPath: $thumbPath, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, uuid, crossingId, filePath, thumbPath, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CrossingPhoto &&
          other.id == this.id &&
          other.uuid == this.uuid &&
          other.crossingId == this.crossingId &&
          other.filePath == this.filePath &&
          other.thumbPath == this.thumbPath &&
          other.createdAt == this.createdAt);
}

class CrossingPhotosCompanion extends UpdateCompanion<CrossingPhoto> {
  final Value<int> id;
  final Value<String> uuid;
  final Value<int> crossingId;
  final Value<String> filePath;
  final Value<String> thumbPath;
  final Value<DateTime> createdAt;
  const CrossingPhotosCompanion({
    this.id = const Value.absent(),
    this.uuid = const Value.absent(),
    this.crossingId = const Value.absent(),
    this.filePath = const Value.absent(),
    this.thumbPath = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  CrossingPhotosCompanion.insert({
    this.id = const Value.absent(),
    required String uuid,
    required int crossingId,
    required String filePath,
    required String thumbPath,
    required DateTime createdAt,
  }) : uuid = Value(uuid),
       crossingId = Value(crossingId),
       filePath = Value(filePath),
       thumbPath = Value(thumbPath),
       createdAt = Value(createdAt);
  static Insertable<CrossingPhoto> custom({
    Expression<int>? id,
    Expression<String>? uuid,
    Expression<int>? crossingId,
    Expression<String>? filePath,
    Expression<String>? thumbPath,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (uuid != null) 'uuid': uuid,
      if (crossingId != null) 'crossing_id': crossingId,
      if (filePath != null) 'file_path': filePath,
      if (thumbPath != null) 'thumb_path': thumbPath,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  CrossingPhotosCompanion copyWith({
    Value<int>? id,
    Value<String>? uuid,
    Value<int>? crossingId,
    Value<String>? filePath,
    Value<String>? thumbPath,
    Value<DateTime>? createdAt,
  }) {
    return CrossingPhotosCompanion(
      id: id ?? this.id,
      uuid: uuid ?? this.uuid,
      crossingId: crossingId ?? this.crossingId,
      filePath: filePath ?? this.filePath,
      thumbPath: thumbPath ?? this.thumbPath,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (uuid.present) {
      map['uuid'] = Variable<String>(uuid.value);
    }
    if (crossingId.present) {
      map['crossing_id'] = Variable<int>(crossingId.value);
    }
    if (filePath.present) {
      map['file_path'] = Variable<String>(filePath.value);
    }
    if (thumbPath.present) {
      map['thumb_path'] = Variable<String>(thumbPath.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CrossingPhotosCompanion(')
          ..write('id: $id, ')
          ..write('uuid: $uuid, ')
          ..write('crossingId: $crossingId, ')
          ..write('filePath: $filePath, ')
          ..write('thumbPath: $thumbPath, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $ChangeHistoryTable extends ChangeHistory
    with TableInfo<$ChangeHistoryTable, ChangeHistoryData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ChangeHistoryTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _crossingIdMeta = const VerificationMeta(
    'crossingId',
  );
  @override
  late final GeneratedColumn<int> crossingId = GeneratedColumn<int>(
    'crossing_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _changeTypeMeta = const VerificationMeta(
    'changeType',
  );
  @override
  late final GeneratedColumn<String> changeType = GeneratedColumn<String>(
    'change_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _snapshotJsonMeta = const VerificationMeta(
    'snapshotJson',
  );
  @override
  late final GeneratedColumn<String> snapshotJson = GeneratedColumn<String>(
    'snapshot_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _changedAtMeta = const VerificationMeta(
    'changedAt',
  );
  @override
  late final GeneratedColumn<DateTime> changedAt = GeneratedColumn<DateTime>(
    'changed_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _changedByMeta = const VerificationMeta(
    'changedBy',
  );
  @override
  late final GeneratedColumn<String> changedBy = GeneratedColumn<String>(
    'changed_by',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('local'),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    crossingId,
    changeType,
    snapshotJson,
    changedAt,
    changedBy,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'change_history';
  @override
  VerificationContext validateIntegrity(
    Insertable<ChangeHistoryData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('crossing_id')) {
      context.handle(
        _crossingIdMeta,
        crossingId.isAcceptableOrUnknown(data['crossing_id']!, _crossingIdMeta),
      );
    } else if (isInserting) {
      context.missing(_crossingIdMeta);
    }
    if (data.containsKey('change_type')) {
      context.handle(
        _changeTypeMeta,
        changeType.isAcceptableOrUnknown(data['change_type']!, _changeTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_changeTypeMeta);
    }
    if (data.containsKey('snapshot_json')) {
      context.handle(
        _snapshotJsonMeta,
        snapshotJson.isAcceptableOrUnknown(
          data['snapshot_json']!,
          _snapshotJsonMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_snapshotJsonMeta);
    }
    if (data.containsKey('changed_at')) {
      context.handle(
        _changedAtMeta,
        changedAt.isAcceptableOrUnknown(data['changed_at']!, _changedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_changedAtMeta);
    }
    if (data.containsKey('changed_by')) {
      context.handle(
        _changedByMeta,
        changedBy.isAcceptableOrUnknown(data['changed_by']!, _changedByMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ChangeHistoryData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ChangeHistoryData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      crossingId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}crossing_id'],
      )!,
      changeType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}change_type'],
      )!,
      snapshotJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}snapshot_json'],
      )!,
      changedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}changed_at'],
      )!,
      changedBy: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}changed_by'],
      )!,
    );
  }

  @override
  $ChangeHistoryTable createAlias(String alias) {
    return $ChangeHistoryTable(attachedDatabase, alias);
  }
}

class ChangeHistoryData extends DataClass
    implements Insertable<ChangeHistoryData> {
  final int id;
  final int crossingId;
  final String changeType;
  final String snapshotJson;
  final DateTime changedAt;
  final String changedBy;
  const ChangeHistoryData({
    required this.id,
    required this.crossingId,
    required this.changeType,
    required this.snapshotJson,
    required this.changedAt,
    required this.changedBy,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['crossing_id'] = Variable<int>(crossingId);
    map['change_type'] = Variable<String>(changeType);
    map['snapshot_json'] = Variable<String>(snapshotJson);
    map['changed_at'] = Variable<DateTime>(changedAt);
    map['changed_by'] = Variable<String>(changedBy);
    return map;
  }

  ChangeHistoryCompanion toCompanion(bool nullToAbsent) {
    return ChangeHistoryCompanion(
      id: Value(id),
      crossingId: Value(crossingId),
      changeType: Value(changeType),
      snapshotJson: Value(snapshotJson),
      changedAt: Value(changedAt),
      changedBy: Value(changedBy),
    );
  }

  factory ChangeHistoryData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ChangeHistoryData(
      id: serializer.fromJson<int>(json['id']),
      crossingId: serializer.fromJson<int>(json['crossingId']),
      changeType: serializer.fromJson<String>(json['changeType']),
      snapshotJson: serializer.fromJson<String>(json['snapshotJson']),
      changedAt: serializer.fromJson<DateTime>(json['changedAt']),
      changedBy: serializer.fromJson<String>(json['changedBy']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'crossingId': serializer.toJson<int>(crossingId),
      'changeType': serializer.toJson<String>(changeType),
      'snapshotJson': serializer.toJson<String>(snapshotJson),
      'changedAt': serializer.toJson<DateTime>(changedAt),
      'changedBy': serializer.toJson<String>(changedBy),
    };
  }

  ChangeHistoryData copyWith({
    int? id,
    int? crossingId,
    String? changeType,
    String? snapshotJson,
    DateTime? changedAt,
    String? changedBy,
  }) => ChangeHistoryData(
    id: id ?? this.id,
    crossingId: crossingId ?? this.crossingId,
    changeType: changeType ?? this.changeType,
    snapshotJson: snapshotJson ?? this.snapshotJson,
    changedAt: changedAt ?? this.changedAt,
    changedBy: changedBy ?? this.changedBy,
  );
  ChangeHistoryData copyWithCompanion(ChangeHistoryCompanion data) {
    return ChangeHistoryData(
      id: data.id.present ? data.id.value : this.id,
      crossingId: data.crossingId.present
          ? data.crossingId.value
          : this.crossingId,
      changeType: data.changeType.present
          ? data.changeType.value
          : this.changeType,
      snapshotJson: data.snapshotJson.present
          ? data.snapshotJson.value
          : this.snapshotJson,
      changedAt: data.changedAt.present ? data.changedAt.value : this.changedAt,
      changedBy: data.changedBy.present ? data.changedBy.value : this.changedBy,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ChangeHistoryData(')
          ..write('id: $id, ')
          ..write('crossingId: $crossingId, ')
          ..write('changeType: $changeType, ')
          ..write('snapshotJson: $snapshotJson, ')
          ..write('changedAt: $changedAt, ')
          ..write('changedBy: $changedBy')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    crossingId,
    changeType,
    snapshotJson,
    changedAt,
    changedBy,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ChangeHistoryData &&
          other.id == this.id &&
          other.crossingId == this.crossingId &&
          other.changeType == this.changeType &&
          other.snapshotJson == this.snapshotJson &&
          other.changedAt == this.changedAt &&
          other.changedBy == this.changedBy);
}

class ChangeHistoryCompanion extends UpdateCompanion<ChangeHistoryData> {
  final Value<int> id;
  final Value<int> crossingId;
  final Value<String> changeType;
  final Value<String> snapshotJson;
  final Value<DateTime> changedAt;
  final Value<String> changedBy;
  const ChangeHistoryCompanion({
    this.id = const Value.absent(),
    this.crossingId = const Value.absent(),
    this.changeType = const Value.absent(),
    this.snapshotJson = const Value.absent(),
    this.changedAt = const Value.absent(),
    this.changedBy = const Value.absent(),
  });
  ChangeHistoryCompanion.insert({
    this.id = const Value.absent(),
    required int crossingId,
    required String changeType,
    required String snapshotJson,
    required DateTime changedAt,
    this.changedBy = const Value.absent(),
  }) : crossingId = Value(crossingId),
       changeType = Value(changeType),
       snapshotJson = Value(snapshotJson),
       changedAt = Value(changedAt);
  static Insertable<ChangeHistoryData> custom({
    Expression<int>? id,
    Expression<int>? crossingId,
    Expression<String>? changeType,
    Expression<String>? snapshotJson,
    Expression<DateTime>? changedAt,
    Expression<String>? changedBy,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (crossingId != null) 'crossing_id': crossingId,
      if (changeType != null) 'change_type': changeType,
      if (snapshotJson != null) 'snapshot_json': snapshotJson,
      if (changedAt != null) 'changed_at': changedAt,
      if (changedBy != null) 'changed_by': changedBy,
    });
  }

  ChangeHistoryCompanion copyWith({
    Value<int>? id,
    Value<int>? crossingId,
    Value<String>? changeType,
    Value<String>? snapshotJson,
    Value<DateTime>? changedAt,
    Value<String>? changedBy,
  }) {
    return ChangeHistoryCompanion(
      id: id ?? this.id,
      crossingId: crossingId ?? this.crossingId,
      changeType: changeType ?? this.changeType,
      snapshotJson: snapshotJson ?? this.snapshotJson,
      changedAt: changedAt ?? this.changedAt,
      changedBy: changedBy ?? this.changedBy,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (crossingId.present) {
      map['crossing_id'] = Variable<int>(crossingId.value);
    }
    if (changeType.present) {
      map['change_type'] = Variable<String>(changeType.value);
    }
    if (snapshotJson.present) {
      map['snapshot_json'] = Variable<String>(snapshotJson.value);
    }
    if (changedAt.present) {
      map['changed_at'] = Variable<DateTime>(changedAt.value);
    }
    if (changedBy.present) {
      map['changed_by'] = Variable<String>(changedBy.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ChangeHistoryCompanion(')
          ..write('id: $id, ')
          ..write('crossingId: $crossingId, ')
          ..write('changeType: $changeType, ')
          ..write('snapshotJson: $snapshotJson, ')
          ..write('changedAt: $changedAt, ')
          ..write('changedBy: $changedBy')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $CompaniesTable companies = $CompaniesTable(this);
  late final $VehicleMakesTable vehicleMakes = $VehicleMakesTable(this);
  late final $VehicleModelsTable vehicleModels = $VehicleModelsTable(this);
  late final $CargoTypesTable cargoTypes = $CargoTypesTable(this);
  late final $CrossingsTable crossings = $CrossingsTable(this);
  late final $CrossingPhotosTable crossingPhotos = $CrossingPhotosTable(this);
  late final $ChangeHistoryTable changeHistory = $ChangeHistoryTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    companies,
    vehicleMakes,
    vehicleModels,
    cargoTypes,
    crossings,
    crossingPhotos,
    changeHistory,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'vehicle_makes',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('vehicle_models', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'crossings',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('crossing_photos', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$CompaniesTableCreateCompanionBuilder =
    CompaniesCompanion Function({
      Value<int> id,
      required String uuid,
      required String name,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int?> serverId,
      Value<String> syncStatus,
      Value<bool> isDeleted,
    });
typedef $$CompaniesTableUpdateCompanionBuilder =
    CompaniesCompanion Function({
      Value<int> id,
      Value<String> uuid,
      Value<String> name,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int?> serverId,
      Value<String> syncStatus,
      Value<bool> isDeleted,
    });

final class $$CompaniesTableReferences
    extends BaseReferences<_$AppDatabase, $CompaniesTable, Company> {
  $$CompaniesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$CrossingsTable, List<Crossing>>
  _crossingsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.crossings,
    aliasName: 'companies__id__crossings__company_id',
  );

  $$CrossingsTableProcessedTableManager get crossingsRefs {
    final manager = $$CrossingsTableTableManager(
      $_db,
      $_db.crossings,
    ).filter((f) => f.companyId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_crossingsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$CompaniesTableFilterComposer
    extends Composer<_$AppDatabase, $CompaniesTable> {
  $$CompaniesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get uuid => $composableBuilder(
    column: $table.uuid,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get serverId => $composableBuilder(
    column: $table.serverId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> crossingsRefs(
    Expression<bool> Function($$CrossingsTableFilterComposer f) f,
  ) {
    final $$CrossingsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.crossings,
      getReferencedColumn: (t) => t.companyId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CrossingsTableFilterComposer(
            $db: $db,
            $table: $db.crossings,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CompaniesTableOrderingComposer
    extends Composer<_$AppDatabase, $CompaniesTable> {
  $$CompaniesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get uuid => $composableBuilder(
    column: $table.uuid,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get serverId => $composableBuilder(
    column: $table.serverId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CompaniesTableAnnotationComposer
    extends Composer<_$AppDatabase, $CompaniesTable> {
  $$CompaniesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get uuid =>
      $composableBuilder(column: $table.uuid, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<int> get serverId =>
      $composableBuilder(column: $table.serverId, builder: (column) => column);

  GeneratedColumn<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isDeleted =>
      $composableBuilder(column: $table.isDeleted, builder: (column) => column);

  Expression<T> crossingsRefs<T extends Object>(
    Expression<T> Function($$CrossingsTableAnnotationComposer a) f,
  ) {
    final $$CrossingsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.crossings,
      getReferencedColumn: (t) => t.companyId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CrossingsTableAnnotationComposer(
            $db: $db,
            $table: $db.crossings,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CompaniesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CompaniesTable,
          Company,
          $$CompaniesTableFilterComposer,
          $$CompaniesTableOrderingComposer,
          $$CompaniesTableAnnotationComposer,
          $$CompaniesTableCreateCompanionBuilder,
          $$CompaniesTableUpdateCompanionBuilder,
          (Company, $$CompaniesTableReferences),
          Company,
          PrefetchHooks Function({bool crossingsRefs})
        > {
  $$CompaniesTableTableManager(_$AppDatabase db, $CompaniesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CompaniesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CompaniesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CompaniesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> uuid = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int?> serverId = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<bool> isDeleted = const Value.absent(),
              }) => CompaniesCompanion(
                id: id,
                uuid: uuid,
                name: name,
                createdAt: createdAt,
                updatedAt: updatedAt,
                serverId: serverId,
                syncStatus: syncStatus,
                isDeleted: isDeleted,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String uuid,
                required String name,
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int?> serverId = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<bool> isDeleted = const Value.absent(),
              }) => CompaniesCompanion.insert(
                id: id,
                uuid: uuid,
                name: name,
                createdAt: createdAt,
                updatedAt: updatedAt,
                serverId: serverId,
                syncStatus: syncStatus,
                isDeleted: isDeleted,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$CompaniesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({crossingsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (crossingsRefs) db.crossings],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (crossingsRefs)
                    await $_getPrefetchedData<
                      Company,
                      $CompaniesTable,
                      Crossing
                    >(
                      currentTable: table,
                      referencedTable: $$CompaniesTableReferences
                          ._crossingsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$CompaniesTableReferences(
                            db,
                            table,
                            p0,
                          ).crossingsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.companyId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$CompaniesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CompaniesTable,
      Company,
      $$CompaniesTableFilterComposer,
      $$CompaniesTableOrderingComposer,
      $$CompaniesTableAnnotationComposer,
      $$CompaniesTableCreateCompanionBuilder,
      $$CompaniesTableUpdateCompanionBuilder,
      (Company, $$CompaniesTableReferences),
      Company,
      PrefetchHooks Function({bool crossingsRefs})
    >;
typedef $$VehicleMakesTableCreateCompanionBuilder =
    VehicleMakesCompanion Function({
      Value<int> id,
      required String uuid,
      required String name,
      Value<bool> isBuiltIn,
      Value<bool> isHidden,
    });
typedef $$VehicleMakesTableUpdateCompanionBuilder =
    VehicleMakesCompanion Function({
      Value<int> id,
      Value<String> uuid,
      Value<String> name,
      Value<bool> isBuiltIn,
      Value<bool> isHidden,
    });

final class $$VehicleMakesTableReferences
    extends BaseReferences<_$AppDatabase, $VehicleMakesTable, VehicleMake> {
  $$VehicleMakesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$VehicleModelsTable, List<VehicleModel>>
  _vehicleModelsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.vehicleModels,
    aliasName: 'vehicle_makes__id__vehicle_models__make_id',
  );

  $$VehicleModelsTableProcessedTableManager get vehicleModelsRefs {
    final manager = $$VehicleModelsTableTableManager(
      $_db,
      $_db.vehicleModels,
    ).filter((f) => f.makeId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_vehicleModelsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$CrossingsTable, List<Crossing>>
  _crossingsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.crossings,
    aliasName: 'vehicle_makes__id__crossings__make_id',
  );

  $$CrossingsTableProcessedTableManager get crossingsRefs {
    final manager = $$CrossingsTableTableManager(
      $_db,
      $_db.crossings,
    ).filter((f) => f.makeId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_crossingsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$VehicleMakesTableFilterComposer
    extends Composer<_$AppDatabase, $VehicleMakesTable> {
  $$VehicleMakesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get uuid => $composableBuilder(
    column: $table.uuid,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isBuiltIn => $composableBuilder(
    column: $table.isBuiltIn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isHidden => $composableBuilder(
    column: $table.isHidden,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> vehicleModelsRefs(
    Expression<bool> Function($$VehicleModelsTableFilterComposer f) f,
  ) {
    final $$VehicleModelsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.vehicleModels,
      getReferencedColumn: (t) => t.makeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VehicleModelsTableFilterComposer(
            $db: $db,
            $table: $db.vehicleModels,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> crossingsRefs(
    Expression<bool> Function($$CrossingsTableFilterComposer f) f,
  ) {
    final $$CrossingsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.crossings,
      getReferencedColumn: (t) => t.makeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CrossingsTableFilterComposer(
            $db: $db,
            $table: $db.crossings,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$VehicleMakesTableOrderingComposer
    extends Composer<_$AppDatabase, $VehicleMakesTable> {
  $$VehicleMakesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get uuid => $composableBuilder(
    column: $table.uuid,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isBuiltIn => $composableBuilder(
    column: $table.isBuiltIn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isHidden => $composableBuilder(
    column: $table.isHidden,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$VehicleMakesTableAnnotationComposer
    extends Composer<_$AppDatabase, $VehicleMakesTable> {
  $$VehicleMakesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get uuid =>
      $composableBuilder(column: $table.uuid, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<bool> get isBuiltIn =>
      $composableBuilder(column: $table.isBuiltIn, builder: (column) => column);

  GeneratedColumn<bool> get isHidden =>
      $composableBuilder(column: $table.isHidden, builder: (column) => column);

  Expression<T> vehicleModelsRefs<T extends Object>(
    Expression<T> Function($$VehicleModelsTableAnnotationComposer a) f,
  ) {
    final $$VehicleModelsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.vehicleModels,
      getReferencedColumn: (t) => t.makeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VehicleModelsTableAnnotationComposer(
            $db: $db,
            $table: $db.vehicleModels,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> crossingsRefs<T extends Object>(
    Expression<T> Function($$CrossingsTableAnnotationComposer a) f,
  ) {
    final $$CrossingsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.crossings,
      getReferencedColumn: (t) => t.makeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CrossingsTableAnnotationComposer(
            $db: $db,
            $table: $db.crossings,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$VehicleMakesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $VehicleMakesTable,
          VehicleMake,
          $$VehicleMakesTableFilterComposer,
          $$VehicleMakesTableOrderingComposer,
          $$VehicleMakesTableAnnotationComposer,
          $$VehicleMakesTableCreateCompanionBuilder,
          $$VehicleMakesTableUpdateCompanionBuilder,
          (VehicleMake, $$VehicleMakesTableReferences),
          VehicleMake,
          PrefetchHooks Function({bool vehicleModelsRefs, bool crossingsRefs})
        > {
  $$VehicleMakesTableTableManager(_$AppDatabase db, $VehicleMakesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$VehicleMakesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$VehicleMakesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$VehicleMakesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> uuid = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<bool> isBuiltIn = const Value.absent(),
                Value<bool> isHidden = const Value.absent(),
              }) => VehicleMakesCompanion(
                id: id,
                uuid: uuid,
                name: name,
                isBuiltIn: isBuiltIn,
                isHidden: isHidden,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String uuid,
                required String name,
                Value<bool> isBuiltIn = const Value.absent(),
                Value<bool> isHidden = const Value.absent(),
              }) => VehicleMakesCompanion.insert(
                id: id,
                uuid: uuid,
                name: name,
                isBuiltIn: isBuiltIn,
                isHidden: isHidden,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$VehicleMakesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({vehicleModelsRefs = false, crossingsRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (vehicleModelsRefs) db.vehicleModels,
                    if (crossingsRefs) db.crossings,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (vehicleModelsRefs)
                        await $_getPrefetchedData<
                          VehicleMake,
                          $VehicleMakesTable,
                          VehicleModel
                        >(
                          currentTable: table,
                          referencedTable: $$VehicleMakesTableReferences
                              ._vehicleModelsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$VehicleMakesTableReferences(
                                db,
                                table,
                                p0,
                              ).vehicleModelsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.makeId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (crossingsRefs)
                        await $_getPrefetchedData<
                          VehicleMake,
                          $VehicleMakesTable,
                          Crossing
                        >(
                          currentTable: table,
                          referencedTable: $$VehicleMakesTableReferences
                              ._crossingsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$VehicleMakesTableReferences(
                                db,
                                table,
                                p0,
                              ).crossingsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.makeId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$VehicleMakesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $VehicleMakesTable,
      VehicleMake,
      $$VehicleMakesTableFilterComposer,
      $$VehicleMakesTableOrderingComposer,
      $$VehicleMakesTableAnnotationComposer,
      $$VehicleMakesTableCreateCompanionBuilder,
      $$VehicleMakesTableUpdateCompanionBuilder,
      (VehicleMake, $$VehicleMakesTableReferences),
      VehicleMake,
      PrefetchHooks Function({bool vehicleModelsRefs, bool crossingsRefs})
    >;
typedef $$VehicleModelsTableCreateCompanionBuilder =
    VehicleModelsCompanion Function({
      Value<int> id,
      required String uuid,
      required int makeId,
      required String name,
      Value<bool> isBuiltIn,
      Value<bool> isHidden,
    });
typedef $$VehicleModelsTableUpdateCompanionBuilder =
    VehicleModelsCompanion Function({
      Value<int> id,
      Value<String> uuid,
      Value<int> makeId,
      Value<String> name,
      Value<bool> isBuiltIn,
      Value<bool> isHidden,
    });

final class $$VehicleModelsTableReferences
    extends BaseReferences<_$AppDatabase, $VehicleModelsTable, VehicleModel> {
  $$VehicleModelsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $VehicleMakesTable _makeIdTable(_$AppDatabase db) =>
      db.vehicleMakes.createAlias('vehicle_models__make_id__vehicle_makes__id');

  $$VehicleMakesTableProcessedTableManager get makeId {
    final $_column = $_itemColumn<int>('make_id')!;

    final manager = $$VehicleMakesTableTableManager(
      $_db,
      $_db.vehicleMakes,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_makeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$CrossingsTable, List<Crossing>>
  _crossingsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.crossings,
    aliasName: 'vehicle_models__id__crossings__model_id',
  );

  $$CrossingsTableProcessedTableManager get crossingsRefs {
    final manager = $$CrossingsTableTableManager(
      $_db,
      $_db.crossings,
    ).filter((f) => f.modelId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_crossingsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$VehicleModelsTableFilterComposer
    extends Composer<_$AppDatabase, $VehicleModelsTable> {
  $$VehicleModelsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get uuid => $composableBuilder(
    column: $table.uuid,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isBuiltIn => $composableBuilder(
    column: $table.isBuiltIn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isHidden => $composableBuilder(
    column: $table.isHidden,
    builder: (column) => ColumnFilters(column),
  );

  $$VehicleMakesTableFilterComposer get makeId {
    final $$VehicleMakesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.makeId,
      referencedTable: $db.vehicleMakes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VehicleMakesTableFilterComposer(
            $db: $db,
            $table: $db.vehicleMakes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> crossingsRefs(
    Expression<bool> Function($$CrossingsTableFilterComposer f) f,
  ) {
    final $$CrossingsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.crossings,
      getReferencedColumn: (t) => t.modelId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CrossingsTableFilterComposer(
            $db: $db,
            $table: $db.crossings,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$VehicleModelsTableOrderingComposer
    extends Composer<_$AppDatabase, $VehicleModelsTable> {
  $$VehicleModelsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get uuid => $composableBuilder(
    column: $table.uuid,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isBuiltIn => $composableBuilder(
    column: $table.isBuiltIn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isHidden => $composableBuilder(
    column: $table.isHidden,
    builder: (column) => ColumnOrderings(column),
  );

  $$VehicleMakesTableOrderingComposer get makeId {
    final $$VehicleMakesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.makeId,
      referencedTable: $db.vehicleMakes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VehicleMakesTableOrderingComposer(
            $db: $db,
            $table: $db.vehicleMakes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$VehicleModelsTableAnnotationComposer
    extends Composer<_$AppDatabase, $VehicleModelsTable> {
  $$VehicleModelsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get uuid =>
      $composableBuilder(column: $table.uuid, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<bool> get isBuiltIn =>
      $composableBuilder(column: $table.isBuiltIn, builder: (column) => column);

  GeneratedColumn<bool> get isHidden =>
      $composableBuilder(column: $table.isHidden, builder: (column) => column);

  $$VehicleMakesTableAnnotationComposer get makeId {
    final $$VehicleMakesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.makeId,
      referencedTable: $db.vehicleMakes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VehicleMakesTableAnnotationComposer(
            $db: $db,
            $table: $db.vehicleMakes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> crossingsRefs<T extends Object>(
    Expression<T> Function($$CrossingsTableAnnotationComposer a) f,
  ) {
    final $$CrossingsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.crossings,
      getReferencedColumn: (t) => t.modelId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CrossingsTableAnnotationComposer(
            $db: $db,
            $table: $db.crossings,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$VehicleModelsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $VehicleModelsTable,
          VehicleModel,
          $$VehicleModelsTableFilterComposer,
          $$VehicleModelsTableOrderingComposer,
          $$VehicleModelsTableAnnotationComposer,
          $$VehicleModelsTableCreateCompanionBuilder,
          $$VehicleModelsTableUpdateCompanionBuilder,
          (VehicleModel, $$VehicleModelsTableReferences),
          VehicleModel,
          PrefetchHooks Function({bool makeId, bool crossingsRefs})
        > {
  $$VehicleModelsTableTableManager(_$AppDatabase db, $VehicleModelsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$VehicleModelsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$VehicleModelsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$VehicleModelsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> uuid = const Value.absent(),
                Value<int> makeId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<bool> isBuiltIn = const Value.absent(),
                Value<bool> isHidden = const Value.absent(),
              }) => VehicleModelsCompanion(
                id: id,
                uuid: uuid,
                makeId: makeId,
                name: name,
                isBuiltIn: isBuiltIn,
                isHidden: isHidden,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String uuid,
                required int makeId,
                required String name,
                Value<bool> isBuiltIn = const Value.absent(),
                Value<bool> isHidden = const Value.absent(),
              }) => VehicleModelsCompanion.insert(
                id: id,
                uuid: uuid,
                makeId: makeId,
                name: name,
                isBuiltIn: isBuiltIn,
                isHidden: isHidden,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$VehicleModelsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({makeId = false, crossingsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (crossingsRefs) db.crossings],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (makeId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.makeId,
                                referencedTable: $$VehicleModelsTableReferences
                                    ._makeIdTable(db),
                                referencedColumn: $$VehicleModelsTableReferences
                                    ._makeIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (crossingsRefs)
                    await $_getPrefetchedData<
                      VehicleModel,
                      $VehicleModelsTable,
                      Crossing
                    >(
                      currentTable: table,
                      referencedTable: $$VehicleModelsTableReferences
                          ._crossingsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$VehicleModelsTableReferences(
                            db,
                            table,
                            p0,
                          ).crossingsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.modelId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$VehicleModelsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $VehicleModelsTable,
      VehicleModel,
      $$VehicleModelsTableFilterComposer,
      $$VehicleModelsTableOrderingComposer,
      $$VehicleModelsTableAnnotationComposer,
      $$VehicleModelsTableCreateCompanionBuilder,
      $$VehicleModelsTableUpdateCompanionBuilder,
      (VehicleModel, $$VehicleModelsTableReferences),
      VehicleModel,
      PrefetchHooks Function({bool makeId, bool crossingsRefs})
    >;
typedef $$CargoTypesTableCreateCompanionBuilder =
    CargoTypesCompanion Function({
      Value<int> id,
      required String uuid,
      required String name,
      Value<bool> isBuiltIn,
      Value<bool> isHidden,
    });
typedef $$CargoTypesTableUpdateCompanionBuilder =
    CargoTypesCompanion Function({
      Value<int> id,
      Value<String> uuid,
      Value<String> name,
      Value<bool> isBuiltIn,
      Value<bool> isHidden,
    });

final class $$CargoTypesTableReferences
    extends BaseReferences<_$AppDatabase, $CargoTypesTable, CargoType> {
  $$CargoTypesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$CrossingsTable, List<Crossing>>
  _crossingsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.crossings,
    aliasName: 'cargo_types__id__crossings__cargo_type_id',
  );

  $$CrossingsTableProcessedTableManager get crossingsRefs {
    final manager = $$CrossingsTableTableManager(
      $_db,
      $_db.crossings,
    ).filter((f) => f.cargoTypeId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_crossingsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$CargoTypesTableFilterComposer
    extends Composer<_$AppDatabase, $CargoTypesTable> {
  $$CargoTypesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get uuid => $composableBuilder(
    column: $table.uuid,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isBuiltIn => $composableBuilder(
    column: $table.isBuiltIn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isHidden => $composableBuilder(
    column: $table.isHidden,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> crossingsRefs(
    Expression<bool> Function($$CrossingsTableFilterComposer f) f,
  ) {
    final $$CrossingsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.crossings,
      getReferencedColumn: (t) => t.cargoTypeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CrossingsTableFilterComposer(
            $db: $db,
            $table: $db.crossings,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CargoTypesTableOrderingComposer
    extends Composer<_$AppDatabase, $CargoTypesTable> {
  $$CargoTypesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get uuid => $composableBuilder(
    column: $table.uuid,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isBuiltIn => $composableBuilder(
    column: $table.isBuiltIn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isHidden => $composableBuilder(
    column: $table.isHidden,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CargoTypesTableAnnotationComposer
    extends Composer<_$AppDatabase, $CargoTypesTable> {
  $$CargoTypesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get uuid =>
      $composableBuilder(column: $table.uuid, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<bool> get isBuiltIn =>
      $composableBuilder(column: $table.isBuiltIn, builder: (column) => column);

  GeneratedColumn<bool> get isHidden =>
      $composableBuilder(column: $table.isHidden, builder: (column) => column);

  Expression<T> crossingsRefs<T extends Object>(
    Expression<T> Function($$CrossingsTableAnnotationComposer a) f,
  ) {
    final $$CrossingsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.crossings,
      getReferencedColumn: (t) => t.cargoTypeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CrossingsTableAnnotationComposer(
            $db: $db,
            $table: $db.crossings,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CargoTypesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CargoTypesTable,
          CargoType,
          $$CargoTypesTableFilterComposer,
          $$CargoTypesTableOrderingComposer,
          $$CargoTypesTableAnnotationComposer,
          $$CargoTypesTableCreateCompanionBuilder,
          $$CargoTypesTableUpdateCompanionBuilder,
          (CargoType, $$CargoTypesTableReferences),
          CargoType,
          PrefetchHooks Function({bool crossingsRefs})
        > {
  $$CargoTypesTableTableManager(_$AppDatabase db, $CargoTypesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CargoTypesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CargoTypesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CargoTypesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> uuid = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<bool> isBuiltIn = const Value.absent(),
                Value<bool> isHidden = const Value.absent(),
              }) => CargoTypesCompanion(
                id: id,
                uuid: uuid,
                name: name,
                isBuiltIn: isBuiltIn,
                isHidden: isHidden,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String uuid,
                required String name,
                Value<bool> isBuiltIn = const Value.absent(),
                Value<bool> isHidden = const Value.absent(),
              }) => CargoTypesCompanion.insert(
                id: id,
                uuid: uuid,
                name: name,
                isBuiltIn: isBuiltIn,
                isHidden: isHidden,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$CargoTypesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({crossingsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (crossingsRefs) db.crossings],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (crossingsRefs)
                    await $_getPrefetchedData<
                      CargoType,
                      $CargoTypesTable,
                      Crossing
                    >(
                      currentTable: table,
                      referencedTable: $$CargoTypesTableReferences
                          ._crossingsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$CargoTypesTableReferences(
                            db,
                            table,
                            p0,
                          ).crossingsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where(
                            (e) => e.cargoTypeId == item.id,
                          ),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$CargoTypesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CargoTypesTable,
      CargoType,
      $$CargoTypesTableFilterComposer,
      $$CargoTypesTableOrderingComposer,
      $$CargoTypesTableAnnotationComposer,
      $$CargoTypesTableCreateCompanionBuilder,
      $$CargoTypesTableUpdateCompanionBuilder,
      (CargoType, $$CargoTypesTableReferences),
      CargoType,
      PrefetchHooks Function({bool crossingsRefs})
    >;
typedef $$CrossingsTableCreateCompanionBuilder =
    CrossingsCompanion Function({
      Value<int> id,
      required String uuid,
      required int companyId,
      required String plateNumber,
      required String plateCountry,
      required String plateFormatKey,
      required int makeId,
      Value<int?> modelId,
      required int cargoTypeId,
      Value<double?> cargoQuantity,
      Value<String?> quantityUnit,
      required DateTime crossedAt,
      Value<double?> latitude,
      Value<double?> longitude,
      Value<String?> note,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int?> serverId,
      Value<String> syncStatus,
      Value<bool> isDeleted,
    });
typedef $$CrossingsTableUpdateCompanionBuilder =
    CrossingsCompanion Function({
      Value<int> id,
      Value<String> uuid,
      Value<int> companyId,
      Value<String> plateNumber,
      Value<String> plateCountry,
      Value<String> plateFormatKey,
      Value<int> makeId,
      Value<int?> modelId,
      Value<int> cargoTypeId,
      Value<double?> cargoQuantity,
      Value<String?> quantityUnit,
      Value<DateTime> crossedAt,
      Value<double?> latitude,
      Value<double?> longitude,
      Value<String?> note,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int?> serverId,
      Value<String> syncStatus,
      Value<bool> isDeleted,
    });

final class $$CrossingsTableReferences
    extends BaseReferences<_$AppDatabase, $CrossingsTable, Crossing> {
  $$CrossingsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $CompaniesTable _companyIdTable(_$AppDatabase db) =>
      db.companies.createAlias('crossings__company_id__companies__id');

  $$CompaniesTableProcessedTableManager get companyId {
    final $_column = $_itemColumn<int>('company_id')!;

    final manager = $$CompaniesTableTableManager(
      $_db,
      $_db.companies,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_companyIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $VehicleMakesTable _makeIdTable(_$AppDatabase db) =>
      db.vehicleMakes.createAlias('crossings__make_id__vehicle_makes__id');

  $$VehicleMakesTableProcessedTableManager get makeId {
    final $_column = $_itemColumn<int>('make_id')!;

    final manager = $$VehicleMakesTableTableManager(
      $_db,
      $_db.vehicleMakes,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_makeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $VehicleModelsTable _modelIdTable(_$AppDatabase db) =>
      db.vehicleModels.createAlias('crossings__model_id__vehicle_models__id');

  $$VehicleModelsTableProcessedTableManager? get modelId {
    final $_column = $_itemColumn<int>('model_id');
    if ($_column == null) return null;
    final manager = $$VehicleModelsTableTableManager(
      $_db,
      $_db.vehicleModels,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_modelIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $CargoTypesTable _cargoTypeIdTable(_$AppDatabase db) =>
      db.cargoTypes.createAlias('crossings__cargo_type_id__cargo_types__id');

  $$CargoTypesTableProcessedTableManager get cargoTypeId {
    final $_column = $_itemColumn<int>('cargo_type_id')!;

    final manager = $$CargoTypesTableTableManager(
      $_db,
      $_db.cargoTypes,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_cargoTypeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$CrossingPhotosTable, List<CrossingPhoto>>
  _crossingPhotosRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.crossingPhotos,
    aliasName: 'crossings__id__crossing_photos__crossing_id',
  );

  $$CrossingPhotosTableProcessedTableManager get crossingPhotosRefs {
    final manager = $$CrossingPhotosTableTableManager(
      $_db,
      $_db.crossingPhotos,
    ).filter((f) => f.crossingId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_crossingPhotosRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$CrossingsTableFilterComposer
    extends Composer<_$AppDatabase, $CrossingsTable> {
  $$CrossingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get uuid => $composableBuilder(
    column: $table.uuid,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get plateNumber => $composableBuilder(
    column: $table.plateNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get plateCountry => $composableBuilder(
    column: $table.plateCountry,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get plateFormatKey => $composableBuilder(
    column: $table.plateFormatKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get cargoQuantity => $composableBuilder(
    column: $table.cargoQuantity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get quantityUnit => $composableBuilder(
    column: $table.quantityUnit,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get crossedAt => $composableBuilder(
    column: $table.crossedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get latitude => $composableBuilder(
    column: $table.latitude,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get longitude => $composableBuilder(
    column: $table.longitude,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get serverId => $composableBuilder(
    column: $table.serverId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnFilters(column),
  );

  $$CompaniesTableFilterComposer get companyId {
    final $$CompaniesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.companyId,
      referencedTable: $db.companies,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CompaniesTableFilterComposer(
            $db: $db,
            $table: $db.companies,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$VehicleMakesTableFilterComposer get makeId {
    final $$VehicleMakesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.makeId,
      referencedTable: $db.vehicleMakes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VehicleMakesTableFilterComposer(
            $db: $db,
            $table: $db.vehicleMakes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$VehicleModelsTableFilterComposer get modelId {
    final $$VehicleModelsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.modelId,
      referencedTable: $db.vehicleModels,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VehicleModelsTableFilterComposer(
            $db: $db,
            $table: $db.vehicleModels,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CargoTypesTableFilterComposer get cargoTypeId {
    final $$CargoTypesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.cargoTypeId,
      referencedTable: $db.cargoTypes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CargoTypesTableFilterComposer(
            $db: $db,
            $table: $db.cargoTypes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> crossingPhotosRefs(
    Expression<bool> Function($$CrossingPhotosTableFilterComposer f) f,
  ) {
    final $$CrossingPhotosTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.crossingPhotos,
      getReferencedColumn: (t) => t.crossingId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CrossingPhotosTableFilterComposer(
            $db: $db,
            $table: $db.crossingPhotos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CrossingsTableOrderingComposer
    extends Composer<_$AppDatabase, $CrossingsTable> {
  $$CrossingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get uuid => $composableBuilder(
    column: $table.uuid,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get plateNumber => $composableBuilder(
    column: $table.plateNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get plateCountry => $composableBuilder(
    column: $table.plateCountry,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get plateFormatKey => $composableBuilder(
    column: $table.plateFormatKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get cargoQuantity => $composableBuilder(
    column: $table.cargoQuantity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get quantityUnit => $composableBuilder(
    column: $table.quantityUnit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get crossedAt => $composableBuilder(
    column: $table.crossedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get latitude => $composableBuilder(
    column: $table.latitude,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get longitude => $composableBuilder(
    column: $table.longitude,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get serverId => $composableBuilder(
    column: $table.serverId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnOrderings(column),
  );

  $$CompaniesTableOrderingComposer get companyId {
    final $$CompaniesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.companyId,
      referencedTable: $db.companies,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CompaniesTableOrderingComposer(
            $db: $db,
            $table: $db.companies,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$VehicleMakesTableOrderingComposer get makeId {
    final $$VehicleMakesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.makeId,
      referencedTable: $db.vehicleMakes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VehicleMakesTableOrderingComposer(
            $db: $db,
            $table: $db.vehicleMakes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$VehicleModelsTableOrderingComposer get modelId {
    final $$VehicleModelsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.modelId,
      referencedTable: $db.vehicleModels,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VehicleModelsTableOrderingComposer(
            $db: $db,
            $table: $db.vehicleModels,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CargoTypesTableOrderingComposer get cargoTypeId {
    final $$CargoTypesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.cargoTypeId,
      referencedTable: $db.cargoTypes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CargoTypesTableOrderingComposer(
            $db: $db,
            $table: $db.cargoTypes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CrossingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CrossingsTable> {
  $$CrossingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get uuid =>
      $composableBuilder(column: $table.uuid, builder: (column) => column);

  GeneratedColumn<String> get plateNumber => $composableBuilder(
    column: $table.plateNumber,
    builder: (column) => column,
  );

  GeneratedColumn<String> get plateCountry => $composableBuilder(
    column: $table.plateCountry,
    builder: (column) => column,
  );

  GeneratedColumn<String> get plateFormatKey => $composableBuilder(
    column: $table.plateFormatKey,
    builder: (column) => column,
  );

  GeneratedColumn<double> get cargoQuantity => $composableBuilder(
    column: $table.cargoQuantity,
    builder: (column) => column,
  );

  GeneratedColumn<String> get quantityUnit => $composableBuilder(
    column: $table.quantityUnit,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get crossedAt =>
      $composableBuilder(column: $table.crossedAt, builder: (column) => column);

  GeneratedColumn<double> get latitude =>
      $composableBuilder(column: $table.latitude, builder: (column) => column);

  GeneratedColumn<double> get longitude =>
      $composableBuilder(column: $table.longitude, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<int> get serverId =>
      $composableBuilder(column: $table.serverId, builder: (column) => column);

  GeneratedColumn<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isDeleted =>
      $composableBuilder(column: $table.isDeleted, builder: (column) => column);

  $$CompaniesTableAnnotationComposer get companyId {
    final $$CompaniesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.companyId,
      referencedTable: $db.companies,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CompaniesTableAnnotationComposer(
            $db: $db,
            $table: $db.companies,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$VehicleMakesTableAnnotationComposer get makeId {
    final $$VehicleMakesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.makeId,
      referencedTable: $db.vehicleMakes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VehicleMakesTableAnnotationComposer(
            $db: $db,
            $table: $db.vehicleMakes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$VehicleModelsTableAnnotationComposer get modelId {
    final $$VehicleModelsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.modelId,
      referencedTable: $db.vehicleModels,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VehicleModelsTableAnnotationComposer(
            $db: $db,
            $table: $db.vehicleModels,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CargoTypesTableAnnotationComposer get cargoTypeId {
    final $$CargoTypesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.cargoTypeId,
      referencedTable: $db.cargoTypes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CargoTypesTableAnnotationComposer(
            $db: $db,
            $table: $db.cargoTypes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> crossingPhotosRefs<T extends Object>(
    Expression<T> Function($$CrossingPhotosTableAnnotationComposer a) f,
  ) {
    final $$CrossingPhotosTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.crossingPhotos,
      getReferencedColumn: (t) => t.crossingId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CrossingPhotosTableAnnotationComposer(
            $db: $db,
            $table: $db.crossingPhotos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CrossingsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CrossingsTable,
          Crossing,
          $$CrossingsTableFilterComposer,
          $$CrossingsTableOrderingComposer,
          $$CrossingsTableAnnotationComposer,
          $$CrossingsTableCreateCompanionBuilder,
          $$CrossingsTableUpdateCompanionBuilder,
          (Crossing, $$CrossingsTableReferences),
          Crossing,
          PrefetchHooks Function({
            bool companyId,
            bool makeId,
            bool modelId,
            bool cargoTypeId,
            bool crossingPhotosRefs,
          })
        > {
  $$CrossingsTableTableManager(_$AppDatabase db, $CrossingsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CrossingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CrossingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CrossingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> uuid = const Value.absent(),
                Value<int> companyId = const Value.absent(),
                Value<String> plateNumber = const Value.absent(),
                Value<String> plateCountry = const Value.absent(),
                Value<String> plateFormatKey = const Value.absent(),
                Value<int> makeId = const Value.absent(),
                Value<int?> modelId = const Value.absent(),
                Value<int> cargoTypeId = const Value.absent(),
                Value<double?> cargoQuantity = const Value.absent(),
                Value<String?> quantityUnit = const Value.absent(),
                Value<DateTime> crossedAt = const Value.absent(),
                Value<double?> latitude = const Value.absent(),
                Value<double?> longitude = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int?> serverId = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<bool> isDeleted = const Value.absent(),
              }) => CrossingsCompanion(
                id: id,
                uuid: uuid,
                companyId: companyId,
                plateNumber: plateNumber,
                plateCountry: plateCountry,
                plateFormatKey: plateFormatKey,
                makeId: makeId,
                modelId: modelId,
                cargoTypeId: cargoTypeId,
                cargoQuantity: cargoQuantity,
                quantityUnit: quantityUnit,
                crossedAt: crossedAt,
                latitude: latitude,
                longitude: longitude,
                note: note,
                createdAt: createdAt,
                updatedAt: updatedAt,
                serverId: serverId,
                syncStatus: syncStatus,
                isDeleted: isDeleted,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String uuid,
                required int companyId,
                required String plateNumber,
                required String plateCountry,
                required String plateFormatKey,
                required int makeId,
                Value<int?> modelId = const Value.absent(),
                required int cargoTypeId,
                Value<double?> cargoQuantity = const Value.absent(),
                Value<String?> quantityUnit = const Value.absent(),
                required DateTime crossedAt,
                Value<double?> latitude = const Value.absent(),
                Value<double?> longitude = const Value.absent(),
                Value<String?> note = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int?> serverId = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<bool> isDeleted = const Value.absent(),
              }) => CrossingsCompanion.insert(
                id: id,
                uuid: uuid,
                companyId: companyId,
                plateNumber: plateNumber,
                plateCountry: plateCountry,
                plateFormatKey: plateFormatKey,
                makeId: makeId,
                modelId: modelId,
                cargoTypeId: cargoTypeId,
                cargoQuantity: cargoQuantity,
                quantityUnit: quantityUnit,
                crossedAt: crossedAt,
                latitude: latitude,
                longitude: longitude,
                note: note,
                createdAt: createdAt,
                updatedAt: updatedAt,
                serverId: serverId,
                syncStatus: syncStatus,
                isDeleted: isDeleted,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$CrossingsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                companyId = false,
                makeId = false,
                modelId = false,
                cargoTypeId = false,
                crossingPhotosRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (crossingPhotosRefs) db.crossingPhotos,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (companyId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.companyId,
                                    referencedTable: $$CrossingsTableReferences
                                        ._companyIdTable(db),
                                    referencedColumn: $$CrossingsTableReferences
                                        ._companyIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }
                        if (makeId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.makeId,
                                    referencedTable: $$CrossingsTableReferences
                                        ._makeIdTable(db),
                                    referencedColumn: $$CrossingsTableReferences
                                        ._makeIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }
                        if (modelId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.modelId,
                                    referencedTable: $$CrossingsTableReferences
                                        ._modelIdTable(db),
                                    referencedColumn: $$CrossingsTableReferences
                                        ._modelIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }
                        if (cargoTypeId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.cargoTypeId,
                                    referencedTable: $$CrossingsTableReferences
                                        ._cargoTypeIdTable(db),
                                    referencedColumn: $$CrossingsTableReferences
                                        ._cargoTypeIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (crossingPhotosRefs)
                        await $_getPrefetchedData<
                          Crossing,
                          $CrossingsTable,
                          CrossingPhoto
                        >(
                          currentTable: table,
                          referencedTable: $$CrossingsTableReferences
                              ._crossingPhotosRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$CrossingsTableReferences(
                                db,
                                table,
                                p0,
                              ).crossingPhotosRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.crossingId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$CrossingsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CrossingsTable,
      Crossing,
      $$CrossingsTableFilterComposer,
      $$CrossingsTableOrderingComposer,
      $$CrossingsTableAnnotationComposer,
      $$CrossingsTableCreateCompanionBuilder,
      $$CrossingsTableUpdateCompanionBuilder,
      (Crossing, $$CrossingsTableReferences),
      Crossing,
      PrefetchHooks Function({
        bool companyId,
        bool makeId,
        bool modelId,
        bool cargoTypeId,
        bool crossingPhotosRefs,
      })
    >;
typedef $$CrossingPhotosTableCreateCompanionBuilder =
    CrossingPhotosCompanion Function({
      Value<int> id,
      required String uuid,
      required int crossingId,
      required String filePath,
      required String thumbPath,
      required DateTime createdAt,
    });
typedef $$CrossingPhotosTableUpdateCompanionBuilder =
    CrossingPhotosCompanion Function({
      Value<int> id,
      Value<String> uuid,
      Value<int> crossingId,
      Value<String> filePath,
      Value<String> thumbPath,
      Value<DateTime> createdAt,
    });

final class $$CrossingPhotosTableReferences
    extends BaseReferences<_$AppDatabase, $CrossingPhotosTable, CrossingPhoto> {
  $$CrossingPhotosTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $CrossingsTable _crossingIdTable(_$AppDatabase db) =>
      db.crossings.createAlias('crossing_photos__crossing_id__crossings__id');

  $$CrossingsTableProcessedTableManager get crossingId {
    final $_column = $_itemColumn<int>('crossing_id')!;

    final manager = $$CrossingsTableTableManager(
      $_db,
      $_db.crossings,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_crossingIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$CrossingPhotosTableFilterComposer
    extends Composer<_$AppDatabase, $CrossingPhotosTable> {
  $$CrossingPhotosTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get uuid => $composableBuilder(
    column: $table.uuid,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get filePath => $composableBuilder(
    column: $table.filePath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get thumbPath => $composableBuilder(
    column: $table.thumbPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$CrossingsTableFilterComposer get crossingId {
    final $$CrossingsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.crossingId,
      referencedTable: $db.crossings,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CrossingsTableFilterComposer(
            $db: $db,
            $table: $db.crossings,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CrossingPhotosTableOrderingComposer
    extends Composer<_$AppDatabase, $CrossingPhotosTable> {
  $$CrossingPhotosTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get uuid => $composableBuilder(
    column: $table.uuid,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get filePath => $composableBuilder(
    column: $table.filePath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get thumbPath => $composableBuilder(
    column: $table.thumbPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$CrossingsTableOrderingComposer get crossingId {
    final $$CrossingsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.crossingId,
      referencedTable: $db.crossings,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CrossingsTableOrderingComposer(
            $db: $db,
            $table: $db.crossings,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CrossingPhotosTableAnnotationComposer
    extends Composer<_$AppDatabase, $CrossingPhotosTable> {
  $$CrossingPhotosTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get uuid =>
      $composableBuilder(column: $table.uuid, builder: (column) => column);

  GeneratedColumn<String> get filePath =>
      $composableBuilder(column: $table.filePath, builder: (column) => column);

  GeneratedColumn<String> get thumbPath =>
      $composableBuilder(column: $table.thumbPath, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$CrossingsTableAnnotationComposer get crossingId {
    final $$CrossingsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.crossingId,
      referencedTable: $db.crossings,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CrossingsTableAnnotationComposer(
            $db: $db,
            $table: $db.crossings,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CrossingPhotosTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CrossingPhotosTable,
          CrossingPhoto,
          $$CrossingPhotosTableFilterComposer,
          $$CrossingPhotosTableOrderingComposer,
          $$CrossingPhotosTableAnnotationComposer,
          $$CrossingPhotosTableCreateCompanionBuilder,
          $$CrossingPhotosTableUpdateCompanionBuilder,
          (CrossingPhoto, $$CrossingPhotosTableReferences),
          CrossingPhoto,
          PrefetchHooks Function({bool crossingId})
        > {
  $$CrossingPhotosTableTableManager(
    _$AppDatabase db,
    $CrossingPhotosTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CrossingPhotosTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CrossingPhotosTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CrossingPhotosTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> uuid = const Value.absent(),
                Value<int> crossingId = const Value.absent(),
                Value<String> filePath = const Value.absent(),
                Value<String> thumbPath = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => CrossingPhotosCompanion(
                id: id,
                uuid: uuid,
                crossingId: crossingId,
                filePath: filePath,
                thumbPath: thumbPath,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String uuid,
                required int crossingId,
                required String filePath,
                required String thumbPath,
                required DateTime createdAt,
              }) => CrossingPhotosCompanion.insert(
                id: id,
                uuid: uuid,
                crossingId: crossingId,
                filePath: filePath,
                thumbPath: thumbPath,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$CrossingPhotosTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({crossingId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (crossingId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.crossingId,
                                referencedTable: $$CrossingPhotosTableReferences
                                    ._crossingIdTable(db),
                                referencedColumn:
                                    $$CrossingPhotosTableReferences
                                        ._crossingIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$CrossingPhotosTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CrossingPhotosTable,
      CrossingPhoto,
      $$CrossingPhotosTableFilterComposer,
      $$CrossingPhotosTableOrderingComposer,
      $$CrossingPhotosTableAnnotationComposer,
      $$CrossingPhotosTableCreateCompanionBuilder,
      $$CrossingPhotosTableUpdateCompanionBuilder,
      (CrossingPhoto, $$CrossingPhotosTableReferences),
      CrossingPhoto,
      PrefetchHooks Function({bool crossingId})
    >;
typedef $$ChangeHistoryTableCreateCompanionBuilder =
    ChangeHistoryCompanion Function({
      Value<int> id,
      required int crossingId,
      required String changeType,
      required String snapshotJson,
      required DateTime changedAt,
      Value<String> changedBy,
    });
typedef $$ChangeHistoryTableUpdateCompanionBuilder =
    ChangeHistoryCompanion Function({
      Value<int> id,
      Value<int> crossingId,
      Value<String> changeType,
      Value<String> snapshotJson,
      Value<DateTime> changedAt,
      Value<String> changedBy,
    });

class $$ChangeHistoryTableFilterComposer
    extends Composer<_$AppDatabase, $ChangeHistoryTable> {
  $$ChangeHistoryTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get crossingId => $composableBuilder(
    column: $table.crossingId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get changeType => $composableBuilder(
    column: $table.changeType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get snapshotJson => $composableBuilder(
    column: $table.snapshotJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get changedAt => $composableBuilder(
    column: $table.changedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get changedBy => $composableBuilder(
    column: $table.changedBy,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ChangeHistoryTableOrderingComposer
    extends Composer<_$AppDatabase, $ChangeHistoryTable> {
  $$ChangeHistoryTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get crossingId => $composableBuilder(
    column: $table.crossingId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get changeType => $composableBuilder(
    column: $table.changeType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get snapshotJson => $composableBuilder(
    column: $table.snapshotJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get changedAt => $composableBuilder(
    column: $table.changedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get changedBy => $composableBuilder(
    column: $table.changedBy,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ChangeHistoryTableAnnotationComposer
    extends Composer<_$AppDatabase, $ChangeHistoryTable> {
  $$ChangeHistoryTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get crossingId => $composableBuilder(
    column: $table.crossingId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get changeType => $composableBuilder(
    column: $table.changeType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get snapshotJson => $composableBuilder(
    column: $table.snapshotJson,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get changedAt =>
      $composableBuilder(column: $table.changedAt, builder: (column) => column);

  GeneratedColumn<String> get changedBy =>
      $composableBuilder(column: $table.changedBy, builder: (column) => column);
}

class $$ChangeHistoryTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ChangeHistoryTable,
          ChangeHistoryData,
          $$ChangeHistoryTableFilterComposer,
          $$ChangeHistoryTableOrderingComposer,
          $$ChangeHistoryTableAnnotationComposer,
          $$ChangeHistoryTableCreateCompanionBuilder,
          $$ChangeHistoryTableUpdateCompanionBuilder,
          (
            ChangeHistoryData,
            BaseReferences<
              _$AppDatabase,
              $ChangeHistoryTable,
              ChangeHistoryData
            >,
          ),
          ChangeHistoryData,
          PrefetchHooks Function()
        > {
  $$ChangeHistoryTableTableManager(_$AppDatabase db, $ChangeHistoryTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ChangeHistoryTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ChangeHistoryTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ChangeHistoryTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> crossingId = const Value.absent(),
                Value<String> changeType = const Value.absent(),
                Value<String> snapshotJson = const Value.absent(),
                Value<DateTime> changedAt = const Value.absent(),
                Value<String> changedBy = const Value.absent(),
              }) => ChangeHistoryCompanion(
                id: id,
                crossingId: crossingId,
                changeType: changeType,
                snapshotJson: snapshotJson,
                changedAt: changedAt,
                changedBy: changedBy,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int crossingId,
                required String changeType,
                required String snapshotJson,
                required DateTime changedAt,
                Value<String> changedBy = const Value.absent(),
              }) => ChangeHistoryCompanion.insert(
                id: id,
                crossingId: crossingId,
                changeType: changeType,
                snapshotJson: snapshotJson,
                changedAt: changedAt,
                changedBy: changedBy,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ChangeHistoryTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ChangeHistoryTable,
      ChangeHistoryData,
      $$ChangeHistoryTableFilterComposer,
      $$ChangeHistoryTableOrderingComposer,
      $$ChangeHistoryTableAnnotationComposer,
      $$ChangeHistoryTableCreateCompanionBuilder,
      $$ChangeHistoryTableUpdateCompanionBuilder,
      (
        ChangeHistoryData,
        BaseReferences<_$AppDatabase, $ChangeHistoryTable, ChangeHistoryData>,
      ),
      ChangeHistoryData,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$CompaniesTableTableManager get companies =>
      $$CompaniesTableTableManager(_db, _db.companies);
  $$VehicleMakesTableTableManager get vehicleMakes =>
      $$VehicleMakesTableTableManager(_db, _db.vehicleMakes);
  $$VehicleModelsTableTableManager get vehicleModels =>
      $$VehicleModelsTableTableManager(_db, _db.vehicleModels);
  $$CargoTypesTableTableManager get cargoTypes =>
      $$CargoTypesTableTableManager(_db, _db.cargoTypes);
  $$CrossingsTableTableManager get crossings =>
      $$CrossingsTableTableManager(_db, _db.crossings);
  $$CrossingPhotosTableTableManager get crossingPhotos =>
      $$CrossingPhotosTableTableManager(_db, _db.crossingPhotos);
  $$ChangeHistoryTableTableManager get changeHistory =>
      $$ChangeHistoryTableTableManager(_db, _db.changeHistory);
}
