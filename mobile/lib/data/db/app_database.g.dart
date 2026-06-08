// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $TenantsTable extends Tenants with TableInfo<$TenantsTable, TenantRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TenantsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _tenantIdMeta = const VerificationMeta(
    'tenantId',
  );
  @override
  late final GeneratedColumn<String> tenantId = GeneratedColumn<String>(
    'tenant_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<String> createdAt = GeneratedColumn<String>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: _utcNowIso,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<String> updatedAt = GeneratedColumn<String>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: _utcNowIso,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<String> deletedAt = GeneratedColumn<String>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _versionMeta = const VerificationMeta(
    'version',
  );
  @override
  late final GeneratedColumn<int> version = GeneratedColumn<int>(
    'version',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
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
    defaultValue: const Constant('synced'),
  );
  static const VerificationMeta _lastSyncedAtMeta = const VerificationMeta(
    'lastSyncedAt',
  );
  @override
  late final GeneratedColumn<String> lastSyncedAt = GeneratedColumn<String>(
    'last_synced_at',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _addressMeta = const VerificationMeta(
    'address',
  );
  @override
  late final GeneratedColumn<String> address = GeneratedColumn<String>(
    'address',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _postalCodeMeta = const VerificationMeta(
    'postalCode',
  );
  @override
  late final GeneratedColumn<String> postalCode = GeneratedColumn<String>(
    'postal_code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _cityMeta = const VerificationMeta('city');
  @override
  late final GeneratedColumn<String> city = GeneratedColumn<String>(
    'city',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _countryMeta = const VerificationMeta(
    'country',
  );
  @override
  late final GeneratedColumn<String> country = GeneratedColumn<String>(
    'country',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
    'phone',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
    'email',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _logoFileIdMeta = const VerificationMeta(
    'logoFileId',
  );
  @override
  late final GeneratedColumn<String> logoFileId = GeneratedColumn<String>(
    'logo_file_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    tenantId,
    createdAt,
    updatedAt,
    deletedAt,
    version,
    syncStatus,
    lastSyncedAt,
    name,
    address,
    postalCode,
    city,
    country,
    phone,
    email,
    logoFileId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tenants';
  @override
  VerificationContext validateIntegrity(
    Insertable<TenantRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('tenant_id')) {
      context.handle(
        _tenantIdMeta,
        tenantId.isAcceptableOrUnknown(data['tenant_id']!, _tenantIdMeta),
      );
    } else if (isInserting) {
      context.missing(_tenantIdMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('version')) {
      context.handle(
        _versionMeta,
        version.isAcceptableOrUnknown(data['version']!, _versionMeta),
      );
    }
    if (data.containsKey('sync_status')) {
      context.handle(
        _syncStatusMeta,
        syncStatus.isAcceptableOrUnknown(data['sync_status']!, _syncStatusMeta),
      );
    }
    if (data.containsKey('last_synced_at')) {
      context.handle(
        _lastSyncedAtMeta,
        lastSyncedAt.isAcceptableOrUnknown(
          data['last_synced_at']!,
          _lastSyncedAtMeta,
        ),
      );
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('address')) {
      context.handle(
        _addressMeta,
        address.isAcceptableOrUnknown(data['address']!, _addressMeta),
      );
    } else if (isInserting) {
      context.missing(_addressMeta);
    }
    if (data.containsKey('postal_code')) {
      context.handle(
        _postalCodeMeta,
        postalCode.isAcceptableOrUnknown(data['postal_code']!, _postalCodeMeta),
      );
    } else if (isInserting) {
      context.missing(_postalCodeMeta);
    }
    if (data.containsKey('city')) {
      context.handle(
        _cityMeta,
        city.isAcceptableOrUnknown(data['city']!, _cityMeta),
      );
    } else if (isInserting) {
      context.missing(_cityMeta);
    }
    if (data.containsKey('country')) {
      context.handle(
        _countryMeta,
        country.isAcceptableOrUnknown(data['country']!, _countryMeta),
      );
    } else if (isInserting) {
      context.missing(_countryMeta);
    }
    if (data.containsKey('phone')) {
      context.handle(
        _phoneMeta,
        phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta),
      );
    } else if (isInserting) {
      context.missing(_phoneMeta);
    }
    if (data.containsKey('email')) {
      context.handle(
        _emailMeta,
        email.isAcceptableOrUnknown(data['email']!, _emailMeta),
      );
    } else if (isInserting) {
      context.missing(_emailMeta);
    }
    if (data.containsKey('logo_file_id')) {
      context.handle(
        _logoFileIdMeta,
        logoFileId.isAcceptableOrUnknown(
          data['logo_file_id']!,
          _logoFileIdMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TenantRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TenantRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      tenantId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tenant_id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}deleted_at'],
      ),
      version: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}version'],
      )!,
      syncStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sync_status'],
      )!,
      lastSyncedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_synced_at'],
      ),
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      address: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}address'],
      )!,
      postalCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}postal_code'],
      )!,
      city: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}city'],
      )!,
      country: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}country'],
      )!,
      phone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone'],
      )!,
      email: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}email'],
      )!,
      logoFileId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}logo_file_id'],
      ),
    );
  }

  @override
  $TenantsTable createAlias(String alias) {
    return $TenantsTable(attachedDatabase, alias);
  }
}

class TenantRow extends DataClass implements Insertable<TenantRow> {
  final String id;
  final String tenantId;
  final String createdAt;
  final String updatedAt;
  final String? deletedAt;
  final int version;
  final String syncStatus;
  final String? lastSyncedAt;
  final String name;
  final String address;
  final String postalCode;
  final String city;
  final String country;
  final String phone;
  final String email;
  final String? logoFileId;
  const TenantRow({
    required this.id,
    required this.tenantId,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.version,
    required this.syncStatus,
    this.lastSyncedAt,
    required this.name,
    required this.address,
    required this.postalCode,
    required this.city,
    required this.country,
    required this.phone,
    required this.email,
    this.logoFileId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['tenant_id'] = Variable<String>(tenantId);
    map['created_at'] = Variable<String>(createdAt);
    map['updated_at'] = Variable<String>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<String>(deletedAt);
    }
    map['version'] = Variable<int>(version);
    map['sync_status'] = Variable<String>(syncStatus);
    if (!nullToAbsent || lastSyncedAt != null) {
      map['last_synced_at'] = Variable<String>(lastSyncedAt);
    }
    map['name'] = Variable<String>(name);
    map['address'] = Variable<String>(address);
    map['postal_code'] = Variable<String>(postalCode);
    map['city'] = Variable<String>(city);
    map['country'] = Variable<String>(country);
    map['phone'] = Variable<String>(phone);
    map['email'] = Variable<String>(email);
    if (!nullToAbsent || logoFileId != null) {
      map['logo_file_id'] = Variable<String>(logoFileId);
    }
    return map;
  }

  TenantsCompanion toCompanion(bool nullToAbsent) {
    return TenantsCompanion(
      id: Value(id),
      tenantId: Value(tenantId),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      version: Value(version),
      syncStatus: Value(syncStatus),
      lastSyncedAt: lastSyncedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastSyncedAt),
      name: Value(name),
      address: Value(address),
      postalCode: Value(postalCode),
      city: Value(city),
      country: Value(country),
      phone: Value(phone),
      email: Value(email),
      logoFileId: logoFileId == null && nullToAbsent
          ? const Value.absent()
          : Value(logoFileId),
    );
  }

  factory TenantRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TenantRow(
      id: serializer.fromJson<String>(json['id']),
      tenantId: serializer.fromJson<String>(json['tenantId']),
      createdAt: serializer.fromJson<String>(json['createdAt']),
      updatedAt: serializer.fromJson<String>(json['updatedAt']),
      deletedAt: serializer.fromJson<String?>(json['deletedAt']),
      version: serializer.fromJson<int>(json['version']),
      syncStatus: serializer.fromJson<String>(json['syncStatus']),
      lastSyncedAt: serializer.fromJson<String?>(json['lastSyncedAt']),
      name: serializer.fromJson<String>(json['name']),
      address: serializer.fromJson<String>(json['address']),
      postalCode: serializer.fromJson<String>(json['postalCode']),
      city: serializer.fromJson<String>(json['city']),
      country: serializer.fromJson<String>(json['country']),
      phone: serializer.fromJson<String>(json['phone']),
      email: serializer.fromJson<String>(json['email']),
      logoFileId: serializer.fromJson<String?>(json['logoFileId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'tenantId': serializer.toJson<String>(tenantId),
      'createdAt': serializer.toJson<String>(createdAt),
      'updatedAt': serializer.toJson<String>(updatedAt),
      'deletedAt': serializer.toJson<String?>(deletedAt),
      'version': serializer.toJson<int>(version),
      'syncStatus': serializer.toJson<String>(syncStatus),
      'lastSyncedAt': serializer.toJson<String?>(lastSyncedAt),
      'name': serializer.toJson<String>(name),
      'address': serializer.toJson<String>(address),
      'postalCode': serializer.toJson<String>(postalCode),
      'city': serializer.toJson<String>(city),
      'country': serializer.toJson<String>(country),
      'phone': serializer.toJson<String>(phone),
      'email': serializer.toJson<String>(email),
      'logoFileId': serializer.toJson<String?>(logoFileId),
    };
  }

  TenantRow copyWith({
    String? id,
    String? tenantId,
    String? createdAt,
    String? updatedAt,
    Value<String?> deletedAt = const Value.absent(),
    int? version,
    String? syncStatus,
    Value<String?> lastSyncedAt = const Value.absent(),
    String? name,
    String? address,
    String? postalCode,
    String? city,
    String? country,
    String? phone,
    String? email,
    Value<String?> logoFileId = const Value.absent(),
  }) => TenantRow(
    id: id ?? this.id,
    tenantId: tenantId ?? this.tenantId,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    version: version ?? this.version,
    syncStatus: syncStatus ?? this.syncStatus,
    lastSyncedAt: lastSyncedAt.present ? lastSyncedAt.value : this.lastSyncedAt,
    name: name ?? this.name,
    address: address ?? this.address,
    postalCode: postalCode ?? this.postalCode,
    city: city ?? this.city,
    country: country ?? this.country,
    phone: phone ?? this.phone,
    email: email ?? this.email,
    logoFileId: logoFileId.present ? logoFileId.value : this.logoFileId,
  );
  TenantRow copyWithCompanion(TenantsCompanion data) {
    return TenantRow(
      id: data.id.present ? data.id.value : this.id,
      tenantId: data.tenantId.present ? data.tenantId.value : this.tenantId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      version: data.version.present ? data.version.value : this.version,
      syncStatus: data.syncStatus.present
          ? data.syncStatus.value
          : this.syncStatus,
      lastSyncedAt: data.lastSyncedAt.present
          ? data.lastSyncedAt.value
          : this.lastSyncedAt,
      name: data.name.present ? data.name.value : this.name,
      address: data.address.present ? data.address.value : this.address,
      postalCode: data.postalCode.present
          ? data.postalCode.value
          : this.postalCode,
      city: data.city.present ? data.city.value : this.city,
      country: data.country.present ? data.country.value : this.country,
      phone: data.phone.present ? data.phone.value : this.phone,
      email: data.email.present ? data.email.value : this.email,
      logoFileId: data.logoFileId.present
          ? data.logoFileId.value
          : this.logoFileId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TenantRow(')
          ..write('id: $id, ')
          ..write('tenantId: $tenantId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('version: $version, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('lastSyncedAt: $lastSyncedAt, ')
          ..write('name: $name, ')
          ..write('address: $address, ')
          ..write('postalCode: $postalCode, ')
          ..write('city: $city, ')
          ..write('country: $country, ')
          ..write('phone: $phone, ')
          ..write('email: $email, ')
          ..write('logoFileId: $logoFileId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    tenantId,
    createdAt,
    updatedAt,
    deletedAt,
    version,
    syncStatus,
    lastSyncedAt,
    name,
    address,
    postalCode,
    city,
    country,
    phone,
    email,
    logoFileId,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TenantRow &&
          other.id == this.id &&
          other.tenantId == this.tenantId &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.version == this.version &&
          other.syncStatus == this.syncStatus &&
          other.lastSyncedAt == this.lastSyncedAt &&
          other.name == this.name &&
          other.address == this.address &&
          other.postalCode == this.postalCode &&
          other.city == this.city &&
          other.country == this.country &&
          other.phone == this.phone &&
          other.email == this.email &&
          other.logoFileId == this.logoFileId);
}

class TenantsCompanion extends UpdateCompanion<TenantRow> {
  final Value<String> id;
  final Value<String> tenantId;
  final Value<String> createdAt;
  final Value<String> updatedAt;
  final Value<String?> deletedAt;
  final Value<int> version;
  final Value<String> syncStatus;
  final Value<String?> lastSyncedAt;
  final Value<String> name;
  final Value<String> address;
  final Value<String> postalCode;
  final Value<String> city;
  final Value<String> country;
  final Value<String> phone;
  final Value<String> email;
  final Value<String?> logoFileId;
  final Value<int> rowid;
  const TenantsCompanion({
    this.id = const Value.absent(),
    this.tenantId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.version = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.lastSyncedAt = const Value.absent(),
    this.name = const Value.absent(),
    this.address = const Value.absent(),
    this.postalCode = const Value.absent(),
    this.city = const Value.absent(),
    this.country = const Value.absent(),
    this.phone = const Value.absent(),
    this.email = const Value.absent(),
    this.logoFileId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TenantsCompanion.insert({
    required String id,
    required String tenantId,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.version = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.lastSyncedAt = const Value.absent(),
    required String name,
    required String address,
    required String postalCode,
    required String city,
    required String country,
    required String phone,
    required String email,
    this.logoFileId = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       tenantId = Value(tenantId),
       name = Value(name),
       address = Value(address),
       postalCode = Value(postalCode),
       city = Value(city),
       country = Value(country),
       phone = Value(phone),
       email = Value(email);
  static Insertable<TenantRow> custom({
    Expression<String>? id,
    Expression<String>? tenantId,
    Expression<String>? createdAt,
    Expression<String>? updatedAt,
    Expression<String>? deletedAt,
    Expression<int>? version,
    Expression<String>? syncStatus,
    Expression<String>? lastSyncedAt,
    Expression<String>? name,
    Expression<String>? address,
    Expression<String>? postalCode,
    Expression<String>? city,
    Expression<String>? country,
    Expression<String>? phone,
    Expression<String>? email,
    Expression<String>? logoFileId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (tenantId != null) 'tenant_id': tenantId,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (version != null) 'version': version,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (lastSyncedAt != null) 'last_synced_at': lastSyncedAt,
      if (name != null) 'name': name,
      if (address != null) 'address': address,
      if (postalCode != null) 'postal_code': postalCode,
      if (city != null) 'city': city,
      if (country != null) 'country': country,
      if (phone != null) 'phone': phone,
      if (email != null) 'email': email,
      if (logoFileId != null) 'logo_file_id': logoFileId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TenantsCompanion copyWith({
    Value<String>? id,
    Value<String>? tenantId,
    Value<String>? createdAt,
    Value<String>? updatedAt,
    Value<String?>? deletedAt,
    Value<int>? version,
    Value<String>? syncStatus,
    Value<String?>? lastSyncedAt,
    Value<String>? name,
    Value<String>? address,
    Value<String>? postalCode,
    Value<String>? city,
    Value<String>? country,
    Value<String>? phone,
    Value<String>? email,
    Value<String?>? logoFileId,
    Value<int>? rowid,
  }) {
    return TenantsCompanion(
      id: id ?? this.id,
      tenantId: tenantId ?? this.tenantId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      version: version ?? this.version,
      syncStatus: syncStatus ?? this.syncStatus,
      lastSyncedAt: lastSyncedAt ?? this.lastSyncedAt,
      name: name ?? this.name,
      address: address ?? this.address,
      postalCode: postalCode ?? this.postalCode,
      city: city ?? this.city,
      country: country ?? this.country,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      logoFileId: logoFileId ?? this.logoFileId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (tenantId.present) {
      map['tenant_id'] = Variable<String>(tenantId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<String>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<String>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<String>(deletedAt.value);
    }
    if (version.present) {
      map['version'] = Variable<int>(version.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(syncStatus.value);
    }
    if (lastSyncedAt.present) {
      map['last_synced_at'] = Variable<String>(lastSyncedAt.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (address.present) {
      map['address'] = Variable<String>(address.value);
    }
    if (postalCode.present) {
      map['postal_code'] = Variable<String>(postalCode.value);
    }
    if (city.present) {
      map['city'] = Variable<String>(city.value);
    }
    if (country.present) {
      map['country'] = Variable<String>(country.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (logoFileId.present) {
      map['logo_file_id'] = Variable<String>(logoFileId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TenantsCompanion(')
          ..write('id: $id, ')
          ..write('tenantId: $tenantId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('version: $version, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('lastSyncedAt: $lastSyncedAt, ')
          ..write('name: $name, ')
          ..write('address: $address, ')
          ..write('postalCode: $postalCode, ')
          ..write('city: $city, ')
          ..write('country: $country, ')
          ..write('phone: $phone, ')
          ..write('email: $email, ')
          ..write('logoFileId: $logoFileId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $UsersTable extends Users with TableInfo<$UsersTable, UserRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UsersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _tenantIdMeta = const VerificationMeta(
    'tenantId',
  );
  @override
  late final GeneratedColumn<String> tenantId = GeneratedColumn<String>(
    'tenant_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<String> createdAt = GeneratedColumn<String>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: _utcNowIso,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<String> updatedAt = GeneratedColumn<String>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: _utcNowIso,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<String> deletedAt = GeneratedColumn<String>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _versionMeta = const VerificationMeta(
    'version',
  );
  @override
  late final GeneratedColumn<int> version = GeneratedColumn<int>(
    'version',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
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
    defaultValue: const Constant('synced'),
  );
  static const VerificationMeta _lastSyncedAtMeta = const VerificationMeta(
    'lastSyncedAt',
  );
  @override
  late final GeneratedColumn<String> lastSyncedAt = GeneratedColumn<String>(
    'last_synced_at',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _firstNameMeta = const VerificationMeta(
    'firstName',
  );
  @override
  late final GeneratedColumn<String> firstName = GeneratedColumn<String>(
    'first_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lastNameMeta = const VerificationMeta(
    'lastName',
  );
  @override
  late final GeneratedColumn<String> lastName = GeneratedColumn<String>(
    'last_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
    'email',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
    'phone',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _roleMeta = const VerificationMeta('role');
  @override
  late final GeneratedColumn<String> role = GeneratedColumn<String>(
    'role',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    tenantId,
    createdAt,
    updatedAt,
    deletedAt,
    version,
    syncStatus,
    lastSyncedAt,
    firstName,
    lastName,
    email,
    phone,
    role,
    isActive,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'users';
  @override
  VerificationContext validateIntegrity(
    Insertable<UserRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('tenant_id')) {
      context.handle(
        _tenantIdMeta,
        tenantId.isAcceptableOrUnknown(data['tenant_id']!, _tenantIdMeta),
      );
    } else if (isInserting) {
      context.missing(_tenantIdMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('version')) {
      context.handle(
        _versionMeta,
        version.isAcceptableOrUnknown(data['version']!, _versionMeta),
      );
    }
    if (data.containsKey('sync_status')) {
      context.handle(
        _syncStatusMeta,
        syncStatus.isAcceptableOrUnknown(data['sync_status']!, _syncStatusMeta),
      );
    }
    if (data.containsKey('last_synced_at')) {
      context.handle(
        _lastSyncedAtMeta,
        lastSyncedAt.isAcceptableOrUnknown(
          data['last_synced_at']!,
          _lastSyncedAtMeta,
        ),
      );
    }
    if (data.containsKey('first_name')) {
      context.handle(
        _firstNameMeta,
        firstName.isAcceptableOrUnknown(data['first_name']!, _firstNameMeta),
      );
    } else if (isInserting) {
      context.missing(_firstNameMeta);
    }
    if (data.containsKey('last_name')) {
      context.handle(
        _lastNameMeta,
        lastName.isAcceptableOrUnknown(data['last_name']!, _lastNameMeta),
      );
    } else if (isInserting) {
      context.missing(_lastNameMeta);
    }
    if (data.containsKey('email')) {
      context.handle(
        _emailMeta,
        email.isAcceptableOrUnknown(data['email']!, _emailMeta),
      );
    } else if (isInserting) {
      context.missing(_emailMeta);
    }
    if (data.containsKey('phone')) {
      context.handle(
        _phoneMeta,
        phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta),
      );
    }
    if (data.containsKey('role')) {
      context.handle(
        _roleMeta,
        role.isAcceptableOrUnknown(data['role']!, _roleMeta),
      );
    } else if (isInserting) {
      context.missing(_roleMeta);
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UserRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      tenantId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tenant_id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}deleted_at'],
      ),
      version: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}version'],
      )!,
      syncStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sync_status'],
      )!,
      lastSyncedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_synced_at'],
      ),
      firstName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}first_name'],
      )!,
      lastName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_name'],
      )!,
      email: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}email'],
      )!,
      phone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone'],
      ),
      role: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}role'],
      )!,
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
    );
  }

  @override
  $UsersTable createAlias(String alias) {
    return $UsersTable(attachedDatabase, alias);
  }
}

class UserRow extends DataClass implements Insertable<UserRow> {
  final String id;
  final String tenantId;
  final String createdAt;
  final String updatedAt;
  final String? deletedAt;
  final int version;
  final String syncStatus;
  final String? lastSyncedAt;
  final String firstName;
  final String lastName;
  final String email;
  final String? phone;
  final String role;
  final bool isActive;
  const UserRow({
    required this.id,
    required this.tenantId,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.version,
    required this.syncStatus,
    this.lastSyncedAt,
    required this.firstName,
    required this.lastName,
    required this.email,
    this.phone,
    required this.role,
    required this.isActive,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['tenant_id'] = Variable<String>(tenantId);
    map['created_at'] = Variable<String>(createdAt);
    map['updated_at'] = Variable<String>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<String>(deletedAt);
    }
    map['version'] = Variable<int>(version);
    map['sync_status'] = Variable<String>(syncStatus);
    if (!nullToAbsent || lastSyncedAt != null) {
      map['last_synced_at'] = Variable<String>(lastSyncedAt);
    }
    map['first_name'] = Variable<String>(firstName);
    map['last_name'] = Variable<String>(lastName);
    map['email'] = Variable<String>(email);
    if (!nullToAbsent || phone != null) {
      map['phone'] = Variable<String>(phone);
    }
    map['role'] = Variable<String>(role);
    map['is_active'] = Variable<bool>(isActive);
    return map;
  }

  UsersCompanion toCompanion(bool nullToAbsent) {
    return UsersCompanion(
      id: Value(id),
      tenantId: Value(tenantId),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      version: Value(version),
      syncStatus: Value(syncStatus),
      lastSyncedAt: lastSyncedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastSyncedAt),
      firstName: Value(firstName),
      lastName: Value(lastName),
      email: Value(email),
      phone: phone == null && nullToAbsent
          ? const Value.absent()
          : Value(phone),
      role: Value(role),
      isActive: Value(isActive),
    );
  }

  factory UserRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserRow(
      id: serializer.fromJson<String>(json['id']),
      tenantId: serializer.fromJson<String>(json['tenantId']),
      createdAt: serializer.fromJson<String>(json['createdAt']),
      updatedAt: serializer.fromJson<String>(json['updatedAt']),
      deletedAt: serializer.fromJson<String?>(json['deletedAt']),
      version: serializer.fromJson<int>(json['version']),
      syncStatus: serializer.fromJson<String>(json['syncStatus']),
      lastSyncedAt: serializer.fromJson<String?>(json['lastSyncedAt']),
      firstName: serializer.fromJson<String>(json['firstName']),
      lastName: serializer.fromJson<String>(json['lastName']),
      email: serializer.fromJson<String>(json['email']),
      phone: serializer.fromJson<String?>(json['phone']),
      role: serializer.fromJson<String>(json['role']),
      isActive: serializer.fromJson<bool>(json['isActive']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'tenantId': serializer.toJson<String>(tenantId),
      'createdAt': serializer.toJson<String>(createdAt),
      'updatedAt': serializer.toJson<String>(updatedAt),
      'deletedAt': serializer.toJson<String?>(deletedAt),
      'version': serializer.toJson<int>(version),
      'syncStatus': serializer.toJson<String>(syncStatus),
      'lastSyncedAt': serializer.toJson<String?>(lastSyncedAt),
      'firstName': serializer.toJson<String>(firstName),
      'lastName': serializer.toJson<String>(lastName),
      'email': serializer.toJson<String>(email),
      'phone': serializer.toJson<String?>(phone),
      'role': serializer.toJson<String>(role),
      'isActive': serializer.toJson<bool>(isActive),
    };
  }

  UserRow copyWith({
    String? id,
    String? tenantId,
    String? createdAt,
    String? updatedAt,
    Value<String?> deletedAt = const Value.absent(),
    int? version,
    String? syncStatus,
    Value<String?> lastSyncedAt = const Value.absent(),
    String? firstName,
    String? lastName,
    String? email,
    Value<String?> phone = const Value.absent(),
    String? role,
    bool? isActive,
  }) => UserRow(
    id: id ?? this.id,
    tenantId: tenantId ?? this.tenantId,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    version: version ?? this.version,
    syncStatus: syncStatus ?? this.syncStatus,
    lastSyncedAt: lastSyncedAt.present ? lastSyncedAt.value : this.lastSyncedAt,
    firstName: firstName ?? this.firstName,
    lastName: lastName ?? this.lastName,
    email: email ?? this.email,
    phone: phone.present ? phone.value : this.phone,
    role: role ?? this.role,
    isActive: isActive ?? this.isActive,
  );
  UserRow copyWithCompanion(UsersCompanion data) {
    return UserRow(
      id: data.id.present ? data.id.value : this.id,
      tenantId: data.tenantId.present ? data.tenantId.value : this.tenantId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      version: data.version.present ? data.version.value : this.version,
      syncStatus: data.syncStatus.present
          ? data.syncStatus.value
          : this.syncStatus,
      lastSyncedAt: data.lastSyncedAt.present
          ? data.lastSyncedAt.value
          : this.lastSyncedAt,
      firstName: data.firstName.present ? data.firstName.value : this.firstName,
      lastName: data.lastName.present ? data.lastName.value : this.lastName,
      email: data.email.present ? data.email.value : this.email,
      phone: data.phone.present ? data.phone.value : this.phone,
      role: data.role.present ? data.role.value : this.role,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserRow(')
          ..write('id: $id, ')
          ..write('tenantId: $tenantId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('version: $version, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('lastSyncedAt: $lastSyncedAt, ')
          ..write('firstName: $firstName, ')
          ..write('lastName: $lastName, ')
          ..write('email: $email, ')
          ..write('phone: $phone, ')
          ..write('role: $role, ')
          ..write('isActive: $isActive')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    tenantId,
    createdAt,
    updatedAt,
    deletedAt,
    version,
    syncStatus,
    lastSyncedAt,
    firstName,
    lastName,
    email,
    phone,
    role,
    isActive,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserRow &&
          other.id == this.id &&
          other.tenantId == this.tenantId &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.version == this.version &&
          other.syncStatus == this.syncStatus &&
          other.lastSyncedAt == this.lastSyncedAt &&
          other.firstName == this.firstName &&
          other.lastName == this.lastName &&
          other.email == this.email &&
          other.phone == this.phone &&
          other.role == this.role &&
          other.isActive == this.isActive);
}

class UsersCompanion extends UpdateCompanion<UserRow> {
  final Value<String> id;
  final Value<String> tenantId;
  final Value<String> createdAt;
  final Value<String> updatedAt;
  final Value<String?> deletedAt;
  final Value<int> version;
  final Value<String> syncStatus;
  final Value<String?> lastSyncedAt;
  final Value<String> firstName;
  final Value<String> lastName;
  final Value<String> email;
  final Value<String?> phone;
  final Value<String> role;
  final Value<bool> isActive;
  final Value<int> rowid;
  const UsersCompanion({
    this.id = const Value.absent(),
    this.tenantId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.version = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.lastSyncedAt = const Value.absent(),
    this.firstName = const Value.absent(),
    this.lastName = const Value.absent(),
    this.email = const Value.absent(),
    this.phone = const Value.absent(),
    this.role = const Value.absent(),
    this.isActive = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  UsersCompanion.insert({
    required String id,
    required String tenantId,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.version = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.lastSyncedAt = const Value.absent(),
    required String firstName,
    required String lastName,
    required String email,
    this.phone = const Value.absent(),
    required String role,
    this.isActive = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       tenantId = Value(tenantId),
       firstName = Value(firstName),
       lastName = Value(lastName),
       email = Value(email),
       role = Value(role);
  static Insertable<UserRow> custom({
    Expression<String>? id,
    Expression<String>? tenantId,
    Expression<String>? createdAt,
    Expression<String>? updatedAt,
    Expression<String>? deletedAt,
    Expression<int>? version,
    Expression<String>? syncStatus,
    Expression<String>? lastSyncedAt,
    Expression<String>? firstName,
    Expression<String>? lastName,
    Expression<String>? email,
    Expression<String>? phone,
    Expression<String>? role,
    Expression<bool>? isActive,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (tenantId != null) 'tenant_id': tenantId,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (version != null) 'version': version,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (lastSyncedAt != null) 'last_synced_at': lastSyncedAt,
      if (firstName != null) 'first_name': firstName,
      if (lastName != null) 'last_name': lastName,
      if (email != null) 'email': email,
      if (phone != null) 'phone': phone,
      if (role != null) 'role': role,
      if (isActive != null) 'is_active': isActive,
      if (rowid != null) 'rowid': rowid,
    });
  }

  UsersCompanion copyWith({
    Value<String>? id,
    Value<String>? tenantId,
    Value<String>? createdAt,
    Value<String>? updatedAt,
    Value<String?>? deletedAt,
    Value<int>? version,
    Value<String>? syncStatus,
    Value<String?>? lastSyncedAt,
    Value<String>? firstName,
    Value<String>? lastName,
    Value<String>? email,
    Value<String?>? phone,
    Value<String>? role,
    Value<bool>? isActive,
    Value<int>? rowid,
  }) {
    return UsersCompanion(
      id: id ?? this.id,
      tenantId: tenantId ?? this.tenantId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      version: version ?? this.version,
      syncStatus: syncStatus ?? this.syncStatus,
      lastSyncedAt: lastSyncedAt ?? this.lastSyncedAt,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      role: role ?? this.role,
      isActive: isActive ?? this.isActive,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (tenantId.present) {
      map['tenant_id'] = Variable<String>(tenantId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<String>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<String>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<String>(deletedAt.value);
    }
    if (version.present) {
      map['version'] = Variable<int>(version.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(syncStatus.value);
    }
    if (lastSyncedAt.present) {
      map['last_synced_at'] = Variable<String>(lastSyncedAt.value);
    }
    if (firstName.present) {
      map['first_name'] = Variable<String>(firstName.value);
    }
    if (lastName.present) {
      map['last_name'] = Variable<String>(lastName.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (role.present) {
      map['role'] = Variable<String>(role.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UsersCompanion(')
          ..write('id: $id, ')
          ..write('tenantId: $tenantId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('version: $version, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('lastSyncedAt: $lastSyncedAt, ')
          ..write('firstName: $firstName, ')
          ..write('lastName: $lastName, ')
          ..write('email: $email, ')
          ..write('phone: $phone, ')
          ..write('role: $role, ')
          ..write('isActive: $isActive, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CustomersTable extends Customers
    with TableInfo<$CustomersTable, CustomerRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CustomersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _tenantIdMeta = const VerificationMeta(
    'tenantId',
  );
  @override
  late final GeneratedColumn<String> tenantId = GeneratedColumn<String>(
    'tenant_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<String> createdAt = GeneratedColumn<String>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: _utcNowIso,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<String> updatedAt = GeneratedColumn<String>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: _utcNowIso,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<String> deletedAt = GeneratedColumn<String>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _versionMeta = const VerificationMeta(
    'version',
  );
  @override
  late final GeneratedColumn<int> version = GeneratedColumn<int>(
    'version',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
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
    defaultValue: const Constant('synced'),
  );
  static const VerificationMeta _lastSyncedAtMeta = const VerificationMeta(
    'lastSyncedAt',
  );
  @override
  late final GeneratedColumn<String> lastSyncedAt = GeneratedColumn<String>(
    'last_synced_at',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _displayNameMeta = const VerificationMeta(
    'displayName',
  );
  @override
  late final GeneratedColumn<String> displayName = GeneratedColumn<String>(
    'display_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _firstNameMeta = const VerificationMeta(
    'firstName',
  );
  @override
  late final GeneratedColumn<String> firstName = GeneratedColumn<String>(
    'first_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lastNameMeta = const VerificationMeta(
    'lastName',
  );
  @override
  late final GeneratedColumn<String> lastName = GeneratedColumn<String>(
    'last_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _companyNameMeta = const VerificationMeta(
    'companyName',
  );
  @override
  late final GeneratedColumn<String> companyName = GeneratedColumn<String>(
    'company_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
    'email',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
    'phone',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _mobileMeta = const VerificationMeta('mobile');
  @override
  late final GeneratedColumn<String> mobile = GeneratedColumn<String>(
    'mobile',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _billingAddressMeta = const VerificationMeta(
    'billingAddress',
  );
  @override
  late final GeneratedColumn<String> billingAddress = GeneratedColumn<String>(
    'billing_address',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    tenantId,
    createdAt,
    updatedAt,
    deletedAt,
    version,
    syncStatus,
    lastSyncedAt,
    type,
    displayName,
    firstName,
    lastName,
    companyName,
    email,
    phone,
    mobile,
    billingAddress,
    notes,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'customers';
  @override
  VerificationContext validateIntegrity(
    Insertable<CustomerRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('tenant_id')) {
      context.handle(
        _tenantIdMeta,
        tenantId.isAcceptableOrUnknown(data['tenant_id']!, _tenantIdMeta),
      );
    } else if (isInserting) {
      context.missing(_tenantIdMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('version')) {
      context.handle(
        _versionMeta,
        version.isAcceptableOrUnknown(data['version']!, _versionMeta),
      );
    }
    if (data.containsKey('sync_status')) {
      context.handle(
        _syncStatusMeta,
        syncStatus.isAcceptableOrUnknown(data['sync_status']!, _syncStatusMeta),
      );
    }
    if (data.containsKey('last_synced_at')) {
      context.handle(
        _lastSyncedAtMeta,
        lastSyncedAt.isAcceptableOrUnknown(
          data['last_synced_at']!,
          _lastSyncedAtMeta,
        ),
      );
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('display_name')) {
      context.handle(
        _displayNameMeta,
        displayName.isAcceptableOrUnknown(
          data['display_name']!,
          _displayNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_displayNameMeta);
    }
    if (data.containsKey('first_name')) {
      context.handle(
        _firstNameMeta,
        firstName.isAcceptableOrUnknown(data['first_name']!, _firstNameMeta),
      );
    }
    if (data.containsKey('last_name')) {
      context.handle(
        _lastNameMeta,
        lastName.isAcceptableOrUnknown(data['last_name']!, _lastNameMeta),
      );
    }
    if (data.containsKey('company_name')) {
      context.handle(
        _companyNameMeta,
        companyName.isAcceptableOrUnknown(
          data['company_name']!,
          _companyNameMeta,
        ),
      );
    }
    if (data.containsKey('email')) {
      context.handle(
        _emailMeta,
        email.isAcceptableOrUnknown(data['email']!, _emailMeta),
      );
    }
    if (data.containsKey('phone')) {
      context.handle(
        _phoneMeta,
        phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta),
      );
    }
    if (data.containsKey('mobile')) {
      context.handle(
        _mobileMeta,
        mobile.isAcceptableOrUnknown(data['mobile']!, _mobileMeta),
      );
    }
    if (data.containsKey('billing_address')) {
      context.handle(
        _billingAddressMeta,
        billingAddress.isAcceptableOrUnknown(
          data['billing_address']!,
          _billingAddressMeta,
        ),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CustomerRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CustomerRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      tenantId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tenant_id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}deleted_at'],
      ),
      version: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}version'],
      )!,
      syncStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sync_status'],
      )!,
      lastSyncedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_synced_at'],
      ),
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      displayName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}display_name'],
      )!,
      firstName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}first_name'],
      ),
      lastName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_name'],
      ),
      companyName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}company_name'],
      ),
      email: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}email'],
      ),
      phone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone'],
      ),
      mobile: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}mobile'],
      ),
      billingAddress: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}billing_address'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
    );
  }

  @override
  $CustomersTable createAlias(String alias) {
    return $CustomersTable(attachedDatabase, alias);
  }
}

class CustomerRow extends DataClass implements Insertable<CustomerRow> {
  final String id;
  final String tenantId;
  final String createdAt;
  final String updatedAt;
  final String? deletedAt;
  final int version;
  final String syncStatus;
  final String? lastSyncedAt;
  final String type;
  final String displayName;
  final String? firstName;
  final String? lastName;
  final String? companyName;
  final String? email;
  final String? phone;
  final String? mobile;
  final String? billingAddress;
  final String? notes;
  const CustomerRow({
    required this.id,
    required this.tenantId,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.version,
    required this.syncStatus,
    this.lastSyncedAt,
    required this.type,
    required this.displayName,
    this.firstName,
    this.lastName,
    this.companyName,
    this.email,
    this.phone,
    this.mobile,
    this.billingAddress,
    this.notes,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['tenant_id'] = Variable<String>(tenantId);
    map['created_at'] = Variable<String>(createdAt);
    map['updated_at'] = Variable<String>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<String>(deletedAt);
    }
    map['version'] = Variable<int>(version);
    map['sync_status'] = Variable<String>(syncStatus);
    if (!nullToAbsent || lastSyncedAt != null) {
      map['last_synced_at'] = Variable<String>(lastSyncedAt);
    }
    map['type'] = Variable<String>(type);
    map['display_name'] = Variable<String>(displayName);
    if (!nullToAbsent || firstName != null) {
      map['first_name'] = Variable<String>(firstName);
    }
    if (!nullToAbsent || lastName != null) {
      map['last_name'] = Variable<String>(lastName);
    }
    if (!nullToAbsent || companyName != null) {
      map['company_name'] = Variable<String>(companyName);
    }
    if (!nullToAbsent || email != null) {
      map['email'] = Variable<String>(email);
    }
    if (!nullToAbsent || phone != null) {
      map['phone'] = Variable<String>(phone);
    }
    if (!nullToAbsent || mobile != null) {
      map['mobile'] = Variable<String>(mobile);
    }
    if (!nullToAbsent || billingAddress != null) {
      map['billing_address'] = Variable<String>(billingAddress);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    return map;
  }

  CustomersCompanion toCompanion(bool nullToAbsent) {
    return CustomersCompanion(
      id: Value(id),
      tenantId: Value(tenantId),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      version: Value(version),
      syncStatus: Value(syncStatus),
      lastSyncedAt: lastSyncedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastSyncedAt),
      type: Value(type),
      displayName: Value(displayName),
      firstName: firstName == null && nullToAbsent
          ? const Value.absent()
          : Value(firstName),
      lastName: lastName == null && nullToAbsent
          ? const Value.absent()
          : Value(lastName),
      companyName: companyName == null && nullToAbsent
          ? const Value.absent()
          : Value(companyName),
      email: email == null && nullToAbsent
          ? const Value.absent()
          : Value(email),
      phone: phone == null && nullToAbsent
          ? const Value.absent()
          : Value(phone),
      mobile: mobile == null && nullToAbsent
          ? const Value.absent()
          : Value(mobile),
      billingAddress: billingAddress == null && nullToAbsent
          ? const Value.absent()
          : Value(billingAddress),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
    );
  }

  factory CustomerRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CustomerRow(
      id: serializer.fromJson<String>(json['id']),
      tenantId: serializer.fromJson<String>(json['tenantId']),
      createdAt: serializer.fromJson<String>(json['createdAt']),
      updatedAt: serializer.fromJson<String>(json['updatedAt']),
      deletedAt: serializer.fromJson<String?>(json['deletedAt']),
      version: serializer.fromJson<int>(json['version']),
      syncStatus: serializer.fromJson<String>(json['syncStatus']),
      lastSyncedAt: serializer.fromJson<String?>(json['lastSyncedAt']),
      type: serializer.fromJson<String>(json['type']),
      displayName: serializer.fromJson<String>(json['displayName']),
      firstName: serializer.fromJson<String?>(json['firstName']),
      lastName: serializer.fromJson<String?>(json['lastName']),
      companyName: serializer.fromJson<String?>(json['companyName']),
      email: serializer.fromJson<String?>(json['email']),
      phone: serializer.fromJson<String?>(json['phone']),
      mobile: serializer.fromJson<String?>(json['mobile']),
      billingAddress: serializer.fromJson<String?>(json['billingAddress']),
      notes: serializer.fromJson<String?>(json['notes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'tenantId': serializer.toJson<String>(tenantId),
      'createdAt': serializer.toJson<String>(createdAt),
      'updatedAt': serializer.toJson<String>(updatedAt),
      'deletedAt': serializer.toJson<String?>(deletedAt),
      'version': serializer.toJson<int>(version),
      'syncStatus': serializer.toJson<String>(syncStatus),
      'lastSyncedAt': serializer.toJson<String?>(lastSyncedAt),
      'type': serializer.toJson<String>(type),
      'displayName': serializer.toJson<String>(displayName),
      'firstName': serializer.toJson<String?>(firstName),
      'lastName': serializer.toJson<String?>(lastName),
      'companyName': serializer.toJson<String?>(companyName),
      'email': serializer.toJson<String?>(email),
      'phone': serializer.toJson<String?>(phone),
      'mobile': serializer.toJson<String?>(mobile),
      'billingAddress': serializer.toJson<String?>(billingAddress),
      'notes': serializer.toJson<String?>(notes),
    };
  }

  CustomerRow copyWith({
    String? id,
    String? tenantId,
    String? createdAt,
    String? updatedAt,
    Value<String?> deletedAt = const Value.absent(),
    int? version,
    String? syncStatus,
    Value<String?> lastSyncedAt = const Value.absent(),
    String? type,
    String? displayName,
    Value<String?> firstName = const Value.absent(),
    Value<String?> lastName = const Value.absent(),
    Value<String?> companyName = const Value.absent(),
    Value<String?> email = const Value.absent(),
    Value<String?> phone = const Value.absent(),
    Value<String?> mobile = const Value.absent(),
    Value<String?> billingAddress = const Value.absent(),
    Value<String?> notes = const Value.absent(),
  }) => CustomerRow(
    id: id ?? this.id,
    tenantId: tenantId ?? this.tenantId,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    version: version ?? this.version,
    syncStatus: syncStatus ?? this.syncStatus,
    lastSyncedAt: lastSyncedAt.present ? lastSyncedAt.value : this.lastSyncedAt,
    type: type ?? this.type,
    displayName: displayName ?? this.displayName,
    firstName: firstName.present ? firstName.value : this.firstName,
    lastName: lastName.present ? lastName.value : this.lastName,
    companyName: companyName.present ? companyName.value : this.companyName,
    email: email.present ? email.value : this.email,
    phone: phone.present ? phone.value : this.phone,
    mobile: mobile.present ? mobile.value : this.mobile,
    billingAddress: billingAddress.present
        ? billingAddress.value
        : this.billingAddress,
    notes: notes.present ? notes.value : this.notes,
  );
  CustomerRow copyWithCompanion(CustomersCompanion data) {
    return CustomerRow(
      id: data.id.present ? data.id.value : this.id,
      tenantId: data.tenantId.present ? data.tenantId.value : this.tenantId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      version: data.version.present ? data.version.value : this.version,
      syncStatus: data.syncStatus.present
          ? data.syncStatus.value
          : this.syncStatus,
      lastSyncedAt: data.lastSyncedAt.present
          ? data.lastSyncedAt.value
          : this.lastSyncedAt,
      type: data.type.present ? data.type.value : this.type,
      displayName: data.displayName.present
          ? data.displayName.value
          : this.displayName,
      firstName: data.firstName.present ? data.firstName.value : this.firstName,
      lastName: data.lastName.present ? data.lastName.value : this.lastName,
      companyName: data.companyName.present
          ? data.companyName.value
          : this.companyName,
      email: data.email.present ? data.email.value : this.email,
      phone: data.phone.present ? data.phone.value : this.phone,
      mobile: data.mobile.present ? data.mobile.value : this.mobile,
      billingAddress: data.billingAddress.present
          ? data.billingAddress.value
          : this.billingAddress,
      notes: data.notes.present ? data.notes.value : this.notes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CustomerRow(')
          ..write('id: $id, ')
          ..write('tenantId: $tenantId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('version: $version, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('lastSyncedAt: $lastSyncedAt, ')
          ..write('type: $type, ')
          ..write('displayName: $displayName, ')
          ..write('firstName: $firstName, ')
          ..write('lastName: $lastName, ')
          ..write('companyName: $companyName, ')
          ..write('email: $email, ')
          ..write('phone: $phone, ')
          ..write('mobile: $mobile, ')
          ..write('billingAddress: $billingAddress, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    tenantId,
    createdAt,
    updatedAt,
    deletedAt,
    version,
    syncStatus,
    lastSyncedAt,
    type,
    displayName,
    firstName,
    lastName,
    companyName,
    email,
    phone,
    mobile,
    billingAddress,
    notes,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CustomerRow &&
          other.id == this.id &&
          other.tenantId == this.tenantId &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.version == this.version &&
          other.syncStatus == this.syncStatus &&
          other.lastSyncedAt == this.lastSyncedAt &&
          other.type == this.type &&
          other.displayName == this.displayName &&
          other.firstName == this.firstName &&
          other.lastName == this.lastName &&
          other.companyName == this.companyName &&
          other.email == this.email &&
          other.phone == this.phone &&
          other.mobile == this.mobile &&
          other.billingAddress == this.billingAddress &&
          other.notes == this.notes);
}

class CustomersCompanion extends UpdateCompanion<CustomerRow> {
  final Value<String> id;
  final Value<String> tenantId;
  final Value<String> createdAt;
  final Value<String> updatedAt;
  final Value<String?> deletedAt;
  final Value<int> version;
  final Value<String> syncStatus;
  final Value<String?> lastSyncedAt;
  final Value<String> type;
  final Value<String> displayName;
  final Value<String?> firstName;
  final Value<String?> lastName;
  final Value<String?> companyName;
  final Value<String?> email;
  final Value<String?> phone;
  final Value<String?> mobile;
  final Value<String?> billingAddress;
  final Value<String?> notes;
  final Value<int> rowid;
  const CustomersCompanion({
    this.id = const Value.absent(),
    this.tenantId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.version = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.lastSyncedAt = const Value.absent(),
    this.type = const Value.absent(),
    this.displayName = const Value.absent(),
    this.firstName = const Value.absent(),
    this.lastName = const Value.absent(),
    this.companyName = const Value.absent(),
    this.email = const Value.absent(),
    this.phone = const Value.absent(),
    this.mobile = const Value.absent(),
    this.billingAddress = const Value.absent(),
    this.notes = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CustomersCompanion.insert({
    required String id,
    required String tenantId,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.version = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.lastSyncedAt = const Value.absent(),
    required String type,
    required String displayName,
    this.firstName = const Value.absent(),
    this.lastName = const Value.absent(),
    this.companyName = const Value.absent(),
    this.email = const Value.absent(),
    this.phone = const Value.absent(),
    this.mobile = const Value.absent(),
    this.billingAddress = const Value.absent(),
    this.notes = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       tenantId = Value(tenantId),
       type = Value(type),
       displayName = Value(displayName);
  static Insertable<CustomerRow> custom({
    Expression<String>? id,
    Expression<String>? tenantId,
    Expression<String>? createdAt,
    Expression<String>? updatedAt,
    Expression<String>? deletedAt,
    Expression<int>? version,
    Expression<String>? syncStatus,
    Expression<String>? lastSyncedAt,
    Expression<String>? type,
    Expression<String>? displayName,
    Expression<String>? firstName,
    Expression<String>? lastName,
    Expression<String>? companyName,
    Expression<String>? email,
    Expression<String>? phone,
    Expression<String>? mobile,
    Expression<String>? billingAddress,
    Expression<String>? notes,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (tenantId != null) 'tenant_id': tenantId,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (version != null) 'version': version,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (lastSyncedAt != null) 'last_synced_at': lastSyncedAt,
      if (type != null) 'type': type,
      if (displayName != null) 'display_name': displayName,
      if (firstName != null) 'first_name': firstName,
      if (lastName != null) 'last_name': lastName,
      if (companyName != null) 'company_name': companyName,
      if (email != null) 'email': email,
      if (phone != null) 'phone': phone,
      if (mobile != null) 'mobile': mobile,
      if (billingAddress != null) 'billing_address': billingAddress,
      if (notes != null) 'notes': notes,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CustomersCompanion copyWith({
    Value<String>? id,
    Value<String>? tenantId,
    Value<String>? createdAt,
    Value<String>? updatedAt,
    Value<String?>? deletedAt,
    Value<int>? version,
    Value<String>? syncStatus,
    Value<String?>? lastSyncedAt,
    Value<String>? type,
    Value<String>? displayName,
    Value<String?>? firstName,
    Value<String?>? lastName,
    Value<String?>? companyName,
    Value<String?>? email,
    Value<String?>? phone,
    Value<String?>? mobile,
    Value<String?>? billingAddress,
    Value<String?>? notes,
    Value<int>? rowid,
  }) {
    return CustomersCompanion(
      id: id ?? this.id,
      tenantId: tenantId ?? this.tenantId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      version: version ?? this.version,
      syncStatus: syncStatus ?? this.syncStatus,
      lastSyncedAt: lastSyncedAt ?? this.lastSyncedAt,
      type: type ?? this.type,
      displayName: displayName ?? this.displayName,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      companyName: companyName ?? this.companyName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      mobile: mobile ?? this.mobile,
      billingAddress: billingAddress ?? this.billingAddress,
      notes: notes ?? this.notes,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (tenantId.present) {
      map['tenant_id'] = Variable<String>(tenantId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<String>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<String>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<String>(deletedAt.value);
    }
    if (version.present) {
      map['version'] = Variable<int>(version.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(syncStatus.value);
    }
    if (lastSyncedAt.present) {
      map['last_synced_at'] = Variable<String>(lastSyncedAt.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (displayName.present) {
      map['display_name'] = Variable<String>(displayName.value);
    }
    if (firstName.present) {
      map['first_name'] = Variable<String>(firstName.value);
    }
    if (lastName.present) {
      map['last_name'] = Variable<String>(lastName.value);
    }
    if (companyName.present) {
      map['company_name'] = Variable<String>(companyName.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (mobile.present) {
      map['mobile'] = Variable<String>(mobile.value);
    }
    if (billingAddress.present) {
      map['billing_address'] = Variable<String>(billingAddress.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CustomersCompanion(')
          ..write('id: $id, ')
          ..write('tenantId: $tenantId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('version: $version, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('lastSyncedAt: $lastSyncedAt, ')
          ..write('type: $type, ')
          ..write('displayName: $displayName, ')
          ..write('firstName: $firstName, ')
          ..write('lastName: $lastName, ')
          ..write('companyName: $companyName, ')
          ..write('email: $email, ')
          ..write('phone: $phone, ')
          ..write('mobile: $mobile, ')
          ..write('billingAddress: $billingAddress, ')
          ..write('notes: $notes, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CustomerObjectsTable extends CustomerObjects
    with TableInfo<$CustomerObjectsTable, CustomerObjectRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CustomerObjectsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _tenantIdMeta = const VerificationMeta(
    'tenantId',
  );
  @override
  late final GeneratedColumn<String> tenantId = GeneratedColumn<String>(
    'tenant_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<String> createdAt = GeneratedColumn<String>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: _utcNowIso,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<String> updatedAt = GeneratedColumn<String>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: _utcNowIso,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<String> deletedAt = GeneratedColumn<String>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _versionMeta = const VerificationMeta(
    'version',
  );
  @override
  late final GeneratedColumn<int> version = GeneratedColumn<int>(
    'version',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
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
    defaultValue: const Constant('synced'),
  );
  static const VerificationMeta _lastSyncedAtMeta = const VerificationMeta(
    'lastSyncedAt',
  );
  @override
  late final GeneratedColumn<String> lastSyncedAt = GeneratedColumn<String>(
    'last_synced_at',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _customerIdMeta = const VerificationMeta(
    'customerId',
  );
  @override
  late final GeneratedColumn<String> customerId = GeneratedColumn<String>(
    'customer_id',
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
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _streetMeta = const VerificationMeta('street');
  @override
  late final GeneratedColumn<String> street = GeneratedColumn<String>(
    'street',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _houseNumberMeta = const VerificationMeta(
    'houseNumber',
  );
  @override
  late final GeneratedColumn<String> houseNumber = GeneratedColumn<String>(
    'house_number',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _postalCodeMeta = const VerificationMeta(
    'postalCode',
  );
  @override
  late final GeneratedColumn<String> postalCode = GeneratedColumn<String>(
    'postal_code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _cityMeta = const VerificationMeta('city');
  @override
  late final GeneratedColumn<String> city = GeneratedColumn<String>(
    'city',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _countryMeta = const VerificationMeta(
    'country',
  );
  @override
  late final GeneratedColumn<String> country = GeneratedColumn<String>(
    'country',
    aliasedName,
    false,
    type: DriftSqlType.string,
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
  static const VerificationMeta _accessNotesMeta = const VerificationMeta(
    'accessNotes',
  );
  @override
  late final GeneratedColumn<String> accessNotes = GeneratedColumn<String>(
    'access_notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _safetyNotesMeta = const VerificationMeta(
    'safetyNotes',
  );
  @override
  late final GeneratedColumn<String> safetyNotes = GeneratedColumn<String>(
    'safety_notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _objectNotesMeta = const VerificationMeta(
    'objectNotes',
  );
  @override
  late final GeneratedColumn<String> objectNotes = GeneratedColumn<String>(
    'object_notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    tenantId,
    createdAt,
    updatedAt,
    deletedAt,
    version,
    syncStatus,
    lastSyncedAt,
    customerId,
    name,
    street,
    houseNumber,
    postalCode,
    city,
    country,
    latitude,
    longitude,
    accessNotes,
    safetyNotes,
    objectNotes,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'objects';
  @override
  VerificationContext validateIntegrity(
    Insertable<CustomerObjectRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('tenant_id')) {
      context.handle(
        _tenantIdMeta,
        tenantId.isAcceptableOrUnknown(data['tenant_id']!, _tenantIdMeta),
      );
    } else if (isInserting) {
      context.missing(_tenantIdMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('version')) {
      context.handle(
        _versionMeta,
        version.isAcceptableOrUnknown(data['version']!, _versionMeta),
      );
    }
    if (data.containsKey('sync_status')) {
      context.handle(
        _syncStatusMeta,
        syncStatus.isAcceptableOrUnknown(data['sync_status']!, _syncStatusMeta),
      );
    }
    if (data.containsKey('last_synced_at')) {
      context.handle(
        _lastSyncedAtMeta,
        lastSyncedAt.isAcceptableOrUnknown(
          data['last_synced_at']!,
          _lastSyncedAtMeta,
        ),
      );
    }
    if (data.containsKey('customer_id')) {
      context.handle(
        _customerIdMeta,
        customerId.isAcceptableOrUnknown(data['customer_id']!, _customerIdMeta),
      );
    } else if (isInserting) {
      context.missing(_customerIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('street')) {
      context.handle(
        _streetMeta,
        street.isAcceptableOrUnknown(data['street']!, _streetMeta),
      );
    } else if (isInserting) {
      context.missing(_streetMeta);
    }
    if (data.containsKey('house_number')) {
      context.handle(
        _houseNumberMeta,
        houseNumber.isAcceptableOrUnknown(
          data['house_number']!,
          _houseNumberMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_houseNumberMeta);
    }
    if (data.containsKey('postal_code')) {
      context.handle(
        _postalCodeMeta,
        postalCode.isAcceptableOrUnknown(data['postal_code']!, _postalCodeMeta),
      );
    } else if (isInserting) {
      context.missing(_postalCodeMeta);
    }
    if (data.containsKey('city')) {
      context.handle(
        _cityMeta,
        city.isAcceptableOrUnknown(data['city']!, _cityMeta),
      );
    } else if (isInserting) {
      context.missing(_cityMeta);
    }
    if (data.containsKey('country')) {
      context.handle(
        _countryMeta,
        country.isAcceptableOrUnknown(data['country']!, _countryMeta),
      );
    } else if (isInserting) {
      context.missing(_countryMeta);
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
    if (data.containsKey('access_notes')) {
      context.handle(
        _accessNotesMeta,
        accessNotes.isAcceptableOrUnknown(
          data['access_notes']!,
          _accessNotesMeta,
        ),
      );
    }
    if (data.containsKey('safety_notes')) {
      context.handle(
        _safetyNotesMeta,
        safetyNotes.isAcceptableOrUnknown(
          data['safety_notes']!,
          _safetyNotesMeta,
        ),
      );
    }
    if (data.containsKey('object_notes')) {
      context.handle(
        _objectNotesMeta,
        objectNotes.isAcceptableOrUnknown(
          data['object_notes']!,
          _objectNotesMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CustomerObjectRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CustomerObjectRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      tenantId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tenant_id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}deleted_at'],
      ),
      version: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}version'],
      )!,
      syncStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sync_status'],
      )!,
      lastSyncedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_synced_at'],
      ),
      customerId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}customer_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      street: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}street'],
      )!,
      houseNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}house_number'],
      )!,
      postalCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}postal_code'],
      )!,
      city: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}city'],
      )!,
      country: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}country'],
      )!,
      latitude: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}latitude'],
      ),
      longitude: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}longitude'],
      ),
      accessNotes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}access_notes'],
      ),
      safetyNotes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}safety_notes'],
      ),
      objectNotes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}object_notes'],
      ),
    );
  }

  @override
  $CustomerObjectsTable createAlias(String alias) {
    return $CustomerObjectsTable(attachedDatabase, alias);
  }
}

class CustomerObjectRow extends DataClass
    implements Insertable<CustomerObjectRow> {
  final String id;
  final String tenantId;
  final String createdAt;
  final String updatedAt;
  final String? deletedAt;
  final int version;
  final String syncStatus;
  final String? lastSyncedAt;
  final String customerId;
  final String name;
  final String street;
  final String houseNumber;
  final String postalCode;
  final String city;
  final String country;
  final double? latitude;
  final double? longitude;
  final String? accessNotes;
  final String? safetyNotes;
  final String? objectNotes;
  const CustomerObjectRow({
    required this.id,
    required this.tenantId,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.version,
    required this.syncStatus,
    this.lastSyncedAt,
    required this.customerId,
    required this.name,
    required this.street,
    required this.houseNumber,
    required this.postalCode,
    required this.city,
    required this.country,
    this.latitude,
    this.longitude,
    this.accessNotes,
    this.safetyNotes,
    this.objectNotes,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['tenant_id'] = Variable<String>(tenantId);
    map['created_at'] = Variable<String>(createdAt);
    map['updated_at'] = Variable<String>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<String>(deletedAt);
    }
    map['version'] = Variable<int>(version);
    map['sync_status'] = Variable<String>(syncStatus);
    if (!nullToAbsent || lastSyncedAt != null) {
      map['last_synced_at'] = Variable<String>(lastSyncedAt);
    }
    map['customer_id'] = Variable<String>(customerId);
    map['name'] = Variable<String>(name);
    map['street'] = Variable<String>(street);
    map['house_number'] = Variable<String>(houseNumber);
    map['postal_code'] = Variable<String>(postalCode);
    map['city'] = Variable<String>(city);
    map['country'] = Variable<String>(country);
    if (!nullToAbsent || latitude != null) {
      map['latitude'] = Variable<double>(latitude);
    }
    if (!nullToAbsent || longitude != null) {
      map['longitude'] = Variable<double>(longitude);
    }
    if (!nullToAbsent || accessNotes != null) {
      map['access_notes'] = Variable<String>(accessNotes);
    }
    if (!nullToAbsent || safetyNotes != null) {
      map['safety_notes'] = Variable<String>(safetyNotes);
    }
    if (!nullToAbsent || objectNotes != null) {
      map['object_notes'] = Variable<String>(objectNotes);
    }
    return map;
  }

  CustomerObjectsCompanion toCompanion(bool nullToAbsent) {
    return CustomerObjectsCompanion(
      id: Value(id),
      tenantId: Value(tenantId),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      version: Value(version),
      syncStatus: Value(syncStatus),
      lastSyncedAt: lastSyncedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastSyncedAt),
      customerId: Value(customerId),
      name: Value(name),
      street: Value(street),
      houseNumber: Value(houseNumber),
      postalCode: Value(postalCode),
      city: Value(city),
      country: Value(country),
      latitude: latitude == null && nullToAbsent
          ? const Value.absent()
          : Value(latitude),
      longitude: longitude == null && nullToAbsent
          ? const Value.absent()
          : Value(longitude),
      accessNotes: accessNotes == null && nullToAbsent
          ? const Value.absent()
          : Value(accessNotes),
      safetyNotes: safetyNotes == null && nullToAbsent
          ? const Value.absent()
          : Value(safetyNotes),
      objectNotes: objectNotes == null && nullToAbsent
          ? const Value.absent()
          : Value(objectNotes),
    );
  }

  factory CustomerObjectRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CustomerObjectRow(
      id: serializer.fromJson<String>(json['id']),
      tenantId: serializer.fromJson<String>(json['tenantId']),
      createdAt: serializer.fromJson<String>(json['createdAt']),
      updatedAt: serializer.fromJson<String>(json['updatedAt']),
      deletedAt: serializer.fromJson<String?>(json['deletedAt']),
      version: serializer.fromJson<int>(json['version']),
      syncStatus: serializer.fromJson<String>(json['syncStatus']),
      lastSyncedAt: serializer.fromJson<String?>(json['lastSyncedAt']),
      customerId: serializer.fromJson<String>(json['customerId']),
      name: serializer.fromJson<String>(json['name']),
      street: serializer.fromJson<String>(json['street']),
      houseNumber: serializer.fromJson<String>(json['houseNumber']),
      postalCode: serializer.fromJson<String>(json['postalCode']),
      city: serializer.fromJson<String>(json['city']),
      country: serializer.fromJson<String>(json['country']),
      latitude: serializer.fromJson<double?>(json['latitude']),
      longitude: serializer.fromJson<double?>(json['longitude']),
      accessNotes: serializer.fromJson<String?>(json['accessNotes']),
      safetyNotes: serializer.fromJson<String?>(json['safetyNotes']),
      objectNotes: serializer.fromJson<String?>(json['objectNotes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'tenantId': serializer.toJson<String>(tenantId),
      'createdAt': serializer.toJson<String>(createdAt),
      'updatedAt': serializer.toJson<String>(updatedAt),
      'deletedAt': serializer.toJson<String?>(deletedAt),
      'version': serializer.toJson<int>(version),
      'syncStatus': serializer.toJson<String>(syncStatus),
      'lastSyncedAt': serializer.toJson<String?>(lastSyncedAt),
      'customerId': serializer.toJson<String>(customerId),
      'name': serializer.toJson<String>(name),
      'street': serializer.toJson<String>(street),
      'houseNumber': serializer.toJson<String>(houseNumber),
      'postalCode': serializer.toJson<String>(postalCode),
      'city': serializer.toJson<String>(city),
      'country': serializer.toJson<String>(country),
      'latitude': serializer.toJson<double?>(latitude),
      'longitude': serializer.toJson<double?>(longitude),
      'accessNotes': serializer.toJson<String?>(accessNotes),
      'safetyNotes': serializer.toJson<String?>(safetyNotes),
      'objectNotes': serializer.toJson<String?>(objectNotes),
    };
  }

  CustomerObjectRow copyWith({
    String? id,
    String? tenantId,
    String? createdAt,
    String? updatedAt,
    Value<String?> deletedAt = const Value.absent(),
    int? version,
    String? syncStatus,
    Value<String?> lastSyncedAt = const Value.absent(),
    String? customerId,
    String? name,
    String? street,
    String? houseNumber,
    String? postalCode,
    String? city,
    String? country,
    Value<double?> latitude = const Value.absent(),
    Value<double?> longitude = const Value.absent(),
    Value<String?> accessNotes = const Value.absent(),
    Value<String?> safetyNotes = const Value.absent(),
    Value<String?> objectNotes = const Value.absent(),
  }) => CustomerObjectRow(
    id: id ?? this.id,
    tenantId: tenantId ?? this.tenantId,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    version: version ?? this.version,
    syncStatus: syncStatus ?? this.syncStatus,
    lastSyncedAt: lastSyncedAt.present ? lastSyncedAt.value : this.lastSyncedAt,
    customerId: customerId ?? this.customerId,
    name: name ?? this.name,
    street: street ?? this.street,
    houseNumber: houseNumber ?? this.houseNumber,
    postalCode: postalCode ?? this.postalCode,
    city: city ?? this.city,
    country: country ?? this.country,
    latitude: latitude.present ? latitude.value : this.latitude,
    longitude: longitude.present ? longitude.value : this.longitude,
    accessNotes: accessNotes.present ? accessNotes.value : this.accessNotes,
    safetyNotes: safetyNotes.present ? safetyNotes.value : this.safetyNotes,
    objectNotes: objectNotes.present ? objectNotes.value : this.objectNotes,
  );
  CustomerObjectRow copyWithCompanion(CustomerObjectsCompanion data) {
    return CustomerObjectRow(
      id: data.id.present ? data.id.value : this.id,
      tenantId: data.tenantId.present ? data.tenantId.value : this.tenantId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      version: data.version.present ? data.version.value : this.version,
      syncStatus: data.syncStatus.present
          ? data.syncStatus.value
          : this.syncStatus,
      lastSyncedAt: data.lastSyncedAt.present
          ? data.lastSyncedAt.value
          : this.lastSyncedAt,
      customerId: data.customerId.present
          ? data.customerId.value
          : this.customerId,
      name: data.name.present ? data.name.value : this.name,
      street: data.street.present ? data.street.value : this.street,
      houseNumber: data.houseNumber.present
          ? data.houseNumber.value
          : this.houseNumber,
      postalCode: data.postalCode.present
          ? data.postalCode.value
          : this.postalCode,
      city: data.city.present ? data.city.value : this.city,
      country: data.country.present ? data.country.value : this.country,
      latitude: data.latitude.present ? data.latitude.value : this.latitude,
      longitude: data.longitude.present ? data.longitude.value : this.longitude,
      accessNotes: data.accessNotes.present
          ? data.accessNotes.value
          : this.accessNotes,
      safetyNotes: data.safetyNotes.present
          ? data.safetyNotes.value
          : this.safetyNotes,
      objectNotes: data.objectNotes.present
          ? data.objectNotes.value
          : this.objectNotes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CustomerObjectRow(')
          ..write('id: $id, ')
          ..write('tenantId: $tenantId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('version: $version, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('lastSyncedAt: $lastSyncedAt, ')
          ..write('customerId: $customerId, ')
          ..write('name: $name, ')
          ..write('street: $street, ')
          ..write('houseNumber: $houseNumber, ')
          ..write('postalCode: $postalCode, ')
          ..write('city: $city, ')
          ..write('country: $country, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('accessNotes: $accessNotes, ')
          ..write('safetyNotes: $safetyNotes, ')
          ..write('objectNotes: $objectNotes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    tenantId,
    createdAt,
    updatedAt,
    deletedAt,
    version,
    syncStatus,
    lastSyncedAt,
    customerId,
    name,
    street,
    houseNumber,
    postalCode,
    city,
    country,
    latitude,
    longitude,
    accessNotes,
    safetyNotes,
    objectNotes,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CustomerObjectRow &&
          other.id == this.id &&
          other.tenantId == this.tenantId &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.version == this.version &&
          other.syncStatus == this.syncStatus &&
          other.lastSyncedAt == this.lastSyncedAt &&
          other.customerId == this.customerId &&
          other.name == this.name &&
          other.street == this.street &&
          other.houseNumber == this.houseNumber &&
          other.postalCode == this.postalCode &&
          other.city == this.city &&
          other.country == this.country &&
          other.latitude == this.latitude &&
          other.longitude == this.longitude &&
          other.accessNotes == this.accessNotes &&
          other.safetyNotes == this.safetyNotes &&
          other.objectNotes == this.objectNotes);
}

class CustomerObjectsCompanion extends UpdateCompanion<CustomerObjectRow> {
  final Value<String> id;
  final Value<String> tenantId;
  final Value<String> createdAt;
  final Value<String> updatedAt;
  final Value<String?> deletedAt;
  final Value<int> version;
  final Value<String> syncStatus;
  final Value<String?> lastSyncedAt;
  final Value<String> customerId;
  final Value<String> name;
  final Value<String> street;
  final Value<String> houseNumber;
  final Value<String> postalCode;
  final Value<String> city;
  final Value<String> country;
  final Value<double?> latitude;
  final Value<double?> longitude;
  final Value<String?> accessNotes;
  final Value<String?> safetyNotes;
  final Value<String?> objectNotes;
  final Value<int> rowid;
  const CustomerObjectsCompanion({
    this.id = const Value.absent(),
    this.tenantId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.version = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.lastSyncedAt = const Value.absent(),
    this.customerId = const Value.absent(),
    this.name = const Value.absent(),
    this.street = const Value.absent(),
    this.houseNumber = const Value.absent(),
    this.postalCode = const Value.absent(),
    this.city = const Value.absent(),
    this.country = const Value.absent(),
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
    this.accessNotes = const Value.absent(),
    this.safetyNotes = const Value.absent(),
    this.objectNotes = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CustomerObjectsCompanion.insert({
    required String id,
    required String tenantId,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.version = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.lastSyncedAt = const Value.absent(),
    required String customerId,
    required String name,
    required String street,
    required String houseNumber,
    required String postalCode,
    required String city,
    required String country,
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
    this.accessNotes = const Value.absent(),
    this.safetyNotes = const Value.absent(),
    this.objectNotes = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       tenantId = Value(tenantId),
       customerId = Value(customerId),
       name = Value(name),
       street = Value(street),
       houseNumber = Value(houseNumber),
       postalCode = Value(postalCode),
       city = Value(city),
       country = Value(country);
  static Insertable<CustomerObjectRow> custom({
    Expression<String>? id,
    Expression<String>? tenantId,
    Expression<String>? createdAt,
    Expression<String>? updatedAt,
    Expression<String>? deletedAt,
    Expression<int>? version,
    Expression<String>? syncStatus,
    Expression<String>? lastSyncedAt,
    Expression<String>? customerId,
    Expression<String>? name,
    Expression<String>? street,
    Expression<String>? houseNumber,
    Expression<String>? postalCode,
    Expression<String>? city,
    Expression<String>? country,
    Expression<double>? latitude,
    Expression<double>? longitude,
    Expression<String>? accessNotes,
    Expression<String>? safetyNotes,
    Expression<String>? objectNotes,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (tenantId != null) 'tenant_id': tenantId,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (version != null) 'version': version,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (lastSyncedAt != null) 'last_synced_at': lastSyncedAt,
      if (customerId != null) 'customer_id': customerId,
      if (name != null) 'name': name,
      if (street != null) 'street': street,
      if (houseNumber != null) 'house_number': houseNumber,
      if (postalCode != null) 'postal_code': postalCode,
      if (city != null) 'city': city,
      if (country != null) 'country': country,
      if (latitude != null) 'latitude': latitude,
      if (longitude != null) 'longitude': longitude,
      if (accessNotes != null) 'access_notes': accessNotes,
      if (safetyNotes != null) 'safety_notes': safetyNotes,
      if (objectNotes != null) 'object_notes': objectNotes,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CustomerObjectsCompanion copyWith({
    Value<String>? id,
    Value<String>? tenantId,
    Value<String>? createdAt,
    Value<String>? updatedAt,
    Value<String?>? deletedAt,
    Value<int>? version,
    Value<String>? syncStatus,
    Value<String?>? lastSyncedAt,
    Value<String>? customerId,
    Value<String>? name,
    Value<String>? street,
    Value<String>? houseNumber,
    Value<String>? postalCode,
    Value<String>? city,
    Value<String>? country,
    Value<double?>? latitude,
    Value<double?>? longitude,
    Value<String?>? accessNotes,
    Value<String?>? safetyNotes,
    Value<String?>? objectNotes,
    Value<int>? rowid,
  }) {
    return CustomerObjectsCompanion(
      id: id ?? this.id,
      tenantId: tenantId ?? this.tenantId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      version: version ?? this.version,
      syncStatus: syncStatus ?? this.syncStatus,
      lastSyncedAt: lastSyncedAt ?? this.lastSyncedAt,
      customerId: customerId ?? this.customerId,
      name: name ?? this.name,
      street: street ?? this.street,
      houseNumber: houseNumber ?? this.houseNumber,
      postalCode: postalCode ?? this.postalCode,
      city: city ?? this.city,
      country: country ?? this.country,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      accessNotes: accessNotes ?? this.accessNotes,
      safetyNotes: safetyNotes ?? this.safetyNotes,
      objectNotes: objectNotes ?? this.objectNotes,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (tenantId.present) {
      map['tenant_id'] = Variable<String>(tenantId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<String>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<String>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<String>(deletedAt.value);
    }
    if (version.present) {
      map['version'] = Variable<int>(version.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(syncStatus.value);
    }
    if (lastSyncedAt.present) {
      map['last_synced_at'] = Variable<String>(lastSyncedAt.value);
    }
    if (customerId.present) {
      map['customer_id'] = Variable<String>(customerId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (street.present) {
      map['street'] = Variable<String>(street.value);
    }
    if (houseNumber.present) {
      map['house_number'] = Variable<String>(houseNumber.value);
    }
    if (postalCode.present) {
      map['postal_code'] = Variable<String>(postalCode.value);
    }
    if (city.present) {
      map['city'] = Variable<String>(city.value);
    }
    if (country.present) {
      map['country'] = Variable<String>(country.value);
    }
    if (latitude.present) {
      map['latitude'] = Variable<double>(latitude.value);
    }
    if (longitude.present) {
      map['longitude'] = Variable<double>(longitude.value);
    }
    if (accessNotes.present) {
      map['access_notes'] = Variable<String>(accessNotes.value);
    }
    if (safetyNotes.present) {
      map['safety_notes'] = Variable<String>(safetyNotes.value);
    }
    if (objectNotes.present) {
      map['object_notes'] = Variable<String>(objectNotes.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CustomerObjectsCompanion(')
          ..write('id: $id, ')
          ..write('tenantId: $tenantId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('version: $version, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('lastSyncedAt: $lastSyncedAt, ')
          ..write('customerId: $customerId, ')
          ..write('name: $name, ')
          ..write('street: $street, ')
          ..write('houseNumber: $houseNumber, ')
          ..write('postalCode: $postalCode, ')
          ..write('city: $city, ')
          ..write('country: $country, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('accessNotes: $accessNotes, ')
          ..write('safetyNotes: $safetyNotes, ')
          ..write('objectNotes: $objectNotes, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $InstallationsTable extends Installations
    with TableInfo<$InstallationsTable, InstallationRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $InstallationsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _tenantIdMeta = const VerificationMeta(
    'tenantId',
  );
  @override
  late final GeneratedColumn<String> tenantId = GeneratedColumn<String>(
    'tenant_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<String> createdAt = GeneratedColumn<String>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: _utcNowIso,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<String> updatedAt = GeneratedColumn<String>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: _utcNowIso,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<String> deletedAt = GeneratedColumn<String>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _versionMeta = const VerificationMeta(
    'version',
  );
  @override
  late final GeneratedColumn<int> version = GeneratedColumn<int>(
    'version',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
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
    defaultValue: const Constant('synced'),
  );
  static const VerificationMeta _lastSyncedAtMeta = const VerificationMeta(
    'lastSyncedAt',
  );
  @override
  late final GeneratedColumn<String> lastSyncedAt = GeneratedColumn<String>(
    'last_synced_at',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _objectIdMeta = const VerificationMeta(
    'objectId',
  );
  @override
  late final GeneratedColumn<String> objectId = GeneratedColumn<String>(
    'object_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _manufacturerMeta = const VerificationMeta(
    'manufacturer',
  );
  @override
  late final GeneratedColumn<String> manufacturer = GeneratedColumn<String>(
    'manufacturer',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _modelMeta = const VerificationMeta('model');
  @override
  late final GeneratedColumn<String> model = GeneratedColumn<String>(
    'model',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _serialNumberMeta = const VerificationMeta(
    'serialNumber',
  );
  @override
  late final GeneratedColumn<String> serialNumber = GeneratedColumn<String>(
    'serial_number',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _fuelTypeMeta = const VerificationMeta(
    'fuelType',
  );
  @override
  late final GeneratedColumn<String> fuelType = GeneratedColumn<String>(
    'fuel_type',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _installationYearMeta = const VerificationMeta(
    'installationYear',
  );
  @override
  late final GeneratedColumn<int> installationYear = GeneratedColumn<int>(
    'installation_year',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _locationDescriptionMeta =
      const VerificationMeta('locationDescription');
  @override
  late final GeneratedColumn<String> locationDescription =
      GeneratedColumn<String>(
        'location_description',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _intervalMonthsMeta = const VerificationMeta(
    'intervalMonths',
  );
  @override
  late final GeneratedColumn<int> intervalMonths = GeneratedColumn<int>(
    'interval_months',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lastServiceDateMeta = const VerificationMeta(
    'lastServiceDate',
  );
  @override
  late final GeneratedColumn<String> lastServiceDate = GeneratedColumn<String>(
    'last_service_date',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nextServiceDateMeta = const VerificationMeta(
    'nextServiceDate',
  );
  @override
  late final GeneratedColumn<String> nextServiceDate = GeneratedColumn<String>(
    'next_service_date',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    tenantId,
    createdAt,
    updatedAt,
    deletedAt,
    version,
    syncStatus,
    lastSyncedAt,
    objectId,
    type,
    manufacturer,
    model,
    serialNumber,
    fuelType,
    installationYear,
    locationDescription,
    intervalMonths,
    lastServiceDate,
    nextServiceDate,
    notes,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'installations';
  @override
  VerificationContext validateIntegrity(
    Insertable<InstallationRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('tenant_id')) {
      context.handle(
        _tenantIdMeta,
        tenantId.isAcceptableOrUnknown(data['tenant_id']!, _tenantIdMeta),
      );
    } else if (isInserting) {
      context.missing(_tenantIdMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('version')) {
      context.handle(
        _versionMeta,
        version.isAcceptableOrUnknown(data['version']!, _versionMeta),
      );
    }
    if (data.containsKey('sync_status')) {
      context.handle(
        _syncStatusMeta,
        syncStatus.isAcceptableOrUnknown(data['sync_status']!, _syncStatusMeta),
      );
    }
    if (data.containsKey('last_synced_at')) {
      context.handle(
        _lastSyncedAtMeta,
        lastSyncedAt.isAcceptableOrUnknown(
          data['last_synced_at']!,
          _lastSyncedAtMeta,
        ),
      );
    }
    if (data.containsKey('object_id')) {
      context.handle(
        _objectIdMeta,
        objectId.isAcceptableOrUnknown(data['object_id']!, _objectIdMeta),
      );
    } else if (isInserting) {
      context.missing(_objectIdMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('manufacturer')) {
      context.handle(
        _manufacturerMeta,
        manufacturer.isAcceptableOrUnknown(
          data['manufacturer']!,
          _manufacturerMeta,
        ),
      );
    }
    if (data.containsKey('model')) {
      context.handle(
        _modelMeta,
        model.isAcceptableOrUnknown(data['model']!, _modelMeta),
      );
    }
    if (data.containsKey('serial_number')) {
      context.handle(
        _serialNumberMeta,
        serialNumber.isAcceptableOrUnknown(
          data['serial_number']!,
          _serialNumberMeta,
        ),
      );
    }
    if (data.containsKey('fuel_type')) {
      context.handle(
        _fuelTypeMeta,
        fuelType.isAcceptableOrUnknown(data['fuel_type']!, _fuelTypeMeta),
      );
    }
    if (data.containsKey('installation_year')) {
      context.handle(
        _installationYearMeta,
        installationYear.isAcceptableOrUnknown(
          data['installation_year']!,
          _installationYearMeta,
        ),
      );
    }
    if (data.containsKey('location_description')) {
      context.handle(
        _locationDescriptionMeta,
        locationDescription.isAcceptableOrUnknown(
          data['location_description']!,
          _locationDescriptionMeta,
        ),
      );
    }
    if (data.containsKey('interval_months')) {
      context.handle(
        _intervalMonthsMeta,
        intervalMonths.isAcceptableOrUnknown(
          data['interval_months']!,
          _intervalMonthsMeta,
        ),
      );
    }
    if (data.containsKey('last_service_date')) {
      context.handle(
        _lastServiceDateMeta,
        lastServiceDate.isAcceptableOrUnknown(
          data['last_service_date']!,
          _lastServiceDateMeta,
        ),
      );
    }
    if (data.containsKey('next_service_date')) {
      context.handle(
        _nextServiceDateMeta,
        nextServiceDate.isAcceptableOrUnknown(
          data['next_service_date']!,
          _nextServiceDateMeta,
        ),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  InstallationRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return InstallationRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      tenantId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tenant_id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}deleted_at'],
      ),
      version: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}version'],
      )!,
      syncStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sync_status'],
      )!,
      lastSyncedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_synced_at'],
      ),
      objectId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}object_id'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      manufacturer: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}manufacturer'],
      ),
      model: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}model'],
      ),
      serialNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}serial_number'],
      ),
      fuelType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}fuel_type'],
      ),
      installationYear: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}installation_year'],
      ),
      locationDescription: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}location_description'],
      ),
      intervalMonths: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}interval_months'],
      ),
      lastServiceDate: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_service_date'],
      ),
      nextServiceDate: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}next_service_date'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
    );
  }

  @override
  $InstallationsTable createAlias(String alias) {
    return $InstallationsTable(attachedDatabase, alias);
  }
}

class InstallationRow extends DataClass implements Insertable<InstallationRow> {
  final String id;
  final String tenantId;
  final String createdAt;
  final String updatedAt;
  final String? deletedAt;
  final int version;
  final String syncStatus;
  final String? lastSyncedAt;
  final String objectId;
  final String type;
  final String? manufacturer;
  final String? model;
  final String? serialNumber;
  final String? fuelType;
  final int? installationYear;
  final String? locationDescription;
  final int? intervalMonths;
  final String? lastServiceDate;
  final String? nextServiceDate;
  final String? notes;
  const InstallationRow({
    required this.id,
    required this.tenantId,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.version,
    required this.syncStatus,
    this.lastSyncedAt,
    required this.objectId,
    required this.type,
    this.manufacturer,
    this.model,
    this.serialNumber,
    this.fuelType,
    this.installationYear,
    this.locationDescription,
    this.intervalMonths,
    this.lastServiceDate,
    this.nextServiceDate,
    this.notes,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['tenant_id'] = Variable<String>(tenantId);
    map['created_at'] = Variable<String>(createdAt);
    map['updated_at'] = Variable<String>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<String>(deletedAt);
    }
    map['version'] = Variable<int>(version);
    map['sync_status'] = Variable<String>(syncStatus);
    if (!nullToAbsent || lastSyncedAt != null) {
      map['last_synced_at'] = Variable<String>(lastSyncedAt);
    }
    map['object_id'] = Variable<String>(objectId);
    map['type'] = Variable<String>(type);
    if (!nullToAbsent || manufacturer != null) {
      map['manufacturer'] = Variable<String>(manufacturer);
    }
    if (!nullToAbsent || model != null) {
      map['model'] = Variable<String>(model);
    }
    if (!nullToAbsent || serialNumber != null) {
      map['serial_number'] = Variable<String>(serialNumber);
    }
    if (!nullToAbsent || fuelType != null) {
      map['fuel_type'] = Variable<String>(fuelType);
    }
    if (!nullToAbsent || installationYear != null) {
      map['installation_year'] = Variable<int>(installationYear);
    }
    if (!nullToAbsent || locationDescription != null) {
      map['location_description'] = Variable<String>(locationDescription);
    }
    if (!nullToAbsent || intervalMonths != null) {
      map['interval_months'] = Variable<int>(intervalMonths);
    }
    if (!nullToAbsent || lastServiceDate != null) {
      map['last_service_date'] = Variable<String>(lastServiceDate);
    }
    if (!nullToAbsent || nextServiceDate != null) {
      map['next_service_date'] = Variable<String>(nextServiceDate);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    return map;
  }

  InstallationsCompanion toCompanion(bool nullToAbsent) {
    return InstallationsCompanion(
      id: Value(id),
      tenantId: Value(tenantId),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      version: Value(version),
      syncStatus: Value(syncStatus),
      lastSyncedAt: lastSyncedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastSyncedAt),
      objectId: Value(objectId),
      type: Value(type),
      manufacturer: manufacturer == null && nullToAbsent
          ? const Value.absent()
          : Value(manufacturer),
      model: model == null && nullToAbsent
          ? const Value.absent()
          : Value(model),
      serialNumber: serialNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(serialNumber),
      fuelType: fuelType == null && nullToAbsent
          ? const Value.absent()
          : Value(fuelType),
      installationYear: installationYear == null && nullToAbsent
          ? const Value.absent()
          : Value(installationYear),
      locationDescription: locationDescription == null && nullToAbsent
          ? const Value.absent()
          : Value(locationDescription),
      intervalMonths: intervalMonths == null && nullToAbsent
          ? const Value.absent()
          : Value(intervalMonths),
      lastServiceDate: lastServiceDate == null && nullToAbsent
          ? const Value.absent()
          : Value(lastServiceDate),
      nextServiceDate: nextServiceDate == null && nullToAbsent
          ? const Value.absent()
          : Value(nextServiceDate),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
    );
  }

  factory InstallationRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return InstallationRow(
      id: serializer.fromJson<String>(json['id']),
      tenantId: serializer.fromJson<String>(json['tenantId']),
      createdAt: serializer.fromJson<String>(json['createdAt']),
      updatedAt: serializer.fromJson<String>(json['updatedAt']),
      deletedAt: serializer.fromJson<String?>(json['deletedAt']),
      version: serializer.fromJson<int>(json['version']),
      syncStatus: serializer.fromJson<String>(json['syncStatus']),
      lastSyncedAt: serializer.fromJson<String?>(json['lastSyncedAt']),
      objectId: serializer.fromJson<String>(json['objectId']),
      type: serializer.fromJson<String>(json['type']),
      manufacturer: serializer.fromJson<String?>(json['manufacturer']),
      model: serializer.fromJson<String?>(json['model']),
      serialNumber: serializer.fromJson<String?>(json['serialNumber']),
      fuelType: serializer.fromJson<String?>(json['fuelType']),
      installationYear: serializer.fromJson<int?>(json['installationYear']),
      locationDescription: serializer.fromJson<String?>(
        json['locationDescription'],
      ),
      intervalMonths: serializer.fromJson<int?>(json['intervalMonths']),
      lastServiceDate: serializer.fromJson<String?>(json['lastServiceDate']),
      nextServiceDate: serializer.fromJson<String?>(json['nextServiceDate']),
      notes: serializer.fromJson<String?>(json['notes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'tenantId': serializer.toJson<String>(tenantId),
      'createdAt': serializer.toJson<String>(createdAt),
      'updatedAt': serializer.toJson<String>(updatedAt),
      'deletedAt': serializer.toJson<String?>(deletedAt),
      'version': serializer.toJson<int>(version),
      'syncStatus': serializer.toJson<String>(syncStatus),
      'lastSyncedAt': serializer.toJson<String?>(lastSyncedAt),
      'objectId': serializer.toJson<String>(objectId),
      'type': serializer.toJson<String>(type),
      'manufacturer': serializer.toJson<String?>(manufacturer),
      'model': serializer.toJson<String?>(model),
      'serialNumber': serializer.toJson<String?>(serialNumber),
      'fuelType': serializer.toJson<String?>(fuelType),
      'installationYear': serializer.toJson<int?>(installationYear),
      'locationDescription': serializer.toJson<String?>(locationDescription),
      'intervalMonths': serializer.toJson<int?>(intervalMonths),
      'lastServiceDate': serializer.toJson<String?>(lastServiceDate),
      'nextServiceDate': serializer.toJson<String?>(nextServiceDate),
      'notes': serializer.toJson<String?>(notes),
    };
  }

  InstallationRow copyWith({
    String? id,
    String? tenantId,
    String? createdAt,
    String? updatedAt,
    Value<String?> deletedAt = const Value.absent(),
    int? version,
    String? syncStatus,
    Value<String?> lastSyncedAt = const Value.absent(),
    String? objectId,
    String? type,
    Value<String?> manufacturer = const Value.absent(),
    Value<String?> model = const Value.absent(),
    Value<String?> serialNumber = const Value.absent(),
    Value<String?> fuelType = const Value.absent(),
    Value<int?> installationYear = const Value.absent(),
    Value<String?> locationDescription = const Value.absent(),
    Value<int?> intervalMonths = const Value.absent(),
    Value<String?> lastServiceDate = const Value.absent(),
    Value<String?> nextServiceDate = const Value.absent(),
    Value<String?> notes = const Value.absent(),
  }) => InstallationRow(
    id: id ?? this.id,
    tenantId: tenantId ?? this.tenantId,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    version: version ?? this.version,
    syncStatus: syncStatus ?? this.syncStatus,
    lastSyncedAt: lastSyncedAt.present ? lastSyncedAt.value : this.lastSyncedAt,
    objectId: objectId ?? this.objectId,
    type: type ?? this.type,
    manufacturer: manufacturer.present ? manufacturer.value : this.manufacturer,
    model: model.present ? model.value : this.model,
    serialNumber: serialNumber.present ? serialNumber.value : this.serialNumber,
    fuelType: fuelType.present ? fuelType.value : this.fuelType,
    installationYear: installationYear.present
        ? installationYear.value
        : this.installationYear,
    locationDescription: locationDescription.present
        ? locationDescription.value
        : this.locationDescription,
    intervalMonths: intervalMonths.present
        ? intervalMonths.value
        : this.intervalMonths,
    lastServiceDate: lastServiceDate.present
        ? lastServiceDate.value
        : this.lastServiceDate,
    nextServiceDate: nextServiceDate.present
        ? nextServiceDate.value
        : this.nextServiceDate,
    notes: notes.present ? notes.value : this.notes,
  );
  InstallationRow copyWithCompanion(InstallationsCompanion data) {
    return InstallationRow(
      id: data.id.present ? data.id.value : this.id,
      tenantId: data.tenantId.present ? data.tenantId.value : this.tenantId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      version: data.version.present ? data.version.value : this.version,
      syncStatus: data.syncStatus.present
          ? data.syncStatus.value
          : this.syncStatus,
      lastSyncedAt: data.lastSyncedAt.present
          ? data.lastSyncedAt.value
          : this.lastSyncedAt,
      objectId: data.objectId.present ? data.objectId.value : this.objectId,
      type: data.type.present ? data.type.value : this.type,
      manufacturer: data.manufacturer.present
          ? data.manufacturer.value
          : this.manufacturer,
      model: data.model.present ? data.model.value : this.model,
      serialNumber: data.serialNumber.present
          ? data.serialNumber.value
          : this.serialNumber,
      fuelType: data.fuelType.present ? data.fuelType.value : this.fuelType,
      installationYear: data.installationYear.present
          ? data.installationYear.value
          : this.installationYear,
      locationDescription: data.locationDescription.present
          ? data.locationDescription.value
          : this.locationDescription,
      intervalMonths: data.intervalMonths.present
          ? data.intervalMonths.value
          : this.intervalMonths,
      lastServiceDate: data.lastServiceDate.present
          ? data.lastServiceDate.value
          : this.lastServiceDate,
      nextServiceDate: data.nextServiceDate.present
          ? data.nextServiceDate.value
          : this.nextServiceDate,
      notes: data.notes.present ? data.notes.value : this.notes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('InstallationRow(')
          ..write('id: $id, ')
          ..write('tenantId: $tenantId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('version: $version, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('lastSyncedAt: $lastSyncedAt, ')
          ..write('objectId: $objectId, ')
          ..write('type: $type, ')
          ..write('manufacturer: $manufacturer, ')
          ..write('model: $model, ')
          ..write('serialNumber: $serialNumber, ')
          ..write('fuelType: $fuelType, ')
          ..write('installationYear: $installationYear, ')
          ..write('locationDescription: $locationDescription, ')
          ..write('intervalMonths: $intervalMonths, ')
          ..write('lastServiceDate: $lastServiceDate, ')
          ..write('nextServiceDate: $nextServiceDate, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    tenantId,
    createdAt,
    updatedAt,
    deletedAt,
    version,
    syncStatus,
    lastSyncedAt,
    objectId,
    type,
    manufacturer,
    model,
    serialNumber,
    fuelType,
    installationYear,
    locationDescription,
    intervalMonths,
    lastServiceDate,
    nextServiceDate,
    notes,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is InstallationRow &&
          other.id == this.id &&
          other.tenantId == this.tenantId &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.version == this.version &&
          other.syncStatus == this.syncStatus &&
          other.lastSyncedAt == this.lastSyncedAt &&
          other.objectId == this.objectId &&
          other.type == this.type &&
          other.manufacturer == this.manufacturer &&
          other.model == this.model &&
          other.serialNumber == this.serialNumber &&
          other.fuelType == this.fuelType &&
          other.installationYear == this.installationYear &&
          other.locationDescription == this.locationDescription &&
          other.intervalMonths == this.intervalMonths &&
          other.lastServiceDate == this.lastServiceDate &&
          other.nextServiceDate == this.nextServiceDate &&
          other.notes == this.notes);
}

class InstallationsCompanion extends UpdateCompanion<InstallationRow> {
  final Value<String> id;
  final Value<String> tenantId;
  final Value<String> createdAt;
  final Value<String> updatedAt;
  final Value<String?> deletedAt;
  final Value<int> version;
  final Value<String> syncStatus;
  final Value<String?> lastSyncedAt;
  final Value<String> objectId;
  final Value<String> type;
  final Value<String?> manufacturer;
  final Value<String?> model;
  final Value<String?> serialNumber;
  final Value<String?> fuelType;
  final Value<int?> installationYear;
  final Value<String?> locationDescription;
  final Value<int?> intervalMonths;
  final Value<String?> lastServiceDate;
  final Value<String?> nextServiceDate;
  final Value<String?> notes;
  final Value<int> rowid;
  const InstallationsCompanion({
    this.id = const Value.absent(),
    this.tenantId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.version = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.lastSyncedAt = const Value.absent(),
    this.objectId = const Value.absent(),
    this.type = const Value.absent(),
    this.manufacturer = const Value.absent(),
    this.model = const Value.absent(),
    this.serialNumber = const Value.absent(),
    this.fuelType = const Value.absent(),
    this.installationYear = const Value.absent(),
    this.locationDescription = const Value.absent(),
    this.intervalMonths = const Value.absent(),
    this.lastServiceDate = const Value.absent(),
    this.nextServiceDate = const Value.absent(),
    this.notes = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  InstallationsCompanion.insert({
    required String id,
    required String tenantId,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.version = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.lastSyncedAt = const Value.absent(),
    required String objectId,
    required String type,
    this.manufacturer = const Value.absent(),
    this.model = const Value.absent(),
    this.serialNumber = const Value.absent(),
    this.fuelType = const Value.absent(),
    this.installationYear = const Value.absent(),
    this.locationDescription = const Value.absent(),
    this.intervalMonths = const Value.absent(),
    this.lastServiceDate = const Value.absent(),
    this.nextServiceDate = const Value.absent(),
    this.notes = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       tenantId = Value(tenantId),
       objectId = Value(objectId),
       type = Value(type);
  static Insertable<InstallationRow> custom({
    Expression<String>? id,
    Expression<String>? tenantId,
    Expression<String>? createdAt,
    Expression<String>? updatedAt,
    Expression<String>? deletedAt,
    Expression<int>? version,
    Expression<String>? syncStatus,
    Expression<String>? lastSyncedAt,
    Expression<String>? objectId,
    Expression<String>? type,
    Expression<String>? manufacturer,
    Expression<String>? model,
    Expression<String>? serialNumber,
    Expression<String>? fuelType,
    Expression<int>? installationYear,
    Expression<String>? locationDescription,
    Expression<int>? intervalMonths,
    Expression<String>? lastServiceDate,
    Expression<String>? nextServiceDate,
    Expression<String>? notes,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (tenantId != null) 'tenant_id': tenantId,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (version != null) 'version': version,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (lastSyncedAt != null) 'last_synced_at': lastSyncedAt,
      if (objectId != null) 'object_id': objectId,
      if (type != null) 'type': type,
      if (manufacturer != null) 'manufacturer': manufacturer,
      if (model != null) 'model': model,
      if (serialNumber != null) 'serial_number': serialNumber,
      if (fuelType != null) 'fuel_type': fuelType,
      if (installationYear != null) 'installation_year': installationYear,
      if (locationDescription != null)
        'location_description': locationDescription,
      if (intervalMonths != null) 'interval_months': intervalMonths,
      if (lastServiceDate != null) 'last_service_date': lastServiceDate,
      if (nextServiceDate != null) 'next_service_date': nextServiceDate,
      if (notes != null) 'notes': notes,
      if (rowid != null) 'rowid': rowid,
    });
  }

  InstallationsCompanion copyWith({
    Value<String>? id,
    Value<String>? tenantId,
    Value<String>? createdAt,
    Value<String>? updatedAt,
    Value<String?>? deletedAt,
    Value<int>? version,
    Value<String>? syncStatus,
    Value<String?>? lastSyncedAt,
    Value<String>? objectId,
    Value<String>? type,
    Value<String?>? manufacturer,
    Value<String?>? model,
    Value<String?>? serialNumber,
    Value<String?>? fuelType,
    Value<int?>? installationYear,
    Value<String?>? locationDescription,
    Value<int?>? intervalMonths,
    Value<String?>? lastServiceDate,
    Value<String?>? nextServiceDate,
    Value<String?>? notes,
    Value<int>? rowid,
  }) {
    return InstallationsCompanion(
      id: id ?? this.id,
      tenantId: tenantId ?? this.tenantId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      version: version ?? this.version,
      syncStatus: syncStatus ?? this.syncStatus,
      lastSyncedAt: lastSyncedAt ?? this.lastSyncedAt,
      objectId: objectId ?? this.objectId,
      type: type ?? this.type,
      manufacturer: manufacturer ?? this.manufacturer,
      model: model ?? this.model,
      serialNumber: serialNumber ?? this.serialNumber,
      fuelType: fuelType ?? this.fuelType,
      installationYear: installationYear ?? this.installationYear,
      locationDescription: locationDescription ?? this.locationDescription,
      intervalMonths: intervalMonths ?? this.intervalMonths,
      lastServiceDate: lastServiceDate ?? this.lastServiceDate,
      nextServiceDate: nextServiceDate ?? this.nextServiceDate,
      notes: notes ?? this.notes,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (tenantId.present) {
      map['tenant_id'] = Variable<String>(tenantId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<String>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<String>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<String>(deletedAt.value);
    }
    if (version.present) {
      map['version'] = Variable<int>(version.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(syncStatus.value);
    }
    if (lastSyncedAt.present) {
      map['last_synced_at'] = Variable<String>(lastSyncedAt.value);
    }
    if (objectId.present) {
      map['object_id'] = Variable<String>(objectId.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (manufacturer.present) {
      map['manufacturer'] = Variable<String>(manufacturer.value);
    }
    if (model.present) {
      map['model'] = Variable<String>(model.value);
    }
    if (serialNumber.present) {
      map['serial_number'] = Variable<String>(serialNumber.value);
    }
    if (fuelType.present) {
      map['fuel_type'] = Variable<String>(fuelType.value);
    }
    if (installationYear.present) {
      map['installation_year'] = Variable<int>(installationYear.value);
    }
    if (locationDescription.present) {
      map['location_description'] = Variable<String>(locationDescription.value);
    }
    if (intervalMonths.present) {
      map['interval_months'] = Variable<int>(intervalMonths.value);
    }
    if (lastServiceDate.present) {
      map['last_service_date'] = Variable<String>(lastServiceDate.value);
    }
    if (nextServiceDate.present) {
      map['next_service_date'] = Variable<String>(nextServiceDate.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('InstallationsCompanion(')
          ..write('id: $id, ')
          ..write('tenantId: $tenantId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('version: $version, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('lastSyncedAt: $lastSyncedAt, ')
          ..write('objectId: $objectId, ')
          ..write('type: $type, ')
          ..write('manufacturer: $manufacturer, ')
          ..write('model: $model, ')
          ..write('serialNumber: $serialNumber, ')
          ..write('fuelType: $fuelType, ')
          ..write('installationYear: $installationYear, ')
          ..write('locationDescription: $locationDescription, ')
          ..write('intervalMonths: $intervalMonths, ')
          ..write('lastServiceDate: $lastServiceDate, ')
          ..write('nextServiceDate: $nextServiceDate, ')
          ..write('notes: $notes, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $WorkOrdersTable extends WorkOrders
    with TableInfo<$WorkOrdersTable, WorkOrderRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WorkOrdersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _tenantIdMeta = const VerificationMeta(
    'tenantId',
  );
  @override
  late final GeneratedColumn<String> tenantId = GeneratedColumn<String>(
    'tenant_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<String> createdAt = GeneratedColumn<String>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: _utcNowIso,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<String> updatedAt = GeneratedColumn<String>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: _utcNowIso,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<String> deletedAt = GeneratedColumn<String>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _versionMeta = const VerificationMeta(
    'version',
  );
  @override
  late final GeneratedColumn<int> version = GeneratedColumn<int>(
    'version',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
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
    defaultValue: const Constant('synced'),
  );
  static const VerificationMeta _lastSyncedAtMeta = const VerificationMeta(
    'lastSyncedAt',
  );
  @override
  late final GeneratedColumn<String> lastSyncedAt = GeneratedColumn<String>(
    'last_synced_at',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _customerIdMeta = const VerificationMeta(
    'customerId',
  );
  @override
  late final GeneratedColumn<String> customerId = GeneratedColumn<String>(
    'customer_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _objectIdMeta = const VerificationMeta(
    'objectId',
  );
  @override
  late final GeneratedColumn<String> objectId = GeneratedColumn<String>(
    'object_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _assignedUserIdMeta = const VerificationMeta(
    'assignedUserId',
  );
  @override
  late final GeneratedColumn<String> assignedUserId = GeneratedColumn<String>(
    'assigned_user_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _orderNumberMeta = const VerificationMeta(
    'orderNumber',
  );
  @override
  late final GeneratedColumn<String> orderNumber = GeneratedColumn<String>(
    'order_number',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _priorityMeta = const VerificationMeta(
    'priority',
  );
  @override
  late final GeneratedColumn<String> priority = GeneratedColumn<String>(
    'priority',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _scheduledStartMeta = const VerificationMeta(
    'scheduledStart',
  );
  @override
  late final GeneratedColumn<String> scheduledStart = GeneratedColumn<String>(
    'scheduled_start',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _scheduledEndMeta = const VerificationMeta(
    'scheduledEnd',
  );
  @override
  late final GeneratedColumn<String> scheduledEnd = GeneratedColumn<String>(
    'scheduled_end',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _actualStartMeta = const VerificationMeta(
    'actualStart',
  );
  @override
  late final GeneratedColumn<String> actualStart = GeneratedColumn<String>(
    'actual_start',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _actualEndMeta = const VerificationMeta(
    'actualEnd',
  );
  @override
  late final GeneratedColumn<String> actualEnd = GeneratedColumn<String>(
    'actual_end',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _customerSignatureFileIdMeta =
      const VerificationMeta('customerSignatureFileId');
  @override
  late final GeneratedColumn<String> customerSignatureFileId =
      GeneratedColumn<String>(
        'customer_signature_file_id',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _reportFileIdMeta = const VerificationMeta(
    'reportFileId',
  );
  @override
  late final GeneratedColumn<String> reportFileId = GeneratedColumn<String>(
    'report_file_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _completionNotesMeta = const VerificationMeta(
    'completionNotes',
  );
  @override
  late final GeneratedColumn<String> completionNotes = GeneratedColumn<String>(
    'completion_notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    tenantId,
    createdAt,
    updatedAt,
    deletedAt,
    version,
    syncStatus,
    lastSyncedAt,
    customerId,
    objectId,
    assignedUserId,
    orderNumber,
    title,
    description,
    type,
    status,
    priority,
    scheduledStart,
    scheduledEnd,
    actualStart,
    actualEnd,
    customerSignatureFileId,
    reportFileId,
    completionNotes,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'work_orders';
  @override
  VerificationContext validateIntegrity(
    Insertable<WorkOrderRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('tenant_id')) {
      context.handle(
        _tenantIdMeta,
        tenantId.isAcceptableOrUnknown(data['tenant_id']!, _tenantIdMeta),
      );
    } else if (isInserting) {
      context.missing(_tenantIdMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('version')) {
      context.handle(
        _versionMeta,
        version.isAcceptableOrUnknown(data['version']!, _versionMeta),
      );
    }
    if (data.containsKey('sync_status')) {
      context.handle(
        _syncStatusMeta,
        syncStatus.isAcceptableOrUnknown(data['sync_status']!, _syncStatusMeta),
      );
    }
    if (data.containsKey('last_synced_at')) {
      context.handle(
        _lastSyncedAtMeta,
        lastSyncedAt.isAcceptableOrUnknown(
          data['last_synced_at']!,
          _lastSyncedAtMeta,
        ),
      );
    }
    if (data.containsKey('customer_id')) {
      context.handle(
        _customerIdMeta,
        customerId.isAcceptableOrUnknown(data['customer_id']!, _customerIdMeta),
      );
    } else if (isInserting) {
      context.missing(_customerIdMeta);
    }
    if (data.containsKey('object_id')) {
      context.handle(
        _objectIdMeta,
        objectId.isAcceptableOrUnknown(data['object_id']!, _objectIdMeta),
      );
    } else if (isInserting) {
      context.missing(_objectIdMeta);
    }
    if (data.containsKey('assigned_user_id')) {
      context.handle(
        _assignedUserIdMeta,
        assignedUserId.isAcceptableOrUnknown(
          data['assigned_user_id']!,
          _assignedUserIdMeta,
        ),
      );
    }
    if (data.containsKey('order_number')) {
      context.handle(
        _orderNumberMeta,
        orderNumber.isAcceptableOrUnknown(
          data['order_number']!,
          _orderNumberMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_orderNumberMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('priority')) {
      context.handle(
        _priorityMeta,
        priority.isAcceptableOrUnknown(data['priority']!, _priorityMeta),
      );
    } else if (isInserting) {
      context.missing(_priorityMeta);
    }
    if (data.containsKey('scheduled_start')) {
      context.handle(
        _scheduledStartMeta,
        scheduledStart.isAcceptableOrUnknown(
          data['scheduled_start']!,
          _scheduledStartMeta,
        ),
      );
    }
    if (data.containsKey('scheduled_end')) {
      context.handle(
        _scheduledEndMeta,
        scheduledEnd.isAcceptableOrUnknown(
          data['scheduled_end']!,
          _scheduledEndMeta,
        ),
      );
    }
    if (data.containsKey('actual_start')) {
      context.handle(
        _actualStartMeta,
        actualStart.isAcceptableOrUnknown(
          data['actual_start']!,
          _actualStartMeta,
        ),
      );
    }
    if (data.containsKey('actual_end')) {
      context.handle(
        _actualEndMeta,
        actualEnd.isAcceptableOrUnknown(data['actual_end']!, _actualEndMeta),
      );
    }
    if (data.containsKey('customer_signature_file_id')) {
      context.handle(
        _customerSignatureFileIdMeta,
        customerSignatureFileId.isAcceptableOrUnknown(
          data['customer_signature_file_id']!,
          _customerSignatureFileIdMeta,
        ),
      );
    }
    if (data.containsKey('report_file_id')) {
      context.handle(
        _reportFileIdMeta,
        reportFileId.isAcceptableOrUnknown(
          data['report_file_id']!,
          _reportFileIdMeta,
        ),
      );
    }
    if (data.containsKey('completion_notes')) {
      context.handle(
        _completionNotesMeta,
        completionNotes.isAcceptableOrUnknown(
          data['completion_notes']!,
          _completionNotesMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WorkOrderRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WorkOrderRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      tenantId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tenant_id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}deleted_at'],
      ),
      version: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}version'],
      )!,
      syncStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sync_status'],
      )!,
      lastSyncedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_synced_at'],
      ),
      customerId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}customer_id'],
      )!,
      objectId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}object_id'],
      )!,
      assignedUserId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}assigned_user_id'],
      ),
      orderNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}order_number'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      priority: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}priority'],
      )!,
      scheduledStart: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}scheduled_start'],
      ),
      scheduledEnd: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}scheduled_end'],
      ),
      actualStart: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}actual_start'],
      ),
      actualEnd: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}actual_end'],
      ),
      customerSignatureFileId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}customer_signature_file_id'],
      ),
      reportFileId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}report_file_id'],
      ),
      completionNotes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}completion_notes'],
      ),
    );
  }

  @override
  $WorkOrdersTable createAlias(String alias) {
    return $WorkOrdersTable(attachedDatabase, alias);
  }
}

class WorkOrderRow extends DataClass implements Insertable<WorkOrderRow> {
  final String id;
  final String tenantId;
  final String createdAt;
  final String updatedAt;
  final String? deletedAt;
  final int version;
  final String syncStatus;
  final String? lastSyncedAt;
  final String customerId;
  final String objectId;
  final String? assignedUserId;
  final String orderNumber;
  final String title;
  final String? description;
  final String type;
  final String status;
  final String priority;
  final String? scheduledStart;
  final String? scheduledEnd;
  final String? actualStart;
  final String? actualEnd;
  final String? customerSignatureFileId;
  final String? reportFileId;
  final String? completionNotes;
  const WorkOrderRow({
    required this.id,
    required this.tenantId,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.version,
    required this.syncStatus,
    this.lastSyncedAt,
    required this.customerId,
    required this.objectId,
    this.assignedUserId,
    required this.orderNumber,
    required this.title,
    this.description,
    required this.type,
    required this.status,
    required this.priority,
    this.scheduledStart,
    this.scheduledEnd,
    this.actualStart,
    this.actualEnd,
    this.customerSignatureFileId,
    this.reportFileId,
    this.completionNotes,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['tenant_id'] = Variable<String>(tenantId);
    map['created_at'] = Variable<String>(createdAt);
    map['updated_at'] = Variable<String>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<String>(deletedAt);
    }
    map['version'] = Variable<int>(version);
    map['sync_status'] = Variable<String>(syncStatus);
    if (!nullToAbsent || lastSyncedAt != null) {
      map['last_synced_at'] = Variable<String>(lastSyncedAt);
    }
    map['customer_id'] = Variable<String>(customerId);
    map['object_id'] = Variable<String>(objectId);
    if (!nullToAbsent || assignedUserId != null) {
      map['assigned_user_id'] = Variable<String>(assignedUserId);
    }
    map['order_number'] = Variable<String>(orderNumber);
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['type'] = Variable<String>(type);
    map['status'] = Variable<String>(status);
    map['priority'] = Variable<String>(priority);
    if (!nullToAbsent || scheduledStart != null) {
      map['scheduled_start'] = Variable<String>(scheduledStart);
    }
    if (!nullToAbsent || scheduledEnd != null) {
      map['scheduled_end'] = Variable<String>(scheduledEnd);
    }
    if (!nullToAbsent || actualStart != null) {
      map['actual_start'] = Variable<String>(actualStart);
    }
    if (!nullToAbsent || actualEnd != null) {
      map['actual_end'] = Variable<String>(actualEnd);
    }
    if (!nullToAbsent || customerSignatureFileId != null) {
      map['customer_signature_file_id'] = Variable<String>(
        customerSignatureFileId,
      );
    }
    if (!nullToAbsent || reportFileId != null) {
      map['report_file_id'] = Variable<String>(reportFileId);
    }
    if (!nullToAbsent || completionNotes != null) {
      map['completion_notes'] = Variable<String>(completionNotes);
    }
    return map;
  }

  WorkOrdersCompanion toCompanion(bool nullToAbsent) {
    return WorkOrdersCompanion(
      id: Value(id),
      tenantId: Value(tenantId),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      version: Value(version),
      syncStatus: Value(syncStatus),
      lastSyncedAt: lastSyncedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastSyncedAt),
      customerId: Value(customerId),
      objectId: Value(objectId),
      assignedUserId: assignedUserId == null && nullToAbsent
          ? const Value.absent()
          : Value(assignedUserId),
      orderNumber: Value(orderNumber),
      title: Value(title),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      type: Value(type),
      status: Value(status),
      priority: Value(priority),
      scheduledStart: scheduledStart == null && nullToAbsent
          ? const Value.absent()
          : Value(scheduledStart),
      scheduledEnd: scheduledEnd == null && nullToAbsent
          ? const Value.absent()
          : Value(scheduledEnd),
      actualStart: actualStart == null && nullToAbsent
          ? const Value.absent()
          : Value(actualStart),
      actualEnd: actualEnd == null && nullToAbsent
          ? const Value.absent()
          : Value(actualEnd),
      customerSignatureFileId: customerSignatureFileId == null && nullToAbsent
          ? const Value.absent()
          : Value(customerSignatureFileId),
      reportFileId: reportFileId == null && nullToAbsent
          ? const Value.absent()
          : Value(reportFileId),
      completionNotes: completionNotes == null && nullToAbsent
          ? const Value.absent()
          : Value(completionNotes),
    );
  }

  factory WorkOrderRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WorkOrderRow(
      id: serializer.fromJson<String>(json['id']),
      tenantId: serializer.fromJson<String>(json['tenantId']),
      createdAt: serializer.fromJson<String>(json['createdAt']),
      updatedAt: serializer.fromJson<String>(json['updatedAt']),
      deletedAt: serializer.fromJson<String?>(json['deletedAt']),
      version: serializer.fromJson<int>(json['version']),
      syncStatus: serializer.fromJson<String>(json['syncStatus']),
      lastSyncedAt: serializer.fromJson<String?>(json['lastSyncedAt']),
      customerId: serializer.fromJson<String>(json['customerId']),
      objectId: serializer.fromJson<String>(json['objectId']),
      assignedUserId: serializer.fromJson<String?>(json['assignedUserId']),
      orderNumber: serializer.fromJson<String>(json['orderNumber']),
      title: serializer.fromJson<String>(json['title']),
      description: serializer.fromJson<String?>(json['description']),
      type: serializer.fromJson<String>(json['type']),
      status: serializer.fromJson<String>(json['status']),
      priority: serializer.fromJson<String>(json['priority']),
      scheduledStart: serializer.fromJson<String?>(json['scheduledStart']),
      scheduledEnd: serializer.fromJson<String?>(json['scheduledEnd']),
      actualStart: serializer.fromJson<String?>(json['actualStart']),
      actualEnd: serializer.fromJson<String?>(json['actualEnd']),
      customerSignatureFileId: serializer.fromJson<String?>(
        json['customerSignatureFileId'],
      ),
      reportFileId: serializer.fromJson<String?>(json['reportFileId']),
      completionNotes: serializer.fromJson<String?>(json['completionNotes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'tenantId': serializer.toJson<String>(tenantId),
      'createdAt': serializer.toJson<String>(createdAt),
      'updatedAt': serializer.toJson<String>(updatedAt),
      'deletedAt': serializer.toJson<String?>(deletedAt),
      'version': serializer.toJson<int>(version),
      'syncStatus': serializer.toJson<String>(syncStatus),
      'lastSyncedAt': serializer.toJson<String?>(lastSyncedAt),
      'customerId': serializer.toJson<String>(customerId),
      'objectId': serializer.toJson<String>(objectId),
      'assignedUserId': serializer.toJson<String?>(assignedUserId),
      'orderNumber': serializer.toJson<String>(orderNumber),
      'title': serializer.toJson<String>(title),
      'description': serializer.toJson<String?>(description),
      'type': serializer.toJson<String>(type),
      'status': serializer.toJson<String>(status),
      'priority': serializer.toJson<String>(priority),
      'scheduledStart': serializer.toJson<String?>(scheduledStart),
      'scheduledEnd': serializer.toJson<String?>(scheduledEnd),
      'actualStart': serializer.toJson<String?>(actualStart),
      'actualEnd': serializer.toJson<String?>(actualEnd),
      'customerSignatureFileId': serializer.toJson<String?>(
        customerSignatureFileId,
      ),
      'reportFileId': serializer.toJson<String?>(reportFileId),
      'completionNotes': serializer.toJson<String?>(completionNotes),
    };
  }

  WorkOrderRow copyWith({
    String? id,
    String? tenantId,
    String? createdAt,
    String? updatedAt,
    Value<String?> deletedAt = const Value.absent(),
    int? version,
    String? syncStatus,
    Value<String?> lastSyncedAt = const Value.absent(),
    String? customerId,
    String? objectId,
    Value<String?> assignedUserId = const Value.absent(),
    String? orderNumber,
    String? title,
    Value<String?> description = const Value.absent(),
    String? type,
    String? status,
    String? priority,
    Value<String?> scheduledStart = const Value.absent(),
    Value<String?> scheduledEnd = const Value.absent(),
    Value<String?> actualStart = const Value.absent(),
    Value<String?> actualEnd = const Value.absent(),
    Value<String?> customerSignatureFileId = const Value.absent(),
    Value<String?> reportFileId = const Value.absent(),
    Value<String?> completionNotes = const Value.absent(),
  }) => WorkOrderRow(
    id: id ?? this.id,
    tenantId: tenantId ?? this.tenantId,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    version: version ?? this.version,
    syncStatus: syncStatus ?? this.syncStatus,
    lastSyncedAt: lastSyncedAt.present ? lastSyncedAt.value : this.lastSyncedAt,
    customerId: customerId ?? this.customerId,
    objectId: objectId ?? this.objectId,
    assignedUserId: assignedUserId.present
        ? assignedUserId.value
        : this.assignedUserId,
    orderNumber: orderNumber ?? this.orderNumber,
    title: title ?? this.title,
    description: description.present ? description.value : this.description,
    type: type ?? this.type,
    status: status ?? this.status,
    priority: priority ?? this.priority,
    scheduledStart: scheduledStart.present
        ? scheduledStart.value
        : this.scheduledStart,
    scheduledEnd: scheduledEnd.present ? scheduledEnd.value : this.scheduledEnd,
    actualStart: actualStart.present ? actualStart.value : this.actualStart,
    actualEnd: actualEnd.present ? actualEnd.value : this.actualEnd,
    customerSignatureFileId: customerSignatureFileId.present
        ? customerSignatureFileId.value
        : this.customerSignatureFileId,
    reportFileId: reportFileId.present ? reportFileId.value : this.reportFileId,
    completionNotes: completionNotes.present
        ? completionNotes.value
        : this.completionNotes,
  );
  WorkOrderRow copyWithCompanion(WorkOrdersCompanion data) {
    return WorkOrderRow(
      id: data.id.present ? data.id.value : this.id,
      tenantId: data.tenantId.present ? data.tenantId.value : this.tenantId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      version: data.version.present ? data.version.value : this.version,
      syncStatus: data.syncStatus.present
          ? data.syncStatus.value
          : this.syncStatus,
      lastSyncedAt: data.lastSyncedAt.present
          ? data.lastSyncedAt.value
          : this.lastSyncedAt,
      customerId: data.customerId.present
          ? data.customerId.value
          : this.customerId,
      objectId: data.objectId.present ? data.objectId.value : this.objectId,
      assignedUserId: data.assignedUserId.present
          ? data.assignedUserId.value
          : this.assignedUserId,
      orderNumber: data.orderNumber.present
          ? data.orderNumber.value
          : this.orderNumber,
      title: data.title.present ? data.title.value : this.title,
      description: data.description.present
          ? data.description.value
          : this.description,
      type: data.type.present ? data.type.value : this.type,
      status: data.status.present ? data.status.value : this.status,
      priority: data.priority.present ? data.priority.value : this.priority,
      scheduledStart: data.scheduledStart.present
          ? data.scheduledStart.value
          : this.scheduledStart,
      scheduledEnd: data.scheduledEnd.present
          ? data.scheduledEnd.value
          : this.scheduledEnd,
      actualStart: data.actualStart.present
          ? data.actualStart.value
          : this.actualStart,
      actualEnd: data.actualEnd.present ? data.actualEnd.value : this.actualEnd,
      customerSignatureFileId: data.customerSignatureFileId.present
          ? data.customerSignatureFileId.value
          : this.customerSignatureFileId,
      reportFileId: data.reportFileId.present
          ? data.reportFileId.value
          : this.reportFileId,
      completionNotes: data.completionNotes.present
          ? data.completionNotes.value
          : this.completionNotes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WorkOrderRow(')
          ..write('id: $id, ')
          ..write('tenantId: $tenantId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('version: $version, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('lastSyncedAt: $lastSyncedAt, ')
          ..write('customerId: $customerId, ')
          ..write('objectId: $objectId, ')
          ..write('assignedUserId: $assignedUserId, ')
          ..write('orderNumber: $orderNumber, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('type: $type, ')
          ..write('status: $status, ')
          ..write('priority: $priority, ')
          ..write('scheduledStart: $scheduledStart, ')
          ..write('scheduledEnd: $scheduledEnd, ')
          ..write('actualStart: $actualStart, ')
          ..write('actualEnd: $actualEnd, ')
          ..write('customerSignatureFileId: $customerSignatureFileId, ')
          ..write('reportFileId: $reportFileId, ')
          ..write('completionNotes: $completionNotes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
    id,
    tenantId,
    createdAt,
    updatedAt,
    deletedAt,
    version,
    syncStatus,
    lastSyncedAt,
    customerId,
    objectId,
    assignedUserId,
    orderNumber,
    title,
    description,
    type,
    status,
    priority,
    scheduledStart,
    scheduledEnd,
    actualStart,
    actualEnd,
    customerSignatureFileId,
    reportFileId,
    completionNotes,
  ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WorkOrderRow &&
          other.id == this.id &&
          other.tenantId == this.tenantId &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.version == this.version &&
          other.syncStatus == this.syncStatus &&
          other.lastSyncedAt == this.lastSyncedAt &&
          other.customerId == this.customerId &&
          other.objectId == this.objectId &&
          other.assignedUserId == this.assignedUserId &&
          other.orderNumber == this.orderNumber &&
          other.title == this.title &&
          other.description == this.description &&
          other.type == this.type &&
          other.status == this.status &&
          other.priority == this.priority &&
          other.scheduledStart == this.scheduledStart &&
          other.scheduledEnd == this.scheduledEnd &&
          other.actualStart == this.actualStart &&
          other.actualEnd == this.actualEnd &&
          other.customerSignatureFileId == this.customerSignatureFileId &&
          other.reportFileId == this.reportFileId &&
          other.completionNotes == this.completionNotes);
}

class WorkOrdersCompanion extends UpdateCompanion<WorkOrderRow> {
  final Value<String> id;
  final Value<String> tenantId;
  final Value<String> createdAt;
  final Value<String> updatedAt;
  final Value<String?> deletedAt;
  final Value<int> version;
  final Value<String> syncStatus;
  final Value<String?> lastSyncedAt;
  final Value<String> customerId;
  final Value<String> objectId;
  final Value<String?> assignedUserId;
  final Value<String> orderNumber;
  final Value<String> title;
  final Value<String?> description;
  final Value<String> type;
  final Value<String> status;
  final Value<String> priority;
  final Value<String?> scheduledStart;
  final Value<String?> scheduledEnd;
  final Value<String?> actualStart;
  final Value<String?> actualEnd;
  final Value<String?> customerSignatureFileId;
  final Value<String?> reportFileId;
  final Value<String?> completionNotes;
  final Value<int> rowid;
  const WorkOrdersCompanion({
    this.id = const Value.absent(),
    this.tenantId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.version = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.lastSyncedAt = const Value.absent(),
    this.customerId = const Value.absent(),
    this.objectId = const Value.absent(),
    this.assignedUserId = const Value.absent(),
    this.orderNumber = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    this.type = const Value.absent(),
    this.status = const Value.absent(),
    this.priority = const Value.absent(),
    this.scheduledStart = const Value.absent(),
    this.scheduledEnd = const Value.absent(),
    this.actualStart = const Value.absent(),
    this.actualEnd = const Value.absent(),
    this.customerSignatureFileId = const Value.absent(),
    this.reportFileId = const Value.absent(),
    this.completionNotes = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  WorkOrdersCompanion.insert({
    required String id,
    required String tenantId,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.version = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.lastSyncedAt = const Value.absent(),
    required String customerId,
    required String objectId,
    this.assignedUserId = const Value.absent(),
    required String orderNumber,
    required String title,
    this.description = const Value.absent(),
    required String type,
    required String status,
    required String priority,
    this.scheduledStart = const Value.absent(),
    this.scheduledEnd = const Value.absent(),
    this.actualStart = const Value.absent(),
    this.actualEnd = const Value.absent(),
    this.customerSignatureFileId = const Value.absent(),
    this.reportFileId = const Value.absent(),
    this.completionNotes = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       tenantId = Value(tenantId),
       customerId = Value(customerId),
       objectId = Value(objectId),
       orderNumber = Value(orderNumber),
       title = Value(title),
       type = Value(type),
       status = Value(status),
       priority = Value(priority);
  static Insertable<WorkOrderRow> custom({
    Expression<String>? id,
    Expression<String>? tenantId,
    Expression<String>? createdAt,
    Expression<String>? updatedAt,
    Expression<String>? deletedAt,
    Expression<int>? version,
    Expression<String>? syncStatus,
    Expression<String>? lastSyncedAt,
    Expression<String>? customerId,
    Expression<String>? objectId,
    Expression<String>? assignedUserId,
    Expression<String>? orderNumber,
    Expression<String>? title,
    Expression<String>? description,
    Expression<String>? type,
    Expression<String>? status,
    Expression<String>? priority,
    Expression<String>? scheduledStart,
    Expression<String>? scheduledEnd,
    Expression<String>? actualStart,
    Expression<String>? actualEnd,
    Expression<String>? customerSignatureFileId,
    Expression<String>? reportFileId,
    Expression<String>? completionNotes,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (tenantId != null) 'tenant_id': tenantId,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (version != null) 'version': version,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (lastSyncedAt != null) 'last_synced_at': lastSyncedAt,
      if (customerId != null) 'customer_id': customerId,
      if (objectId != null) 'object_id': objectId,
      if (assignedUserId != null) 'assigned_user_id': assignedUserId,
      if (orderNumber != null) 'order_number': orderNumber,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (type != null) 'type': type,
      if (status != null) 'status': status,
      if (priority != null) 'priority': priority,
      if (scheduledStart != null) 'scheduled_start': scheduledStart,
      if (scheduledEnd != null) 'scheduled_end': scheduledEnd,
      if (actualStart != null) 'actual_start': actualStart,
      if (actualEnd != null) 'actual_end': actualEnd,
      if (customerSignatureFileId != null)
        'customer_signature_file_id': customerSignatureFileId,
      if (reportFileId != null) 'report_file_id': reportFileId,
      if (completionNotes != null) 'completion_notes': completionNotes,
      if (rowid != null) 'rowid': rowid,
    });
  }

  WorkOrdersCompanion copyWith({
    Value<String>? id,
    Value<String>? tenantId,
    Value<String>? createdAt,
    Value<String>? updatedAt,
    Value<String?>? deletedAt,
    Value<int>? version,
    Value<String>? syncStatus,
    Value<String?>? lastSyncedAt,
    Value<String>? customerId,
    Value<String>? objectId,
    Value<String?>? assignedUserId,
    Value<String>? orderNumber,
    Value<String>? title,
    Value<String?>? description,
    Value<String>? type,
    Value<String>? status,
    Value<String>? priority,
    Value<String?>? scheduledStart,
    Value<String?>? scheduledEnd,
    Value<String?>? actualStart,
    Value<String?>? actualEnd,
    Value<String?>? customerSignatureFileId,
    Value<String?>? reportFileId,
    Value<String?>? completionNotes,
    Value<int>? rowid,
  }) {
    return WorkOrdersCompanion(
      id: id ?? this.id,
      tenantId: tenantId ?? this.tenantId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      version: version ?? this.version,
      syncStatus: syncStatus ?? this.syncStatus,
      lastSyncedAt: lastSyncedAt ?? this.lastSyncedAt,
      customerId: customerId ?? this.customerId,
      objectId: objectId ?? this.objectId,
      assignedUserId: assignedUserId ?? this.assignedUserId,
      orderNumber: orderNumber ?? this.orderNumber,
      title: title ?? this.title,
      description: description ?? this.description,
      type: type ?? this.type,
      status: status ?? this.status,
      priority: priority ?? this.priority,
      scheduledStart: scheduledStart ?? this.scheduledStart,
      scheduledEnd: scheduledEnd ?? this.scheduledEnd,
      actualStart: actualStart ?? this.actualStart,
      actualEnd: actualEnd ?? this.actualEnd,
      customerSignatureFileId:
          customerSignatureFileId ?? this.customerSignatureFileId,
      reportFileId: reportFileId ?? this.reportFileId,
      completionNotes: completionNotes ?? this.completionNotes,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (tenantId.present) {
      map['tenant_id'] = Variable<String>(tenantId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<String>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<String>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<String>(deletedAt.value);
    }
    if (version.present) {
      map['version'] = Variable<int>(version.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(syncStatus.value);
    }
    if (lastSyncedAt.present) {
      map['last_synced_at'] = Variable<String>(lastSyncedAt.value);
    }
    if (customerId.present) {
      map['customer_id'] = Variable<String>(customerId.value);
    }
    if (objectId.present) {
      map['object_id'] = Variable<String>(objectId.value);
    }
    if (assignedUserId.present) {
      map['assigned_user_id'] = Variable<String>(assignedUserId.value);
    }
    if (orderNumber.present) {
      map['order_number'] = Variable<String>(orderNumber.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (priority.present) {
      map['priority'] = Variable<String>(priority.value);
    }
    if (scheduledStart.present) {
      map['scheduled_start'] = Variable<String>(scheduledStart.value);
    }
    if (scheduledEnd.present) {
      map['scheduled_end'] = Variable<String>(scheduledEnd.value);
    }
    if (actualStart.present) {
      map['actual_start'] = Variable<String>(actualStart.value);
    }
    if (actualEnd.present) {
      map['actual_end'] = Variable<String>(actualEnd.value);
    }
    if (customerSignatureFileId.present) {
      map['customer_signature_file_id'] = Variable<String>(
        customerSignatureFileId.value,
      );
    }
    if (reportFileId.present) {
      map['report_file_id'] = Variable<String>(reportFileId.value);
    }
    if (completionNotes.present) {
      map['completion_notes'] = Variable<String>(completionNotes.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WorkOrdersCompanion(')
          ..write('id: $id, ')
          ..write('tenantId: $tenantId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('version: $version, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('lastSyncedAt: $lastSyncedAt, ')
          ..write('customerId: $customerId, ')
          ..write('objectId: $objectId, ')
          ..write('assignedUserId: $assignedUserId, ')
          ..write('orderNumber: $orderNumber, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('type: $type, ')
          ..write('status: $status, ')
          ..write('priority: $priority, ')
          ..write('scheduledStart: $scheduledStart, ')
          ..write('scheduledEnd: $scheduledEnd, ')
          ..write('actualStart: $actualStart, ')
          ..write('actualEnd: $actualEnd, ')
          ..write('customerSignatureFileId: $customerSignatureFileId, ')
          ..write('reportFileId: $reportFileId, ')
          ..write('completionNotes: $completionNotes, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $WorkOrderInstallationsTable extends WorkOrderInstallations
    with TableInfo<$WorkOrderInstallationsTable, WorkOrderInstallationRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WorkOrderInstallationsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _tenantIdMeta = const VerificationMeta(
    'tenantId',
  );
  @override
  late final GeneratedColumn<String> tenantId = GeneratedColumn<String>(
    'tenant_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<String> createdAt = GeneratedColumn<String>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: _utcNowIso,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<String> updatedAt = GeneratedColumn<String>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: _utcNowIso,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<String> deletedAt = GeneratedColumn<String>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _versionMeta = const VerificationMeta(
    'version',
  );
  @override
  late final GeneratedColumn<int> version = GeneratedColumn<int>(
    'version',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
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
    defaultValue: const Constant('synced'),
  );
  static const VerificationMeta _lastSyncedAtMeta = const VerificationMeta(
    'lastSyncedAt',
  );
  @override
  late final GeneratedColumn<String> lastSyncedAt = GeneratedColumn<String>(
    'last_synced_at',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _workOrderIdMeta = const VerificationMeta(
    'workOrderId',
  );
  @override
  late final GeneratedColumn<String> workOrderId = GeneratedColumn<String>(
    'work_order_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _installationIdMeta = const VerificationMeta(
    'installationId',
  );
  @override
  late final GeneratedColumn<String> installationId = GeneratedColumn<String>(
    'installation_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    tenantId,
    createdAt,
    updatedAt,
    deletedAt,
    version,
    syncStatus,
    lastSyncedAt,
    workOrderId,
    installationId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'work_order_installations';
  @override
  VerificationContext validateIntegrity(
    Insertable<WorkOrderInstallationRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('tenant_id')) {
      context.handle(
        _tenantIdMeta,
        tenantId.isAcceptableOrUnknown(data['tenant_id']!, _tenantIdMeta),
      );
    } else if (isInserting) {
      context.missing(_tenantIdMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('version')) {
      context.handle(
        _versionMeta,
        version.isAcceptableOrUnknown(data['version']!, _versionMeta),
      );
    }
    if (data.containsKey('sync_status')) {
      context.handle(
        _syncStatusMeta,
        syncStatus.isAcceptableOrUnknown(data['sync_status']!, _syncStatusMeta),
      );
    }
    if (data.containsKey('last_synced_at')) {
      context.handle(
        _lastSyncedAtMeta,
        lastSyncedAt.isAcceptableOrUnknown(
          data['last_synced_at']!,
          _lastSyncedAtMeta,
        ),
      );
    }
    if (data.containsKey('work_order_id')) {
      context.handle(
        _workOrderIdMeta,
        workOrderId.isAcceptableOrUnknown(
          data['work_order_id']!,
          _workOrderIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_workOrderIdMeta);
    }
    if (data.containsKey('installation_id')) {
      context.handle(
        _installationIdMeta,
        installationId.isAcceptableOrUnknown(
          data['installation_id']!,
          _installationIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_installationIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WorkOrderInstallationRow map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WorkOrderInstallationRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      tenantId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tenant_id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}deleted_at'],
      ),
      version: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}version'],
      )!,
      syncStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sync_status'],
      )!,
      lastSyncedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_synced_at'],
      ),
      workOrderId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}work_order_id'],
      )!,
      installationId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}installation_id'],
      )!,
    );
  }

  @override
  $WorkOrderInstallationsTable createAlias(String alias) {
    return $WorkOrderInstallationsTable(attachedDatabase, alias);
  }
}

class WorkOrderInstallationRow extends DataClass
    implements Insertable<WorkOrderInstallationRow> {
  final String id;
  final String tenantId;
  final String createdAt;
  final String updatedAt;
  final String? deletedAt;
  final int version;
  final String syncStatus;
  final String? lastSyncedAt;
  final String workOrderId;
  final String installationId;
  const WorkOrderInstallationRow({
    required this.id,
    required this.tenantId,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.version,
    required this.syncStatus,
    this.lastSyncedAt,
    required this.workOrderId,
    required this.installationId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['tenant_id'] = Variable<String>(tenantId);
    map['created_at'] = Variable<String>(createdAt);
    map['updated_at'] = Variable<String>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<String>(deletedAt);
    }
    map['version'] = Variable<int>(version);
    map['sync_status'] = Variable<String>(syncStatus);
    if (!nullToAbsent || lastSyncedAt != null) {
      map['last_synced_at'] = Variable<String>(lastSyncedAt);
    }
    map['work_order_id'] = Variable<String>(workOrderId);
    map['installation_id'] = Variable<String>(installationId);
    return map;
  }

  WorkOrderInstallationsCompanion toCompanion(bool nullToAbsent) {
    return WorkOrderInstallationsCompanion(
      id: Value(id),
      tenantId: Value(tenantId),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      version: Value(version),
      syncStatus: Value(syncStatus),
      lastSyncedAt: lastSyncedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastSyncedAt),
      workOrderId: Value(workOrderId),
      installationId: Value(installationId),
    );
  }

  factory WorkOrderInstallationRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WorkOrderInstallationRow(
      id: serializer.fromJson<String>(json['id']),
      tenantId: serializer.fromJson<String>(json['tenantId']),
      createdAt: serializer.fromJson<String>(json['createdAt']),
      updatedAt: serializer.fromJson<String>(json['updatedAt']),
      deletedAt: serializer.fromJson<String?>(json['deletedAt']),
      version: serializer.fromJson<int>(json['version']),
      syncStatus: serializer.fromJson<String>(json['syncStatus']),
      lastSyncedAt: serializer.fromJson<String?>(json['lastSyncedAt']),
      workOrderId: serializer.fromJson<String>(json['workOrderId']),
      installationId: serializer.fromJson<String>(json['installationId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'tenantId': serializer.toJson<String>(tenantId),
      'createdAt': serializer.toJson<String>(createdAt),
      'updatedAt': serializer.toJson<String>(updatedAt),
      'deletedAt': serializer.toJson<String?>(deletedAt),
      'version': serializer.toJson<int>(version),
      'syncStatus': serializer.toJson<String>(syncStatus),
      'lastSyncedAt': serializer.toJson<String?>(lastSyncedAt),
      'workOrderId': serializer.toJson<String>(workOrderId),
      'installationId': serializer.toJson<String>(installationId),
    };
  }

  WorkOrderInstallationRow copyWith({
    String? id,
    String? tenantId,
    String? createdAt,
    String? updatedAt,
    Value<String?> deletedAt = const Value.absent(),
    int? version,
    String? syncStatus,
    Value<String?> lastSyncedAt = const Value.absent(),
    String? workOrderId,
    String? installationId,
  }) => WorkOrderInstallationRow(
    id: id ?? this.id,
    tenantId: tenantId ?? this.tenantId,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    version: version ?? this.version,
    syncStatus: syncStatus ?? this.syncStatus,
    lastSyncedAt: lastSyncedAt.present ? lastSyncedAt.value : this.lastSyncedAt,
    workOrderId: workOrderId ?? this.workOrderId,
    installationId: installationId ?? this.installationId,
  );
  WorkOrderInstallationRow copyWithCompanion(
    WorkOrderInstallationsCompanion data,
  ) {
    return WorkOrderInstallationRow(
      id: data.id.present ? data.id.value : this.id,
      tenantId: data.tenantId.present ? data.tenantId.value : this.tenantId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      version: data.version.present ? data.version.value : this.version,
      syncStatus: data.syncStatus.present
          ? data.syncStatus.value
          : this.syncStatus,
      lastSyncedAt: data.lastSyncedAt.present
          ? data.lastSyncedAt.value
          : this.lastSyncedAt,
      workOrderId: data.workOrderId.present
          ? data.workOrderId.value
          : this.workOrderId,
      installationId: data.installationId.present
          ? data.installationId.value
          : this.installationId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WorkOrderInstallationRow(')
          ..write('id: $id, ')
          ..write('tenantId: $tenantId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('version: $version, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('lastSyncedAt: $lastSyncedAt, ')
          ..write('workOrderId: $workOrderId, ')
          ..write('installationId: $installationId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    tenantId,
    createdAt,
    updatedAt,
    deletedAt,
    version,
    syncStatus,
    lastSyncedAt,
    workOrderId,
    installationId,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WorkOrderInstallationRow &&
          other.id == this.id &&
          other.tenantId == this.tenantId &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.version == this.version &&
          other.syncStatus == this.syncStatus &&
          other.lastSyncedAt == this.lastSyncedAt &&
          other.workOrderId == this.workOrderId &&
          other.installationId == this.installationId);
}

class WorkOrderInstallationsCompanion
    extends UpdateCompanion<WorkOrderInstallationRow> {
  final Value<String> id;
  final Value<String> tenantId;
  final Value<String> createdAt;
  final Value<String> updatedAt;
  final Value<String?> deletedAt;
  final Value<int> version;
  final Value<String> syncStatus;
  final Value<String?> lastSyncedAt;
  final Value<String> workOrderId;
  final Value<String> installationId;
  final Value<int> rowid;
  const WorkOrderInstallationsCompanion({
    this.id = const Value.absent(),
    this.tenantId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.version = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.lastSyncedAt = const Value.absent(),
    this.workOrderId = const Value.absent(),
    this.installationId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  WorkOrderInstallationsCompanion.insert({
    required String id,
    required String tenantId,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.version = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.lastSyncedAt = const Value.absent(),
    required String workOrderId,
    required String installationId,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       tenantId = Value(tenantId),
       workOrderId = Value(workOrderId),
       installationId = Value(installationId);
  static Insertable<WorkOrderInstallationRow> custom({
    Expression<String>? id,
    Expression<String>? tenantId,
    Expression<String>? createdAt,
    Expression<String>? updatedAt,
    Expression<String>? deletedAt,
    Expression<int>? version,
    Expression<String>? syncStatus,
    Expression<String>? lastSyncedAt,
    Expression<String>? workOrderId,
    Expression<String>? installationId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (tenantId != null) 'tenant_id': tenantId,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (version != null) 'version': version,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (lastSyncedAt != null) 'last_synced_at': lastSyncedAt,
      if (workOrderId != null) 'work_order_id': workOrderId,
      if (installationId != null) 'installation_id': installationId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  WorkOrderInstallationsCompanion copyWith({
    Value<String>? id,
    Value<String>? tenantId,
    Value<String>? createdAt,
    Value<String>? updatedAt,
    Value<String?>? deletedAt,
    Value<int>? version,
    Value<String>? syncStatus,
    Value<String?>? lastSyncedAt,
    Value<String>? workOrderId,
    Value<String>? installationId,
    Value<int>? rowid,
  }) {
    return WorkOrderInstallationsCompanion(
      id: id ?? this.id,
      tenantId: tenantId ?? this.tenantId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      version: version ?? this.version,
      syncStatus: syncStatus ?? this.syncStatus,
      lastSyncedAt: lastSyncedAt ?? this.lastSyncedAt,
      workOrderId: workOrderId ?? this.workOrderId,
      installationId: installationId ?? this.installationId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (tenantId.present) {
      map['tenant_id'] = Variable<String>(tenantId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<String>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<String>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<String>(deletedAt.value);
    }
    if (version.present) {
      map['version'] = Variable<int>(version.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(syncStatus.value);
    }
    if (lastSyncedAt.present) {
      map['last_synced_at'] = Variable<String>(lastSyncedAt.value);
    }
    if (workOrderId.present) {
      map['work_order_id'] = Variable<String>(workOrderId.value);
    }
    if (installationId.present) {
      map['installation_id'] = Variable<String>(installationId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WorkOrderInstallationsCompanion(')
          ..write('id: $id, ')
          ..write('tenantId: $tenantId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('version: $version, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('lastSyncedAt: $lastSyncedAt, ')
          ..write('workOrderId: $workOrderId, ')
          ..write('installationId: $installationId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ChecklistTemplatesTable extends ChecklistTemplates
    with TableInfo<$ChecklistTemplatesTable, ChecklistTemplateRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ChecklistTemplatesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _tenantIdMeta = const VerificationMeta(
    'tenantId',
  );
  @override
  late final GeneratedColumn<String> tenantId = GeneratedColumn<String>(
    'tenant_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<String> createdAt = GeneratedColumn<String>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: _utcNowIso,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<String> updatedAt = GeneratedColumn<String>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: _utcNowIso,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<String> deletedAt = GeneratedColumn<String>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _versionMeta = const VerificationMeta(
    'version',
  );
  @override
  late final GeneratedColumn<int> version = GeneratedColumn<int>(
    'version',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
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
    defaultValue: const Constant('synced'),
  );
  static const VerificationMeta _lastSyncedAtMeta = const VerificationMeta(
    'lastSyncedAt',
  );
  @override
  late final GeneratedColumn<String> lastSyncedAt = GeneratedColumn<String>(
    'last_synced_at',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _versionNumberMeta = const VerificationMeta(
    'versionNumber',
  );
  @override
  late final GeneratedColumn<int> versionNumber = GeneratedColumn<int>(
    'version_number',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    tenantId,
    createdAt,
    updatedAt,
    deletedAt,
    version,
    syncStatus,
    lastSyncedAt,
    name,
    type,
    versionNumber,
    isActive,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'checklist_templates';
  @override
  VerificationContext validateIntegrity(
    Insertable<ChecklistTemplateRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('tenant_id')) {
      context.handle(
        _tenantIdMeta,
        tenantId.isAcceptableOrUnknown(data['tenant_id']!, _tenantIdMeta),
      );
    } else if (isInserting) {
      context.missing(_tenantIdMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('version')) {
      context.handle(
        _versionMeta,
        version.isAcceptableOrUnknown(data['version']!, _versionMeta),
      );
    }
    if (data.containsKey('sync_status')) {
      context.handle(
        _syncStatusMeta,
        syncStatus.isAcceptableOrUnknown(data['sync_status']!, _syncStatusMeta),
      );
    }
    if (data.containsKey('last_synced_at')) {
      context.handle(
        _lastSyncedAtMeta,
        lastSyncedAt.isAcceptableOrUnknown(
          data['last_synced_at']!,
          _lastSyncedAtMeta,
        ),
      );
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('version_number')) {
      context.handle(
        _versionNumberMeta,
        versionNumber.isAcceptableOrUnknown(
          data['version_number']!,
          _versionNumberMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_versionNumberMeta);
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ChecklistTemplateRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ChecklistTemplateRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      tenantId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tenant_id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}deleted_at'],
      ),
      version: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}version'],
      )!,
      syncStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sync_status'],
      )!,
      lastSyncedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_synced_at'],
      ),
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      versionNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}version_number'],
      )!,
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
    );
  }

  @override
  $ChecklistTemplatesTable createAlias(String alias) {
    return $ChecklistTemplatesTable(attachedDatabase, alias);
  }
}

class ChecklistTemplateRow extends DataClass
    implements Insertable<ChecklistTemplateRow> {
  final String id;
  final String tenantId;
  final String createdAt;
  final String updatedAt;
  final String? deletedAt;
  final int version;
  final String syncStatus;
  final String? lastSyncedAt;
  final String name;
  final String type;
  final int versionNumber;
  final bool isActive;
  const ChecklistTemplateRow({
    required this.id,
    required this.tenantId,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.version,
    required this.syncStatus,
    this.lastSyncedAt,
    required this.name,
    required this.type,
    required this.versionNumber,
    required this.isActive,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['tenant_id'] = Variable<String>(tenantId);
    map['created_at'] = Variable<String>(createdAt);
    map['updated_at'] = Variable<String>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<String>(deletedAt);
    }
    map['version'] = Variable<int>(version);
    map['sync_status'] = Variable<String>(syncStatus);
    if (!nullToAbsent || lastSyncedAt != null) {
      map['last_synced_at'] = Variable<String>(lastSyncedAt);
    }
    map['name'] = Variable<String>(name);
    map['type'] = Variable<String>(type);
    map['version_number'] = Variable<int>(versionNumber);
    map['is_active'] = Variable<bool>(isActive);
    return map;
  }

  ChecklistTemplatesCompanion toCompanion(bool nullToAbsent) {
    return ChecklistTemplatesCompanion(
      id: Value(id),
      tenantId: Value(tenantId),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      version: Value(version),
      syncStatus: Value(syncStatus),
      lastSyncedAt: lastSyncedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastSyncedAt),
      name: Value(name),
      type: Value(type),
      versionNumber: Value(versionNumber),
      isActive: Value(isActive),
    );
  }

  factory ChecklistTemplateRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ChecklistTemplateRow(
      id: serializer.fromJson<String>(json['id']),
      tenantId: serializer.fromJson<String>(json['tenantId']),
      createdAt: serializer.fromJson<String>(json['createdAt']),
      updatedAt: serializer.fromJson<String>(json['updatedAt']),
      deletedAt: serializer.fromJson<String?>(json['deletedAt']),
      version: serializer.fromJson<int>(json['version']),
      syncStatus: serializer.fromJson<String>(json['syncStatus']),
      lastSyncedAt: serializer.fromJson<String?>(json['lastSyncedAt']),
      name: serializer.fromJson<String>(json['name']),
      type: serializer.fromJson<String>(json['type']),
      versionNumber: serializer.fromJson<int>(json['versionNumber']),
      isActive: serializer.fromJson<bool>(json['isActive']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'tenantId': serializer.toJson<String>(tenantId),
      'createdAt': serializer.toJson<String>(createdAt),
      'updatedAt': serializer.toJson<String>(updatedAt),
      'deletedAt': serializer.toJson<String?>(deletedAt),
      'version': serializer.toJson<int>(version),
      'syncStatus': serializer.toJson<String>(syncStatus),
      'lastSyncedAt': serializer.toJson<String?>(lastSyncedAt),
      'name': serializer.toJson<String>(name),
      'type': serializer.toJson<String>(type),
      'versionNumber': serializer.toJson<int>(versionNumber),
      'isActive': serializer.toJson<bool>(isActive),
    };
  }

  ChecklistTemplateRow copyWith({
    String? id,
    String? tenantId,
    String? createdAt,
    String? updatedAt,
    Value<String?> deletedAt = const Value.absent(),
    int? version,
    String? syncStatus,
    Value<String?> lastSyncedAt = const Value.absent(),
    String? name,
    String? type,
    int? versionNumber,
    bool? isActive,
  }) => ChecklistTemplateRow(
    id: id ?? this.id,
    tenantId: tenantId ?? this.tenantId,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    version: version ?? this.version,
    syncStatus: syncStatus ?? this.syncStatus,
    lastSyncedAt: lastSyncedAt.present ? lastSyncedAt.value : this.lastSyncedAt,
    name: name ?? this.name,
    type: type ?? this.type,
    versionNumber: versionNumber ?? this.versionNumber,
    isActive: isActive ?? this.isActive,
  );
  ChecklistTemplateRow copyWithCompanion(ChecklistTemplatesCompanion data) {
    return ChecklistTemplateRow(
      id: data.id.present ? data.id.value : this.id,
      tenantId: data.tenantId.present ? data.tenantId.value : this.tenantId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      version: data.version.present ? data.version.value : this.version,
      syncStatus: data.syncStatus.present
          ? data.syncStatus.value
          : this.syncStatus,
      lastSyncedAt: data.lastSyncedAt.present
          ? data.lastSyncedAt.value
          : this.lastSyncedAt,
      name: data.name.present ? data.name.value : this.name,
      type: data.type.present ? data.type.value : this.type,
      versionNumber: data.versionNumber.present
          ? data.versionNumber.value
          : this.versionNumber,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ChecklistTemplateRow(')
          ..write('id: $id, ')
          ..write('tenantId: $tenantId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('version: $version, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('lastSyncedAt: $lastSyncedAt, ')
          ..write('name: $name, ')
          ..write('type: $type, ')
          ..write('versionNumber: $versionNumber, ')
          ..write('isActive: $isActive')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    tenantId,
    createdAt,
    updatedAt,
    deletedAt,
    version,
    syncStatus,
    lastSyncedAt,
    name,
    type,
    versionNumber,
    isActive,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ChecklistTemplateRow &&
          other.id == this.id &&
          other.tenantId == this.tenantId &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.version == this.version &&
          other.syncStatus == this.syncStatus &&
          other.lastSyncedAt == this.lastSyncedAt &&
          other.name == this.name &&
          other.type == this.type &&
          other.versionNumber == this.versionNumber &&
          other.isActive == this.isActive);
}

class ChecklistTemplatesCompanion
    extends UpdateCompanion<ChecklistTemplateRow> {
  final Value<String> id;
  final Value<String> tenantId;
  final Value<String> createdAt;
  final Value<String> updatedAt;
  final Value<String?> deletedAt;
  final Value<int> version;
  final Value<String> syncStatus;
  final Value<String?> lastSyncedAt;
  final Value<String> name;
  final Value<String> type;
  final Value<int> versionNumber;
  final Value<bool> isActive;
  final Value<int> rowid;
  const ChecklistTemplatesCompanion({
    this.id = const Value.absent(),
    this.tenantId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.version = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.lastSyncedAt = const Value.absent(),
    this.name = const Value.absent(),
    this.type = const Value.absent(),
    this.versionNumber = const Value.absent(),
    this.isActive = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ChecklistTemplatesCompanion.insert({
    required String id,
    required String tenantId,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.version = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.lastSyncedAt = const Value.absent(),
    required String name,
    required String type,
    required int versionNumber,
    this.isActive = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       tenantId = Value(tenantId),
       name = Value(name),
       type = Value(type),
       versionNumber = Value(versionNumber);
  static Insertable<ChecklistTemplateRow> custom({
    Expression<String>? id,
    Expression<String>? tenantId,
    Expression<String>? createdAt,
    Expression<String>? updatedAt,
    Expression<String>? deletedAt,
    Expression<int>? version,
    Expression<String>? syncStatus,
    Expression<String>? lastSyncedAt,
    Expression<String>? name,
    Expression<String>? type,
    Expression<int>? versionNumber,
    Expression<bool>? isActive,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (tenantId != null) 'tenant_id': tenantId,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (version != null) 'version': version,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (lastSyncedAt != null) 'last_synced_at': lastSyncedAt,
      if (name != null) 'name': name,
      if (type != null) 'type': type,
      if (versionNumber != null) 'version_number': versionNumber,
      if (isActive != null) 'is_active': isActive,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ChecklistTemplatesCompanion copyWith({
    Value<String>? id,
    Value<String>? tenantId,
    Value<String>? createdAt,
    Value<String>? updatedAt,
    Value<String?>? deletedAt,
    Value<int>? version,
    Value<String>? syncStatus,
    Value<String?>? lastSyncedAt,
    Value<String>? name,
    Value<String>? type,
    Value<int>? versionNumber,
    Value<bool>? isActive,
    Value<int>? rowid,
  }) {
    return ChecklistTemplatesCompanion(
      id: id ?? this.id,
      tenantId: tenantId ?? this.tenantId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      version: version ?? this.version,
      syncStatus: syncStatus ?? this.syncStatus,
      lastSyncedAt: lastSyncedAt ?? this.lastSyncedAt,
      name: name ?? this.name,
      type: type ?? this.type,
      versionNumber: versionNumber ?? this.versionNumber,
      isActive: isActive ?? this.isActive,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (tenantId.present) {
      map['tenant_id'] = Variable<String>(tenantId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<String>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<String>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<String>(deletedAt.value);
    }
    if (version.present) {
      map['version'] = Variable<int>(version.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(syncStatus.value);
    }
    if (lastSyncedAt.present) {
      map['last_synced_at'] = Variable<String>(lastSyncedAt.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (versionNumber.present) {
      map['version_number'] = Variable<int>(versionNumber.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ChecklistTemplatesCompanion(')
          ..write('id: $id, ')
          ..write('tenantId: $tenantId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('version: $version, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('lastSyncedAt: $lastSyncedAt, ')
          ..write('name: $name, ')
          ..write('type: $type, ')
          ..write('versionNumber: $versionNumber, ')
          ..write('isActive: $isActive, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ChecklistTemplateItemsTable extends ChecklistTemplateItems
    with TableInfo<$ChecklistTemplateItemsTable, ChecklistTemplateItemRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ChecklistTemplateItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _tenantIdMeta = const VerificationMeta(
    'tenantId',
  );
  @override
  late final GeneratedColumn<String> tenantId = GeneratedColumn<String>(
    'tenant_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<String> createdAt = GeneratedColumn<String>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: _utcNowIso,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<String> updatedAt = GeneratedColumn<String>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: _utcNowIso,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<String> deletedAt = GeneratedColumn<String>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _versionMeta = const VerificationMeta(
    'version',
  );
  @override
  late final GeneratedColumn<int> version = GeneratedColumn<int>(
    'version',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
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
    defaultValue: const Constant('synced'),
  );
  static const VerificationMeta _lastSyncedAtMeta = const VerificationMeta(
    'lastSyncedAt',
  );
  @override
  late final GeneratedColumn<String> lastSyncedAt = GeneratedColumn<String>(
    'last_synced_at',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _templateIdMeta = const VerificationMeta(
    'templateId',
  );
  @override
  late final GeneratedColumn<String> templateId = GeneratedColumn<String>(
    'template_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _positionMeta = const VerificationMeta(
    'position',
  );
  @override
  late final GeneratedColumn<int> position = GeneratedColumn<int>(
    'position',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _labelMeta = const VerificationMeta('label');
  @override
  late final GeneratedColumn<String> label = GeneratedColumn<String>(
    'label',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _helpTextMeta = const VerificationMeta(
    'helpText',
  );
  @override
  late final GeneratedColumn<String> helpText = GeneratedColumn<String>(
    'help_text',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _answerTypeMeta = const VerificationMeta(
    'answerType',
  );
  @override
  late final GeneratedColumn<String> answerType = GeneratedColumn<String>(
    'answer_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _requiredMeta = const VerificationMeta(
    'required',
  );
  @override
  late final GeneratedColumn<bool> required = GeneratedColumn<bool>(
    'required',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("required" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _optionsJsonMeta = const VerificationMeta(
    'optionsJson',
  );
  @override
  late final GeneratedColumn<String> optionsJson = GeneratedColumn<String>(
    'options_json',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    tenantId,
    createdAt,
    updatedAt,
    deletedAt,
    version,
    syncStatus,
    lastSyncedAt,
    templateId,
    position,
    label,
    helpText,
    answerType,
    required,
    optionsJson,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'checklist_template_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<ChecklistTemplateItemRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('tenant_id')) {
      context.handle(
        _tenantIdMeta,
        tenantId.isAcceptableOrUnknown(data['tenant_id']!, _tenantIdMeta),
      );
    } else if (isInserting) {
      context.missing(_tenantIdMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('version')) {
      context.handle(
        _versionMeta,
        version.isAcceptableOrUnknown(data['version']!, _versionMeta),
      );
    }
    if (data.containsKey('sync_status')) {
      context.handle(
        _syncStatusMeta,
        syncStatus.isAcceptableOrUnknown(data['sync_status']!, _syncStatusMeta),
      );
    }
    if (data.containsKey('last_synced_at')) {
      context.handle(
        _lastSyncedAtMeta,
        lastSyncedAt.isAcceptableOrUnknown(
          data['last_synced_at']!,
          _lastSyncedAtMeta,
        ),
      );
    }
    if (data.containsKey('template_id')) {
      context.handle(
        _templateIdMeta,
        templateId.isAcceptableOrUnknown(data['template_id']!, _templateIdMeta),
      );
    } else if (isInserting) {
      context.missing(_templateIdMeta);
    }
    if (data.containsKey('position')) {
      context.handle(
        _positionMeta,
        position.isAcceptableOrUnknown(data['position']!, _positionMeta),
      );
    } else if (isInserting) {
      context.missing(_positionMeta);
    }
    if (data.containsKey('label')) {
      context.handle(
        _labelMeta,
        label.isAcceptableOrUnknown(data['label']!, _labelMeta),
      );
    } else if (isInserting) {
      context.missing(_labelMeta);
    }
    if (data.containsKey('help_text')) {
      context.handle(
        _helpTextMeta,
        helpText.isAcceptableOrUnknown(data['help_text']!, _helpTextMeta),
      );
    }
    if (data.containsKey('answer_type')) {
      context.handle(
        _answerTypeMeta,
        answerType.isAcceptableOrUnknown(data['answer_type']!, _answerTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_answerTypeMeta);
    }
    if (data.containsKey('required')) {
      context.handle(
        _requiredMeta,
        required.isAcceptableOrUnknown(data['required']!, _requiredMeta),
      );
    }
    if (data.containsKey('options_json')) {
      context.handle(
        _optionsJsonMeta,
        optionsJson.isAcceptableOrUnknown(
          data['options_json']!,
          _optionsJsonMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ChecklistTemplateItemRow map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ChecklistTemplateItemRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      tenantId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tenant_id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}deleted_at'],
      ),
      version: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}version'],
      )!,
      syncStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sync_status'],
      )!,
      lastSyncedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_synced_at'],
      ),
      templateId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}template_id'],
      )!,
      position: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}position'],
      )!,
      label: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}label'],
      )!,
      helpText: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}help_text'],
      ),
      answerType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}answer_type'],
      )!,
      required: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}required'],
      )!,
      optionsJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}options_json'],
      ),
    );
  }

  @override
  $ChecklistTemplateItemsTable createAlias(String alias) {
    return $ChecklistTemplateItemsTable(attachedDatabase, alias);
  }
}

class ChecklistTemplateItemRow extends DataClass
    implements Insertable<ChecklistTemplateItemRow> {
  final String id;
  final String tenantId;
  final String createdAt;
  final String updatedAt;
  final String? deletedAt;
  final int version;
  final String syncStatus;
  final String? lastSyncedAt;
  final String templateId;
  final int position;
  final String label;
  final String? helpText;
  final String answerType;
  final bool required;
  final String? optionsJson;
  const ChecklistTemplateItemRow({
    required this.id,
    required this.tenantId,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.version,
    required this.syncStatus,
    this.lastSyncedAt,
    required this.templateId,
    required this.position,
    required this.label,
    this.helpText,
    required this.answerType,
    required this.required,
    this.optionsJson,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['tenant_id'] = Variable<String>(tenantId);
    map['created_at'] = Variable<String>(createdAt);
    map['updated_at'] = Variable<String>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<String>(deletedAt);
    }
    map['version'] = Variable<int>(version);
    map['sync_status'] = Variable<String>(syncStatus);
    if (!nullToAbsent || lastSyncedAt != null) {
      map['last_synced_at'] = Variable<String>(lastSyncedAt);
    }
    map['template_id'] = Variable<String>(templateId);
    map['position'] = Variable<int>(position);
    map['label'] = Variable<String>(label);
    if (!nullToAbsent || helpText != null) {
      map['help_text'] = Variable<String>(helpText);
    }
    map['answer_type'] = Variable<String>(answerType);
    map['required'] = Variable<bool>(required);
    if (!nullToAbsent || optionsJson != null) {
      map['options_json'] = Variable<String>(optionsJson);
    }
    return map;
  }

  ChecklistTemplateItemsCompanion toCompanion(bool nullToAbsent) {
    return ChecklistTemplateItemsCompanion(
      id: Value(id),
      tenantId: Value(tenantId),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      version: Value(version),
      syncStatus: Value(syncStatus),
      lastSyncedAt: lastSyncedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastSyncedAt),
      templateId: Value(templateId),
      position: Value(position),
      label: Value(label),
      helpText: helpText == null && nullToAbsent
          ? const Value.absent()
          : Value(helpText),
      answerType: Value(answerType),
      required: Value(required),
      optionsJson: optionsJson == null && nullToAbsent
          ? const Value.absent()
          : Value(optionsJson),
    );
  }

  factory ChecklistTemplateItemRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ChecklistTemplateItemRow(
      id: serializer.fromJson<String>(json['id']),
      tenantId: serializer.fromJson<String>(json['tenantId']),
      createdAt: serializer.fromJson<String>(json['createdAt']),
      updatedAt: serializer.fromJson<String>(json['updatedAt']),
      deletedAt: serializer.fromJson<String?>(json['deletedAt']),
      version: serializer.fromJson<int>(json['version']),
      syncStatus: serializer.fromJson<String>(json['syncStatus']),
      lastSyncedAt: serializer.fromJson<String?>(json['lastSyncedAt']),
      templateId: serializer.fromJson<String>(json['templateId']),
      position: serializer.fromJson<int>(json['position']),
      label: serializer.fromJson<String>(json['label']),
      helpText: serializer.fromJson<String?>(json['helpText']),
      answerType: serializer.fromJson<String>(json['answerType']),
      required: serializer.fromJson<bool>(json['required']),
      optionsJson: serializer.fromJson<String?>(json['optionsJson']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'tenantId': serializer.toJson<String>(tenantId),
      'createdAt': serializer.toJson<String>(createdAt),
      'updatedAt': serializer.toJson<String>(updatedAt),
      'deletedAt': serializer.toJson<String?>(deletedAt),
      'version': serializer.toJson<int>(version),
      'syncStatus': serializer.toJson<String>(syncStatus),
      'lastSyncedAt': serializer.toJson<String?>(lastSyncedAt),
      'templateId': serializer.toJson<String>(templateId),
      'position': serializer.toJson<int>(position),
      'label': serializer.toJson<String>(label),
      'helpText': serializer.toJson<String?>(helpText),
      'answerType': serializer.toJson<String>(answerType),
      'required': serializer.toJson<bool>(required),
      'optionsJson': serializer.toJson<String?>(optionsJson),
    };
  }

  ChecklistTemplateItemRow copyWith({
    String? id,
    String? tenantId,
    String? createdAt,
    String? updatedAt,
    Value<String?> deletedAt = const Value.absent(),
    int? version,
    String? syncStatus,
    Value<String?> lastSyncedAt = const Value.absent(),
    String? templateId,
    int? position,
    String? label,
    Value<String?> helpText = const Value.absent(),
    String? answerType,
    bool? required,
    Value<String?> optionsJson = const Value.absent(),
  }) => ChecklistTemplateItemRow(
    id: id ?? this.id,
    tenantId: tenantId ?? this.tenantId,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    version: version ?? this.version,
    syncStatus: syncStatus ?? this.syncStatus,
    lastSyncedAt: lastSyncedAt.present ? lastSyncedAt.value : this.lastSyncedAt,
    templateId: templateId ?? this.templateId,
    position: position ?? this.position,
    label: label ?? this.label,
    helpText: helpText.present ? helpText.value : this.helpText,
    answerType: answerType ?? this.answerType,
    required: required ?? this.required,
    optionsJson: optionsJson.present ? optionsJson.value : this.optionsJson,
  );
  ChecklistTemplateItemRow copyWithCompanion(
    ChecklistTemplateItemsCompanion data,
  ) {
    return ChecklistTemplateItemRow(
      id: data.id.present ? data.id.value : this.id,
      tenantId: data.tenantId.present ? data.tenantId.value : this.tenantId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      version: data.version.present ? data.version.value : this.version,
      syncStatus: data.syncStatus.present
          ? data.syncStatus.value
          : this.syncStatus,
      lastSyncedAt: data.lastSyncedAt.present
          ? data.lastSyncedAt.value
          : this.lastSyncedAt,
      templateId: data.templateId.present
          ? data.templateId.value
          : this.templateId,
      position: data.position.present ? data.position.value : this.position,
      label: data.label.present ? data.label.value : this.label,
      helpText: data.helpText.present ? data.helpText.value : this.helpText,
      answerType: data.answerType.present
          ? data.answerType.value
          : this.answerType,
      required: data.required.present ? data.required.value : this.required,
      optionsJson: data.optionsJson.present
          ? data.optionsJson.value
          : this.optionsJson,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ChecklistTemplateItemRow(')
          ..write('id: $id, ')
          ..write('tenantId: $tenantId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('version: $version, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('lastSyncedAt: $lastSyncedAt, ')
          ..write('templateId: $templateId, ')
          ..write('position: $position, ')
          ..write('label: $label, ')
          ..write('helpText: $helpText, ')
          ..write('answerType: $answerType, ')
          ..write('required: $required, ')
          ..write('optionsJson: $optionsJson')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    tenantId,
    createdAt,
    updatedAt,
    deletedAt,
    version,
    syncStatus,
    lastSyncedAt,
    templateId,
    position,
    label,
    helpText,
    answerType,
    required,
    optionsJson,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ChecklistTemplateItemRow &&
          other.id == this.id &&
          other.tenantId == this.tenantId &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.version == this.version &&
          other.syncStatus == this.syncStatus &&
          other.lastSyncedAt == this.lastSyncedAt &&
          other.templateId == this.templateId &&
          other.position == this.position &&
          other.label == this.label &&
          other.helpText == this.helpText &&
          other.answerType == this.answerType &&
          other.required == this.required &&
          other.optionsJson == this.optionsJson);
}

class ChecklistTemplateItemsCompanion
    extends UpdateCompanion<ChecklistTemplateItemRow> {
  final Value<String> id;
  final Value<String> tenantId;
  final Value<String> createdAt;
  final Value<String> updatedAt;
  final Value<String?> deletedAt;
  final Value<int> version;
  final Value<String> syncStatus;
  final Value<String?> lastSyncedAt;
  final Value<String> templateId;
  final Value<int> position;
  final Value<String> label;
  final Value<String?> helpText;
  final Value<String> answerType;
  final Value<bool> required;
  final Value<String?> optionsJson;
  final Value<int> rowid;
  const ChecklistTemplateItemsCompanion({
    this.id = const Value.absent(),
    this.tenantId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.version = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.lastSyncedAt = const Value.absent(),
    this.templateId = const Value.absent(),
    this.position = const Value.absent(),
    this.label = const Value.absent(),
    this.helpText = const Value.absent(),
    this.answerType = const Value.absent(),
    this.required = const Value.absent(),
    this.optionsJson = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ChecklistTemplateItemsCompanion.insert({
    required String id,
    required String tenantId,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.version = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.lastSyncedAt = const Value.absent(),
    required String templateId,
    required int position,
    required String label,
    this.helpText = const Value.absent(),
    required String answerType,
    this.required = const Value.absent(),
    this.optionsJson = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       tenantId = Value(tenantId),
       templateId = Value(templateId),
       position = Value(position),
       label = Value(label),
       answerType = Value(answerType);
  static Insertable<ChecklistTemplateItemRow> custom({
    Expression<String>? id,
    Expression<String>? tenantId,
    Expression<String>? createdAt,
    Expression<String>? updatedAt,
    Expression<String>? deletedAt,
    Expression<int>? version,
    Expression<String>? syncStatus,
    Expression<String>? lastSyncedAt,
    Expression<String>? templateId,
    Expression<int>? position,
    Expression<String>? label,
    Expression<String>? helpText,
    Expression<String>? answerType,
    Expression<bool>? required,
    Expression<String>? optionsJson,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (tenantId != null) 'tenant_id': tenantId,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (version != null) 'version': version,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (lastSyncedAt != null) 'last_synced_at': lastSyncedAt,
      if (templateId != null) 'template_id': templateId,
      if (position != null) 'position': position,
      if (label != null) 'label': label,
      if (helpText != null) 'help_text': helpText,
      if (answerType != null) 'answer_type': answerType,
      if (required != null) 'required': required,
      if (optionsJson != null) 'options_json': optionsJson,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ChecklistTemplateItemsCompanion copyWith({
    Value<String>? id,
    Value<String>? tenantId,
    Value<String>? createdAt,
    Value<String>? updatedAt,
    Value<String?>? deletedAt,
    Value<int>? version,
    Value<String>? syncStatus,
    Value<String?>? lastSyncedAt,
    Value<String>? templateId,
    Value<int>? position,
    Value<String>? label,
    Value<String?>? helpText,
    Value<String>? answerType,
    Value<bool>? required,
    Value<String?>? optionsJson,
    Value<int>? rowid,
  }) {
    return ChecklistTemplateItemsCompanion(
      id: id ?? this.id,
      tenantId: tenantId ?? this.tenantId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      version: version ?? this.version,
      syncStatus: syncStatus ?? this.syncStatus,
      lastSyncedAt: lastSyncedAt ?? this.lastSyncedAt,
      templateId: templateId ?? this.templateId,
      position: position ?? this.position,
      label: label ?? this.label,
      helpText: helpText ?? this.helpText,
      answerType: answerType ?? this.answerType,
      required: required ?? this.required,
      optionsJson: optionsJson ?? this.optionsJson,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (tenantId.present) {
      map['tenant_id'] = Variable<String>(tenantId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<String>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<String>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<String>(deletedAt.value);
    }
    if (version.present) {
      map['version'] = Variable<int>(version.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(syncStatus.value);
    }
    if (lastSyncedAt.present) {
      map['last_synced_at'] = Variable<String>(lastSyncedAt.value);
    }
    if (templateId.present) {
      map['template_id'] = Variable<String>(templateId.value);
    }
    if (position.present) {
      map['position'] = Variable<int>(position.value);
    }
    if (label.present) {
      map['label'] = Variable<String>(label.value);
    }
    if (helpText.present) {
      map['help_text'] = Variable<String>(helpText.value);
    }
    if (answerType.present) {
      map['answer_type'] = Variable<String>(answerType.value);
    }
    if (required.present) {
      map['required'] = Variable<bool>(required.value);
    }
    if (optionsJson.present) {
      map['options_json'] = Variable<String>(optionsJson.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ChecklistTemplateItemsCompanion(')
          ..write('id: $id, ')
          ..write('tenantId: $tenantId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('version: $version, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('lastSyncedAt: $lastSyncedAt, ')
          ..write('templateId: $templateId, ')
          ..write('position: $position, ')
          ..write('label: $label, ')
          ..write('helpText: $helpText, ')
          ..write('answerType: $answerType, ')
          ..write('required: $required, ')
          ..write('optionsJson: $optionsJson, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ChecklistAnswersTable extends ChecklistAnswers
    with TableInfo<$ChecklistAnswersTable, ChecklistAnswerRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ChecklistAnswersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _tenantIdMeta = const VerificationMeta(
    'tenantId',
  );
  @override
  late final GeneratedColumn<String> tenantId = GeneratedColumn<String>(
    'tenant_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<String> createdAt = GeneratedColumn<String>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: _utcNowIso,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<String> updatedAt = GeneratedColumn<String>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: _utcNowIso,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<String> deletedAt = GeneratedColumn<String>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _versionMeta = const VerificationMeta(
    'version',
  );
  @override
  late final GeneratedColumn<int> version = GeneratedColumn<int>(
    'version',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
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
    defaultValue: const Constant('synced'),
  );
  static const VerificationMeta _lastSyncedAtMeta = const VerificationMeta(
    'lastSyncedAt',
  );
  @override
  late final GeneratedColumn<String> lastSyncedAt = GeneratedColumn<String>(
    'last_synced_at',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _workOrderIdMeta = const VerificationMeta(
    'workOrderId',
  );
  @override
  late final GeneratedColumn<String> workOrderId = GeneratedColumn<String>(
    'work_order_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _templateItemIdMeta = const VerificationMeta(
    'templateItemId',
  );
  @override
  late final GeneratedColumn<String> templateItemId = GeneratedColumn<String>(
    'template_item_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _answerValueMeta = const VerificationMeta(
    'answerValue',
  );
  @override
  late final GeneratedColumn<String> answerValue = GeneratedColumn<String>(
    'answer_value',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _commentMeta = const VerificationMeta(
    'comment',
  );
  @override
  late final GeneratedColumn<String> comment = GeneratedColumn<String>(
    'comment',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isOkMeta = const VerificationMeta('isOk');
  @override
  late final GeneratedColumn<bool> isOk = GeneratedColumn<bool>(
    'is_ok',
    aliasedName,
    true,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_ok" IN (0, 1))',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    tenantId,
    createdAt,
    updatedAt,
    deletedAt,
    version,
    syncStatus,
    lastSyncedAt,
    workOrderId,
    templateItemId,
    answerValue,
    comment,
    isOk,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'checklist_answers';
  @override
  VerificationContext validateIntegrity(
    Insertable<ChecklistAnswerRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('tenant_id')) {
      context.handle(
        _tenantIdMeta,
        tenantId.isAcceptableOrUnknown(data['tenant_id']!, _tenantIdMeta),
      );
    } else if (isInserting) {
      context.missing(_tenantIdMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('version')) {
      context.handle(
        _versionMeta,
        version.isAcceptableOrUnknown(data['version']!, _versionMeta),
      );
    }
    if (data.containsKey('sync_status')) {
      context.handle(
        _syncStatusMeta,
        syncStatus.isAcceptableOrUnknown(data['sync_status']!, _syncStatusMeta),
      );
    }
    if (data.containsKey('last_synced_at')) {
      context.handle(
        _lastSyncedAtMeta,
        lastSyncedAt.isAcceptableOrUnknown(
          data['last_synced_at']!,
          _lastSyncedAtMeta,
        ),
      );
    }
    if (data.containsKey('work_order_id')) {
      context.handle(
        _workOrderIdMeta,
        workOrderId.isAcceptableOrUnknown(
          data['work_order_id']!,
          _workOrderIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_workOrderIdMeta);
    }
    if (data.containsKey('template_item_id')) {
      context.handle(
        _templateItemIdMeta,
        templateItemId.isAcceptableOrUnknown(
          data['template_item_id']!,
          _templateItemIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_templateItemIdMeta);
    }
    if (data.containsKey('answer_value')) {
      context.handle(
        _answerValueMeta,
        answerValue.isAcceptableOrUnknown(
          data['answer_value']!,
          _answerValueMeta,
        ),
      );
    }
    if (data.containsKey('comment')) {
      context.handle(
        _commentMeta,
        comment.isAcceptableOrUnknown(data['comment']!, _commentMeta),
      );
    }
    if (data.containsKey('is_ok')) {
      context.handle(
        _isOkMeta,
        isOk.isAcceptableOrUnknown(data['is_ok']!, _isOkMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ChecklistAnswerRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ChecklistAnswerRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      tenantId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tenant_id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}deleted_at'],
      ),
      version: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}version'],
      )!,
      syncStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sync_status'],
      )!,
      lastSyncedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_synced_at'],
      ),
      workOrderId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}work_order_id'],
      )!,
      templateItemId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}template_item_id'],
      )!,
      answerValue: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}answer_value'],
      ),
      comment: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}comment'],
      ),
      isOk: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_ok'],
      ),
    );
  }

  @override
  $ChecklistAnswersTable createAlias(String alias) {
    return $ChecklistAnswersTable(attachedDatabase, alias);
  }
}

class ChecklistAnswerRow extends DataClass
    implements Insertable<ChecklistAnswerRow> {
  final String id;
  final String tenantId;
  final String createdAt;
  final String updatedAt;
  final String? deletedAt;
  final int version;
  final String syncStatus;
  final String? lastSyncedAt;
  final String workOrderId;
  final String templateItemId;
  final String? answerValue;
  final String? comment;
  final bool? isOk;
  const ChecklistAnswerRow({
    required this.id,
    required this.tenantId,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.version,
    required this.syncStatus,
    this.lastSyncedAt,
    required this.workOrderId,
    required this.templateItemId,
    this.answerValue,
    this.comment,
    this.isOk,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['tenant_id'] = Variable<String>(tenantId);
    map['created_at'] = Variable<String>(createdAt);
    map['updated_at'] = Variable<String>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<String>(deletedAt);
    }
    map['version'] = Variable<int>(version);
    map['sync_status'] = Variable<String>(syncStatus);
    if (!nullToAbsent || lastSyncedAt != null) {
      map['last_synced_at'] = Variable<String>(lastSyncedAt);
    }
    map['work_order_id'] = Variable<String>(workOrderId);
    map['template_item_id'] = Variable<String>(templateItemId);
    if (!nullToAbsent || answerValue != null) {
      map['answer_value'] = Variable<String>(answerValue);
    }
    if (!nullToAbsent || comment != null) {
      map['comment'] = Variable<String>(comment);
    }
    if (!nullToAbsent || isOk != null) {
      map['is_ok'] = Variable<bool>(isOk);
    }
    return map;
  }

  ChecklistAnswersCompanion toCompanion(bool nullToAbsent) {
    return ChecklistAnswersCompanion(
      id: Value(id),
      tenantId: Value(tenantId),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      version: Value(version),
      syncStatus: Value(syncStatus),
      lastSyncedAt: lastSyncedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastSyncedAt),
      workOrderId: Value(workOrderId),
      templateItemId: Value(templateItemId),
      answerValue: answerValue == null && nullToAbsent
          ? const Value.absent()
          : Value(answerValue),
      comment: comment == null && nullToAbsent
          ? const Value.absent()
          : Value(comment),
      isOk: isOk == null && nullToAbsent ? const Value.absent() : Value(isOk),
    );
  }

  factory ChecklistAnswerRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ChecklistAnswerRow(
      id: serializer.fromJson<String>(json['id']),
      tenantId: serializer.fromJson<String>(json['tenantId']),
      createdAt: serializer.fromJson<String>(json['createdAt']),
      updatedAt: serializer.fromJson<String>(json['updatedAt']),
      deletedAt: serializer.fromJson<String?>(json['deletedAt']),
      version: serializer.fromJson<int>(json['version']),
      syncStatus: serializer.fromJson<String>(json['syncStatus']),
      lastSyncedAt: serializer.fromJson<String?>(json['lastSyncedAt']),
      workOrderId: serializer.fromJson<String>(json['workOrderId']),
      templateItemId: serializer.fromJson<String>(json['templateItemId']),
      answerValue: serializer.fromJson<String?>(json['answerValue']),
      comment: serializer.fromJson<String?>(json['comment']),
      isOk: serializer.fromJson<bool?>(json['isOk']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'tenantId': serializer.toJson<String>(tenantId),
      'createdAt': serializer.toJson<String>(createdAt),
      'updatedAt': serializer.toJson<String>(updatedAt),
      'deletedAt': serializer.toJson<String?>(deletedAt),
      'version': serializer.toJson<int>(version),
      'syncStatus': serializer.toJson<String>(syncStatus),
      'lastSyncedAt': serializer.toJson<String?>(lastSyncedAt),
      'workOrderId': serializer.toJson<String>(workOrderId),
      'templateItemId': serializer.toJson<String>(templateItemId),
      'answerValue': serializer.toJson<String?>(answerValue),
      'comment': serializer.toJson<String?>(comment),
      'isOk': serializer.toJson<bool?>(isOk),
    };
  }

  ChecklistAnswerRow copyWith({
    String? id,
    String? tenantId,
    String? createdAt,
    String? updatedAt,
    Value<String?> deletedAt = const Value.absent(),
    int? version,
    String? syncStatus,
    Value<String?> lastSyncedAt = const Value.absent(),
    String? workOrderId,
    String? templateItemId,
    Value<String?> answerValue = const Value.absent(),
    Value<String?> comment = const Value.absent(),
    Value<bool?> isOk = const Value.absent(),
  }) => ChecklistAnswerRow(
    id: id ?? this.id,
    tenantId: tenantId ?? this.tenantId,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    version: version ?? this.version,
    syncStatus: syncStatus ?? this.syncStatus,
    lastSyncedAt: lastSyncedAt.present ? lastSyncedAt.value : this.lastSyncedAt,
    workOrderId: workOrderId ?? this.workOrderId,
    templateItemId: templateItemId ?? this.templateItemId,
    answerValue: answerValue.present ? answerValue.value : this.answerValue,
    comment: comment.present ? comment.value : this.comment,
    isOk: isOk.present ? isOk.value : this.isOk,
  );
  ChecklistAnswerRow copyWithCompanion(ChecklistAnswersCompanion data) {
    return ChecklistAnswerRow(
      id: data.id.present ? data.id.value : this.id,
      tenantId: data.tenantId.present ? data.tenantId.value : this.tenantId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      version: data.version.present ? data.version.value : this.version,
      syncStatus: data.syncStatus.present
          ? data.syncStatus.value
          : this.syncStatus,
      lastSyncedAt: data.lastSyncedAt.present
          ? data.lastSyncedAt.value
          : this.lastSyncedAt,
      workOrderId: data.workOrderId.present
          ? data.workOrderId.value
          : this.workOrderId,
      templateItemId: data.templateItemId.present
          ? data.templateItemId.value
          : this.templateItemId,
      answerValue: data.answerValue.present
          ? data.answerValue.value
          : this.answerValue,
      comment: data.comment.present ? data.comment.value : this.comment,
      isOk: data.isOk.present ? data.isOk.value : this.isOk,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ChecklistAnswerRow(')
          ..write('id: $id, ')
          ..write('tenantId: $tenantId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('version: $version, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('lastSyncedAt: $lastSyncedAt, ')
          ..write('workOrderId: $workOrderId, ')
          ..write('templateItemId: $templateItemId, ')
          ..write('answerValue: $answerValue, ')
          ..write('comment: $comment, ')
          ..write('isOk: $isOk')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    tenantId,
    createdAt,
    updatedAt,
    deletedAt,
    version,
    syncStatus,
    lastSyncedAt,
    workOrderId,
    templateItemId,
    answerValue,
    comment,
    isOk,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ChecklistAnswerRow &&
          other.id == this.id &&
          other.tenantId == this.tenantId &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.version == this.version &&
          other.syncStatus == this.syncStatus &&
          other.lastSyncedAt == this.lastSyncedAt &&
          other.workOrderId == this.workOrderId &&
          other.templateItemId == this.templateItemId &&
          other.answerValue == this.answerValue &&
          other.comment == this.comment &&
          other.isOk == this.isOk);
}

class ChecklistAnswersCompanion extends UpdateCompanion<ChecklistAnswerRow> {
  final Value<String> id;
  final Value<String> tenantId;
  final Value<String> createdAt;
  final Value<String> updatedAt;
  final Value<String?> deletedAt;
  final Value<int> version;
  final Value<String> syncStatus;
  final Value<String?> lastSyncedAt;
  final Value<String> workOrderId;
  final Value<String> templateItemId;
  final Value<String?> answerValue;
  final Value<String?> comment;
  final Value<bool?> isOk;
  final Value<int> rowid;
  const ChecklistAnswersCompanion({
    this.id = const Value.absent(),
    this.tenantId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.version = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.lastSyncedAt = const Value.absent(),
    this.workOrderId = const Value.absent(),
    this.templateItemId = const Value.absent(),
    this.answerValue = const Value.absent(),
    this.comment = const Value.absent(),
    this.isOk = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ChecklistAnswersCompanion.insert({
    required String id,
    required String tenantId,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.version = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.lastSyncedAt = const Value.absent(),
    required String workOrderId,
    required String templateItemId,
    this.answerValue = const Value.absent(),
    this.comment = const Value.absent(),
    this.isOk = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       tenantId = Value(tenantId),
       workOrderId = Value(workOrderId),
       templateItemId = Value(templateItemId);
  static Insertable<ChecklistAnswerRow> custom({
    Expression<String>? id,
    Expression<String>? tenantId,
    Expression<String>? createdAt,
    Expression<String>? updatedAt,
    Expression<String>? deletedAt,
    Expression<int>? version,
    Expression<String>? syncStatus,
    Expression<String>? lastSyncedAt,
    Expression<String>? workOrderId,
    Expression<String>? templateItemId,
    Expression<String>? answerValue,
    Expression<String>? comment,
    Expression<bool>? isOk,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (tenantId != null) 'tenant_id': tenantId,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (version != null) 'version': version,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (lastSyncedAt != null) 'last_synced_at': lastSyncedAt,
      if (workOrderId != null) 'work_order_id': workOrderId,
      if (templateItemId != null) 'template_item_id': templateItemId,
      if (answerValue != null) 'answer_value': answerValue,
      if (comment != null) 'comment': comment,
      if (isOk != null) 'is_ok': isOk,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ChecklistAnswersCompanion copyWith({
    Value<String>? id,
    Value<String>? tenantId,
    Value<String>? createdAt,
    Value<String>? updatedAt,
    Value<String?>? deletedAt,
    Value<int>? version,
    Value<String>? syncStatus,
    Value<String?>? lastSyncedAt,
    Value<String>? workOrderId,
    Value<String>? templateItemId,
    Value<String?>? answerValue,
    Value<String?>? comment,
    Value<bool?>? isOk,
    Value<int>? rowid,
  }) {
    return ChecklistAnswersCompanion(
      id: id ?? this.id,
      tenantId: tenantId ?? this.tenantId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      version: version ?? this.version,
      syncStatus: syncStatus ?? this.syncStatus,
      lastSyncedAt: lastSyncedAt ?? this.lastSyncedAt,
      workOrderId: workOrderId ?? this.workOrderId,
      templateItemId: templateItemId ?? this.templateItemId,
      answerValue: answerValue ?? this.answerValue,
      comment: comment ?? this.comment,
      isOk: isOk ?? this.isOk,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (tenantId.present) {
      map['tenant_id'] = Variable<String>(tenantId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<String>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<String>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<String>(deletedAt.value);
    }
    if (version.present) {
      map['version'] = Variable<int>(version.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(syncStatus.value);
    }
    if (lastSyncedAt.present) {
      map['last_synced_at'] = Variable<String>(lastSyncedAt.value);
    }
    if (workOrderId.present) {
      map['work_order_id'] = Variable<String>(workOrderId.value);
    }
    if (templateItemId.present) {
      map['template_item_id'] = Variable<String>(templateItemId.value);
    }
    if (answerValue.present) {
      map['answer_value'] = Variable<String>(answerValue.value);
    }
    if (comment.present) {
      map['comment'] = Variable<String>(comment.value);
    }
    if (isOk.present) {
      map['is_ok'] = Variable<bool>(isOk.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ChecklistAnswersCompanion(')
          ..write('id: $id, ')
          ..write('tenantId: $tenantId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('version: $version, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('lastSyncedAt: $lastSyncedAt, ')
          ..write('workOrderId: $workOrderId, ')
          ..write('templateItemId: $templateItemId, ')
          ..write('answerValue: $answerValue, ')
          ..write('comment: $comment, ')
          ..write('isOk: $isOk, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MeasurementsTable extends Measurements
    with TableInfo<$MeasurementsTable, MeasurementRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MeasurementsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _tenantIdMeta = const VerificationMeta(
    'tenantId',
  );
  @override
  late final GeneratedColumn<String> tenantId = GeneratedColumn<String>(
    'tenant_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<String> createdAt = GeneratedColumn<String>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: _utcNowIso,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<String> updatedAt = GeneratedColumn<String>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: _utcNowIso,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<String> deletedAt = GeneratedColumn<String>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _versionMeta = const VerificationMeta(
    'version',
  );
  @override
  late final GeneratedColumn<int> version = GeneratedColumn<int>(
    'version',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
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
    defaultValue: const Constant('synced'),
  );
  static const VerificationMeta _lastSyncedAtMeta = const VerificationMeta(
    'lastSyncedAt',
  );
  @override
  late final GeneratedColumn<String> lastSyncedAt = GeneratedColumn<String>(
    'last_synced_at',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _workOrderIdMeta = const VerificationMeta(
    'workOrderId',
  );
  @override
  late final GeneratedColumn<String> workOrderId = GeneratedColumn<String>(
    'work_order_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _installationIdMeta = const VerificationMeta(
    'installationId',
  );
  @override
  late final GeneratedColumn<String> installationId = GeneratedColumn<String>(
    'installation_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _measurementTypeMeta = const VerificationMeta(
    'measurementType',
  );
  @override
  late final GeneratedColumn<String> measurementType = GeneratedColumn<String>(
    'measurement_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<double> value = GeneratedColumn<double>(
    'value',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _unitMeta = const VerificationMeta('unit');
  @override
  late final GeneratedColumn<String> unit = GeneratedColumn<String>(
    'unit',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _measuredAtMeta = const VerificationMeta(
    'measuredAt',
  );
  @override
  late final GeneratedColumn<String> measuredAt = GeneratedColumn<String>(
    'measured_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deviceNameMeta = const VerificationMeta(
    'deviceName',
  );
  @override
  late final GeneratedColumn<String> deviceName = GeneratedColumn<String>(
    'device_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _deviceSerialMeta = const VerificationMeta(
    'deviceSerial',
  );
  @override
  late final GeneratedColumn<String> deviceSerial = GeneratedColumn<String>(
    'device_serial',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    tenantId,
    createdAt,
    updatedAt,
    deletedAt,
    version,
    syncStatus,
    lastSyncedAt,
    workOrderId,
    installationId,
    measurementType,
    value,
    unit,
    measuredAt,
    deviceName,
    deviceSerial,
    notes,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'measurements';
  @override
  VerificationContext validateIntegrity(
    Insertable<MeasurementRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('tenant_id')) {
      context.handle(
        _tenantIdMeta,
        tenantId.isAcceptableOrUnknown(data['tenant_id']!, _tenantIdMeta),
      );
    } else if (isInserting) {
      context.missing(_tenantIdMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('version')) {
      context.handle(
        _versionMeta,
        version.isAcceptableOrUnknown(data['version']!, _versionMeta),
      );
    }
    if (data.containsKey('sync_status')) {
      context.handle(
        _syncStatusMeta,
        syncStatus.isAcceptableOrUnknown(data['sync_status']!, _syncStatusMeta),
      );
    }
    if (data.containsKey('last_synced_at')) {
      context.handle(
        _lastSyncedAtMeta,
        lastSyncedAt.isAcceptableOrUnknown(
          data['last_synced_at']!,
          _lastSyncedAtMeta,
        ),
      );
    }
    if (data.containsKey('work_order_id')) {
      context.handle(
        _workOrderIdMeta,
        workOrderId.isAcceptableOrUnknown(
          data['work_order_id']!,
          _workOrderIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_workOrderIdMeta);
    }
    if (data.containsKey('installation_id')) {
      context.handle(
        _installationIdMeta,
        installationId.isAcceptableOrUnknown(
          data['installation_id']!,
          _installationIdMeta,
        ),
      );
    }
    if (data.containsKey('measurement_type')) {
      context.handle(
        _measurementTypeMeta,
        measurementType.isAcceptableOrUnknown(
          data['measurement_type']!,
          _measurementTypeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_measurementTypeMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
        _valueMeta,
        value.isAcceptableOrUnknown(data['value']!, _valueMeta),
      );
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    if (data.containsKey('unit')) {
      context.handle(
        _unitMeta,
        unit.isAcceptableOrUnknown(data['unit']!, _unitMeta),
      );
    } else if (isInserting) {
      context.missing(_unitMeta);
    }
    if (data.containsKey('measured_at')) {
      context.handle(
        _measuredAtMeta,
        measuredAt.isAcceptableOrUnknown(data['measured_at']!, _measuredAtMeta),
      );
    } else if (isInserting) {
      context.missing(_measuredAtMeta);
    }
    if (data.containsKey('device_name')) {
      context.handle(
        _deviceNameMeta,
        deviceName.isAcceptableOrUnknown(data['device_name']!, _deviceNameMeta),
      );
    }
    if (data.containsKey('device_serial')) {
      context.handle(
        _deviceSerialMeta,
        deviceSerial.isAcceptableOrUnknown(
          data['device_serial']!,
          _deviceSerialMeta,
        ),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MeasurementRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MeasurementRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      tenantId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tenant_id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}deleted_at'],
      ),
      version: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}version'],
      )!,
      syncStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sync_status'],
      )!,
      lastSyncedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_synced_at'],
      ),
      workOrderId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}work_order_id'],
      )!,
      installationId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}installation_id'],
      ),
      measurementType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}measurement_type'],
      )!,
      value: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}value'],
      )!,
      unit: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}unit'],
      )!,
      measuredAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}measured_at'],
      )!,
      deviceName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}device_name'],
      ),
      deviceSerial: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}device_serial'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
    );
  }

  @override
  $MeasurementsTable createAlias(String alias) {
    return $MeasurementsTable(attachedDatabase, alias);
  }
}

class MeasurementRow extends DataClass implements Insertable<MeasurementRow> {
  final String id;
  final String tenantId;
  final String createdAt;
  final String updatedAt;
  final String? deletedAt;
  final int version;
  final String syncStatus;
  final String? lastSyncedAt;
  final String workOrderId;
  final String? installationId;
  final String measurementType;
  final double value;
  final String unit;
  final String measuredAt;
  final String? deviceName;
  final String? deviceSerial;
  final String? notes;
  const MeasurementRow({
    required this.id,
    required this.tenantId,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.version,
    required this.syncStatus,
    this.lastSyncedAt,
    required this.workOrderId,
    this.installationId,
    required this.measurementType,
    required this.value,
    required this.unit,
    required this.measuredAt,
    this.deviceName,
    this.deviceSerial,
    this.notes,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['tenant_id'] = Variable<String>(tenantId);
    map['created_at'] = Variable<String>(createdAt);
    map['updated_at'] = Variable<String>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<String>(deletedAt);
    }
    map['version'] = Variable<int>(version);
    map['sync_status'] = Variable<String>(syncStatus);
    if (!nullToAbsent || lastSyncedAt != null) {
      map['last_synced_at'] = Variable<String>(lastSyncedAt);
    }
    map['work_order_id'] = Variable<String>(workOrderId);
    if (!nullToAbsent || installationId != null) {
      map['installation_id'] = Variable<String>(installationId);
    }
    map['measurement_type'] = Variable<String>(measurementType);
    map['value'] = Variable<double>(value);
    map['unit'] = Variable<String>(unit);
    map['measured_at'] = Variable<String>(measuredAt);
    if (!nullToAbsent || deviceName != null) {
      map['device_name'] = Variable<String>(deviceName);
    }
    if (!nullToAbsent || deviceSerial != null) {
      map['device_serial'] = Variable<String>(deviceSerial);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    return map;
  }

  MeasurementsCompanion toCompanion(bool nullToAbsent) {
    return MeasurementsCompanion(
      id: Value(id),
      tenantId: Value(tenantId),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      version: Value(version),
      syncStatus: Value(syncStatus),
      lastSyncedAt: lastSyncedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastSyncedAt),
      workOrderId: Value(workOrderId),
      installationId: installationId == null && nullToAbsent
          ? const Value.absent()
          : Value(installationId),
      measurementType: Value(measurementType),
      value: Value(value),
      unit: Value(unit),
      measuredAt: Value(measuredAt),
      deviceName: deviceName == null && nullToAbsent
          ? const Value.absent()
          : Value(deviceName),
      deviceSerial: deviceSerial == null && nullToAbsent
          ? const Value.absent()
          : Value(deviceSerial),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
    );
  }

  factory MeasurementRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MeasurementRow(
      id: serializer.fromJson<String>(json['id']),
      tenantId: serializer.fromJson<String>(json['tenantId']),
      createdAt: serializer.fromJson<String>(json['createdAt']),
      updatedAt: serializer.fromJson<String>(json['updatedAt']),
      deletedAt: serializer.fromJson<String?>(json['deletedAt']),
      version: serializer.fromJson<int>(json['version']),
      syncStatus: serializer.fromJson<String>(json['syncStatus']),
      lastSyncedAt: serializer.fromJson<String?>(json['lastSyncedAt']),
      workOrderId: serializer.fromJson<String>(json['workOrderId']),
      installationId: serializer.fromJson<String?>(json['installationId']),
      measurementType: serializer.fromJson<String>(json['measurementType']),
      value: serializer.fromJson<double>(json['value']),
      unit: serializer.fromJson<String>(json['unit']),
      measuredAt: serializer.fromJson<String>(json['measuredAt']),
      deviceName: serializer.fromJson<String?>(json['deviceName']),
      deviceSerial: serializer.fromJson<String?>(json['deviceSerial']),
      notes: serializer.fromJson<String?>(json['notes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'tenantId': serializer.toJson<String>(tenantId),
      'createdAt': serializer.toJson<String>(createdAt),
      'updatedAt': serializer.toJson<String>(updatedAt),
      'deletedAt': serializer.toJson<String?>(deletedAt),
      'version': serializer.toJson<int>(version),
      'syncStatus': serializer.toJson<String>(syncStatus),
      'lastSyncedAt': serializer.toJson<String?>(lastSyncedAt),
      'workOrderId': serializer.toJson<String>(workOrderId),
      'installationId': serializer.toJson<String?>(installationId),
      'measurementType': serializer.toJson<String>(measurementType),
      'value': serializer.toJson<double>(value),
      'unit': serializer.toJson<String>(unit),
      'measuredAt': serializer.toJson<String>(measuredAt),
      'deviceName': serializer.toJson<String?>(deviceName),
      'deviceSerial': serializer.toJson<String?>(deviceSerial),
      'notes': serializer.toJson<String?>(notes),
    };
  }

  MeasurementRow copyWith({
    String? id,
    String? tenantId,
    String? createdAt,
    String? updatedAt,
    Value<String?> deletedAt = const Value.absent(),
    int? version,
    String? syncStatus,
    Value<String?> lastSyncedAt = const Value.absent(),
    String? workOrderId,
    Value<String?> installationId = const Value.absent(),
    String? measurementType,
    double? value,
    String? unit,
    String? measuredAt,
    Value<String?> deviceName = const Value.absent(),
    Value<String?> deviceSerial = const Value.absent(),
    Value<String?> notes = const Value.absent(),
  }) => MeasurementRow(
    id: id ?? this.id,
    tenantId: tenantId ?? this.tenantId,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    version: version ?? this.version,
    syncStatus: syncStatus ?? this.syncStatus,
    lastSyncedAt: lastSyncedAt.present ? lastSyncedAt.value : this.lastSyncedAt,
    workOrderId: workOrderId ?? this.workOrderId,
    installationId: installationId.present
        ? installationId.value
        : this.installationId,
    measurementType: measurementType ?? this.measurementType,
    value: value ?? this.value,
    unit: unit ?? this.unit,
    measuredAt: measuredAt ?? this.measuredAt,
    deviceName: deviceName.present ? deviceName.value : this.deviceName,
    deviceSerial: deviceSerial.present ? deviceSerial.value : this.deviceSerial,
    notes: notes.present ? notes.value : this.notes,
  );
  MeasurementRow copyWithCompanion(MeasurementsCompanion data) {
    return MeasurementRow(
      id: data.id.present ? data.id.value : this.id,
      tenantId: data.tenantId.present ? data.tenantId.value : this.tenantId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      version: data.version.present ? data.version.value : this.version,
      syncStatus: data.syncStatus.present
          ? data.syncStatus.value
          : this.syncStatus,
      lastSyncedAt: data.lastSyncedAt.present
          ? data.lastSyncedAt.value
          : this.lastSyncedAt,
      workOrderId: data.workOrderId.present
          ? data.workOrderId.value
          : this.workOrderId,
      installationId: data.installationId.present
          ? data.installationId.value
          : this.installationId,
      measurementType: data.measurementType.present
          ? data.measurementType.value
          : this.measurementType,
      value: data.value.present ? data.value.value : this.value,
      unit: data.unit.present ? data.unit.value : this.unit,
      measuredAt: data.measuredAt.present
          ? data.measuredAt.value
          : this.measuredAt,
      deviceName: data.deviceName.present
          ? data.deviceName.value
          : this.deviceName,
      deviceSerial: data.deviceSerial.present
          ? data.deviceSerial.value
          : this.deviceSerial,
      notes: data.notes.present ? data.notes.value : this.notes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MeasurementRow(')
          ..write('id: $id, ')
          ..write('tenantId: $tenantId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('version: $version, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('lastSyncedAt: $lastSyncedAt, ')
          ..write('workOrderId: $workOrderId, ')
          ..write('installationId: $installationId, ')
          ..write('measurementType: $measurementType, ')
          ..write('value: $value, ')
          ..write('unit: $unit, ')
          ..write('measuredAt: $measuredAt, ')
          ..write('deviceName: $deviceName, ')
          ..write('deviceSerial: $deviceSerial, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    tenantId,
    createdAt,
    updatedAt,
    deletedAt,
    version,
    syncStatus,
    lastSyncedAt,
    workOrderId,
    installationId,
    measurementType,
    value,
    unit,
    measuredAt,
    deviceName,
    deviceSerial,
    notes,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MeasurementRow &&
          other.id == this.id &&
          other.tenantId == this.tenantId &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.version == this.version &&
          other.syncStatus == this.syncStatus &&
          other.lastSyncedAt == this.lastSyncedAt &&
          other.workOrderId == this.workOrderId &&
          other.installationId == this.installationId &&
          other.measurementType == this.measurementType &&
          other.value == this.value &&
          other.unit == this.unit &&
          other.measuredAt == this.measuredAt &&
          other.deviceName == this.deviceName &&
          other.deviceSerial == this.deviceSerial &&
          other.notes == this.notes);
}

class MeasurementsCompanion extends UpdateCompanion<MeasurementRow> {
  final Value<String> id;
  final Value<String> tenantId;
  final Value<String> createdAt;
  final Value<String> updatedAt;
  final Value<String?> deletedAt;
  final Value<int> version;
  final Value<String> syncStatus;
  final Value<String?> lastSyncedAt;
  final Value<String> workOrderId;
  final Value<String?> installationId;
  final Value<String> measurementType;
  final Value<double> value;
  final Value<String> unit;
  final Value<String> measuredAt;
  final Value<String?> deviceName;
  final Value<String?> deviceSerial;
  final Value<String?> notes;
  final Value<int> rowid;
  const MeasurementsCompanion({
    this.id = const Value.absent(),
    this.tenantId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.version = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.lastSyncedAt = const Value.absent(),
    this.workOrderId = const Value.absent(),
    this.installationId = const Value.absent(),
    this.measurementType = const Value.absent(),
    this.value = const Value.absent(),
    this.unit = const Value.absent(),
    this.measuredAt = const Value.absent(),
    this.deviceName = const Value.absent(),
    this.deviceSerial = const Value.absent(),
    this.notes = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MeasurementsCompanion.insert({
    required String id,
    required String tenantId,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.version = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.lastSyncedAt = const Value.absent(),
    required String workOrderId,
    this.installationId = const Value.absent(),
    required String measurementType,
    required double value,
    required String unit,
    required String measuredAt,
    this.deviceName = const Value.absent(),
    this.deviceSerial = const Value.absent(),
    this.notes = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       tenantId = Value(tenantId),
       workOrderId = Value(workOrderId),
       measurementType = Value(measurementType),
       value = Value(value),
       unit = Value(unit),
       measuredAt = Value(measuredAt);
  static Insertable<MeasurementRow> custom({
    Expression<String>? id,
    Expression<String>? tenantId,
    Expression<String>? createdAt,
    Expression<String>? updatedAt,
    Expression<String>? deletedAt,
    Expression<int>? version,
    Expression<String>? syncStatus,
    Expression<String>? lastSyncedAt,
    Expression<String>? workOrderId,
    Expression<String>? installationId,
    Expression<String>? measurementType,
    Expression<double>? value,
    Expression<String>? unit,
    Expression<String>? measuredAt,
    Expression<String>? deviceName,
    Expression<String>? deviceSerial,
    Expression<String>? notes,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (tenantId != null) 'tenant_id': tenantId,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (version != null) 'version': version,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (lastSyncedAt != null) 'last_synced_at': lastSyncedAt,
      if (workOrderId != null) 'work_order_id': workOrderId,
      if (installationId != null) 'installation_id': installationId,
      if (measurementType != null) 'measurement_type': measurementType,
      if (value != null) 'value': value,
      if (unit != null) 'unit': unit,
      if (measuredAt != null) 'measured_at': measuredAt,
      if (deviceName != null) 'device_name': deviceName,
      if (deviceSerial != null) 'device_serial': deviceSerial,
      if (notes != null) 'notes': notes,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MeasurementsCompanion copyWith({
    Value<String>? id,
    Value<String>? tenantId,
    Value<String>? createdAt,
    Value<String>? updatedAt,
    Value<String?>? deletedAt,
    Value<int>? version,
    Value<String>? syncStatus,
    Value<String?>? lastSyncedAt,
    Value<String>? workOrderId,
    Value<String?>? installationId,
    Value<String>? measurementType,
    Value<double>? value,
    Value<String>? unit,
    Value<String>? measuredAt,
    Value<String?>? deviceName,
    Value<String?>? deviceSerial,
    Value<String?>? notes,
    Value<int>? rowid,
  }) {
    return MeasurementsCompanion(
      id: id ?? this.id,
      tenantId: tenantId ?? this.tenantId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      version: version ?? this.version,
      syncStatus: syncStatus ?? this.syncStatus,
      lastSyncedAt: lastSyncedAt ?? this.lastSyncedAt,
      workOrderId: workOrderId ?? this.workOrderId,
      installationId: installationId ?? this.installationId,
      measurementType: measurementType ?? this.measurementType,
      value: value ?? this.value,
      unit: unit ?? this.unit,
      measuredAt: measuredAt ?? this.measuredAt,
      deviceName: deviceName ?? this.deviceName,
      deviceSerial: deviceSerial ?? this.deviceSerial,
      notes: notes ?? this.notes,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (tenantId.present) {
      map['tenant_id'] = Variable<String>(tenantId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<String>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<String>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<String>(deletedAt.value);
    }
    if (version.present) {
      map['version'] = Variable<int>(version.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(syncStatus.value);
    }
    if (lastSyncedAt.present) {
      map['last_synced_at'] = Variable<String>(lastSyncedAt.value);
    }
    if (workOrderId.present) {
      map['work_order_id'] = Variable<String>(workOrderId.value);
    }
    if (installationId.present) {
      map['installation_id'] = Variable<String>(installationId.value);
    }
    if (measurementType.present) {
      map['measurement_type'] = Variable<String>(measurementType.value);
    }
    if (value.present) {
      map['value'] = Variable<double>(value.value);
    }
    if (unit.present) {
      map['unit'] = Variable<String>(unit.value);
    }
    if (measuredAt.present) {
      map['measured_at'] = Variable<String>(measuredAt.value);
    }
    if (deviceName.present) {
      map['device_name'] = Variable<String>(deviceName.value);
    }
    if (deviceSerial.present) {
      map['device_serial'] = Variable<String>(deviceSerial.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MeasurementsCompanion(')
          ..write('id: $id, ')
          ..write('tenantId: $tenantId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('version: $version, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('lastSyncedAt: $lastSyncedAt, ')
          ..write('workOrderId: $workOrderId, ')
          ..write('installationId: $installationId, ')
          ..write('measurementType: $measurementType, ')
          ..write('value: $value, ')
          ..write('unit: $unit, ')
          ..write('measuredAt: $measuredAt, ')
          ..write('deviceName: $deviceName, ')
          ..write('deviceSerial: $deviceSerial, ')
          ..write('notes: $notes, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DefectsTable extends Defects with TableInfo<$DefectsTable, DefectRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DefectsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _tenantIdMeta = const VerificationMeta(
    'tenantId',
  );
  @override
  late final GeneratedColumn<String> tenantId = GeneratedColumn<String>(
    'tenant_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<String> createdAt = GeneratedColumn<String>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: _utcNowIso,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<String> updatedAt = GeneratedColumn<String>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: _utcNowIso,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<String> deletedAt = GeneratedColumn<String>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _versionMeta = const VerificationMeta(
    'version',
  );
  @override
  late final GeneratedColumn<int> version = GeneratedColumn<int>(
    'version',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
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
    defaultValue: const Constant('synced'),
  );
  static const VerificationMeta _lastSyncedAtMeta = const VerificationMeta(
    'lastSyncedAt',
  );
  @override
  late final GeneratedColumn<String> lastSyncedAt = GeneratedColumn<String>(
    'last_synced_at',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _workOrderIdMeta = const VerificationMeta(
    'workOrderId',
  );
  @override
  late final GeneratedColumn<String> workOrderId = GeneratedColumn<String>(
    'work_order_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _installationIdMeta = const VerificationMeta(
    'installationId',
  );
  @override
  late final GeneratedColumn<String> installationId = GeneratedColumn<String>(
    'installation_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _severityMeta = const VerificationMeta(
    'severity',
  );
  @override
  late final GeneratedColumn<String> severity = GeneratedColumn<String>(
    'severity',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _recommendedActionMeta = const VerificationMeta(
    'recommendedAction',
  );
  @override
  late final GeneratedColumn<String> recommendedAction =
      GeneratedColumn<String>(
        'recommended_action',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _dueDateMeta = const VerificationMeta(
    'dueDate',
  );
  @override
  late final GeneratedColumn<String> dueDate = GeneratedColumn<String>(
    'due_date',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _resolvedMeta = const VerificationMeta(
    'resolved',
  );
  @override
  late final GeneratedColumn<bool> resolved = GeneratedColumn<bool>(
    'resolved',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("resolved" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    tenantId,
    createdAt,
    updatedAt,
    deletedAt,
    version,
    syncStatus,
    lastSyncedAt,
    workOrderId,
    installationId,
    severity,
    title,
    description,
    recommendedAction,
    dueDate,
    resolved,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'defects';
  @override
  VerificationContext validateIntegrity(
    Insertable<DefectRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('tenant_id')) {
      context.handle(
        _tenantIdMeta,
        tenantId.isAcceptableOrUnknown(data['tenant_id']!, _tenantIdMeta),
      );
    } else if (isInserting) {
      context.missing(_tenantIdMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('version')) {
      context.handle(
        _versionMeta,
        version.isAcceptableOrUnknown(data['version']!, _versionMeta),
      );
    }
    if (data.containsKey('sync_status')) {
      context.handle(
        _syncStatusMeta,
        syncStatus.isAcceptableOrUnknown(data['sync_status']!, _syncStatusMeta),
      );
    }
    if (data.containsKey('last_synced_at')) {
      context.handle(
        _lastSyncedAtMeta,
        lastSyncedAt.isAcceptableOrUnknown(
          data['last_synced_at']!,
          _lastSyncedAtMeta,
        ),
      );
    }
    if (data.containsKey('work_order_id')) {
      context.handle(
        _workOrderIdMeta,
        workOrderId.isAcceptableOrUnknown(
          data['work_order_id']!,
          _workOrderIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_workOrderIdMeta);
    }
    if (data.containsKey('installation_id')) {
      context.handle(
        _installationIdMeta,
        installationId.isAcceptableOrUnknown(
          data['installation_id']!,
          _installationIdMeta,
        ),
      );
    }
    if (data.containsKey('severity')) {
      context.handle(
        _severityMeta,
        severity.isAcceptableOrUnknown(data['severity']!, _severityMeta),
      );
    } else if (isInserting) {
      context.missing(_severityMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('recommended_action')) {
      context.handle(
        _recommendedActionMeta,
        recommendedAction.isAcceptableOrUnknown(
          data['recommended_action']!,
          _recommendedActionMeta,
        ),
      );
    }
    if (data.containsKey('due_date')) {
      context.handle(
        _dueDateMeta,
        dueDate.isAcceptableOrUnknown(data['due_date']!, _dueDateMeta),
      );
    }
    if (data.containsKey('resolved')) {
      context.handle(
        _resolvedMeta,
        resolved.isAcceptableOrUnknown(data['resolved']!, _resolvedMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DefectRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DefectRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      tenantId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tenant_id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}deleted_at'],
      ),
      version: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}version'],
      )!,
      syncStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sync_status'],
      )!,
      lastSyncedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_synced_at'],
      ),
      workOrderId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}work_order_id'],
      )!,
      installationId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}installation_id'],
      ),
      severity: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}severity'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      recommendedAction: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}recommended_action'],
      ),
      dueDate: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}due_date'],
      ),
      resolved: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}resolved'],
      )!,
    );
  }

  @override
  $DefectsTable createAlias(String alias) {
    return $DefectsTable(attachedDatabase, alias);
  }
}

class DefectRow extends DataClass implements Insertable<DefectRow> {
  final String id;
  final String tenantId;
  final String createdAt;
  final String updatedAt;
  final String? deletedAt;
  final int version;
  final String syncStatus;
  final String? lastSyncedAt;
  final String workOrderId;
  final String? installationId;
  final String severity;
  final String title;
  final String description;
  final String? recommendedAction;
  final String? dueDate;
  final bool resolved;
  const DefectRow({
    required this.id,
    required this.tenantId,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.version,
    required this.syncStatus,
    this.lastSyncedAt,
    required this.workOrderId,
    this.installationId,
    required this.severity,
    required this.title,
    required this.description,
    this.recommendedAction,
    this.dueDate,
    required this.resolved,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['tenant_id'] = Variable<String>(tenantId);
    map['created_at'] = Variable<String>(createdAt);
    map['updated_at'] = Variable<String>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<String>(deletedAt);
    }
    map['version'] = Variable<int>(version);
    map['sync_status'] = Variable<String>(syncStatus);
    if (!nullToAbsent || lastSyncedAt != null) {
      map['last_synced_at'] = Variable<String>(lastSyncedAt);
    }
    map['work_order_id'] = Variable<String>(workOrderId);
    if (!nullToAbsent || installationId != null) {
      map['installation_id'] = Variable<String>(installationId);
    }
    map['severity'] = Variable<String>(severity);
    map['title'] = Variable<String>(title);
    map['description'] = Variable<String>(description);
    if (!nullToAbsent || recommendedAction != null) {
      map['recommended_action'] = Variable<String>(recommendedAction);
    }
    if (!nullToAbsent || dueDate != null) {
      map['due_date'] = Variable<String>(dueDate);
    }
    map['resolved'] = Variable<bool>(resolved);
    return map;
  }

  DefectsCompanion toCompanion(bool nullToAbsent) {
    return DefectsCompanion(
      id: Value(id),
      tenantId: Value(tenantId),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      version: Value(version),
      syncStatus: Value(syncStatus),
      lastSyncedAt: lastSyncedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastSyncedAt),
      workOrderId: Value(workOrderId),
      installationId: installationId == null && nullToAbsent
          ? const Value.absent()
          : Value(installationId),
      severity: Value(severity),
      title: Value(title),
      description: Value(description),
      recommendedAction: recommendedAction == null && nullToAbsent
          ? const Value.absent()
          : Value(recommendedAction),
      dueDate: dueDate == null && nullToAbsent
          ? const Value.absent()
          : Value(dueDate),
      resolved: Value(resolved),
    );
  }

  factory DefectRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DefectRow(
      id: serializer.fromJson<String>(json['id']),
      tenantId: serializer.fromJson<String>(json['tenantId']),
      createdAt: serializer.fromJson<String>(json['createdAt']),
      updatedAt: serializer.fromJson<String>(json['updatedAt']),
      deletedAt: serializer.fromJson<String?>(json['deletedAt']),
      version: serializer.fromJson<int>(json['version']),
      syncStatus: serializer.fromJson<String>(json['syncStatus']),
      lastSyncedAt: serializer.fromJson<String?>(json['lastSyncedAt']),
      workOrderId: serializer.fromJson<String>(json['workOrderId']),
      installationId: serializer.fromJson<String?>(json['installationId']),
      severity: serializer.fromJson<String>(json['severity']),
      title: serializer.fromJson<String>(json['title']),
      description: serializer.fromJson<String>(json['description']),
      recommendedAction: serializer.fromJson<String?>(
        json['recommendedAction'],
      ),
      dueDate: serializer.fromJson<String?>(json['dueDate']),
      resolved: serializer.fromJson<bool>(json['resolved']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'tenantId': serializer.toJson<String>(tenantId),
      'createdAt': serializer.toJson<String>(createdAt),
      'updatedAt': serializer.toJson<String>(updatedAt),
      'deletedAt': serializer.toJson<String?>(deletedAt),
      'version': serializer.toJson<int>(version),
      'syncStatus': serializer.toJson<String>(syncStatus),
      'lastSyncedAt': serializer.toJson<String?>(lastSyncedAt),
      'workOrderId': serializer.toJson<String>(workOrderId),
      'installationId': serializer.toJson<String?>(installationId),
      'severity': serializer.toJson<String>(severity),
      'title': serializer.toJson<String>(title),
      'description': serializer.toJson<String>(description),
      'recommendedAction': serializer.toJson<String?>(recommendedAction),
      'dueDate': serializer.toJson<String?>(dueDate),
      'resolved': serializer.toJson<bool>(resolved),
    };
  }

  DefectRow copyWith({
    String? id,
    String? tenantId,
    String? createdAt,
    String? updatedAt,
    Value<String?> deletedAt = const Value.absent(),
    int? version,
    String? syncStatus,
    Value<String?> lastSyncedAt = const Value.absent(),
    String? workOrderId,
    Value<String?> installationId = const Value.absent(),
    String? severity,
    String? title,
    String? description,
    Value<String?> recommendedAction = const Value.absent(),
    Value<String?> dueDate = const Value.absent(),
    bool? resolved,
  }) => DefectRow(
    id: id ?? this.id,
    tenantId: tenantId ?? this.tenantId,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    version: version ?? this.version,
    syncStatus: syncStatus ?? this.syncStatus,
    lastSyncedAt: lastSyncedAt.present ? lastSyncedAt.value : this.lastSyncedAt,
    workOrderId: workOrderId ?? this.workOrderId,
    installationId: installationId.present
        ? installationId.value
        : this.installationId,
    severity: severity ?? this.severity,
    title: title ?? this.title,
    description: description ?? this.description,
    recommendedAction: recommendedAction.present
        ? recommendedAction.value
        : this.recommendedAction,
    dueDate: dueDate.present ? dueDate.value : this.dueDate,
    resolved: resolved ?? this.resolved,
  );
  DefectRow copyWithCompanion(DefectsCompanion data) {
    return DefectRow(
      id: data.id.present ? data.id.value : this.id,
      tenantId: data.tenantId.present ? data.tenantId.value : this.tenantId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      version: data.version.present ? data.version.value : this.version,
      syncStatus: data.syncStatus.present
          ? data.syncStatus.value
          : this.syncStatus,
      lastSyncedAt: data.lastSyncedAt.present
          ? data.lastSyncedAt.value
          : this.lastSyncedAt,
      workOrderId: data.workOrderId.present
          ? data.workOrderId.value
          : this.workOrderId,
      installationId: data.installationId.present
          ? data.installationId.value
          : this.installationId,
      severity: data.severity.present ? data.severity.value : this.severity,
      title: data.title.present ? data.title.value : this.title,
      description: data.description.present
          ? data.description.value
          : this.description,
      recommendedAction: data.recommendedAction.present
          ? data.recommendedAction.value
          : this.recommendedAction,
      dueDate: data.dueDate.present ? data.dueDate.value : this.dueDate,
      resolved: data.resolved.present ? data.resolved.value : this.resolved,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DefectRow(')
          ..write('id: $id, ')
          ..write('tenantId: $tenantId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('version: $version, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('lastSyncedAt: $lastSyncedAt, ')
          ..write('workOrderId: $workOrderId, ')
          ..write('installationId: $installationId, ')
          ..write('severity: $severity, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('recommendedAction: $recommendedAction, ')
          ..write('dueDate: $dueDate, ')
          ..write('resolved: $resolved')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    tenantId,
    createdAt,
    updatedAt,
    deletedAt,
    version,
    syncStatus,
    lastSyncedAt,
    workOrderId,
    installationId,
    severity,
    title,
    description,
    recommendedAction,
    dueDate,
    resolved,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DefectRow &&
          other.id == this.id &&
          other.tenantId == this.tenantId &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.version == this.version &&
          other.syncStatus == this.syncStatus &&
          other.lastSyncedAt == this.lastSyncedAt &&
          other.workOrderId == this.workOrderId &&
          other.installationId == this.installationId &&
          other.severity == this.severity &&
          other.title == this.title &&
          other.description == this.description &&
          other.recommendedAction == this.recommendedAction &&
          other.dueDate == this.dueDate &&
          other.resolved == this.resolved);
}

class DefectsCompanion extends UpdateCompanion<DefectRow> {
  final Value<String> id;
  final Value<String> tenantId;
  final Value<String> createdAt;
  final Value<String> updatedAt;
  final Value<String?> deletedAt;
  final Value<int> version;
  final Value<String> syncStatus;
  final Value<String?> lastSyncedAt;
  final Value<String> workOrderId;
  final Value<String?> installationId;
  final Value<String> severity;
  final Value<String> title;
  final Value<String> description;
  final Value<String?> recommendedAction;
  final Value<String?> dueDate;
  final Value<bool> resolved;
  final Value<int> rowid;
  const DefectsCompanion({
    this.id = const Value.absent(),
    this.tenantId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.version = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.lastSyncedAt = const Value.absent(),
    this.workOrderId = const Value.absent(),
    this.installationId = const Value.absent(),
    this.severity = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    this.recommendedAction = const Value.absent(),
    this.dueDate = const Value.absent(),
    this.resolved = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DefectsCompanion.insert({
    required String id,
    required String tenantId,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.version = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.lastSyncedAt = const Value.absent(),
    required String workOrderId,
    this.installationId = const Value.absent(),
    required String severity,
    required String title,
    required String description,
    this.recommendedAction = const Value.absent(),
    this.dueDate = const Value.absent(),
    this.resolved = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       tenantId = Value(tenantId),
       workOrderId = Value(workOrderId),
       severity = Value(severity),
       title = Value(title),
       description = Value(description);
  static Insertable<DefectRow> custom({
    Expression<String>? id,
    Expression<String>? tenantId,
    Expression<String>? createdAt,
    Expression<String>? updatedAt,
    Expression<String>? deletedAt,
    Expression<int>? version,
    Expression<String>? syncStatus,
    Expression<String>? lastSyncedAt,
    Expression<String>? workOrderId,
    Expression<String>? installationId,
    Expression<String>? severity,
    Expression<String>? title,
    Expression<String>? description,
    Expression<String>? recommendedAction,
    Expression<String>? dueDate,
    Expression<bool>? resolved,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (tenantId != null) 'tenant_id': tenantId,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (version != null) 'version': version,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (lastSyncedAt != null) 'last_synced_at': lastSyncedAt,
      if (workOrderId != null) 'work_order_id': workOrderId,
      if (installationId != null) 'installation_id': installationId,
      if (severity != null) 'severity': severity,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (recommendedAction != null) 'recommended_action': recommendedAction,
      if (dueDate != null) 'due_date': dueDate,
      if (resolved != null) 'resolved': resolved,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DefectsCompanion copyWith({
    Value<String>? id,
    Value<String>? tenantId,
    Value<String>? createdAt,
    Value<String>? updatedAt,
    Value<String?>? deletedAt,
    Value<int>? version,
    Value<String>? syncStatus,
    Value<String?>? lastSyncedAt,
    Value<String>? workOrderId,
    Value<String?>? installationId,
    Value<String>? severity,
    Value<String>? title,
    Value<String>? description,
    Value<String?>? recommendedAction,
    Value<String?>? dueDate,
    Value<bool>? resolved,
    Value<int>? rowid,
  }) {
    return DefectsCompanion(
      id: id ?? this.id,
      tenantId: tenantId ?? this.tenantId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      version: version ?? this.version,
      syncStatus: syncStatus ?? this.syncStatus,
      lastSyncedAt: lastSyncedAt ?? this.lastSyncedAt,
      workOrderId: workOrderId ?? this.workOrderId,
      installationId: installationId ?? this.installationId,
      severity: severity ?? this.severity,
      title: title ?? this.title,
      description: description ?? this.description,
      recommendedAction: recommendedAction ?? this.recommendedAction,
      dueDate: dueDate ?? this.dueDate,
      resolved: resolved ?? this.resolved,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (tenantId.present) {
      map['tenant_id'] = Variable<String>(tenantId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<String>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<String>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<String>(deletedAt.value);
    }
    if (version.present) {
      map['version'] = Variable<int>(version.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(syncStatus.value);
    }
    if (lastSyncedAt.present) {
      map['last_synced_at'] = Variable<String>(lastSyncedAt.value);
    }
    if (workOrderId.present) {
      map['work_order_id'] = Variable<String>(workOrderId.value);
    }
    if (installationId.present) {
      map['installation_id'] = Variable<String>(installationId.value);
    }
    if (severity.present) {
      map['severity'] = Variable<String>(severity.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (recommendedAction.present) {
      map['recommended_action'] = Variable<String>(recommendedAction.value);
    }
    if (dueDate.present) {
      map['due_date'] = Variable<String>(dueDate.value);
    }
    if (resolved.present) {
      map['resolved'] = Variable<bool>(resolved.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DefectsCompanion(')
          ..write('id: $id, ')
          ..write('tenantId: $tenantId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('version: $version, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('lastSyncedAt: $lastSyncedAt, ')
          ..write('workOrderId: $workOrderId, ')
          ..write('installationId: $installationId, ')
          ..write('severity: $severity, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('recommendedAction: $recommendedAction, ')
          ..write('dueDate: $dueDate, ')
          ..write('resolved: $resolved, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PhotosTable extends Photos with TableInfo<$PhotosTable, PhotoRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PhotosTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _tenantIdMeta = const VerificationMeta(
    'tenantId',
  );
  @override
  late final GeneratedColumn<String> tenantId = GeneratedColumn<String>(
    'tenant_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<String> createdAt = GeneratedColumn<String>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: _utcNowIso,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<String> updatedAt = GeneratedColumn<String>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: _utcNowIso,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<String> deletedAt = GeneratedColumn<String>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _versionMeta = const VerificationMeta(
    'version',
  );
  @override
  late final GeneratedColumn<int> version = GeneratedColumn<int>(
    'version',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
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
    defaultValue: const Constant('synced'),
  );
  static const VerificationMeta _lastSyncedAtMeta = const VerificationMeta(
    'lastSyncedAt',
  );
  @override
  late final GeneratedColumn<String> lastSyncedAt = GeneratedColumn<String>(
    'last_synced_at',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _workOrderIdMeta = const VerificationMeta(
    'workOrderId',
  );
  @override
  late final GeneratedColumn<String> workOrderId = GeneratedColumn<String>(
    'work_order_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _objectIdMeta = const VerificationMeta(
    'objectId',
  );
  @override
  late final GeneratedColumn<String> objectId = GeneratedColumn<String>(
    'object_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _installationIdMeta = const VerificationMeta(
    'installationId',
  );
  @override
  late final GeneratedColumn<String> installationId = GeneratedColumn<String>(
    'installation_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _defectIdMeta = const VerificationMeta(
    'defectId',
  );
  @override
  late final GeneratedColumn<String> defectId = GeneratedColumn<String>(
    'defect_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _localPathMeta = const VerificationMeta(
    'localPath',
  );
  @override
  late final GeneratedColumn<String> localPath = GeneratedColumn<String>(
    'local_path',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _remoteUrlMeta = const VerificationMeta(
    'remoteUrl',
  );
  @override
  late final GeneratedColumn<String> remoteUrl = GeneratedColumn<String>(
    'remote_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _fileNameMeta = const VerificationMeta(
    'fileName',
  );
  @override
  late final GeneratedColumn<String> fileName = GeneratedColumn<String>(
    'file_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _mimeTypeMeta = const VerificationMeta(
    'mimeType',
  );
  @override
  late final GeneratedColumn<String> mimeType = GeneratedColumn<String>(
    'mime_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sizeBytesMeta = const VerificationMeta(
    'sizeBytes',
  );
  @override
  late final GeneratedColumn<int> sizeBytes = GeneratedColumn<int>(
    'size_bytes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _captionMeta = const VerificationMeta(
    'caption',
  );
  @override
  late final GeneratedColumn<String> caption = GeneratedColumn<String>(
    'caption',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _takenAtMeta = const VerificationMeta(
    'takenAt',
  );
  @override
  late final GeneratedColumn<String> takenAt = GeneratedColumn<String>(
    'taken_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _uploadStatusMeta = const VerificationMeta(
    'uploadStatus',
  );
  @override
  late final GeneratedColumn<String> uploadStatus = GeneratedColumn<String>(
    'upload_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    tenantId,
    createdAt,
    updatedAt,
    deletedAt,
    version,
    syncStatus,
    lastSyncedAt,
    workOrderId,
    objectId,
    installationId,
    defectId,
    localPath,
    remoteUrl,
    fileName,
    mimeType,
    sizeBytes,
    caption,
    takenAt,
    uploadStatus,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'photos';
  @override
  VerificationContext validateIntegrity(
    Insertable<PhotoRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('tenant_id')) {
      context.handle(
        _tenantIdMeta,
        tenantId.isAcceptableOrUnknown(data['tenant_id']!, _tenantIdMeta),
      );
    } else if (isInserting) {
      context.missing(_tenantIdMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('version')) {
      context.handle(
        _versionMeta,
        version.isAcceptableOrUnknown(data['version']!, _versionMeta),
      );
    }
    if (data.containsKey('sync_status')) {
      context.handle(
        _syncStatusMeta,
        syncStatus.isAcceptableOrUnknown(data['sync_status']!, _syncStatusMeta),
      );
    }
    if (data.containsKey('last_synced_at')) {
      context.handle(
        _lastSyncedAtMeta,
        lastSyncedAt.isAcceptableOrUnknown(
          data['last_synced_at']!,
          _lastSyncedAtMeta,
        ),
      );
    }
    if (data.containsKey('work_order_id')) {
      context.handle(
        _workOrderIdMeta,
        workOrderId.isAcceptableOrUnknown(
          data['work_order_id']!,
          _workOrderIdMeta,
        ),
      );
    }
    if (data.containsKey('object_id')) {
      context.handle(
        _objectIdMeta,
        objectId.isAcceptableOrUnknown(data['object_id']!, _objectIdMeta),
      );
    }
    if (data.containsKey('installation_id')) {
      context.handle(
        _installationIdMeta,
        installationId.isAcceptableOrUnknown(
          data['installation_id']!,
          _installationIdMeta,
        ),
      );
    }
    if (data.containsKey('defect_id')) {
      context.handle(
        _defectIdMeta,
        defectId.isAcceptableOrUnknown(data['defect_id']!, _defectIdMeta),
      );
    }
    if (data.containsKey('local_path')) {
      context.handle(
        _localPathMeta,
        localPath.isAcceptableOrUnknown(data['local_path']!, _localPathMeta),
      );
    } else if (isInserting) {
      context.missing(_localPathMeta);
    }
    if (data.containsKey('remote_url')) {
      context.handle(
        _remoteUrlMeta,
        remoteUrl.isAcceptableOrUnknown(data['remote_url']!, _remoteUrlMeta),
      );
    }
    if (data.containsKey('file_name')) {
      context.handle(
        _fileNameMeta,
        fileName.isAcceptableOrUnknown(data['file_name']!, _fileNameMeta),
      );
    } else if (isInserting) {
      context.missing(_fileNameMeta);
    }
    if (data.containsKey('mime_type')) {
      context.handle(
        _mimeTypeMeta,
        mimeType.isAcceptableOrUnknown(data['mime_type']!, _mimeTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_mimeTypeMeta);
    }
    if (data.containsKey('size_bytes')) {
      context.handle(
        _sizeBytesMeta,
        sizeBytes.isAcceptableOrUnknown(data['size_bytes']!, _sizeBytesMeta),
      );
    } else if (isInserting) {
      context.missing(_sizeBytesMeta);
    }
    if (data.containsKey('caption')) {
      context.handle(
        _captionMeta,
        caption.isAcceptableOrUnknown(data['caption']!, _captionMeta),
      );
    }
    if (data.containsKey('taken_at')) {
      context.handle(
        _takenAtMeta,
        takenAt.isAcceptableOrUnknown(data['taken_at']!, _takenAtMeta),
      );
    } else if (isInserting) {
      context.missing(_takenAtMeta);
    }
    if (data.containsKey('upload_status')) {
      context.handle(
        _uploadStatusMeta,
        uploadStatus.isAcceptableOrUnknown(
          data['upload_status']!,
          _uploadStatusMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_uploadStatusMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PhotoRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PhotoRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      tenantId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tenant_id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}deleted_at'],
      ),
      version: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}version'],
      )!,
      syncStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sync_status'],
      )!,
      lastSyncedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_synced_at'],
      ),
      workOrderId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}work_order_id'],
      ),
      objectId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}object_id'],
      ),
      installationId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}installation_id'],
      ),
      defectId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}defect_id'],
      ),
      localPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}local_path'],
      )!,
      remoteUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}remote_url'],
      ),
      fileName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}file_name'],
      )!,
      mimeType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}mime_type'],
      )!,
      sizeBytes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}size_bytes'],
      )!,
      caption: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}caption'],
      ),
      takenAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}taken_at'],
      )!,
      uploadStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}upload_status'],
      )!,
    );
  }

  @override
  $PhotosTable createAlias(String alias) {
    return $PhotosTable(attachedDatabase, alias);
  }
}

class PhotoRow extends DataClass implements Insertable<PhotoRow> {
  final String id;
  final String tenantId;
  final String createdAt;
  final String updatedAt;
  final String? deletedAt;
  final int version;
  final String syncStatus;
  final String? lastSyncedAt;
  final String? workOrderId;
  final String? objectId;
  final String? installationId;
  final String? defectId;
  final String localPath;
  final String? remoteUrl;
  final String fileName;
  final String mimeType;
  final int sizeBytes;
  final String? caption;
  final String takenAt;
  final String uploadStatus;
  const PhotoRow({
    required this.id,
    required this.tenantId,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.version,
    required this.syncStatus,
    this.lastSyncedAt,
    this.workOrderId,
    this.objectId,
    this.installationId,
    this.defectId,
    required this.localPath,
    this.remoteUrl,
    required this.fileName,
    required this.mimeType,
    required this.sizeBytes,
    this.caption,
    required this.takenAt,
    required this.uploadStatus,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['tenant_id'] = Variable<String>(tenantId);
    map['created_at'] = Variable<String>(createdAt);
    map['updated_at'] = Variable<String>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<String>(deletedAt);
    }
    map['version'] = Variable<int>(version);
    map['sync_status'] = Variable<String>(syncStatus);
    if (!nullToAbsent || lastSyncedAt != null) {
      map['last_synced_at'] = Variable<String>(lastSyncedAt);
    }
    if (!nullToAbsent || workOrderId != null) {
      map['work_order_id'] = Variable<String>(workOrderId);
    }
    if (!nullToAbsent || objectId != null) {
      map['object_id'] = Variable<String>(objectId);
    }
    if (!nullToAbsent || installationId != null) {
      map['installation_id'] = Variable<String>(installationId);
    }
    if (!nullToAbsent || defectId != null) {
      map['defect_id'] = Variable<String>(defectId);
    }
    map['local_path'] = Variable<String>(localPath);
    if (!nullToAbsent || remoteUrl != null) {
      map['remote_url'] = Variable<String>(remoteUrl);
    }
    map['file_name'] = Variable<String>(fileName);
    map['mime_type'] = Variable<String>(mimeType);
    map['size_bytes'] = Variable<int>(sizeBytes);
    if (!nullToAbsent || caption != null) {
      map['caption'] = Variable<String>(caption);
    }
    map['taken_at'] = Variable<String>(takenAt);
    map['upload_status'] = Variable<String>(uploadStatus);
    return map;
  }

  PhotosCompanion toCompanion(bool nullToAbsent) {
    return PhotosCompanion(
      id: Value(id),
      tenantId: Value(tenantId),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      version: Value(version),
      syncStatus: Value(syncStatus),
      lastSyncedAt: lastSyncedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastSyncedAt),
      workOrderId: workOrderId == null && nullToAbsent
          ? const Value.absent()
          : Value(workOrderId),
      objectId: objectId == null && nullToAbsent
          ? const Value.absent()
          : Value(objectId),
      installationId: installationId == null && nullToAbsent
          ? const Value.absent()
          : Value(installationId),
      defectId: defectId == null && nullToAbsent
          ? const Value.absent()
          : Value(defectId),
      localPath: Value(localPath),
      remoteUrl: remoteUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(remoteUrl),
      fileName: Value(fileName),
      mimeType: Value(mimeType),
      sizeBytes: Value(sizeBytes),
      caption: caption == null && nullToAbsent
          ? const Value.absent()
          : Value(caption),
      takenAt: Value(takenAt),
      uploadStatus: Value(uploadStatus),
    );
  }

  factory PhotoRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PhotoRow(
      id: serializer.fromJson<String>(json['id']),
      tenantId: serializer.fromJson<String>(json['tenantId']),
      createdAt: serializer.fromJson<String>(json['createdAt']),
      updatedAt: serializer.fromJson<String>(json['updatedAt']),
      deletedAt: serializer.fromJson<String?>(json['deletedAt']),
      version: serializer.fromJson<int>(json['version']),
      syncStatus: serializer.fromJson<String>(json['syncStatus']),
      lastSyncedAt: serializer.fromJson<String?>(json['lastSyncedAt']),
      workOrderId: serializer.fromJson<String?>(json['workOrderId']),
      objectId: serializer.fromJson<String?>(json['objectId']),
      installationId: serializer.fromJson<String?>(json['installationId']),
      defectId: serializer.fromJson<String?>(json['defectId']),
      localPath: serializer.fromJson<String>(json['localPath']),
      remoteUrl: serializer.fromJson<String?>(json['remoteUrl']),
      fileName: serializer.fromJson<String>(json['fileName']),
      mimeType: serializer.fromJson<String>(json['mimeType']),
      sizeBytes: serializer.fromJson<int>(json['sizeBytes']),
      caption: serializer.fromJson<String?>(json['caption']),
      takenAt: serializer.fromJson<String>(json['takenAt']),
      uploadStatus: serializer.fromJson<String>(json['uploadStatus']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'tenantId': serializer.toJson<String>(tenantId),
      'createdAt': serializer.toJson<String>(createdAt),
      'updatedAt': serializer.toJson<String>(updatedAt),
      'deletedAt': serializer.toJson<String?>(deletedAt),
      'version': serializer.toJson<int>(version),
      'syncStatus': serializer.toJson<String>(syncStatus),
      'lastSyncedAt': serializer.toJson<String?>(lastSyncedAt),
      'workOrderId': serializer.toJson<String?>(workOrderId),
      'objectId': serializer.toJson<String?>(objectId),
      'installationId': serializer.toJson<String?>(installationId),
      'defectId': serializer.toJson<String?>(defectId),
      'localPath': serializer.toJson<String>(localPath),
      'remoteUrl': serializer.toJson<String?>(remoteUrl),
      'fileName': serializer.toJson<String>(fileName),
      'mimeType': serializer.toJson<String>(mimeType),
      'sizeBytes': serializer.toJson<int>(sizeBytes),
      'caption': serializer.toJson<String?>(caption),
      'takenAt': serializer.toJson<String>(takenAt),
      'uploadStatus': serializer.toJson<String>(uploadStatus),
    };
  }

  PhotoRow copyWith({
    String? id,
    String? tenantId,
    String? createdAt,
    String? updatedAt,
    Value<String?> deletedAt = const Value.absent(),
    int? version,
    String? syncStatus,
    Value<String?> lastSyncedAt = const Value.absent(),
    Value<String?> workOrderId = const Value.absent(),
    Value<String?> objectId = const Value.absent(),
    Value<String?> installationId = const Value.absent(),
    Value<String?> defectId = const Value.absent(),
    String? localPath,
    Value<String?> remoteUrl = const Value.absent(),
    String? fileName,
    String? mimeType,
    int? sizeBytes,
    Value<String?> caption = const Value.absent(),
    String? takenAt,
    String? uploadStatus,
  }) => PhotoRow(
    id: id ?? this.id,
    tenantId: tenantId ?? this.tenantId,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    version: version ?? this.version,
    syncStatus: syncStatus ?? this.syncStatus,
    lastSyncedAt: lastSyncedAt.present ? lastSyncedAt.value : this.lastSyncedAt,
    workOrderId: workOrderId.present ? workOrderId.value : this.workOrderId,
    objectId: objectId.present ? objectId.value : this.objectId,
    installationId: installationId.present
        ? installationId.value
        : this.installationId,
    defectId: defectId.present ? defectId.value : this.defectId,
    localPath: localPath ?? this.localPath,
    remoteUrl: remoteUrl.present ? remoteUrl.value : this.remoteUrl,
    fileName: fileName ?? this.fileName,
    mimeType: mimeType ?? this.mimeType,
    sizeBytes: sizeBytes ?? this.sizeBytes,
    caption: caption.present ? caption.value : this.caption,
    takenAt: takenAt ?? this.takenAt,
    uploadStatus: uploadStatus ?? this.uploadStatus,
  );
  PhotoRow copyWithCompanion(PhotosCompanion data) {
    return PhotoRow(
      id: data.id.present ? data.id.value : this.id,
      tenantId: data.tenantId.present ? data.tenantId.value : this.tenantId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      version: data.version.present ? data.version.value : this.version,
      syncStatus: data.syncStatus.present
          ? data.syncStatus.value
          : this.syncStatus,
      lastSyncedAt: data.lastSyncedAt.present
          ? data.lastSyncedAt.value
          : this.lastSyncedAt,
      workOrderId: data.workOrderId.present
          ? data.workOrderId.value
          : this.workOrderId,
      objectId: data.objectId.present ? data.objectId.value : this.objectId,
      installationId: data.installationId.present
          ? data.installationId.value
          : this.installationId,
      defectId: data.defectId.present ? data.defectId.value : this.defectId,
      localPath: data.localPath.present ? data.localPath.value : this.localPath,
      remoteUrl: data.remoteUrl.present ? data.remoteUrl.value : this.remoteUrl,
      fileName: data.fileName.present ? data.fileName.value : this.fileName,
      mimeType: data.mimeType.present ? data.mimeType.value : this.mimeType,
      sizeBytes: data.sizeBytes.present ? data.sizeBytes.value : this.sizeBytes,
      caption: data.caption.present ? data.caption.value : this.caption,
      takenAt: data.takenAt.present ? data.takenAt.value : this.takenAt,
      uploadStatus: data.uploadStatus.present
          ? data.uploadStatus.value
          : this.uploadStatus,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PhotoRow(')
          ..write('id: $id, ')
          ..write('tenantId: $tenantId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('version: $version, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('lastSyncedAt: $lastSyncedAt, ')
          ..write('workOrderId: $workOrderId, ')
          ..write('objectId: $objectId, ')
          ..write('installationId: $installationId, ')
          ..write('defectId: $defectId, ')
          ..write('localPath: $localPath, ')
          ..write('remoteUrl: $remoteUrl, ')
          ..write('fileName: $fileName, ')
          ..write('mimeType: $mimeType, ')
          ..write('sizeBytes: $sizeBytes, ')
          ..write('caption: $caption, ')
          ..write('takenAt: $takenAt, ')
          ..write('uploadStatus: $uploadStatus')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    tenantId,
    createdAt,
    updatedAt,
    deletedAt,
    version,
    syncStatus,
    lastSyncedAt,
    workOrderId,
    objectId,
    installationId,
    defectId,
    localPath,
    remoteUrl,
    fileName,
    mimeType,
    sizeBytes,
    caption,
    takenAt,
    uploadStatus,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PhotoRow &&
          other.id == this.id &&
          other.tenantId == this.tenantId &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.version == this.version &&
          other.syncStatus == this.syncStatus &&
          other.lastSyncedAt == this.lastSyncedAt &&
          other.workOrderId == this.workOrderId &&
          other.objectId == this.objectId &&
          other.installationId == this.installationId &&
          other.defectId == this.defectId &&
          other.localPath == this.localPath &&
          other.remoteUrl == this.remoteUrl &&
          other.fileName == this.fileName &&
          other.mimeType == this.mimeType &&
          other.sizeBytes == this.sizeBytes &&
          other.caption == this.caption &&
          other.takenAt == this.takenAt &&
          other.uploadStatus == this.uploadStatus);
}

class PhotosCompanion extends UpdateCompanion<PhotoRow> {
  final Value<String> id;
  final Value<String> tenantId;
  final Value<String> createdAt;
  final Value<String> updatedAt;
  final Value<String?> deletedAt;
  final Value<int> version;
  final Value<String> syncStatus;
  final Value<String?> lastSyncedAt;
  final Value<String?> workOrderId;
  final Value<String?> objectId;
  final Value<String?> installationId;
  final Value<String?> defectId;
  final Value<String> localPath;
  final Value<String?> remoteUrl;
  final Value<String> fileName;
  final Value<String> mimeType;
  final Value<int> sizeBytes;
  final Value<String?> caption;
  final Value<String> takenAt;
  final Value<String> uploadStatus;
  final Value<int> rowid;
  const PhotosCompanion({
    this.id = const Value.absent(),
    this.tenantId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.version = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.lastSyncedAt = const Value.absent(),
    this.workOrderId = const Value.absent(),
    this.objectId = const Value.absent(),
    this.installationId = const Value.absent(),
    this.defectId = const Value.absent(),
    this.localPath = const Value.absent(),
    this.remoteUrl = const Value.absent(),
    this.fileName = const Value.absent(),
    this.mimeType = const Value.absent(),
    this.sizeBytes = const Value.absent(),
    this.caption = const Value.absent(),
    this.takenAt = const Value.absent(),
    this.uploadStatus = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PhotosCompanion.insert({
    required String id,
    required String tenantId,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.version = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.lastSyncedAt = const Value.absent(),
    this.workOrderId = const Value.absent(),
    this.objectId = const Value.absent(),
    this.installationId = const Value.absent(),
    this.defectId = const Value.absent(),
    required String localPath,
    this.remoteUrl = const Value.absent(),
    required String fileName,
    required String mimeType,
    required int sizeBytes,
    this.caption = const Value.absent(),
    required String takenAt,
    required String uploadStatus,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       tenantId = Value(tenantId),
       localPath = Value(localPath),
       fileName = Value(fileName),
       mimeType = Value(mimeType),
       sizeBytes = Value(sizeBytes),
       takenAt = Value(takenAt),
       uploadStatus = Value(uploadStatus);
  static Insertable<PhotoRow> custom({
    Expression<String>? id,
    Expression<String>? tenantId,
    Expression<String>? createdAt,
    Expression<String>? updatedAt,
    Expression<String>? deletedAt,
    Expression<int>? version,
    Expression<String>? syncStatus,
    Expression<String>? lastSyncedAt,
    Expression<String>? workOrderId,
    Expression<String>? objectId,
    Expression<String>? installationId,
    Expression<String>? defectId,
    Expression<String>? localPath,
    Expression<String>? remoteUrl,
    Expression<String>? fileName,
    Expression<String>? mimeType,
    Expression<int>? sizeBytes,
    Expression<String>? caption,
    Expression<String>? takenAt,
    Expression<String>? uploadStatus,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (tenantId != null) 'tenant_id': tenantId,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (version != null) 'version': version,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (lastSyncedAt != null) 'last_synced_at': lastSyncedAt,
      if (workOrderId != null) 'work_order_id': workOrderId,
      if (objectId != null) 'object_id': objectId,
      if (installationId != null) 'installation_id': installationId,
      if (defectId != null) 'defect_id': defectId,
      if (localPath != null) 'local_path': localPath,
      if (remoteUrl != null) 'remote_url': remoteUrl,
      if (fileName != null) 'file_name': fileName,
      if (mimeType != null) 'mime_type': mimeType,
      if (sizeBytes != null) 'size_bytes': sizeBytes,
      if (caption != null) 'caption': caption,
      if (takenAt != null) 'taken_at': takenAt,
      if (uploadStatus != null) 'upload_status': uploadStatus,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PhotosCompanion copyWith({
    Value<String>? id,
    Value<String>? tenantId,
    Value<String>? createdAt,
    Value<String>? updatedAt,
    Value<String?>? deletedAt,
    Value<int>? version,
    Value<String>? syncStatus,
    Value<String?>? lastSyncedAt,
    Value<String?>? workOrderId,
    Value<String?>? objectId,
    Value<String?>? installationId,
    Value<String?>? defectId,
    Value<String>? localPath,
    Value<String?>? remoteUrl,
    Value<String>? fileName,
    Value<String>? mimeType,
    Value<int>? sizeBytes,
    Value<String?>? caption,
    Value<String>? takenAt,
    Value<String>? uploadStatus,
    Value<int>? rowid,
  }) {
    return PhotosCompanion(
      id: id ?? this.id,
      tenantId: tenantId ?? this.tenantId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      version: version ?? this.version,
      syncStatus: syncStatus ?? this.syncStatus,
      lastSyncedAt: lastSyncedAt ?? this.lastSyncedAt,
      workOrderId: workOrderId ?? this.workOrderId,
      objectId: objectId ?? this.objectId,
      installationId: installationId ?? this.installationId,
      defectId: defectId ?? this.defectId,
      localPath: localPath ?? this.localPath,
      remoteUrl: remoteUrl ?? this.remoteUrl,
      fileName: fileName ?? this.fileName,
      mimeType: mimeType ?? this.mimeType,
      sizeBytes: sizeBytes ?? this.sizeBytes,
      caption: caption ?? this.caption,
      takenAt: takenAt ?? this.takenAt,
      uploadStatus: uploadStatus ?? this.uploadStatus,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (tenantId.present) {
      map['tenant_id'] = Variable<String>(tenantId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<String>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<String>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<String>(deletedAt.value);
    }
    if (version.present) {
      map['version'] = Variable<int>(version.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(syncStatus.value);
    }
    if (lastSyncedAt.present) {
      map['last_synced_at'] = Variable<String>(lastSyncedAt.value);
    }
    if (workOrderId.present) {
      map['work_order_id'] = Variable<String>(workOrderId.value);
    }
    if (objectId.present) {
      map['object_id'] = Variable<String>(objectId.value);
    }
    if (installationId.present) {
      map['installation_id'] = Variable<String>(installationId.value);
    }
    if (defectId.present) {
      map['defect_id'] = Variable<String>(defectId.value);
    }
    if (localPath.present) {
      map['local_path'] = Variable<String>(localPath.value);
    }
    if (remoteUrl.present) {
      map['remote_url'] = Variable<String>(remoteUrl.value);
    }
    if (fileName.present) {
      map['file_name'] = Variable<String>(fileName.value);
    }
    if (mimeType.present) {
      map['mime_type'] = Variable<String>(mimeType.value);
    }
    if (sizeBytes.present) {
      map['size_bytes'] = Variable<int>(sizeBytes.value);
    }
    if (caption.present) {
      map['caption'] = Variable<String>(caption.value);
    }
    if (takenAt.present) {
      map['taken_at'] = Variable<String>(takenAt.value);
    }
    if (uploadStatus.present) {
      map['upload_status'] = Variable<String>(uploadStatus.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PhotosCompanion(')
          ..write('id: $id, ')
          ..write('tenantId: $tenantId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('version: $version, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('lastSyncedAt: $lastSyncedAt, ')
          ..write('workOrderId: $workOrderId, ')
          ..write('objectId: $objectId, ')
          ..write('installationId: $installationId, ')
          ..write('defectId: $defectId, ')
          ..write('localPath: $localPath, ')
          ..write('remoteUrl: $remoteUrl, ')
          ..write('fileName: $fileName, ')
          ..write('mimeType: $mimeType, ')
          ..write('sizeBytes: $sizeBytes, ')
          ..write('caption: $caption, ')
          ..write('takenAt: $takenAt, ')
          ..write('uploadStatus: $uploadStatus, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TimeEntriesTable extends TimeEntries
    with TableInfo<$TimeEntriesTable, TimeEntryRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TimeEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _tenantIdMeta = const VerificationMeta(
    'tenantId',
  );
  @override
  late final GeneratedColumn<String> tenantId = GeneratedColumn<String>(
    'tenant_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<String> createdAt = GeneratedColumn<String>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: _utcNowIso,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<String> updatedAt = GeneratedColumn<String>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: _utcNowIso,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<String> deletedAt = GeneratedColumn<String>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _versionMeta = const VerificationMeta(
    'version',
  );
  @override
  late final GeneratedColumn<int> version = GeneratedColumn<int>(
    'version',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
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
    defaultValue: const Constant('synced'),
  );
  static const VerificationMeta _lastSyncedAtMeta = const VerificationMeta(
    'lastSyncedAt',
  );
  @override
  late final GeneratedColumn<String> lastSyncedAt = GeneratedColumn<String>(
    'last_synced_at',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _workOrderIdMeta = const VerificationMeta(
    'workOrderId',
  );
  @override
  late final GeneratedColumn<String> workOrderId = GeneratedColumn<String>(
    'work_order_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _startTimeMeta = const VerificationMeta(
    'startTime',
  );
  @override
  late final GeneratedColumn<String> startTime = GeneratedColumn<String>(
    'start_time',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _endTimeMeta = const VerificationMeta(
    'endTime',
  );
  @override
  late final GeneratedColumn<String> endTime = GeneratedColumn<String>(
    'end_time',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _durationMinutesMeta = const VerificationMeta(
    'durationMinutes',
  );
  @override
  late final GeneratedColumn<int> durationMinutes = GeneratedColumn<int>(
    'duration_minutes',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    tenantId,
    createdAt,
    updatedAt,
    deletedAt,
    version,
    syncStatus,
    lastSyncedAt,
    workOrderId,
    userId,
    type,
    startTime,
    endTime,
    durationMinutes,
    notes,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'time_entries';
  @override
  VerificationContext validateIntegrity(
    Insertable<TimeEntryRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('tenant_id')) {
      context.handle(
        _tenantIdMeta,
        tenantId.isAcceptableOrUnknown(data['tenant_id']!, _tenantIdMeta),
      );
    } else if (isInserting) {
      context.missing(_tenantIdMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('version')) {
      context.handle(
        _versionMeta,
        version.isAcceptableOrUnknown(data['version']!, _versionMeta),
      );
    }
    if (data.containsKey('sync_status')) {
      context.handle(
        _syncStatusMeta,
        syncStatus.isAcceptableOrUnknown(data['sync_status']!, _syncStatusMeta),
      );
    }
    if (data.containsKey('last_synced_at')) {
      context.handle(
        _lastSyncedAtMeta,
        lastSyncedAt.isAcceptableOrUnknown(
          data['last_synced_at']!,
          _lastSyncedAtMeta,
        ),
      );
    }
    if (data.containsKey('work_order_id')) {
      context.handle(
        _workOrderIdMeta,
        workOrderId.isAcceptableOrUnknown(
          data['work_order_id']!,
          _workOrderIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_workOrderIdMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('start_time')) {
      context.handle(
        _startTimeMeta,
        startTime.isAcceptableOrUnknown(data['start_time']!, _startTimeMeta),
      );
    } else if (isInserting) {
      context.missing(_startTimeMeta);
    }
    if (data.containsKey('end_time')) {
      context.handle(
        _endTimeMeta,
        endTime.isAcceptableOrUnknown(data['end_time']!, _endTimeMeta),
      );
    }
    if (data.containsKey('duration_minutes')) {
      context.handle(
        _durationMinutesMeta,
        durationMinutes.isAcceptableOrUnknown(
          data['duration_minutes']!,
          _durationMinutesMeta,
        ),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TimeEntryRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TimeEntryRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      tenantId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tenant_id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}deleted_at'],
      ),
      version: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}version'],
      )!,
      syncStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sync_status'],
      )!,
      lastSyncedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_synced_at'],
      ),
      workOrderId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}work_order_id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      startTime: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}start_time'],
      )!,
      endTime: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}end_time'],
      ),
      durationMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}duration_minutes'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
    );
  }

  @override
  $TimeEntriesTable createAlias(String alias) {
    return $TimeEntriesTable(attachedDatabase, alias);
  }
}

class TimeEntryRow extends DataClass implements Insertable<TimeEntryRow> {
  final String id;
  final String tenantId;
  final String createdAt;
  final String updatedAt;
  final String? deletedAt;
  final int version;
  final String syncStatus;
  final String? lastSyncedAt;
  final String workOrderId;
  final String userId;
  final String type;
  final String startTime;
  final String? endTime;
  final int? durationMinutes;
  final String? notes;
  const TimeEntryRow({
    required this.id,
    required this.tenantId,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.version,
    required this.syncStatus,
    this.lastSyncedAt,
    required this.workOrderId,
    required this.userId,
    required this.type,
    required this.startTime,
    this.endTime,
    this.durationMinutes,
    this.notes,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['tenant_id'] = Variable<String>(tenantId);
    map['created_at'] = Variable<String>(createdAt);
    map['updated_at'] = Variable<String>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<String>(deletedAt);
    }
    map['version'] = Variable<int>(version);
    map['sync_status'] = Variable<String>(syncStatus);
    if (!nullToAbsent || lastSyncedAt != null) {
      map['last_synced_at'] = Variable<String>(lastSyncedAt);
    }
    map['work_order_id'] = Variable<String>(workOrderId);
    map['user_id'] = Variable<String>(userId);
    map['type'] = Variable<String>(type);
    map['start_time'] = Variable<String>(startTime);
    if (!nullToAbsent || endTime != null) {
      map['end_time'] = Variable<String>(endTime);
    }
    if (!nullToAbsent || durationMinutes != null) {
      map['duration_minutes'] = Variable<int>(durationMinutes);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    return map;
  }

  TimeEntriesCompanion toCompanion(bool nullToAbsent) {
    return TimeEntriesCompanion(
      id: Value(id),
      tenantId: Value(tenantId),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      version: Value(version),
      syncStatus: Value(syncStatus),
      lastSyncedAt: lastSyncedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastSyncedAt),
      workOrderId: Value(workOrderId),
      userId: Value(userId),
      type: Value(type),
      startTime: Value(startTime),
      endTime: endTime == null && nullToAbsent
          ? const Value.absent()
          : Value(endTime),
      durationMinutes: durationMinutes == null && nullToAbsent
          ? const Value.absent()
          : Value(durationMinutes),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
    );
  }

  factory TimeEntryRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TimeEntryRow(
      id: serializer.fromJson<String>(json['id']),
      tenantId: serializer.fromJson<String>(json['tenantId']),
      createdAt: serializer.fromJson<String>(json['createdAt']),
      updatedAt: serializer.fromJson<String>(json['updatedAt']),
      deletedAt: serializer.fromJson<String?>(json['deletedAt']),
      version: serializer.fromJson<int>(json['version']),
      syncStatus: serializer.fromJson<String>(json['syncStatus']),
      lastSyncedAt: serializer.fromJson<String?>(json['lastSyncedAt']),
      workOrderId: serializer.fromJson<String>(json['workOrderId']),
      userId: serializer.fromJson<String>(json['userId']),
      type: serializer.fromJson<String>(json['type']),
      startTime: serializer.fromJson<String>(json['startTime']),
      endTime: serializer.fromJson<String?>(json['endTime']),
      durationMinutes: serializer.fromJson<int?>(json['durationMinutes']),
      notes: serializer.fromJson<String?>(json['notes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'tenantId': serializer.toJson<String>(tenantId),
      'createdAt': serializer.toJson<String>(createdAt),
      'updatedAt': serializer.toJson<String>(updatedAt),
      'deletedAt': serializer.toJson<String?>(deletedAt),
      'version': serializer.toJson<int>(version),
      'syncStatus': serializer.toJson<String>(syncStatus),
      'lastSyncedAt': serializer.toJson<String?>(lastSyncedAt),
      'workOrderId': serializer.toJson<String>(workOrderId),
      'userId': serializer.toJson<String>(userId),
      'type': serializer.toJson<String>(type),
      'startTime': serializer.toJson<String>(startTime),
      'endTime': serializer.toJson<String?>(endTime),
      'durationMinutes': serializer.toJson<int?>(durationMinutes),
      'notes': serializer.toJson<String?>(notes),
    };
  }

  TimeEntryRow copyWith({
    String? id,
    String? tenantId,
    String? createdAt,
    String? updatedAt,
    Value<String?> deletedAt = const Value.absent(),
    int? version,
    String? syncStatus,
    Value<String?> lastSyncedAt = const Value.absent(),
    String? workOrderId,
    String? userId,
    String? type,
    String? startTime,
    Value<String?> endTime = const Value.absent(),
    Value<int?> durationMinutes = const Value.absent(),
    Value<String?> notes = const Value.absent(),
  }) => TimeEntryRow(
    id: id ?? this.id,
    tenantId: tenantId ?? this.tenantId,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    version: version ?? this.version,
    syncStatus: syncStatus ?? this.syncStatus,
    lastSyncedAt: lastSyncedAt.present ? lastSyncedAt.value : this.lastSyncedAt,
    workOrderId: workOrderId ?? this.workOrderId,
    userId: userId ?? this.userId,
    type: type ?? this.type,
    startTime: startTime ?? this.startTime,
    endTime: endTime.present ? endTime.value : this.endTime,
    durationMinutes: durationMinutes.present
        ? durationMinutes.value
        : this.durationMinutes,
    notes: notes.present ? notes.value : this.notes,
  );
  TimeEntryRow copyWithCompanion(TimeEntriesCompanion data) {
    return TimeEntryRow(
      id: data.id.present ? data.id.value : this.id,
      tenantId: data.tenantId.present ? data.tenantId.value : this.tenantId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      version: data.version.present ? data.version.value : this.version,
      syncStatus: data.syncStatus.present
          ? data.syncStatus.value
          : this.syncStatus,
      lastSyncedAt: data.lastSyncedAt.present
          ? data.lastSyncedAt.value
          : this.lastSyncedAt,
      workOrderId: data.workOrderId.present
          ? data.workOrderId.value
          : this.workOrderId,
      userId: data.userId.present ? data.userId.value : this.userId,
      type: data.type.present ? data.type.value : this.type,
      startTime: data.startTime.present ? data.startTime.value : this.startTime,
      endTime: data.endTime.present ? data.endTime.value : this.endTime,
      durationMinutes: data.durationMinutes.present
          ? data.durationMinutes.value
          : this.durationMinutes,
      notes: data.notes.present ? data.notes.value : this.notes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TimeEntryRow(')
          ..write('id: $id, ')
          ..write('tenantId: $tenantId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('version: $version, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('lastSyncedAt: $lastSyncedAt, ')
          ..write('workOrderId: $workOrderId, ')
          ..write('userId: $userId, ')
          ..write('type: $type, ')
          ..write('startTime: $startTime, ')
          ..write('endTime: $endTime, ')
          ..write('durationMinutes: $durationMinutes, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    tenantId,
    createdAt,
    updatedAt,
    deletedAt,
    version,
    syncStatus,
    lastSyncedAt,
    workOrderId,
    userId,
    type,
    startTime,
    endTime,
    durationMinutes,
    notes,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TimeEntryRow &&
          other.id == this.id &&
          other.tenantId == this.tenantId &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.version == this.version &&
          other.syncStatus == this.syncStatus &&
          other.lastSyncedAt == this.lastSyncedAt &&
          other.workOrderId == this.workOrderId &&
          other.userId == this.userId &&
          other.type == this.type &&
          other.startTime == this.startTime &&
          other.endTime == this.endTime &&
          other.durationMinutes == this.durationMinutes &&
          other.notes == this.notes);
}

class TimeEntriesCompanion extends UpdateCompanion<TimeEntryRow> {
  final Value<String> id;
  final Value<String> tenantId;
  final Value<String> createdAt;
  final Value<String> updatedAt;
  final Value<String?> deletedAt;
  final Value<int> version;
  final Value<String> syncStatus;
  final Value<String?> lastSyncedAt;
  final Value<String> workOrderId;
  final Value<String> userId;
  final Value<String> type;
  final Value<String> startTime;
  final Value<String?> endTime;
  final Value<int?> durationMinutes;
  final Value<String?> notes;
  final Value<int> rowid;
  const TimeEntriesCompanion({
    this.id = const Value.absent(),
    this.tenantId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.version = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.lastSyncedAt = const Value.absent(),
    this.workOrderId = const Value.absent(),
    this.userId = const Value.absent(),
    this.type = const Value.absent(),
    this.startTime = const Value.absent(),
    this.endTime = const Value.absent(),
    this.durationMinutes = const Value.absent(),
    this.notes = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TimeEntriesCompanion.insert({
    required String id,
    required String tenantId,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.version = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.lastSyncedAt = const Value.absent(),
    required String workOrderId,
    required String userId,
    required String type,
    required String startTime,
    this.endTime = const Value.absent(),
    this.durationMinutes = const Value.absent(),
    this.notes = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       tenantId = Value(tenantId),
       workOrderId = Value(workOrderId),
       userId = Value(userId),
       type = Value(type),
       startTime = Value(startTime);
  static Insertable<TimeEntryRow> custom({
    Expression<String>? id,
    Expression<String>? tenantId,
    Expression<String>? createdAt,
    Expression<String>? updatedAt,
    Expression<String>? deletedAt,
    Expression<int>? version,
    Expression<String>? syncStatus,
    Expression<String>? lastSyncedAt,
    Expression<String>? workOrderId,
    Expression<String>? userId,
    Expression<String>? type,
    Expression<String>? startTime,
    Expression<String>? endTime,
    Expression<int>? durationMinutes,
    Expression<String>? notes,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (tenantId != null) 'tenant_id': tenantId,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (version != null) 'version': version,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (lastSyncedAt != null) 'last_synced_at': lastSyncedAt,
      if (workOrderId != null) 'work_order_id': workOrderId,
      if (userId != null) 'user_id': userId,
      if (type != null) 'type': type,
      if (startTime != null) 'start_time': startTime,
      if (endTime != null) 'end_time': endTime,
      if (durationMinutes != null) 'duration_minutes': durationMinutes,
      if (notes != null) 'notes': notes,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TimeEntriesCompanion copyWith({
    Value<String>? id,
    Value<String>? tenantId,
    Value<String>? createdAt,
    Value<String>? updatedAt,
    Value<String?>? deletedAt,
    Value<int>? version,
    Value<String>? syncStatus,
    Value<String?>? lastSyncedAt,
    Value<String>? workOrderId,
    Value<String>? userId,
    Value<String>? type,
    Value<String>? startTime,
    Value<String?>? endTime,
    Value<int?>? durationMinutes,
    Value<String?>? notes,
    Value<int>? rowid,
  }) {
    return TimeEntriesCompanion(
      id: id ?? this.id,
      tenantId: tenantId ?? this.tenantId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      version: version ?? this.version,
      syncStatus: syncStatus ?? this.syncStatus,
      lastSyncedAt: lastSyncedAt ?? this.lastSyncedAt,
      workOrderId: workOrderId ?? this.workOrderId,
      userId: userId ?? this.userId,
      type: type ?? this.type,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      durationMinutes: durationMinutes ?? this.durationMinutes,
      notes: notes ?? this.notes,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (tenantId.present) {
      map['tenant_id'] = Variable<String>(tenantId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<String>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<String>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<String>(deletedAt.value);
    }
    if (version.present) {
      map['version'] = Variable<int>(version.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(syncStatus.value);
    }
    if (lastSyncedAt.present) {
      map['last_synced_at'] = Variable<String>(lastSyncedAt.value);
    }
    if (workOrderId.present) {
      map['work_order_id'] = Variable<String>(workOrderId.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (startTime.present) {
      map['start_time'] = Variable<String>(startTime.value);
    }
    if (endTime.present) {
      map['end_time'] = Variable<String>(endTime.value);
    }
    if (durationMinutes.present) {
      map['duration_minutes'] = Variable<int>(durationMinutes.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TimeEntriesCompanion(')
          ..write('id: $id, ')
          ..write('tenantId: $tenantId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('version: $version, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('lastSyncedAt: $lastSyncedAt, ')
          ..write('workOrderId: $workOrderId, ')
          ..write('userId: $userId, ')
          ..write('type: $type, ')
          ..write('startTime: $startTime, ')
          ..write('endTime: $endTime, ')
          ..write('durationMinutes: $durationMinutes, ')
          ..write('notes: $notes, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MaterialsTable extends Materials
    with TableInfo<$MaterialsTable, MaterialRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MaterialsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _tenantIdMeta = const VerificationMeta(
    'tenantId',
  );
  @override
  late final GeneratedColumn<String> tenantId = GeneratedColumn<String>(
    'tenant_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<String> createdAt = GeneratedColumn<String>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: _utcNowIso,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<String> updatedAt = GeneratedColumn<String>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: _utcNowIso,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<String> deletedAt = GeneratedColumn<String>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _versionMeta = const VerificationMeta(
    'version',
  );
  @override
  late final GeneratedColumn<int> version = GeneratedColumn<int>(
    'version',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
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
    defaultValue: const Constant('synced'),
  );
  static const VerificationMeta _lastSyncedAtMeta = const VerificationMeta(
    'lastSyncedAt',
  );
  @override
  late final GeneratedColumn<String> lastSyncedAt = GeneratedColumn<String>(
    'last_synced_at',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _skuMeta = const VerificationMeta('sku');
  @override
  late final GeneratedColumn<String> sku = GeneratedColumn<String>(
    'sku',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _unitMeta = const VerificationMeta('unit');
  @override
  late final GeneratedColumn<String> unit = GeneratedColumn<String>(
    'unit',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _defaultPriceMeta = const VerificationMeta(
    'defaultPrice',
  );
  @override
  late final GeneratedColumn<double> defaultPrice = GeneratedColumn<double>(
    'default_price',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    tenantId,
    createdAt,
    updatedAt,
    deletedAt,
    version,
    syncStatus,
    lastSyncedAt,
    sku,
    name,
    unit,
    defaultPrice,
    isActive,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'materials';
  @override
  VerificationContext validateIntegrity(
    Insertable<MaterialRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('tenant_id')) {
      context.handle(
        _tenantIdMeta,
        tenantId.isAcceptableOrUnknown(data['tenant_id']!, _tenantIdMeta),
      );
    } else if (isInserting) {
      context.missing(_tenantIdMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('version')) {
      context.handle(
        _versionMeta,
        version.isAcceptableOrUnknown(data['version']!, _versionMeta),
      );
    }
    if (data.containsKey('sync_status')) {
      context.handle(
        _syncStatusMeta,
        syncStatus.isAcceptableOrUnknown(data['sync_status']!, _syncStatusMeta),
      );
    }
    if (data.containsKey('last_synced_at')) {
      context.handle(
        _lastSyncedAtMeta,
        lastSyncedAt.isAcceptableOrUnknown(
          data['last_synced_at']!,
          _lastSyncedAtMeta,
        ),
      );
    }
    if (data.containsKey('sku')) {
      context.handle(
        _skuMeta,
        sku.isAcceptableOrUnknown(data['sku']!, _skuMeta),
      );
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('unit')) {
      context.handle(
        _unitMeta,
        unit.isAcceptableOrUnknown(data['unit']!, _unitMeta),
      );
    } else if (isInserting) {
      context.missing(_unitMeta);
    }
    if (data.containsKey('default_price')) {
      context.handle(
        _defaultPriceMeta,
        defaultPrice.isAcceptableOrUnknown(
          data['default_price']!,
          _defaultPriceMeta,
        ),
      );
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MaterialRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MaterialRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      tenantId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tenant_id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}deleted_at'],
      ),
      version: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}version'],
      )!,
      syncStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sync_status'],
      )!,
      lastSyncedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_synced_at'],
      ),
      sku: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sku'],
      ),
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      unit: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}unit'],
      )!,
      defaultPrice: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}default_price'],
      ),
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
    );
  }

  @override
  $MaterialsTable createAlias(String alias) {
    return $MaterialsTable(attachedDatabase, alias);
  }
}

class MaterialRow extends DataClass implements Insertable<MaterialRow> {
  final String id;
  final String tenantId;
  final String createdAt;
  final String updatedAt;
  final String? deletedAt;
  final int version;
  final String syncStatus;
  final String? lastSyncedAt;
  final String? sku;
  final String name;
  final String unit;
  final double? defaultPrice;
  final bool isActive;
  const MaterialRow({
    required this.id,
    required this.tenantId,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.version,
    required this.syncStatus,
    this.lastSyncedAt,
    this.sku,
    required this.name,
    required this.unit,
    this.defaultPrice,
    required this.isActive,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['tenant_id'] = Variable<String>(tenantId);
    map['created_at'] = Variable<String>(createdAt);
    map['updated_at'] = Variable<String>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<String>(deletedAt);
    }
    map['version'] = Variable<int>(version);
    map['sync_status'] = Variable<String>(syncStatus);
    if (!nullToAbsent || lastSyncedAt != null) {
      map['last_synced_at'] = Variable<String>(lastSyncedAt);
    }
    if (!nullToAbsent || sku != null) {
      map['sku'] = Variable<String>(sku);
    }
    map['name'] = Variable<String>(name);
    map['unit'] = Variable<String>(unit);
    if (!nullToAbsent || defaultPrice != null) {
      map['default_price'] = Variable<double>(defaultPrice);
    }
    map['is_active'] = Variable<bool>(isActive);
    return map;
  }

  MaterialsCompanion toCompanion(bool nullToAbsent) {
    return MaterialsCompanion(
      id: Value(id),
      tenantId: Value(tenantId),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      version: Value(version),
      syncStatus: Value(syncStatus),
      lastSyncedAt: lastSyncedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastSyncedAt),
      sku: sku == null && nullToAbsent ? const Value.absent() : Value(sku),
      name: Value(name),
      unit: Value(unit),
      defaultPrice: defaultPrice == null && nullToAbsent
          ? const Value.absent()
          : Value(defaultPrice),
      isActive: Value(isActive),
    );
  }

  factory MaterialRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MaterialRow(
      id: serializer.fromJson<String>(json['id']),
      tenantId: serializer.fromJson<String>(json['tenantId']),
      createdAt: serializer.fromJson<String>(json['createdAt']),
      updatedAt: serializer.fromJson<String>(json['updatedAt']),
      deletedAt: serializer.fromJson<String?>(json['deletedAt']),
      version: serializer.fromJson<int>(json['version']),
      syncStatus: serializer.fromJson<String>(json['syncStatus']),
      lastSyncedAt: serializer.fromJson<String?>(json['lastSyncedAt']),
      sku: serializer.fromJson<String?>(json['sku']),
      name: serializer.fromJson<String>(json['name']),
      unit: serializer.fromJson<String>(json['unit']),
      defaultPrice: serializer.fromJson<double?>(json['defaultPrice']),
      isActive: serializer.fromJson<bool>(json['isActive']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'tenantId': serializer.toJson<String>(tenantId),
      'createdAt': serializer.toJson<String>(createdAt),
      'updatedAt': serializer.toJson<String>(updatedAt),
      'deletedAt': serializer.toJson<String?>(deletedAt),
      'version': serializer.toJson<int>(version),
      'syncStatus': serializer.toJson<String>(syncStatus),
      'lastSyncedAt': serializer.toJson<String?>(lastSyncedAt),
      'sku': serializer.toJson<String?>(sku),
      'name': serializer.toJson<String>(name),
      'unit': serializer.toJson<String>(unit),
      'defaultPrice': serializer.toJson<double?>(defaultPrice),
      'isActive': serializer.toJson<bool>(isActive),
    };
  }

  MaterialRow copyWith({
    String? id,
    String? tenantId,
    String? createdAt,
    String? updatedAt,
    Value<String?> deletedAt = const Value.absent(),
    int? version,
    String? syncStatus,
    Value<String?> lastSyncedAt = const Value.absent(),
    Value<String?> sku = const Value.absent(),
    String? name,
    String? unit,
    Value<double?> defaultPrice = const Value.absent(),
    bool? isActive,
  }) => MaterialRow(
    id: id ?? this.id,
    tenantId: tenantId ?? this.tenantId,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    version: version ?? this.version,
    syncStatus: syncStatus ?? this.syncStatus,
    lastSyncedAt: lastSyncedAt.present ? lastSyncedAt.value : this.lastSyncedAt,
    sku: sku.present ? sku.value : this.sku,
    name: name ?? this.name,
    unit: unit ?? this.unit,
    defaultPrice: defaultPrice.present ? defaultPrice.value : this.defaultPrice,
    isActive: isActive ?? this.isActive,
  );
  MaterialRow copyWithCompanion(MaterialsCompanion data) {
    return MaterialRow(
      id: data.id.present ? data.id.value : this.id,
      tenantId: data.tenantId.present ? data.tenantId.value : this.tenantId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      version: data.version.present ? data.version.value : this.version,
      syncStatus: data.syncStatus.present
          ? data.syncStatus.value
          : this.syncStatus,
      lastSyncedAt: data.lastSyncedAt.present
          ? data.lastSyncedAt.value
          : this.lastSyncedAt,
      sku: data.sku.present ? data.sku.value : this.sku,
      name: data.name.present ? data.name.value : this.name,
      unit: data.unit.present ? data.unit.value : this.unit,
      defaultPrice: data.defaultPrice.present
          ? data.defaultPrice.value
          : this.defaultPrice,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MaterialRow(')
          ..write('id: $id, ')
          ..write('tenantId: $tenantId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('version: $version, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('lastSyncedAt: $lastSyncedAt, ')
          ..write('sku: $sku, ')
          ..write('name: $name, ')
          ..write('unit: $unit, ')
          ..write('defaultPrice: $defaultPrice, ')
          ..write('isActive: $isActive')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    tenantId,
    createdAt,
    updatedAt,
    deletedAt,
    version,
    syncStatus,
    lastSyncedAt,
    sku,
    name,
    unit,
    defaultPrice,
    isActive,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MaterialRow &&
          other.id == this.id &&
          other.tenantId == this.tenantId &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.version == this.version &&
          other.syncStatus == this.syncStatus &&
          other.lastSyncedAt == this.lastSyncedAt &&
          other.sku == this.sku &&
          other.name == this.name &&
          other.unit == this.unit &&
          other.defaultPrice == this.defaultPrice &&
          other.isActive == this.isActive);
}

class MaterialsCompanion extends UpdateCompanion<MaterialRow> {
  final Value<String> id;
  final Value<String> tenantId;
  final Value<String> createdAt;
  final Value<String> updatedAt;
  final Value<String?> deletedAt;
  final Value<int> version;
  final Value<String> syncStatus;
  final Value<String?> lastSyncedAt;
  final Value<String?> sku;
  final Value<String> name;
  final Value<String> unit;
  final Value<double?> defaultPrice;
  final Value<bool> isActive;
  final Value<int> rowid;
  const MaterialsCompanion({
    this.id = const Value.absent(),
    this.tenantId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.version = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.lastSyncedAt = const Value.absent(),
    this.sku = const Value.absent(),
    this.name = const Value.absent(),
    this.unit = const Value.absent(),
    this.defaultPrice = const Value.absent(),
    this.isActive = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MaterialsCompanion.insert({
    required String id,
    required String tenantId,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.version = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.lastSyncedAt = const Value.absent(),
    this.sku = const Value.absent(),
    required String name,
    required String unit,
    this.defaultPrice = const Value.absent(),
    this.isActive = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       tenantId = Value(tenantId),
       name = Value(name),
       unit = Value(unit);
  static Insertable<MaterialRow> custom({
    Expression<String>? id,
    Expression<String>? tenantId,
    Expression<String>? createdAt,
    Expression<String>? updatedAt,
    Expression<String>? deletedAt,
    Expression<int>? version,
    Expression<String>? syncStatus,
    Expression<String>? lastSyncedAt,
    Expression<String>? sku,
    Expression<String>? name,
    Expression<String>? unit,
    Expression<double>? defaultPrice,
    Expression<bool>? isActive,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (tenantId != null) 'tenant_id': tenantId,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (version != null) 'version': version,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (lastSyncedAt != null) 'last_synced_at': lastSyncedAt,
      if (sku != null) 'sku': sku,
      if (name != null) 'name': name,
      if (unit != null) 'unit': unit,
      if (defaultPrice != null) 'default_price': defaultPrice,
      if (isActive != null) 'is_active': isActive,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MaterialsCompanion copyWith({
    Value<String>? id,
    Value<String>? tenantId,
    Value<String>? createdAt,
    Value<String>? updatedAt,
    Value<String?>? deletedAt,
    Value<int>? version,
    Value<String>? syncStatus,
    Value<String?>? lastSyncedAt,
    Value<String?>? sku,
    Value<String>? name,
    Value<String>? unit,
    Value<double?>? defaultPrice,
    Value<bool>? isActive,
    Value<int>? rowid,
  }) {
    return MaterialsCompanion(
      id: id ?? this.id,
      tenantId: tenantId ?? this.tenantId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      version: version ?? this.version,
      syncStatus: syncStatus ?? this.syncStatus,
      lastSyncedAt: lastSyncedAt ?? this.lastSyncedAt,
      sku: sku ?? this.sku,
      name: name ?? this.name,
      unit: unit ?? this.unit,
      defaultPrice: defaultPrice ?? this.defaultPrice,
      isActive: isActive ?? this.isActive,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (tenantId.present) {
      map['tenant_id'] = Variable<String>(tenantId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<String>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<String>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<String>(deletedAt.value);
    }
    if (version.present) {
      map['version'] = Variable<int>(version.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(syncStatus.value);
    }
    if (lastSyncedAt.present) {
      map['last_synced_at'] = Variable<String>(lastSyncedAt.value);
    }
    if (sku.present) {
      map['sku'] = Variable<String>(sku.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (unit.present) {
      map['unit'] = Variable<String>(unit.value);
    }
    if (defaultPrice.present) {
      map['default_price'] = Variable<double>(defaultPrice.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MaterialsCompanion(')
          ..write('id: $id, ')
          ..write('tenantId: $tenantId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('version: $version, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('lastSyncedAt: $lastSyncedAt, ')
          ..write('sku: $sku, ')
          ..write('name: $name, ')
          ..write('unit: $unit, ')
          ..write('defaultPrice: $defaultPrice, ')
          ..write('isActive: $isActive, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $WorkOrderMaterialsTable extends WorkOrderMaterials
    with TableInfo<$WorkOrderMaterialsTable, WorkOrderMaterialRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WorkOrderMaterialsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _tenantIdMeta = const VerificationMeta(
    'tenantId',
  );
  @override
  late final GeneratedColumn<String> tenantId = GeneratedColumn<String>(
    'tenant_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<String> createdAt = GeneratedColumn<String>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: _utcNowIso,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<String> updatedAt = GeneratedColumn<String>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: _utcNowIso,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<String> deletedAt = GeneratedColumn<String>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _versionMeta = const VerificationMeta(
    'version',
  );
  @override
  late final GeneratedColumn<int> version = GeneratedColumn<int>(
    'version',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
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
    defaultValue: const Constant('synced'),
  );
  static const VerificationMeta _lastSyncedAtMeta = const VerificationMeta(
    'lastSyncedAt',
  );
  @override
  late final GeneratedColumn<String> lastSyncedAt = GeneratedColumn<String>(
    'last_synced_at',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _workOrderIdMeta = const VerificationMeta(
    'workOrderId',
  );
  @override
  late final GeneratedColumn<String> workOrderId = GeneratedColumn<String>(
    'work_order_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _materialIdMeta = const VerificationMeta(
    'materialId',
  );
  @override
  late final GeneratedColumn<String> materialId = GeneratedColumn<String>(
    'material_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _quantityMeta = const VerificationMeta(
    'quantity',
  );
  @override
  late final GeneratedColumn<double> quantity = GeneratedColumn<double>(
    'quantity',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _unitMeta = const VerificationMeta('unit');
  @override
  late final GeneratedColumn<String> unit = GeneratedColumn<String>(
    'unit',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    tenantId,
    createdAt,
    updatedAt,
    deletedAt,
    version,
    syncStatus,
    lastSyncedAt,
    workOrderId,
    materialId,
    name,
    quantity,
    unit,
    notes,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'work_order_materials';
  @override
  VerificationContext validateIntegrity(
    Insertable<WorkOrderMaterialRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('tenant_id')) {
      context.handle(
        _tenantIdMeta,
        tenantId.isAcceptableOrUnknown(data['tenant_id']!, _tenantIdMeta),
      );
    } else if (isInserting) {
      context.missing(_tenantIdMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('version')) {
      context.handle(
        _versionMeta,
        version.isAcceptableOrUnknown(data['version']!, _versionMeta),
      );
    }
    if (data.containsKey('sync_status')) {
      context.handle(
        _syncStatusMeta,
        syncStatus.isAcceptableOrUnknown(data['sync_status']!, _syncStatusMeta),
      );
    }
    if (data.containsKey('last_synced_at')) {
      context.handle(
        _lastSyncedAtMeta,
        lastSyncedAt.isAcceptableOrUnknown(
          data['last_synced_at']!,
          _lastSyncedAtMeta,
        ),
      );
    }
    if (data.containsKey('work_order_id')) {
      context.handle(
        _workOrderIdMeta,
        workOrderId.isAcceptableOrUnknown(
          data['work_order_id']!,
          _workOrderIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_workOrderIdMeta);
    }
    if (data.containsKey('material_id')) {
      context.handle(
        _materialIdMeta,
        materialId.isAcceptableOrUnknown(data['material_id']!, _materialIdMeta),
      );
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('quantity')) {
      context.handle(
        _quantityMeta,
        quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta),
      );
    } else if (isInserting) {
      context.missing(_quantityMeta);
    }
    if (data.containsKey('unit')) {
      context.handle(
        _unitMeta,
        unit.isAcceptableOrUnknown(data['unit']!, _unitMeta),
      );
    } else if (isInserting) {
      context.missing(_unitMeta);
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WorkOrderMaterialRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WorkOrderMaterialRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      tenantId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tenant_id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}deleted_at'],
      ),
      version: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}version'],
      )!,
      syncStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sync_status'],
      )!,
      lastSyncedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_synced_at'],
      ),
      workOrderId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}work_order_id'],
      )!,
      materialId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}material_id'],
      ),
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      quantity: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}quantity'],
      )!,
      unit: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}unit'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
    );
  }

  @override
  $WorkOrderMaterialsTable createAlias(String alias) {
    return $WorkOrderMaterialsTable(attachedDatabase, alias);
  }
}

class WorkOrderMaterialRow extends DataClass
    implements Insertable<WorkOrderMaterialRow> {
  final String id;
  final String tenantId;
  final String createdAt;
  final String updatedAt;
  final String? deletedAt;
  final int version;
  final String syncStatus;
  final String? lastSyncedAt;
  final String workOrderId;
  final String? materialId;
  final String name;
  final double quantity;
  final String unit;
  final String? notes;
  const WorkOrderMaterialRow({
    required this.id,
    required this.tenantId,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.version,
    required this.syncStatus,
    this.lastSyncedAt,
    required this.workOrderId,
    this.materialId,
    required this.name,
    required this.quantity,
    required this.unit,
    this.notes,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['tenant_id'] = Variable<String>(tenantId);
    map['created_at'] = Variable<String>(createdAt);
    map['updated_at'] = Variable<String>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<String>(deletedAt);
    }
    map['version'] = Variable<int>(version);
    map['sync_status'] = Variable<String>(syncStatus);
    if (!nullToAbsent || lastSyncedAt != null) {
      map['last_synced_at'] = Variable<String>(lastSyncedAt);
    }
    map['work_order_id'] = Variable<String>(workOrderId);
    if (!nullToAbsent || materialId != null) {
      map['material_id'] = Variable<String>(materialId);
    }
    map['name'] = Variable<String>(name);
    map['quantity'] = Variable<double>(quantity);
    map['unit'] = Variable<String>(unit);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    return map;
  }

  WorkOrderMaterialsCompanion toCompanion(bool nullToAbsent) {
    return WorkOrderMaterialsCompanion(
      id: Value(id),
      tenantId: Value(tenantId),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      version: Value(version),
      syncStatus: Value(syncStatus),
      lastSyncedAt: lastSyncedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastSyncedAt),
      workOrderId: Value(workOrderId),
      materialId: materialId == null && nullToAbsent
          ? const Value.absent()
          : Value(materialId),
      name: Value(name),
      quantity: Value(quantity),
      unit: Value(unit),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
    );
  }

  factory WorkOrderMaterialRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WorkOrderMaterialRow(
      id: serializer.fromJson<String>(json['id']),
      tenantId: serializer.fromJson<String>(json['tenantId']),
      createdAt: serializer.fromJson<String>(json['createdAt']),
      updatedAt: serializer.fromJson<String>(json['updatedAt']),
      deletedAt: serializer.fromJson<String?>(json['deletedAt']),
      version: serializer.fromJson<int>(json['version']),
      syncStatus: serializer.fromJson<String>(json['syncStatus']),
      lastSyncedAt: serializer.fromJson<String?>(json['lastSyncedAt']),
      workOrderId: serializer.fromJson<String>(json['workOrderId']),
      materialId: serializer.fromJson<String?>(json['materialId']),
      name: serializer.fromJson<String>(json['name']),
      quantity: serializer.fromJson<double>(json['quantity']),
      unit: serializer.fromJson<String>(json['unit']),
      notes: serializer.fromJson<String?>(json['notes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'tenantId': serializer.toJson<String>(tenantId),
      'createdAt': serializer.toJson<String>(createdAt),
      'updatedAt': serializer.toJson<String>(updatedAt),
      'deletedAt': serializer.toJson<String?>(deletedAt),
      'version': serializer.toJson<int>(version),
      'syncStatus': serializer.toJson<String>(syncStatus),
      'lastSyncedAt': serializer.toJson<String?>(lastSyncedAt),
      'workOrderId': serializer.toJson<String>(workOrderId),
      'materialId': serializer.toJson<String?>(materialId),
      'name': serializer.toJson<String>(name),
      'quantity': serializer.toJson<double>(quantity),
      'unit': serializer.toJson<String>(unit),
      'notes': serializer.toJson<String?>(notes),
    };
  }

  WorkOrderMaterialRow copyWith({
    String? id,
    String? tenantId,
    String? createdAt,
    String? updatedAt,
    Value<String?> deletedAt = const Value.absent(),
    int? version,
    String? syncStatus,
    Value<String?> lastSyncedAt = const Value.absent(),
    String? workOrderId,
    Value<String?> materialId = const Value.absent(),
    String? name,
    double? quantity,
    String? unit,
    Value<String?> notes = const Value.absent(),
  }) => WorkOrderMaterialRow(
    id: id ?? this.id,
    tenantId: tenantId ?? this.tenantId,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    version: version ?? this.version,
    syncStatus: syncStatus ?? this.syncStatus,
    lastSyncedAt: lastSyncedAt.present ? lastSyncedAt.value : this.lastSyncedAt,
    workOrderId: workOrderId ?? this.workOrderId,
    materialId: materialId.present ? materialId.value : this.materialId,
    name: name ?? this.name,
    quantity: quantity ?? this.quantity,
    unit: unit ?? this.unit,
    notes: notes.present ? notes.value : this.notes,
  );
  WorkOrderMaterialRow copyWithCompanion(WorkOrderMaterialsCompanion data) {
    return WorkOrderMaterialRow(
      id: data.id.present ? data.id.value : this.id,
      tenantId: data.tenantId.present ? data.tenantId.value : this.tenantId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      version: data.version.present ? data.version.value : this.version,
      syncStatus: data.syncStatus.present
          ? data.syncStatus.value
          : this.syncStatus,
      lastSyncedAt: data.lastSyncedAt.present
          ? data.lastSyncedAt.value
          : this.lastSyncedAt,
      workOrderId: data.workOrderId.present
          ? data.workOrderId.value
          : this.workOrderId,
      materialId: data.materialId.present
          ? data.materialId.value
          : this.materialId,
      name: data.name.present ? data.name.value : this.name,
      quantity: data.quantity.present ? data.quantity.value : this.quantity,
      unit: data.unit.present ? data.unit.value : this.unit,
      notes: data.notes.present ? data.notes.value : this.notes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WorkOrderMaterialRow(')
          ..write('id: $id, ')
          ..write('tenantId: $tenantId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('version: $version, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('lastSyncedAt: $lastSyncedAt, ')
          ..write('workOrderId: $workOrderId, ')
          ..write('materialId: $materialId, ')
          ..write('name: $name, ')
          ..write('quantity: $quantity, ')
          ..write('unit: $unit, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    tenantId,
    createdAt,
    updatedAt,
    deletedAt,
    version,
    syncStatus,
    lastSyncedAt,
    workOrderId,
    materialId,
    name,
    quantity,
    unit,
    notes,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WorkOrderMaterialRow &&
          other.id == this.id &&
          other.tenantId == this.tenantId &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.version == this.version &&
          other.syncStatus == this.syncStatus &&
          other.lastSyncedAt == this.lastSyncedAt &&
          other.workOrderId == this.workOrderId &&
          other.materialId == this.materialId &&
          other.name == this.name &&
          other.quantity == this.quantity &&
          other.unit == this.unit &&
          other.notes == this.notes);
}

class WorkOrderMaterialsCompanion
    extends UpdateCompanion<WorkOrderMaterialRow> {
  final Value<String> id;
  final Value<String> tenantId;
  final Value<String> createdAt;
  final Value<String> updatedAt;
  final Value<String?> deletedAt;
  final Value<int> version;
  final Value<String> syncStatus;
  final Value<String?> lastSyncedAt;
  final Value<String> workOrderId;
  final Value<String?> materialId;
  final Value<String> name;
  final Value<double> quantity;
  final Value<String> unit;
  final Value<String?> notes;
  final Value<int> rowid;
  const WorkOrderMaterialsCompanion({
    this.id = const Value.absent(),
    this.tenantId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.version = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.lastSyncedAt = const Value.absent(),
    this.workOrderId = const Value.absent(),
    this.materialId = const Value.absent(),
    this.name = const Value.absent(),
    this.quantity = const Value.absent(),
    this.unit = const Value.absent(),
    this.notes = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  WorkOrderMaterialsCompanion.insert({
    required String id,
    required String tenantId,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.version = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.lastSyncedAt = const Value.absent(),
    required String workOrderId,
    this.materialId = const Value.absent(),
    required String name,
    required double quantity,
    required String unit,
    this.notes = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       tenantId = Value(tenantId),
       workOrderId = Value(workOrderId),
       name = Value(name),
       quantity = Value(quantity),
       unit = Value(unit);
  static Insertable<WorkOrderMaterialRow> custom({
    Expression<String>? id,
    Expression<String>? tenantId,
    Expression<String>? createdAt,
    Expression<String>? updatedAt,
    Expression<String>? deletedAt,
    Expression<int>? version,
    Expression<String>? syncStatus,
    Expression<String>? lastSyncedAt,
    Expression<String>? workOrderId,
    Expression<String>? materialId,
    Expression<String>? name,
    Expression<double>? quantity,
    Expression<String>? unit,
    Expression<String>? notes,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (tenantId != null) 'tenant_id': tenantId,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (version != null) 'version': version,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (lastSyncedAt != null) 'last_synced_at': lastSyncedAt,
      if (workOrderId != null) 'work_order_id': workOrderId,
      if (materialId != null) 'material_id': materialId,
      if (name != null) 'name': name,
      if (quantity != null) 'quantity': quantity,
      if (unit != null) 'unit': unit,
      if (notes != null) 'notes': notes,
      if (rowid != null) 'rowid': rowid,
    });
  }

  WorkOrderMaterialsCompanion copyWith({
    Value<String>? id,
    Value<String>? tenantId,
    Value<String>? createdAt,
    Value<String>? updatedAt,
    Value<String?>? deletedAt,
    Value<int>? version,
    Value<String>? syncStatus,
    Value<String?>? lastSyncedAt,
    Value<String>? workOrderId,
    Value<String?>? materialId,
    Value<String>? name,
    Value<double>? quantity,
    Value<String>? unit,
    Value<String?>? notes,
    Value<int>? rowid,
  }) {
    return WorkOrderMaterialsCompanion(
      id: id ?? this.id,
      tenantId: tenantId ?? this.tenantId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      version: version ?? this.version,
      syncStatus: syncStatus ?? this.syncStatus,
      lastSyncedAt: lastSyncedAt ?? this.lastSyncedAt,
      workOrderId: workOrderId ?? this.workOrderId,
      materialId: materialId ?? this.materialId,
      name: name ?? this.name,
      quantity: quantity ?? this.quantity,
      unit: unit ?? this.unit,
      notes: notes ?? this.notes,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (tenantId.present) {
      map['tenant_id'] = Variable<String>(tenantId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<String>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<String>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<String>(deletedAt.value);
    }
    if (version.present) {
      map['version'] = Variable<int>(version.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(syncStatus.value);
    }
    if (lastSyncedAt.present) {
      map['last_synced_at'] = Variable<String>(lastSyncedAt.value);
    }
    if (workOrderId.present) {
      map['work_order_id'] = Variable<String>(workOrderId.value);
    }
    if (materialId.present) {
      map['material_id'] = Variable<String>(materialId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<double>(quantity.value);
    }
    if (unit.present) {
      map['unit'] = Variable<String>(unit.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WorkOrderMaterialsCompanion(')
          ..write('id: $id, ')
          ..write('tenantId: $tenantId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('version: $version, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('lastSyncedAt: $lastSyncedAt, ')
          ..write('workOrderId: $workOrderId, ')
          ..write('materialId: $materialId, ')
          ..write('name: $name, ')
          ..write('quantity: $quantity, ')
          ..write('unit: $unit, ')
          ..write('notes: $notes, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ReportsTable extends Reports with TableInfo<$ReportsTable, ReportRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ReportsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _tenantIdMeta = const VerificationMeta(
    'tenantId',
  );
  @override
  late final GeneratedColumn<String> tenantId = GeneratedColumn<String>(
    'tenant_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<String> createdAt = GeneratedColumn<String>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: _utcNowIso,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<String> updatedAt = GeneratedColumn<String>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: _utcNowIso,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<String> deletedAt = GeneratedColumn<String>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _versionMeta = const VerificationMeta(
    'version',
  );
  @override
  late final GeneratedColumn<int> version = GeneratedColumn<int>(
    'version',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
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
    defaultValue: const Constant('synced'),
  );
  static const VerificationMeta _lastSyncedAtMeta = const VerificationMeta(
    'lastSyncedAt',
  );
  @override
  late final GeneratedColumn<String> lastSyncedAt = GeneratedColumn<String>(
    'last_synced_at',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _workOrderIdMeta = const VerificationMeta(
    'workOrderId',
  );
  @override
  late final GeneratedColumn<String> workOrderId = GeneratedColumn<String>(
    'work_order_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _reportNumberMeta = const VerificationMeta(
    'reportNumber',
  );
  @override
  late final GeneratedColumn<String> reportNumber = GeneratedColumn<String>(
    'report_number',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _pdfLocalPathMeta = const VerificationMeta(
    'pdfLocalPath',
  );
  @override
  late final GeneratedColumn<String> pdfLocalPath = GeneratedColumn<String>(
    'pdf_local_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _pdfRemoteUrlMeta = const VerificationMeta(
    'pdfRemoteUrl',
  );
  @override
  late final GeneratedColumn<String> pdfRemoteUrl = GeneratedColumn<String>(
    'pdf_remote_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _generatedAtMeta = const VerificationMeta(
    'generatedAt',
  );
  @override
  late final GeneratedColumn<String> generatedAt = GeneratedColumn<String>(
    'generated_at',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _signedAtMeta = const VerificationMeta(
    'signedAt',
  );
  @override
  late final GeneratedColumn<String> signedAt = GeneratedColumn<String>(
    'signed_at',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _customerNameSignedMeta =
      const VerificationMeta('customerNameSigned');
  @override
  late final GeneratedColumn<String> customerNameSigned =
      GeneratedColumn<String>(
        'customer_name_signed',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    tenantId,
    createdAt,
    updatedAt,
    deletedAt,
    version,
    syncStatus,
    lastSyncedAt,
    workOrderId,
    reportNumber,
    status,
    pdfLocalPath,
    pdfRemoteUrl,
    generatedAt,
    signedAt,
    customerNameSigned,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'reports';
  @override
  VerificationContext validateIntegrity(
    Insertable<ReportRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('tenant_id')) {
      context.handle(
        _tenantIdMeta,
        tenantId.isAcceptableOrUnknown(data['tenant_id']!, _tenantIdMeta),
      );
    } else if (isInserting) {
      context.missing(_tenantIdMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('version')) {
      context.handle(
        _versionMeta,
        version.isAcceptableOrUnknown(data['version']!, _versionMeta),
      );
    }
    if (data.containsKey('sync_status')) {
      context.handle(
        _syncStatusMeta,
        syncStatus.isAcceptableOrUnknown(data['sync_status']!, _syncStatusMeta),
      );
    }
    if (data.containsKey('last_synced_at')) {
      context.handle(
        _lastSyncedAtMeta,
        lastSyncedAt.isAcceptableOrUnknown(
          data['last_synced_at']!,
          _lastSyncedAtMeta,
        ),
      );
    }
    if (data.containsKey('work_order_id')) {
      context.handle(
        _workOrderIdMeta,
        workOrderId.isAcceptableOrUnknown(
          data['work_order_id']!,
          _workOrderIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_workOrderIdMeta);
    }
    if (data.containsKey('report_number')) {
      context.handle(
        _reportNumberMeta,
        reportNumber.isAcceptableOrUnknown(
          data['report_number']!,
          _reportNumberMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_reportNumberMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('pdf_local_path')) {
      context.handle(
        _pdfLocalPathMeta,
        pdfLocalPath.isAcceptableOrUnknown(
          data['pdf_local_path']!,
          _pdfLocalPathMeta,
        ),
      );
    }
    if (data.containsKey('pdf_remote_url')) {
      context.handle(
        _pdfRemoteUrlMeta,
        pdfRemoteUrl.isAcceptableOrUnknown(
          data['pdf_remote_url']!,
          _pdfRemoteUrlMeta,
        ),
      );
    }
    if (data.containsKey('generated_at')) {
      context.handle(
        _generatedAtMeta,
        generatedAt.isAcceptableOrUnknown(
          data['generated_at']!,
          _generatedAtMeta,
        ),
      );
    }
    if (data.containsKey('signed_at')) {
      context.handle(
        _signedAtMeta,
        signedAt.isAcceptableOrUnknown(data['signed_at']!, _signedAtMeta),
      );
    }
    if (data.containsKey('customer_name_signed')) {
      context.handle(
        _customerNameSignedMeta,
        customerNameSigned.isAcceptableOrUnknown(
          data['customer_name_signed']!,
          _customerNameSignedMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ReportRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ReportRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      tenantId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tenant_id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}deleted_at'],
      ),
      version: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}version'],
      )!,
      syncStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sync_status'],
      )!,
      lastSyncedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_synced_at'],
      ),
      workOrderId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}work_order_id'],
      )!,
      reportNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}report_number'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      pdfLocalPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}pdf_local_path'],
      ),
      pdfRemoteUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}pdf_remote_url'],
      ),
      generatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}generated_at'],
      ),
      signedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}signed_at'],
      ),
      customerNameSigned: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}customer_name_signed'],
      ),
    );
  }

  @override
  $ReportsTable createAlias(String alias) {
    return $ReportsTable(attachedDatabase, alias);
  }
}

class ReportRow extends DataClass implements Insertable<ReportRow> {
  final String id;
  final String tenantId;
  final String createdAt;
  final String updatedAt;
  final String? deletedAt;
  final int version;
  final String syncStatus;
  final String? lastSyncedAt;
  final String workOrderId;
  final String reportNumber;
  final String status;
  final String? pdfLocalPath;
  final String? pdfRemoteUrl;
  final String? generatedAt;
  final String? signedAt;
  final String? customerNameSigned;
  const ReportRow({
    required this.id,
    required this.tenantId,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.version,
    required this.syncStatus,
    this.lastSyncedAt,
    required this.workOrderId,
    required this.reportNumber,
    required this.status,
    this.pdfLocalPath,
    this.pdfRemoteUrl,
    this.generatedAt,
    this.signedAt,
    this.customerNameSigned,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['tenant_id'] = Variable<String>(tenantId);
    map['created_at'] = Variable<String>(createdAt);
    map['updated_at'] = Variable<String>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<String>(deletedAt);
    }
    map['version'] = Variable<int>(version);
    map['sync_status'] = Variable<String>(syncStatus);
    if (!nullToAbsent || lastSyncedAt != null) {
      map['last_synced_at'] = Variable<String>(lastSyncedAt);
    }
    map['work_order_id'] = Variable<String>(workOrderId);
    map['report_number'] = Variable<String>(reportNumber);
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || pdfLocalPath != null) {
      map['pdf_local_path'] = Variable<String>(pdfLocalPath);
    }
    if (!nullToAbsent || pdfRemoteUrl != null) {
      map['pdf_remote_url'] = Variable<String>(pdfRemoteUrl);
    }
    if (!nullToAbsent || generatedAt != null) {
      map['generated_at'] = Variable<String>(generatedAt);
    }
    if (!nullToAbsent || signedAt != null) {
      map['signed_at'] = Variable<String>(signedAt);
    }
    if (!nullToAbsent || customerNameSigned != null) {
      map['customer_name_signed'] = Variable<String>(customerNameSigned);
    }
    return map;
  }

  ReportsCompanion toCompanion(bool nullToAbsent) {
    return ReportsCompanion(
      id: Value(id),
      tenantId: Value(tenantId),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      version: Value(version),
      syncStatus: Value(syncStatus),
      lastSyncedAt: lastSyncedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastSyncedAt),
      workOrderId: Value(workOrderId),
      reportNumber: Value(reportNumber),
      status: Value(status),
      pdfLocalPath: pdfLocalPath == null && nullToAbsent
          ? const Value.absent()
          : Value(pdfLocalPath),
      pdfRemoteUrl: pdfRemoteUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(pdfRemoteUrl),
      generatedAt: generatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(generatedAt),
      signedAt: signedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(signedAt),
      customerNameSigned: customerNameSigned == null && nullToAbsent
          ? const Value.absent()
          : Value(customerNameSigned),
    );
  }

  factory ReportRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ReportRow(
      id: serializer.fromJson<String>(json['id']),
      tenantId: serializer.fromJson<String>(json['tenantId']),
      createdAt: serializer.fromJson<String>(json['createdAt']),
      updatedAt: serializer.fromJson<String>(json['updatedAt']),
      deletedAt: serializer.fromJson<String?>(json['deletedAt']),
      version: serializer.fromJson<int>(json['version']),
      syncStatus: serializer.fromJson<String>(json['syncStatus']),
      lastSyncedAt: serializer.fromJson<String?>(json['lastSyncedAt']),
      workOrderId: serializer.fromJson<String>(json['workOrderId']),
      reportNumber: serializer.fromJson<String>(json['reportNumber']),
      status: serializer.fromJson<String>(json['status']),
      pdfLocalPath: serializer.fromJson<String?>(json['pdfLocalPath']),
      pdfRemoteUrl: serializer.fromJson<String?>(json['pdfRemoteUrl']),
      generatedAt: serializer.fromJson<String?>(json['generatedAt']),
      signedAt: serializer.fromJson<String?>(json['signedAt']),
      customerNameSigned: serializer.fromJson<String?>(
        json['customerNameSigned'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'tenantId': serializer.toJson<String>(tenantId),
      'createdAt': serializer.toJson<String>(createdAt),
      'updatedAt': serializer.toJson<String>(updatedAt),
      'deletedAt': serializer.toJson<String?>(deletedAt),
      'version': serializer.toJson<int>(version),
      'syncStatus': serializer.toJson<String>(syncStatus),
      'lastSyncedAt': serializer.toJson<String?>(lastSyncedAt),
      'workOrderId': serializer.toJson<String>(workOrderId),
      'reportNumber': serializer.toJson<String>(reportNumber),
      'status': serializer.toJson<String>(status),
      'pdfLocalPath': serializer.toJson<String?>(pdfLocalPath),
      'pdfRemoteUrl': serializer.toJson<String?>(pdfRemoteUrl),
      'generatedAt': serializer.toJson<String?>(generatedAt),
      'signedAt': serializer.toJson<String?>(signedAt),
      'customerNameSigned': serializer.toJson<String?>(customerNameSigned),
    };
  }

  ReportRow copyWith({
    String? id,
    String? tenantId,
    String? createdAt,
    String? updatedAt,
    Value<String?> deletedAt = const Value.absent(),
    int? version,
    String? syncStatus,
    Value<String?> lastSyncedAt = const Value.absent(),
    String? workOrderId,
    String? reportNumber,
    String? status,
    Value<String?> pdfLocalPath = const Value.absent(),
    Value<String?> pdfRemoteUrl = const Value.absent(),
    Value<String?> generatedAt = const Value.absent(),
    Value<String?> signedAt = const Value.absent(),
    Value<String?> customerNameSigned = const Value.absent(),
  }) => ReportRow(
    id: id ?? this.id,
    tenantId: tenantId ?? this.tenantId,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    version: version ?? this.version,
    syncStatus: syncStatus ?? this.syncStatus,
    lastSyncedAt: lastSyncedAt.present ? lastSyncedAt.value : this.lastSyncedAt,
    workOrderId: workOrderId ?? this.workOrderId,
    reportNumber: reportNumber ?? this.reportNumber,
    status: status ?? this.status,
    pdfLocalPath: pdfLocalPath.present ? pdfLocalPath.value : this.pdfLocalPath,
    pdfRemoteUrl: pdfRemoteUrl.present ? pdfRemoteUrl.value : this.pdfRemoteUrl,
    generatedAt: generatedAt.present ? generatedAt.value : this.generatedAt,
    signedAt: signedAt.present ? signedAt.value : this.signedAt,
    customerNameSigned: customerNameSigned.present
        ? customerNameSigned.value
        : this.customerNameSigned,
  );
  ReportRow copyWithCompanion(ReportsCompanion data) {
    return ReportRow(
      id: data.id.present ? data.id.value : this.id,
      tenantId: data.tenantId.present ? data.tenantId.value : this.tenantId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      version: data.version.present ? data.version.value : this.version,
      syncStatus: data.syncStatus.present
          ? data.syncStatus.value
          : this.syncStatus,
      lastSyncedAt: data.lastSyncedAt.present
          ? data.lastSyncedAt.value
          : this.lastSyncedAt,
      workOrderId: data.workOrderId.present
          ? data.workOrderId.value
          : this.workOrderId,
      reportNumber: data.reportNumber.present
          ? data.reportNumber.value
          : this.reportNumber,
      status: data.status.present ? data.status.value : this.status,
      pdfLocalPath: data.pdfLocalPath.present
          ? data.pdfLocalPath.value
          : this.pdfLocalPath,
      pdfRemoteUrl: data.pdfRemoteUrl.present
          ? data.pdfRemoteUrl.value
          : this.pdfRemoteUrl,
      generatedAt: data.generatedAt.present
          ? data.generatedAt.value
          : this.generatedAt,
      signedAt: data.signedAt.present ? data.signedAt.value : this.signedAt,
      customerNameSigned: data.customerNameSigned.present
          ? data.customerNameSigned.value
          : this.customerNameSigned,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ReportRow(')
          ..write('id: $id, ')
          ..write('tenantId: $tenantId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('version: $version, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('lastSyncedAt: $lastSyncedAt, ')
          ..write('workOrderId: $workOrderId, ')
          ..write('reportNumber: $reportNumber, ')
          ..write('status: $status, ')
          ..write('pdfLocalPath: $pdfLocalPath, ')
          ..write('pdfRemoteUrl: $pdfRemoteUrl, ')
          ..write('generatedAt: $generatedAt, ')
          ..write('signedAt: $signedAt, ')
          ..write('customerNameSigned: $customerNameSigned')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    tenantId,
    createdAt,
    updatedAt,
    deletedAt,
    version,
    syncStatus,
    lastSyncedAt,
    workOrderId,
    reportNumber,
    status,
    pdfLocalPath,
    pdfRemoteUrl,
    generatedAt,
    signedAt,
    customerNameSigned,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ReportRow &&
          other.id == this.id &&
          other.tenantId == this.tenantId &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.version == this.version &&
          other.syncStatus == this.syncStatus &&
          other.lastSyncedAt == this.lastSyncedAt &&
          other.workOrderId == this.workOrderId &&
          other.reportNumber == this.reportNumber &&
          other.status == this.status &&
          other.pdfLocalPath == this.pdfLocalPath &&
          other.pdfRemoteUrl == this.pdfRemoteUrl &&
          other.generatedAt == this.generatedAt &&
          other.signedAt == this.signedAt &&
          other.customerNameSigned == this.customerNameSigned);
}

class ReportsCompanion extends UpdateCompanion<ReportRow> {
  final Value<String> id;
  final Value<String> tenantId;
  final Value<String> createdAt;
  final Value<String> updatedAt;
  final Value<String?> deletedAt;
  final Value<int> version;
  final Value<String> syncStatus;
  final Value<String?> lastSyncedAt;
  final Value<String> workOrderId;
  final Value<String> reportNumber;
  final Value<String> status;
  final Value<String?> pdfLocalPath;
  final Value<String?> pdfRemoteUrl;
  final Value<String?> generatedAt;
  final Value<String?> signedAt;
  final Value<String?> customerNameSigned;
  final Value<int> rowid;
  const ReportsCompanion({
    this.id = const Value.absent(),
    this.tenantId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.version = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.lastSyncedAt = const Value.absent(),
    this.workOrderId = const Value.absent(),
    this.reportNumber = const Value.absent(),
    this.status = const Value.absent(),
    this.pdfLocalPath = const Value.absent(),
    this.pdfRemoteUrl = const Value.absent(),
    this.generatedAt = const Value.absent(),
    this.signedAt = const Value.absent(),
    this.customerNameSigned = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ReportsCompanion.insert({
    required String id,
    required String tenantId,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.version = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.lastSyncedAt = const Value.absent(),
    required String workOrderId,
    required String reportNumber,
    required String status,
    this.pdfLocalPath = const Value.absent(),
    this.pdfRemoteUrl = const Value.absent(),
    this.generatedAt = const Value.absent(),
    this.signedAt = const Value.absent(),
    this.customerNameSigned = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       tenantId = Value(tenantId),
       workOrderId = Value(workOrderId),
       reportNumber = Value(reportNumber),
       status = Value(status);
  static Insertable<ReportRow> custom({
    Expression<String>? id,
    Expression<String>? tenantId,
    Expression<String>? createdAt,
    Expression<String>? updatedAt,
    Expression<String>? deletedAt,
    Expression<int>? version,
    Expression<String>? syncStatus,
    Expression<String>? lastSyncedAt,
    Expression<String>? workOrderId,
    Expression<String>? reportNumber,
    Expression<String>? status,
    Expression<String>? pdfLocalPath,
    Expression<String>? pdfRemoteUrl,
    Expression<String>? generatedAt,
    Expression<String>? signedAt,
    Expression<String>? customerNameSigned,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (tenantId != null) 'tenant_id': tenantId,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (version != null) 'version': version,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (lastSyncedAt != null) 'last_synced_at': lastSyncedAt,
      if (workOrderId != null) 'work_order_id': workOrderId,
      if (reportNumber != null) 'report_number': reportNumber,
      if (status != null) 'status': status,
      if (pdfLocalPath != null) 'pdf_local_path': pdfLocalPath,
      if (pdfRemoteUrl != null) 'pdf_remote_url': pdfRemoteUrl,
      if (generatedAt != null) 'generated_at': generatedAt,
      if (signedAt != null) 'signed_at': signedAt,
      if (customerNameSigned != null)
        'customer_name_signed': customerNameSigned,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ReportsCompanion copyWith({
    Value<String>? id,
    Value<String>? tenantId,
    Value<String>? createdAt,
    Value<String>? updatedAt,
    Value<String?>? deletedAt,
    Value<int>? version,
    Value<String>? syncStatus,
    Value<String?>? lastSyncedAt,
    Value<String>? workOrderId,
    Value<String>? reportNumber,
    Value<String>? status,
    Value<String?>? pdfLocalPath,
    Value<String?>? pdfRemoteUrl,
    Value<String?>? generatedAt,
    Value<String?>? signedAt,
    Value<String?>? customerNameSigned,
    Value<int>? rowid,
  }) {
    return ReportsCompanion(
      id: id ?? this.id,
      tenantId: tenantId ?? this.tenantId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      version: version ?? this.version,
      syncStatus: syncStatus ?? this.syncStatus,
      lastSyncedAt: lastSyncedAt ?? this.lastSyncedAt,
      workOrderId: workOrderId ?? this.workOrderId,
      reportNumber: reportNumber ?? this.reportNumber,
      status: status ?? this.status,
      pdfLocalPath: pdfLocalPath ?? this.pdfLocalPath,
      pdfRemoteUrl: pdfRemoteUrl ?? this.pdfRemoteUrl,
      generatedAt: generatedAt ?? this.generatedAt,
      signedAt: signedAt ?? this.signedAt,
      customerNameSigned: customerNameSigned ?? this.customerNameSigned,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (tenantId.present) {
      map['tenant_id'] = Variable<String>(tenantId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<String>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<String>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<String>(deletedAt.value);
    }
    if (version.present) {
      map['version'] = Variable<int>(version.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(syncStatus.value);
    }
    if (lastSyncedAt.present) {
      map['last_synced_at'] = Variable<String>(lastSyncedAt.value);
    }
    if (workOrderId.present) {
      map['work_order_id'] = Variable<String>(workOrderId.value);
    }
    if (reportNumber.present) {
      map['report_number'] = Variable<String>(reportNumber.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (pdfLocalPath.present) {
      map['pdf_local_path'] = Variable<String>(pdfLocalPath.value);
    }
    if (pdfRemoteUrl.present) {
      map['pdf_remote_url'] = Variable<String>(pdfRemoteUrl.value);
    }
    if (generatedAt.present) {
      map['generated_at'] = Variable<String>(generatedAt.value);
    }
    if (signedAt.present) {
      map['signed_at'] = Variable<String>(signedAt.value);
    }
    if (customerNameSigned.present) {
      map['customer_name_signed'] = Variable<String>(customerNameSigned.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ReportsCompanion(')
          ..write('id: $id, ')
          ..write('tenantId: $tenantId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('version: $version, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('lastSyncedAt: $lastSyncedAt, ')
          ..write('workOrderId: $workOrderId, ')
          ..write('reportNumber: $reportNumber, ')
          ..write('status: $status, ')
          ..write('pdfLocalPath: $pdfLocalPath, ')
          ..write('pdfRemoteUrl: $pdfRemoteUrl, ')
          ..write('generatedAt: $generatedAt, ')
          ..write('signedAt: $signedAt, ')
          ..write('customerNameSigned: $customerNameSigned, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $OutboxEntriesTable extends OutboxEntries
    with TableInfo<$OutboxEntriesTable, OutboxEntryRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $OutboxEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _tenantIdMeta = const VerificationMeta(
    'tenantId',
  );
  @override
  late final GeneratedColumn<String> tenantId = GeneratedColumn<String>(
    'tenant_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<String> createdAt = GeneratedColumn<String>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: _utcNowIso,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<String> updatedAt = GeneratedColumn<String>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: _utcNowIso,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<String> deletedAt = GeneratedColumn<String>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _versionMeta = const VerificationMeta(
    'version',
  );
  @override
  late final GeneratedColumn<int> version = GeneratedColumn<int>(
    'version',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
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
    defaultValue: const Constant('synced'),
  );
  static const VerificationMeta _lastSyncedAtMeta = const VerificationMeta(
    'lastSyncedAt',
  );
  @override
  late final GeneratedColumn<String> lastSyncedAt = GeneratedColumn<String>(
    'last_synced_at',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _entityTypeMeta = const VerificationMeta(
    'entityType',
  );
  @override
  late final GeneratedColumn<String> entityType = GeneratedColumn<String>(
    'entity_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _entityIdMeta = const VerificationMeta(
    'entityId',
  );
  @override
  late final GeneratedColumn<String> entityId = GeneratedColumn<String>(
    'entity_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _operationMeta = const VerificationMeta(
    'operation',
  );
  @override
  late final GeneratedColumn<String> operation = GeneratedColumn<String>(
    'operation',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _payloadJsonMeta = const VerificationMeta(
    'payloadJson',
  );
  @override
  late final GeneratedColumn<String> payloadJson = GeneratedColumn<String>(
    'payload_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _attemptsMeta = const VerificationMeta(
    'attempts',
  );
  @override
  late final GeneratedColumn<int> attempts = GeneratedColumn<int>(
    'attempts',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _lastAttemptAtMeta = const VerificationMeta(
    'lastAttemptAt',
  );
  @override
  late final GeneratedColumn<String> lastAttemptAt = GeneratedColumn<String>(
    'last_attempt_at',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('pending'),
  );
  static const VerificationMeta _errorMessageMeta = const VerificationMeta(
    'errorMessage',
  );
  @override
  late final GeneratedColumn<String> errorMessage = GeneratedColumn<String>(
    'error_message',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    tenantId,
    createdAt,
    updatedAt,
    deletedAt,
    version,
    syncStatus,
    lastSyncedAt,
    entityType,
    entityId,
    operation,
    payloadJson,
    attempts,
    lastAttemptAt,
    status,
    errorMessage,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'outbox_entries';
  @override
  VerificationContext validateIntegrity(
    Insertable<OutboxEntryRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('tenant_id')) {
      context.handle(
        _tenantIdMeta,
        tenantId.isAcceptableOrUnknown(data['tenant_id']!, _tenantIdMeta),
      );
    } else if (isInserting) {
      context.missing(_tenantIdMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('version')) {
      context.handle(
        _versionMeta,
        version.isAcceptableOrUnknown(data['version']!, _versionMeta),
      );
    }
    if (data.containsKey('sync_status')) {
      context.handle(
        _syncStatusMeta,
        syncStatus.isAcceptableOrUnknown(data['sync_status']!, _syncStatusMeta),
      );
    }
    if (data.containsKey('last_synced_at')) {
      context.handle(
        _lastSyncedAtMeta,
        lastSyncedAt.isAcceptableOrUnknown(
          data['last_synced_at']!,
          _lastSyncedAtMeta,
        ),
      );
    }
    if (data.containsKey('entity_type')) {
      context.handle(
        _entityTypeMeta,
        entityType.isAcceptableOrUnknown(data['entity_type']!, _entityTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_entityTypeMeta);
    }
    if (data.containsKey('entity_id')) {
      context.handle(
        _entityIdMeta,
        entityId.isAcceptableOrUnknown(data['entity_id']!, _entityIdMeta),
      );
    } else if (isInserting) {
      context.missing(_entityIdMeta);
    }
    if (data.containsKey('operation')) {
      context.handle(
        _operationMeta,
        operation.isAcceptableOrUnknown(data['operation']!, _operationMeta),
      );
    } else if (isInserting) {
      context.missing(_operationMeta);
    }
    if (data.containsKey('payload_json')) {
      context.handle(
        _payloadJsonMeta,
        payloadJson.isAcceptableOrUnknown(
          data['payload_json']!,
          _payloadJsonMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_payloadJsonMeta);
    }
    if (data.containsKey('attempts')) {
      context.handle(
        _attemptsMeta,
        attempts.isAcceptableOrUnknown(data['attempts']!, _attemptsMeta),
      );
    }
    if (data.containsKey('last_attempt_at')) {
      context.handle(
        _lastAttemptAtMeta,
        lastAttemptAt.isAcceptableOrUnknown(
          data['last_attempt_at']!,
          _lastAttemptAtMeta,
        ),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('error_message')) {
      context.handle(
        _errorMessageMeta,
        errorMessage.isAcceptableOrUnknown(
          data['error_message']!,
          _errorMessageMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  OutboxEntryRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return OutboxEntryRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      tenantId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tenant_id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}deleted_at'],
      ),
      version: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}version'],
      )!,
      syncStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sync_status'],
      )!,
      lastSyncedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_synced_at'],
      ),
      entityType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}entity_type'],
      )!,
      entityId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}entity_id'],
      )!,
      operation: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}operation'],
      )!,
      payloadJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payload_json'],
      )!,
      attempts: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}attempts'],
      )!,
      lastAttemptAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_attempt_at'],
      ),
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      errorMessage: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}error_message'],
      ),
    );
  }

  @override
  $OutboxEntriesTable createAlias(String alias) {
    return $OutboxEntriesTable(attachedDatabase, alias);
  }
}

class OutboxEntryRow extends DataClass implements Insertable<OutboxEntryRow> {
  final String id;
  final String tenantId;
  final String createdAt;
  final String updatedAt;
  final String? deletedAt;
  final int version;
  final String syncStatus;
  final String? lastSyncedAt;
  final String entityType;
  final String entityId;
  final String operation;
  final String payloadJson;
  final int attempts;
  final String? lastAttemptAt;
  final String status;
  final String? errorMessage;
  const OutboxEntryRow({
    required this.id,
    required this.tenantId,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.version,
    required this.syncStatus,
    this.lastSyncedAt,
    required this.entityType,
    required this.entityId,
    required this.operation,
    required this.payloadJson,
    required this.attempts,
    this.lastAttemptAt,
    required this.status,
    this.errorMessage,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['tenant_id'] = Variable<String>(tenantId);
    map['created_at'] = Variable<String>(createdAt);
    map['updated_at'] = Variable<String>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<String>(deletedAt);
    }
    map['version'] = Variable<int>(version);
    map['sync_status'] = Variable<String>(syncStatus);
    if (!nullToAbsent || lastSyncedAt != null) {
      map['last_synced_at'] = Variable<String>(lastSyncedAt);
    }
    map['entity_type'] = Variable<String>(entityType);
    map['entity_id'] = Variable<String>(entityId);
    map['operation'] = Variable<String>(operation);
    map['payload_json'] = Variable<String>(payloadJson);
    map['attempts'] = Variable<int>(attempts);
    if (!nullToAbsent || lastAttemptAt != null) {
      map['last_attempt_at'] = Variable<String>(lastAttemptAt);
    }
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || errorMessage != null) {
      map['error_message'] = Variable<String>(errorMessage);
    }
    return map;
  }

  OutboxEntriesCompanion toCompanion(bool nullToAbsent) {
    return OutboxEntriesCompanion(
      id: Value(id),
      tenantId: Value(tenantId),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      version: Value(version),
      syncStatus: Value(syncStatus),
      lastSyncedAt: lastSyncedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastSyncedAt),
      entityType: Value(entityType),
      entityId: Value(entityId),
      operation: Value(operation),
      payloadJson: Value(payloadJson),
      attempts: Value(attempts),
      lastAttemptAt: lastAttemptAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastAttemptAt),
      status: Value(status),
      errorMessage: errorMessage == null && nullToAbsent
          ? const Value.absent()
          : Value(errorMessage),
    );
  }

  factory OutboxEntryRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return OutboxEntryRow(
      id: serializer.fromJson<String>(json['id']),
      tenantId: serializer.fromJson<String>(json['tenantId']),
      createdAt: serializer.fromJson<String>(json['createdAt']),
      updatedAt: serializer.fromJson<String>(json['updatedAt']),
      deletedAt: serializer.fromJson<String?>(json['deletedAt']),
      version: serializer.fromJson<int>(json['version']),
      syncStatus: serializer.fromJson<String>(json['syncStatus']),
      lastSyncedAt: serializer.fromJson<String?>(json['lastSyncedAt']),
      entityType: serializer.fromJson<String>(json['entityType']),
      entityId: serializer.fromJson<String>(json['entityId']),
      operation: serializer.fromJson<String>(json['operation']),
      payloadJson: serializer.fromJson<String>(json['payloadJson']),
      attempts: serializer.fromJson<int>(json['attempts']),
      lastAttemptAt: serializer.fromJson<String?>(json['lastAttemptAt']),
      status: serializer.fromJson<String>(json['status']),
      errorMessage: serializer.fromJson<String?>(json['errorMessage']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'tenantId': serializer.toJson<String>(tenantId),
      'createdAt': serializer.toJson<String>(createdAt),
      'updatedAt': serializer.toJson<String>(updatedAt),
      'deletedAt': serializer.toJson<String?>(deletedAt),
      'version': serializer.toJson<int>(version),
      'syncStatus': serializer.toJson<String>(syncStatus),
      'lastSyncedAt': serializer.toJson<String?>(lastSyncedAt),
      'entityType': serializer.toJson<String>(entityType),
      'entityId': serializer.toJson<String>(entityId),
      'operation': serializer.toJson<String>(operation),
      'payloadJson': serializer.toJson<String>(payloadJson),
      'attempts': serializer.toJson<int>(attempts),
      'lastAttemptAt': serializer.toJson<String?>(lastAttemptAt),
      'status': serializer.toJson<String>(status),
      'errorMessage': serializer.toJson<String?>(errorMessage),
    };
  }

  OutboxEntryRow copyWith({
    String? id,
    String? tenantId,
    String? createdAt,
    String? updatedAt,
    Value<String?> deletedAt = const Value.absent(),
    int? version,
    String? syncStatus,
    Value<String?> lastSyncedAt = const Value.absent(),
    String? entityType,
    String? entityId,
    String? operation,
    String? payloadJson,
    int? attempts,
    Value<String?> lastAttemptAt = const Value.absent(),
    String? status,
    Value<String?> errorMessage = const Value.absent(),
  }) => OutboxEntryRow(
    id: id ?? this.id,
    tenantId: tenantId ?? this.tenantId,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    version: version ?? this.version,
    syncStatus: syncStatus ?? this.syncStatus,
    lastSyncedAt: lastSyncedAt.present ? lastSyncedAt.value : this.lastSyncedAt,
    entityType: entityType ?? this.entityType,
    entityId: entityId ?? this.entityId,
    operation: operation ?? this.operation,
    payloadJson: payloadJson ?? this.payloadJson,
    attempts: attempts ?? this.attempts,
    lastAttemptAt: lastAttemptAt.present
        ? lastAttemptAt.value
        : this.lastAttemptAt,
    status: status ?? this.status,
    errorMessage: errorMessage.present ? errorMessage.value : this.errorMessage,
  );
  OutboxEntryRow copyWithCompanion(OutboxEntriesCompanion data) {
    return OutboxEntryRow(
      id: data.id.present ? data.id.value : this.id,
      tenantId: data.tenantId.present ? data.tenantId.value : this.tenantId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      version: data.version.present ? data.version.value : this.version,
      syncStatus: data.syncStatus.present
          ? data.syncStatus.value
          : this.syncStatus,
      lastSyncedAt: data.lastSyncedAt.present
          ? data.lastSyncedAt.value
          : this.lastSyncedAt,
      entityType: data.entityType.present
          ? data.entityType.value
          : this.entityType,
      entityId: data.entityId.present ? data.entityId.value : this.entityId,
      operation: data.operation.present ? data.operation.value : this.operation,
      payloadJson: data.payloadJson.present
          ? data.payloadJson.value
          : this.payloadJson,
      attempts: data.attempts.present ? data.attempts.value : this.attempts,
      lastAttemptAt: data.lastAttemptAt.present
          ? data.lastAttemptAt.value
          : this.lastAttemptAt,
      status: data.status.present ? data.status.value : this.status,
      errorMessage: data.errorMessage.present
          ? data.errorMessage.value
          : this.errorMessage,
    );
  }

  @override
  String toString() {
    return (StringBuffer('OutboxEntryRow(')
          ..write('id: $id, ')
          ..write('tenantId: $tenantId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('version: $version, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('lastSyncedAt: $lastSyncedAt, ')
          ..write('entityType: $entityType, ')
          ..write('entityId: $entityId, ')
          ..write('operation: $operation, ')
          ..write('payloadJson: $payloadJson, ')
          ..write('attempts: $attempts, ')
          ..write('lastAttemptAt: $lastAttemptAt, ')
          ..write('status: $status, ')
          ..write('errorMessage: $errorMessage')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    tenantId,
    createdAt,
    updatedAt,
    deletedAt,
    version,
    syncStatus,
    lastSyncedAt,
    entityType,
    entityId,
    operation,
    payloadJson,
    attempts,
    lastAttemptAt,
    status,
    errorMessage,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is OutboxEntryRow &&
          other.id == this.id &&
          other.tenantId == this.tenantId &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.version == this.version &&
          other.syncStatus == this.syncStatus &&
          other.lastSyncedAt == this.lastSyncedAt &&
          other.entityType == this.entityType &&
          other.entityId == this.entityId &&
          other.operation == this.operation &&
          other.payloadJson == this.payloadJson &&
          other.attempts == this.attempts &&
          other.lastAttemptAt == this.lastAttemptAt &&
          other.status == this.status &&
          other.errorMessage == this.errorMessage);
}

class OutboxEntriesCompanion extends UpdateCompanion<OutboxEntryRow> {
  final Value<String> id;
  final Value<String> tenantId;
  final Value<String> createdAt;
  final Value<String> updatedAt;
  final Value<String?> deletedAt;
  final Value<int> version;
  final Value<String> syncStatus;
  final Value<String?> lastSyncedAt;
  final Value<String> entityType;
  final Value<String> entityId;
  final Value<String> operation;
  final Value<String> payloadJson;
  final Value<int> attempts;
  final Value<String?> lastAttemptAt;
  final Value<String> status;
  final Value<String?> errorMessage;
  final Value<int> rowid;
  const OutboxEntriesCompanion({
    this.id = const Value.absent(),
    this.tenantId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.version = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.lastSyncedAt = const Value.absent(),
    this.entityType = const Value.absent(),
    this.entityId = const Value.absent(),
    this.operation = const Value.absent(),
    this.payloadJson = const Value.absent(),
    this.attempts = const Value.absent(),
    this.lastAttemptAt = const Value.absent(),
    this.status = const Value.absent(),
    this.errorMessage = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  OutboxEntriesCompanion.insert({
    required String id,
    required String tenantId,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.version = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.lastSyncedAt = const Value.absent(),
    required String entityType,
    required String entityId,
    required String operation,
    required String payloadJson,
    this.attempts = const Value.absent(),
    this.lastAttemptAt = const Value.absent(),
    this.status = const Value.absent(),
    this.errorMessage = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       tenantId = Value(tenantId),
       entityType = Value(entityType),
       entityId = Value(entityId),
       operation = Value(operation),
       payloadJson = Value(payloadJson);
  static Insertable<OutboxEntryRow> custom({
    Expression<String>? id,
    Expression<String>? tenantId,
    Expression<String>? createdAt,
    Expression<String>? updatedAt,
    Expression<String>? deletedAt,
    Expression<int>? version,
    Expression<String>? syncStatus,
    Expression<String>? lastSyncedAt,
    Expression<String>? entityType,
    Expression<String>? entityId,
    Expression<String>? operation,
    Expression<String>? payloadJson,
    Expression<int>? attempts,
    Expression<String>? lastAttemptAt,
    Expression<String>? status,
    Expression<String>? errorMessage,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (tenantId != null) 'tenant_id': tenantId,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (version != null) 'version': version,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (lastSyncedAt != null) 'last_synced_at': lastSyncedAt,
      if (entityType != null) 'entity_type': entityType,
      if (entityId != null) 'entity_id': entityId,
      if (operation != null) 'operation': operation,
      if (payloadJson != null) 'payload_json': payloadJson,
      if (attempts != null) 'attempts': attempts,
      if (lastAttemptAt != null) 'last_attempt_at': lastAttemptAt,
      if (status != null) 'status': status,
      if (errorMessage != null) 'error_message': errorMessage,
      if (rowid != null) 'rowid': rowid,
    });
  }

  OutboxEntriesCompanion copyWith({
    Value<String>? id,
    Value<String>? tenantId,
    Value<String>? createdAt,
    Value<String>? updatedAt,
    Value<String?>? deletedAt,
    Value<int>? version,
    Value<String>? syncStatus,
    Value<String?>? lastSyncedAt,
    Value<String>? entityType,
    Value<String>? entityId,
    Value<String>? operation,
    Value<String>? payloadJson,
    Value<int>? attempts,
    Value<String?>? lastAttemptAt,
    Value<String>? status,
    Value<String?>? errorMessage,
    Value<int>? rowid,
  }) {
    return OutboxEntriesCompanion(
      id: id ?? this.id,
      tenantId: tenantId ?? this.tenantId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      version: version ?? this.version,
      syncStatus: syncStatus ?? this.syncStatus,
      lastSyncedAt: lastSyncedAt ?? this.lastSyncedAt,
      entityType: entityType ?? this.entityType,
      entityId: entityId ?? this.entityId,
      operation: operation ?? this.operation,
      payloadJson: payloadJson ?? this.payloadJson,
      attempts: attempts ?? this.attempts,
      lastAttemptAt: lastAttemptAt ?? this.lastAttemptAt,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (tenantId.present) {
      map['tenant_id'] = Variable<String>(tenantId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<String>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<String>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<String>(deletedAt.value);
    }
    if (version.present) {
      map['version'] = Variable<int>(version.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(syncStatus.value);
    }
    if (lastSyncedAt.present) {
      map['last_synced_at'] = Variable<String>(lastSyncedAt.value);
    }
    if (entityType.present) {
      map['entity_type'] = Variable<String>(entityType.value);
    }
    if (entityId.present) {
      map['entity_id'] = Variable<String>(entityId.value);
    }
    if (operation.present) {
      map['operation'] = Variable<String>(operation.value);
    }
    if (payloadJson.present) {
      map['payload_json'] = Variable<String>(payloadJson.value);
    }
    if (attempts.present) {
      map['attempts'] = Variable<int>(attempts.value);
    }
    if (lastAttemptAt.present) {
      map['last_attempt_at'] = Variable<String>(lastAttemptAt.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (errorMessage.present) {
      map['error_message'] = Variable<String>(errorMessage.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('OutboxEntriesCompanion(')
          ..write('id: $id, ')
          ..write('tenantId: $tenantId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('version: $version, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('lastSyncedAt: $lastSyncedAt, ')
          ..write('entityType: $entityType, ')
          ..write('entityId: $entityId, ')
          ..write('operation: $operation, ')
          ..write('payloadJson: $payloadJson, ')
          ..write('attempts: $attempts, ')
          ..write('lastAttemptAt: $lastAttemptAt, ')
          ..write('status: $status, ')
          ..write('errorMessage: $errorMessage, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SyncStatesTable extends SyncStates
    with TableInfo<$SyncStatesTable, SyncStateRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SyncStatesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _tenantIdMeta = const VerificationMeta(
    'tenantId',
  );
  @override
  late final GeneratedColumn<String> tenantId = GeneratedColumn<String>(
    'tenant_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _entityTypeMeta = const VerificationMeta(
    'entityType',
  );
  @override
  late final GeneratedColumn<String> entityType = GeneratedColumn<String>(
    'entity_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lastPullAtMeta = const VerificationMeta(
    'lastPullAt',
  );
  @override
  late final GeneratedColumn<String> lastPullAt = GeneratedColumn<String>(
    'last_pull_at',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lastSuccessfulSyncAtMeta =
      const VerificationMeta('lastSuccessfulSyncAt');
  @override
  late final GeneratedColumn<String> lastSuccessfulSyncAt =
      GeneratedColumn<String>(
        'last_successful_sync_at',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _cursorMeta = const VerificationMeta('cursor');
  @override
  late final GeneratedColumn<String> cursor = GeneratedColumn<String>(
    'cursor',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    tenantId,
    entityType,
    lastPullAt,
    lastSuccessfulSyncAt,
    cursor,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sync_states';
  @override
  VerificationContext validateIntegrity(
    Insertable<SyncStateRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('tenant_id')) {
      context.handle(
        _tenantIdMeta,
        tenantId.isAcceptableOrUnknown(data['tenant_id']!, _tenantIdMeta),
      );
    } else if (isInserting) {
      context.missing(_tenantIdMeta);
    }
    if (data.containsKey('entity_type')) {
      context.handle(
        _entityTypeMeta,
        entityType.isAcceptableOrUnknown(data['entity_type']!, _entityTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_entityTypeMeta);
    }
    if (data.containsKey('last_pull_at')) {
      context.handle(
        _lastPullAtMeta,
        lastPullAt.isAcceptableOrUnknown(
          data['last_pull_at']!,
          _lastPullAtMeta,
        ),
      );
    }
    if (data.containsKey('last_successful_sync_at')) {
      context.handle(
        _lastSuccessfulSyncAtMeta,
        lastSuccessfulSyncAt.isAcceptableOrUnknown(
          data['last_successful_sync_at']!,
          _lastSuccessfulSyncAtMeta,
        ),
      );
    }
    if (data.containsKey('cursor')) {
      context.handle(
        _cursorMeta,
        cursor.isAcceptableOrUnknown(data['cursor']!, _cursorMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SyncStateRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SyncStateRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      tenantId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tenant_id'],
      )!,
      entityType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}entity_type'],
      )!,
      lastPullAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_pull_at'],
      ),
      lastSuccessfulSyncAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_successful_sync_at'],
      ),
      cursor: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}cursor'],
      ),
    );
  }

  @override
  $SyncStatesTable createAlias(String alias) {
    return $SyncStatesTable(attachedDatabase, alias);
  }
}

class SyncStateRow extends DataClass implements Insertable<SyncStateRow> {
  final String id;
  final String tenantId;
  final String entityType;
  final String? lastPullAt;
  final String? lastSuccessfulSyncAt;
  final String? cursor;
  const SyncStateRow({
    required this.id,
    required this.tenantId,
    required this.entityType,
    this.lastPullAt,
    this.lastSuccessfulSyncAt,
    this.cursor,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['tenant_id'] = Variable<String>(tenantId);
    map['entity_type'] = Variable<String>(entityType);
    if (!nullToAbsent || lastPullAt != null) {
      map['last_pull_at'] = Variable<String>(lastPullAt);
    }
    if (!nullToAbsent || lastSuccessfulSyncAt != null) {
      map['last_successful_sync_at'] = Variable<String>(lastSuccessfulSyncAt);
    }
    if (!nullToAbsent || cursor != null) {
      map['cursor'] = Variable<String>(cursor);
    }
    return map;
  }

  SyncStatesCompanion toCompanion(bool nullToAbsent) {
    return SyncStatesCompanion(
      id: Value(id),
      tenantId: Value(tenantId),
      entityType: Value(entityType),
      lastPullAt: lastPullAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastPullAt),
      lastSuccessfulSyncAt: lastSuccessfulSyncAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastSuccessfulSyncAt),
      cursor: cursor == null && nullToAbsent
          ? const Value.absent()
          : Value(cursor),
    );
  }

  factory SyncStateRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SyncStateRow(
      id: serializer.fromJson<String>(json['id']),
      tenantId: serializer.fromJson<String>(json['tenantId']),
      entityType: serializer.fromJson<String>(json['entityType']),
      lastPullAt: serializer.fromJson<String?>(json['lastPullAt']),
      lastSuccessfulSyncAt: serializer.fromJson<String?>(
        json['lastSuccessfulSyncAt'],
      ),
      cursor: serializer.fromJson<String?>(json['cursor']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'tenantId': serializer.toJson<String>(tenantId),
      'entityType': serializer.toJson<String>(entityType),
      'lastPullAt': serializer.toJson<String?>(lastPullAt),
      'lastSuccessfulSyncAt': serializer.toJson<String?>(lastSuccessfulSyncAt),
      'cursor': serializer.toJson<String?>(cursor),
    };
  }

  SyncStateRow copyWith({
    String? id,
    String? tenantId,
    String? entityType,
    Value<String?> lastPullAt = const Value.absent(),
    Value<String?> lastSuccessfulSyncAt = const Value.absent(),
    Value<String?> cursor = const Value.absent(),
  }) => SyncStateRow(
    id: id ?? this.id,
    tenantId: tenantId ?? this.tenantId,
    entityType: entityType ?? this.entityType,
    lastPullAt: lastPullAt.present ? lastPullAt.value : this.lastPullAt,
    lastSuccessfulSyncAt: lastSuccessfulSyncAt.present
        ? lastSuccessfulSyncAt.value
        : this.lastSuccessfulSyncAt,
    cursor: cursor.present ? cursor.value : this.cursor,
  );
  SyncStateRow copyWithCompanion(SyncStatesCompanion data) {
    return SyncStateRow(
      id: data.id.present ? data.id.value : this.id,
      tenantId: data.tenantId.present ? data.tenantId.value : this.tenantId,
      entityType: data.entityType.present
          ? data.entityType.value
          : this.entityType,
      lastPullAt: data.lastPullAt.present
          ? data.lastPullAt.value
          : this.lastPullAt,
      lastSuccessfulSyncAt: data.lastSuccessfulSyncAt.present
          ? data.lastSuccessfulSyncAt.value
          : this.lastSuccessfulSyncAt,
      cursor: data.cursor.present ? data.cursor.value : this.cursor,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SyncStateRow(')
          ..write('id: $id, ')
          ..write('tenantId: $tenantId, ')
          ..write('entityType: $entityType, ')
          ..write('lastPullAt: $lastPullAt, ')
          ..write('lastSuccessfulSyncAt: $lastSuccessfulSyncAt, ')
          ..write('cursor: $cursor')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    tenantId,
    entityType,
    lastPullAt,
    lastSuccessfulSyncAt,
    cursor,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SyncStateRow &&
          other.id == this.id &&
          other.tenantId == this.tenantId &&
          other.entityType == this.entityType &&
          other.lastPullAt == this.lastPullAt &&
          other.lastSuccessfulSyncAt == this.lastSuccessfulSyncAt &&
          other.cursor == this.cursor);
}

class SyncStatesCompanion extends UpdateCompanion<SyncStateRow> {
  final Value<String> id;
  final Value<String> tenantId;
  final Value<String> entityType;
  final Value<String?> lastPullAt;
  final Value<String?> lastSuccessfulSyncAt;
  final Value<String?> cursor;
  final Value<int> rowid;
  const SyncStatesCompanion({
    this.id = const Value.absent(),
    this.tenantId = const Value.absent(),
    this.entityType = const Value.absent(),
    this.lastPullAt = const Value.absent(),
    this.lastSuccessfulSyncAt = const Value.absent(),
    this.cursor = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SyncStatesCompanion.insert({
    required String id,
    required String tenantId,
    required String entityType,
    this.lastPullAt = const Value.absent(),
    this.lastSuccessfulSyncAt = const Value.absent(),
    this.cursor = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       tenantId = Value(tenantId),
       entityType = Value(entityType);
  static Insertable<SyncStateRow> custom({
    Expression<String>? id,
    Expression<String>? tenantId,
    Expression<String>? entityType,
    Expression<String>? lastPullAt,
    Expression<String>? lastSuccessfulSyncAt,
    Expression<String>? cursor,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (tenantId != null) 'tenant_id': tenantId,
      if (entityType != null) 'entity_type': entityType,
      if (lastPullAt != null) 'last_pull_at': lastPullAt,
      if (lastSuccessfulSyncAt != null)
        'last_successful_sync_at': lastSuccessfulSyncAt,
      if (cursor != null) 'cursor': cursor,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SyncStatesCompanion copyWith({
    Value<String>? id,
    Value<String>? tenantId,
    Value<String>? entityType,
    Value<String?>? lastPullAt,
    Value<String?>? lastSuccessfulSyncAt,
    Value<String?>? cursor,
    Value<int>? rowid,
  }) {
    return SyncStatesCompanion(
      id: id ?? this.id,
      tenantId: tenantId ?? this.tenantId,
      entityType: entityType ?? this.entityType,
      lastPullAt: lastPullAt ?? this.lastPullAt,
      lastSuccessfulSyncAt: lastSuccessfulSyncAt ?? this.lastSuccessfulSyncAt,
      cursor: cursor ?? this.cursor,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (tenantId.present) {
      map['tenant_id'] = Variable<String>(tenantId.value);
    }
    if (entityType.present) {
      map['entity_type'] = Variable<String>(entityType.value);
    }
    if (lastPullAt.present) {
      map['last_pull_at'] = Variable<String>(lastPullAt.value);
    }
    if (lastSuccessfulSyncAt.present) {
      map['last_successful_sync_at'] = Variable<String>(
        lastSuccessfulSyncAt.value,
      );
    }
    if (cursor.present) {
      map['cursor'] = Variable<String>(cursor.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SyncStatesCompanion(')
          ..write('id: $id, ')
          ..write('tenantId: $tenantId, ')
          ..write('entityType: $entityType, ')
          ..write('lastPullAt: $lastPullAt, ')
          ..write('lastSuccessfulSyncAt: $lastSuccessfulSyncAt, ')
          ..write('cursor: $cursor, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $TenantsTable tenants = $TenantsTable(this);
  late final $UsersTable users = $UsersTable(this);
  late final $CustomersTable customers = $CustomersTable(this);
  late final $CustomerObjectsTable customerObjects = $CustomerObjectsTable(
    this,
  );
  late final $InstallationsTable installations = $InstallationsTable(this);
  late final $WorkOrdersTable workOrders = $WorkOrdersTable(this);
  late final $WorkOrderInstallationsTable workOrderInstallations =
      $WorkOrderInstallationsTable(this);
  late final $ChecklistTemplatesTable checklistTemplates =
      $ChecklistTemplatesTable(this);
  late final $ChecklistTemplateItemsTable checklistTemplateItems =
      $ChecklistTemplateItemsTable(this);
  late final $ChecklistAnswersTable checklistAnswers = $ChecklistAnswersTable(
    this,
  );
  late final $MeasurementsTable measurements = $MeasurementsTable(this);
  late final $DefectsTable defects = $DefectsTable(this);
  late final $PhotosTable photos = $PhotosTable(this);
  late final $TimeEntriesTable timeEntries = $TimeEntriesTable(this);
  late final $MaterialsTable materials = $MaterialsTable(this);
  late final $WorkOrderMaterialsTable workOrderMaterials =
      $WorkOrderMaterialsTable(this);
  late final $ReportsTable reports = $ReportsTable(this);
  late final $OutboxEntriesTable outboxEntries = $OutboxEntriesTable(this);
  late final $SyncStatesTable syncStates = $SyncStatesTable(this);
  late final UserDao userDao = UserDao(this as AppDatabase);
  late final CustomerDao customerDao = CustomerDao(this as AppDatabase);
  late final ObjectDao objectDao = ObjectDao(this as AppDatabase);
  late final InstallationDao installationDao = InstallationDao(
    this as AppDatabase,
  );
  late final WorkOrderDao workOrderDao = WorkOrderDao(this as AppDatabase);
  late final ChecklistDao checklistDao = ChecklistDao(this as AppDatabase);
  late final MeasurementDao measurementDao = MeasurementDao(
    this as AppDatabase,
  );
  late final DefectDao defectDao = DefectDao(this as AppDatabase);
  late final PhotoDao photoDao = PhotoDao(this as AppDatabase);
  late final TimeEntryDao timeEntryDao = TimeEntryDao(this as AppDatabase);
  late final MaterialDao materialDao = MaterialDao(this as AppDatabase);
  late final ReportDao reportDao = ReportDao(this as AppDatabase);
  late final OutboxDao outboxDao = OutboxDao(this as AppDatabase);
  late final SyncStateDao syncStateDao = SyncStateDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    tenants,
    users,
    customers,
    customerObjects,
    installations,
    workOrders,
    workOrderInstallations,
    checklistTemplates,
    checklistTemplateItems,
    checklistAnswers,
    measurements,
    defects,
    photos,
    timeEntries,
    materials,
    workOrderMaterials,
    reports,
    outboxEntries,
    syncStates,
  ];
}

typedef $$TenantsTableCreateCompanionBuilder =
    TenantsCompanion Function({
      required String id,
      required String tenantId,
      Value<String> createdAt,
      Value<String> updatedAt,
      Value<String?> deletedAt,
      Value<int> version,
      Value<String> syncStatus,
      Value<String?> lastSyncedAt,
      required String name,
      required String address,
      required String postalCode,
      required String city,
      required String country,
      required String phone,
      required String email,
      Value<String?> logoFileId,
      Value<int> rowid,
    });
typedef $$TenantsTableUpdateCompanionBuilder =
    TenantsCompanion Function({
      Value<String> id,
      Value<String> tenantId,
      Value<String> createdAt,
      Value<String> updatedAt,
      Value<String?> deletedAt,
      Value<int> version,
      Value<String> syncStatus,
      Value<String?> lastSyncedAt,
      Value<String> name,
      Value<String> address,
      Value<String> postalCode,
      Value<String> city,
      Value<String> country,
      Value<String> phone,
      Value<String> email,
      Value<String?> logoFileId,
      Value<int> rowid,
    });

class $$TenantsTableFilterComposer
    extends Composer<_$AppDatabase, $TenantsTable> {
  $$TenantsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tenantId => $composableBuilder(
    column: $table.tenantId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastSyncedAt => $composableBuilder(
    column: $table.lastSyncedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get postalCode => $composableBuilder(
    column: $table.postalCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get city => $composableBuilder(
    column: $table.city,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get country => $composableBuilder(
    column: $table.country,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get logoFileId => $composableBuilder(
    column: $table.logoFileId,
    builder: (column) => ColumnFilters(column),
  );
}

class $$TenantsTableOrderingComposer
    extends Composer<_$AppDatabase, $TenantsTable> {
  $$TenantsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tenantId => $composableBuilder(
    column: $table.tenantId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastSyncedAt => $composableBuilder(
    column: $table.lastSyncedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get postalCode => $composableBuilder(
    column: $table.postalCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get city => $composableBuilder(
    column: $table.city,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get country => $composableBuilder(
    column: $table.country,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get logoFileId => $composableBuilder(
    column: $table.logoFileId,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TenantsTableAnnotationComposer
    extends Composer<_$AppDatabase, $TenantsTable> {
  $$TenantsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get tenantId =>
      $composableBuilder(column: $table.tenantId, builder: (column) => column);

  GeneratedColumn<String> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<int> get version =>
      $composableBuilder(column: $table.version, builder: (column) => column);

  GeneratedColumn<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => column,
  );

  GeneratedColumn<String> get lastSyncedAt => $composableBuilder(
    column: $table.lastSyncedAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get address =>
      $composableBuilder(column: $table.address, builder: (column) => column);

  GeneratedColumn<String> get postalCode => $composableBuilder(
    column: $table.postalCode,
    builder: (column) => column,
  );

  GeneratedColumn<String> get city =>
      $composableBuilder(column: $table.city, builder: (column) => column);

  GeneratedColumn<String> get country =>
      $composableBuilder(column: $table.country, builder: (column) => column);

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get logoFileId => $composableBuilder(
    column: $table.logoFileId,
    builder: (column) => column,
  );
}

class $$TenantsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TenantsTable,
          TenantRow,
          $$TenantsTableFilterComposer,
          $$TenantsTableOrderingComposer,
          $$TenantsTableAnnotationComposer,
          $$TenantsTableCreateCompanionBuilder,
          $$TenantsTableUpdateCompanionBuilder,
          (TenantRow, BaseReferences<_$AppDatabase, $TenantsTable, TenantRow>),
          TenantRow,
          PrefetchHooks Function()
        > {
  $$TenantsTableTableManager(_$AppDatabase db, $TenantsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TenantsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TenantsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TenantsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> tenantId = const Value.absent(),
                Value<String> createdAt = const Value.absent(),
                Value<String> updatedAt = const Value.absent(),
                Value<String?> deletedAt = const Value.absent(),
                Value<int> version = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<String?> lastSyncedAt = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> address = const Value.absent(),
                Value<String> postalCode = const Value.absent(),
                Value<String> city = const Value.absent(),
                Value<String> country = const Value.absent(),
                Value<String> phone = const Value.absent(),
                Value<String> email = const Value.absent(),
                Value<String?> logoFileId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TenantsCompanion(
                id: id,
                tenantId: tenantId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                version: version,
                syncStatus: syncStatus,
                lastSyncedAt: lastSyncedAt,
                name: name,
                address: address,
                postalCode: postalCode,
                city: city,
                country: country,
                phone: phone,
                email: email,
                logoFileId: logoFileId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String tenantId,
                Value<String> createdAt = const Value.absent(),
                Value<String> updatedAt = const Value.absent(),
                Value<String?> deletedAt = const Value.absent(),
                Value<int> version = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<String?> lastSyncedAt = const Value.absent(),
                required String name,
                required String address,
                required String postalCode,
                required String city,
                required String country,
                required String phone,
                required String email,
                Value<String?> logoFileId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TenantsCompanion.insert(
                id: id,
                tenantId: tenantId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                version: version,
                syncStatus: syncStatus,
                lastSyncedAt: lastSyncedAt,
                name: name,
                address: address,
                postalCode: postalCode,
                city: city,
                country: country,
                phone: phone,
                email: email,
                logoFileId: logoFileId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$TenantsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TenantsTable,
      TenantRow,
      $$TenantsTableFilterComposer,
      $$TenantsTableOrderingComposer,
      $$TenantsTableAnnotationComposer,
      $$TenantsTableCreateCompanionBuilder,
      $$TenantsTableUpdateCompanionBuilder,
      (TenantRow, BaseReferences<_$AppDatabase, $TenantsTable, TenantRow>),
      TenantRow,
      PrefetchHooks Function()
    >;
typedef $$UsersTableCreateCompanionBuilder =
    UsersCompanion Function({
      required String id,
      required String tenantId,
      Value<String> createdAt,
      Value<String> updatedAt,
      Value<String?> deletedAt,
      Value<int> version,
      Value<String> syncStatus,
      Value<String?> lastSyncedAt,
      required String firstName,
      required String lastName,
      required String email,
      Value<String?> phone,
      required String role,
      Value<bool> isActive,
      Value<int> rowid,
    });
typedef $$UsersTableUpdateCompanionBuilder =
    UsersCompanion Function({
      Value<String> id,
      Value<String> tenantId,
      Value<String> createdAt,
      Value<String> updatedAt,
      Value<String?> deletedAt,
      Value<int> version,
      Value<String> syncStatus,
      Value<String?> lastSyncedAt,
      Value<String> firstName,
      Value<String> lastName,
      Value<String> email,
      Value<String?> phone,
      Value<String> role,
      Value<bool> isActive,
      Value<int> rowid,
    });

class $$UsersTableFilterComposer extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tenantId => $composableBuilder(
    column: $table.tenantId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastSyncedAt => $composableBuilder(
    column: $table.lastSyncedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get firstName => $composableBuilder(
    column: $table.firstName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastName => $composableBuilder(
    column: $table.lastName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );
}

class $$UsersTableOrderingComposer
    extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tenantId => $composableBuilder(
    column: $table.tenantId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastSyncedAt => $composableBuilder(
    column: $table.lastSyncedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get firstName => $composableBuilder(
    column: $table.firstName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastName => $composableBuilder(
    column: $table.lastName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$UsersTableAnnotationComposer
    extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get tenantId =>
      $composableBuilder(column: $table.tenantId, builder: (column) => column);

  GeneratedColumn<String> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<int> get version =>
      $composableBuilder(column: $table.version, builder: (column) => column);

  GeneratedColumn<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => column,
  );

  GeneratedColumn<String> get lastSyncedAt => $composableBuilder(
    column: $table.lastSyncedAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get firstName =>
      $composableBuilder(column: $table.firstName, builder: (column) => column);

  GeneratedColumn<String> get lastName =>
      $composableBuilder(column: $table.lastName, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<String> get role =>
      $composableBuilder(column: $table.role, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);
}

class $$UsersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UsersTable,
          UserRow,
          $$UsersTableFilterComposer,
          $$UsersTableOrderingComposer,
          $$UsersTableAnnotationComposer,
          $$UsersTableCreateCompanionBuilder,
          $$UsersTableUpdateCompanionBuilder,
          (UserRow, BaseReferences<_$AppDatabase, $UsersTable, UserRow>),
          UserRow,
          PrefetchHooks Function()
        > {
  $$UsersTableTableManager(_$AppDatabase db, $UsersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UsersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UsersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UsersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> tenantId = const Value.absent(),
                Value<String> createdAt = const Value.absent(),
                Value<String> updatedAt = const Value.absent(),
                Value<String?> deletedAt = const Value.absent(),
                Value<int> version = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<String?> lastSyncedAt = const Value.absent(),
                Value<String> firstName = const Value.absent(),
                Value<String> lastName = const Value.absent(),
                Value<String> email = const Value.absent(),
                Value<String?> phone = const Value.absent(),
                Value<String> role = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => UsersCompanion(
                id: id,
                tenantId: tenantId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                version: version,
                syncStatus: syncStatus,
                lastSyncedAt: lastSyncedAt,
                firstName: firstName,
                lastName: lastName,
                email: email,
                phone: phone,
                role: role,
                isActive: isActive,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String tenantId,
                Value<String> createdAt = const Value.absent(),
                Value<String> updatedAt = const Value.absent(),
                Value<String?> deletedAt = const Value.absent(),
                Value<int> version = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<String?> lastSyncedAt = const Value.absent(),
                required String firstName,
                required String lastName,
                required String email,
                Value<String?> phone = const Value.absent(),
                required String role,
                Value<bool> isActive = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => UsersCompanion.insert(
                id: id,
                tenantId: tenantId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                version: version,
                syncStatus: syncStatus,
                lastSyncedAt: lastSyncedAt,
                firstName: firstName,
                lastName: lastName,
                email: email,
                phone: phone,
                role: role,
                isActive: isActive,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$UsersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UsersTable,
      UserRow,
      $$UsersTableFilterComposer,
      $$UsersTableOrderingComposer,
      $$UsersTableAnnotationComposer,
      $$UsersTableCreateCompanionBuilder,
      $$UsersTableUpdateCompanionBuilder,
      (UserRow, BaseReferences<_$AppDatabase, $UsersTable, UserRow>),
      UserRow,
      PrefetchHooks Function()
    >;
typedef $$CustomersTableCreateCompanionBuilder =
    CustomersCompanion Function({
      required String id,
      required String tenantId,
      Value<String> createdAt,
      Value<String> updatedAt,
      Value<String?> deletedAt,
      Value<int> version,
      Value<String> syncStatus,
      Value<String?> lastSyncedAt,
      required String type,
      required String displayName,
      Value<String?> firstName,
      Value<String?> lastName,
      Value<String?> companyName,
      Value<String?> email,
      Value<String?> phone,
      Value<String?> mobile,
      Value<String?> billingAddress,
      Value<String?> notes,
      Value<int> rowid,
    });
typedef $$CustomersTableUpdateCompanionBuilder =
    CustomersCompanion Function({
      Value<String> id,
      Value<String> tenantId,
      Value<String> createdAt,
      Value<String> updatedAt,
      Value<String?> deletedAt,
      Value<int> version,
      Value<String> syncStatus,
      Value<String?> lastSyncedAt,
      Value<String> type,
      Value<String> displayName,
      Value<String?> firstName,
      Value<String?> lastName,
      Value<String?> companyName,
      Value<String?> email,
      Value<String?> phone,
      Value<String?> mobile,
      Value<String?> billingAddress,
      Value<String?> notes,
      Value<int> rowid,
    });

class $$CustomersTableFilterComposer
    extends Composer<_$AppDatabase, $CustomersTable> {
  $$CustomersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tenantId => $composableBuilder(
    column: $table.tenantId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastSyncedAt => $composableBuilder(
    column: $table.lastSyncedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get firstName => $composableBuilder(
    column: $table.firstName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastName => $composableBuilder(
    column: $table.lastName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get companyName => $composableBuilder(
    column: $table.companyName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get mobile => $composableBuilder(
    column: $table.mobile,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get billingAddress => $composableBuilder(
    column: $table.billingAddress,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CustomersTableOrderingComposer
    extends Composer<_$AppDatabase, $CustomersTable> {
  $$CustomersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tenantId => $composableBuilder(
    column: $table.tenantId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastSyncedAt => $composableBuilder(
    column: $table.lastSyncedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get firstName => $composableBuilder(
    column: $table.firstName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastName => $composableBuilder(
    column: $table.lastName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get companyName => $composableBuilder(
    column: $table.companyName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get mobile => $composableBuilder(
    column: $table.mobile,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get billingAddress => $composableBuilder(
    column: $table.billingAddress,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CustomersTableAnnotationComposer
    extends Composer<_$AppDatabase, $CustomersTable> {
  $$CustomersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get tenantId =>
      $composableBuilder(column: $table.tenantId, builder: (column) => column);

  GeneratedColumn<String> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<int> get version =>
      $composableBuilder(column: $table.version, builder: (column) => column);

  GeneratedColumn<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => column,
  );

  GeneratedColumn<String> get lastSyncedAt => $composableBuilder(
    column: $table.lastSyncedAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get firstName =>
      $composableBuilder(column: $table.firstName, builder: (column) => column);

  GeneratedColumn<String> get lastName =>
      $composableBuilder(column: $table.lastName, builder: (column) => column);

  GeneratedColumn<String> get companyName => $composableBuilder(
    column: $table.companyName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<String> get mobile =>
      $composableBuilder(column: $table.mobile, builder: (column) => column);

  GeneratedColumn<String> get billingAddress => $composableBuilder(
    column: $table.billingAddress,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);
}

class $$CustomersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CustomersTable,
          CustomerRow,
          $$CustomersTableFilterComposer,
          $$CustomersTableOrderingComposer,
          $$CustomersTableAnnotationComposer,
          $$CustomersTableCreateCompanionBuilder,
          $$CustomersTableUpdateCompanionBuilder,
          (
            CustomerRow,
            BaseReferences<_$AppDatabase, $CustomersTable, CustomerRow>,
          ),
          CustomerRow,
          PrefetchHooks Function()
        > {
  $$CustomersTableTableManager(_$AppDatabase db, $CustomersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CustomersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CustomersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CustomersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> tenantId = const Value.absent(),
                Value<String> createdAt = const Value.absent(),
                Value<String> updatedAt = const Value.absent(),
                Value<String?> deletedAt = const Value.absent(),
                Value<int> version = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<String?> lastSyncedAt = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<String> displayName = const Value.absent(),
                Value<String?> firstName = const Value.absent(),
                Value<String?> lastName = const Value.absent(),
                Value<String?> companyName = const Value.absent(),
                Value<String?> email = const Value.absent(),
                Value<String?> phone = const Value.absent(),
                Value<String?> mobile = const Value.absent(),
                Value<String?> billingAddress = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CustomersCompanion(
                id: id,
                tenantId: tenantId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                version: version,
                syncStatus: syncStatus,
                lastSyncedAt: lastSyncedAt,
                type: type,
                displayName: displayName,
                firstName: firstName,
                lastName: lastName,
                companyName: companyName,
                email: email,
                phone: phone,
                mobile: mobile,
                billingAddress: billingAddress,
                notes: notes,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String tenantId,
                Value<String> createdAt = const Value.absent(),
                Value<String> updatedAt = const Value.absent(),
                Value<String?> deletedAt = const Value.absent(),
                Value<int> version = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<String?> lastSyncedAt = const Value.absent(),
                required String type,
                required String displayName,
                Value<String?> firstName = const Value.absent(),
                Value<String?> lastName = const Value.absent(),
                Value<String?> companyName = const Value.absent(),
                Value<String?> email = const Value.absent(),
                Value<String?> phone = const Value.absent(),
                Value<String?> mobile = const Value.absent(),
                Value<String?> billingAddress = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CustomersCompanion.insert(
                id: id,
                tenantId: tenantId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                version: version,
                syncStatus: syncStatus,
                lastSyncedAt: lastSyncedAt,
                type: type,
                displayName: displayName,
                firstName: firstName,
                lastName: lastName,
                companyName: companyName,
                email: email,
                phone: phone,
                mobile: mobile,
                billingAddress: billingAddress,
                notes: notes,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CustomersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CustomersTable,
      CustomerRow,
      $$CustomersTableFilterComposer,
      $$CustomersTableOrderingComposer,
      $$CustomersTableAnnotationComposer,
      $$CustomersTableCreateCompanionBuilder,
      $$CustomersTableUpdateCompanionBuilder,
      (
        CustomerRow,
        BaseReferences<_$AppDatabase, $CustomersTable, CustomerRow>,
      ),
      CustomerRow,
      PrefetchHooks Function()
    >;
typedef $$CustomerObjectsTableCreateCompanionBuilder =
    CustomerObjectsCompanion Function({
      required String id,
      required String tenantId,
      Value<String> createdAt,
      Value<String> updatedAt,
      Value<String?> deletedAt,
      Value<int> version,
      Value<String> syncStatus,
      Value<String?> lastSyncedAt,
      required String customerId,
      required String name,
      required String street,
      required String houseNumber,
      required String postalCode,
      required String city,
      required String country,
      Value<double?> latitude,
      Value<double?> longitude,
      Value<String?> accessNotes,
      Value<String?> safetyNotes,
      Value<String?> objectNotes,
      Value<int> rowid,
    });
typedef $$CustomerObjectsTableUpdateCompanionBuilder =
    CustomerObjectsCompanion Function({
      Value<String> id,
      Value<String> tenantId,
      Value<String> createdAt,
      Value<String> updatedAt,
      Value<String?> deletedAt,
      Value<int> version,
      Value<String> syncStatus,
      Value<String?> lastSyncedAt,
      Value<String> customerId,
      Value<String> name,
      Value<String> street,
      Value<String> houseNumber,
      Value<String> postalCode,
      Value<String> city,
      Value<String> country,
      Value<double?> latitude,
      Value<double?> longitude,
      Value<String?> accessNotes,
      Value<String?> safetyNotes,
      Value<String?> objectNotes,
      Value<int> rowid,
    });

class $$CustomerObjectsTableFilterComposer
    extends Composer<_$AppDatabase, $CustomerObjectsTable> {
  $$CustomerObjectsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tenantId => $composableBuilder(
    column: $table.tenantId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastSyncedAt => $composableBuilder(
    column: $table.lastSyncedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get customerId => $composableBuilder(
    column: $table.customerId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get street => $composableBuilder(
    column: $table.street,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get houseNumber => $composableBuilder(
    column: $table.houseNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get postalCode => $composableBuilder(
    column: $table.postalCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get city => $composableBuilder(
    column: $table.city,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get country => $composableBuilder(
    column: $table.country,
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

  ColumnFilters<String> get accessNotes => $composableBuilder(
    column: $table.accessNotes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get safetyNotes => $composableBuilder(
    column: $table.safetyNotes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get objectNotes => $composableBuilder(
    column: $table.objectNotes,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CustomerObjectsTableOrderingComposer
    extends Composer<_$AppDatabase, $CustomerObjectsTable> {
  $$CustomerObjectsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tenantId => $composableBuilder(
    column: $table.tenantId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastSyncedAt => $composableBuilder(
    column: $table.lastSyncedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get customerId => $composableBuilder(
    column: $table.customerId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get street => $composableBuilder(
    column: $table.street,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get houseNumber => $composableBuilder(
    column: $table.houseNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get postalCode => $composableBuilder(
    column: $table.postalCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get city => $composableBuilder(
    column: $table.city,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get country => $composableBuilder(
    column: $table.country,
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

  ColumnOrderings<String> get accessNotes => $composableBuilder(
    column: $table.accessNotes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get safetyNotes => $composableBuilder(
    column: $table.safetyNotes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get objectNotes => $composableBuilder(
    column: $table.objectNotes,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CustomerObjectsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CustomerObjectsTable> {
  $$CustomerObjectsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get tenantId =>
      $composableBuilder(column: $table.tenantId, builder: (column) => column);

  GeneratedColumn<String> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<int> get version =>
      $composableBuilder(column: $table.version, builder: (column) => column);

  GeneratedColumn<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => column,
  );

  GeneratedColumn<String> get lastSyncedAt => $composableBuilder(
    column: $table.lastSyncedAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get customerId => $composableBuilder(
    column: $table.customerId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get street =>
      $composableBuilder(column: $table.street, builder: (column) => column);

  GeneratedColumn<String> get houseNumber => $composableBuilder(
    column: $table.houseNumber,
    builder: (column) => column,
  );

  GeneratedColumn<String> get postalCode => $composableBuilder(
    column: $table.postalCode,
    builder: (column) => column,
  );

  GeneratedColumn<String> get city =>
      $composableBuilder(column: $table.city, builder: (column) => column);

  GeneratedColumn<String> get country =>
      $composableBuilder(column: $table.country, builder: (column) => column);

  GeneratedColumn<double> get latitude =>
      $composableBuilder(column: $table.latitude, builder: (column) => column);

  GeneratedColumn<double> get longitude =>
      $composableBuilder(column: $table.longitude, builder: (column) => column);

  GeneratedColumn<String> get accessNotes => $composableBuilder(
    column: $table.accessNotes,
    builder: (column) => column,
  );

  GeneratedColumn<String> get safetyNotes => $composableBuilder(
    column: $table.safetyNotes,
    builder: (column) => column,
  );

  GeneratedColumn<String> get objectNotes => $composableBuilder(
    column: $table.objectNotes,
    builder: (column) => column,
  );
}

class $$CustomerObjectsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CustomerObjectsTable,
          CustomerObjectRow,
          $$CustomerObjectsTableFilterComposer,
          $$CustomerObjectsTableOrderingComposer,
          $$CustomerObjectsTableAnnotationComposer,
          $$CustomerObjectsTableCreateCompanionBuilder,
          $$CustomerObjectsTableUpdateCompanionBuilder,
          (
            CustomerObjectRow,
            BaseReferences<
              _$AppDatabase,
              $CustomerObjectsTable,
              CustomerObjectRow
            >,
          ),
          CustomerObjectRow,
          PrefetchHooks Function()
        > {
  $$CustomerObjectsTableTableManager(
    _$AppDatabase db,
    $CustomerObjectsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CustomerObjectsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CustomerObjectsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CustomerObjectsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> tenantId = const Value.absent(),
                Value<String> createdAt = const Value.absent(),
                Value<String> updatedAt = const Value.absent(),
                Value<String?> deletedAt = const Value.absent(),
                Value<int> version = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<String?> lastSyncedAt = const Value.absent(),
                Value<String> customerId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> street = const Value.absent(),
                Value<String> houseNumber = const Value.absent(),
                Value<String> postalCode = const Value.absent(),
                Value<String> city = const Value.absent(),
                Value<String> country = const Value.absent(),
                Value<double?> latitude = const Value.absent(),
                Value<double?> longitude = const Value.absent(),
                Value<String?> accessNotes = const Value.absent(),
                Value<String?> safetyNotes = const Value.absent(),
                Value<String?> objectNotes = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CustomerObjectsCompanion(
                id: id,
                tenantId: tenantId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                version: version,
                syncStatus: syncStatus,
                lastSyncedAt: lastSyncedAt,
                customerId: customerId,
                name: name,
                street: street,
                houseNumber: houseNumber,
                postalCode: postalCode,
                city: city,
                country: country,
                latitude: latitude,
                longitude: longitude,
                accessNotes: accessNotes,
                safetyNotes: safetyNotes,
                objectNotes: objectNotes,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String tenantId,
                Value<String> createdAt = const Value.absent(),
                Value<String> updatedAt = const Value.absent(),
                Value<String?> deletedAt = const Value.absent(),
                Value<int> version = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<String?> lastSyncedAt = const Value.absent(),
                required String customerId,
                required String name,
                required String street,
                required String houseNumber,
                required String postalCode,
                required String city,
                required String country,
                Value<double?> latitude = const Value.absent(),
                Value<double?> longitude = const Value.absent(),
                Value<String?> accessNotes = const Value.absent(),
                Value<String?> safetyNotes = const Value.absent(),
                Value<String?> objectNotes = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CustomerObjectsCompanion.insert(
                id: id,
                tenantId: tenantId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                version: version,
                syncStatus: syncStatus,
                lastSyncedAt: lastSyncedAt,
                customerId: customerId,
                name: name,
                street: street,
                houseNumber: houseNumber,
                postalCode: postalCode,
                city: city,
                country: country,
                latitude: latitude,
                longitude: longitude,
                accessNotes: accessNotes,
                safetyNotes: safetyNotes,
                objectNotes: objectNotes,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CustomerObjectsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CustomerObjectsTable,
      CustomerObjectRow,
      $$CustomerObjectsTableFilterComposer,
      $$CustomerObjectsTableOrderingComposer,
      $$CustomerObjectsTableAnnotationComposer,
      $$CustomerObjectsTableCreateCompanionBuilder,
      $$CustomerObjectsTableUpdateCompanionBuilder,
      (
        CustomerObjectRow,
        BaseReferences<_$AppDatabase, $CustomerObjectsTable, CustomerObjectRow>,
      ),
      CustomerObjectRow,
      PrefetchHooks Function()
    >;
typedef $$InstallationsTableCreateCompanionBuilder =
    InstallationsCompanion Function({
      required String id,
      required String tenantId,
      Value<String> createdAt,
      Value<String> updatedAt,
      Value<String?> deletedAt,
      Value<int> version,
      Value<String> syncStatus,
      Value<String?> lastSyncedAt,
      required String objectId,
      required String type,
      Value<String?> manufacturer,
      Value<String?> model,
      Value<String?> serialNumber,
      Value<String?> fuelType,
      Value<int?> installationYear,
      Value<String?> locationDescription,
      Value<int?> intervalMonths,
      Value<String?> lastServiceDate,
      Value<String?> nextServiceDate,
      Value<String?> notes,
      Value<int> rowid,
    });
typedef $$InstallationsTableUpdateCompanionBuilder =
    InstallationsCompanion Function({
      Value<String> id,
      Value<String> tenantId,
      Value<String> createdAt,
      Value<String> updatedAt,
      Value<String?> deletedAt,
      Value<int> version,
      Value<String> syncStatus,
      Value<String?> lastSyncedAt,
      Value<String> objectId,
      Value<String> type,
      Value<String?> manufacturer,
      Value<String?> model,
      Value<String?> serialNumber,
      Value<String?> fuelType,
      Value<int?> installationYear,
      Value<String?> locationDescription,
      Value<int?> intervalMonths,
      Value<String?> lastServiceDate,
      Value<String?> nextServiceDate,
      Value<String?> notes,
      Value<int> rowid,
    });

class $$InstallationsTableFilterComposer
    extends Composer<_$AppDatabase, $InstallationsTable> {
  $$InstallationsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tenantId => $composableBuilder(
    column: $table.tenantId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastSyncedAt => $composableBuilder(
    column: $table.lastSyncedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get objectId => $composableBuilder(
    column: $table.objectId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get manufacturer => $composableBuilder(
    column: $table.manufacturer,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get model => $composableBuilder(
    column: $table.model,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get serialNumber => $composableBuilder(
    column: $table.serialNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fuelType => $composableBuilder(
    column: $table.fuelType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get installationYear => $composableBuilder(
    column: $table.installationYear,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get locationDescription => $composableBuilder(
    column: $table.locationDescription,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get intervalMonths => $composableBuilder(
    column: $table.intervalMonths,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastServiceDate => $composableBuilder(
    column: $table.lastServiceDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nextServiceDate => $composableBuilder(
    column: $table.nextServiceDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );
}

class $$InstallationsTableOrderingComposer
    extends Composer<_$AppDatabase, $InstallationsTable> {
  $$InstallationsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tenantId => $composableBuilder(
    column: $table.tenantId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastSyncedAt => $composableBuilder(
    column: $table.lastSyncedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get objectId => $composableBuilder(
    column: $table.objectId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get manufacturer => $composableBuilder(
    column: $table.manufacturer,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get model => $composableBuilder(
    column: $table.model,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get serialNumber => $composableBuilder(
    column: $table.serialNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fuelType => $composableBuilder(
    column: $table.fuelType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get installationYear => $composableBuilder(
    column: $table.installationYear,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get locationDescription => $composableBuilder(
    column: $table.locationDescription,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get intervalMonths => $composableBuilder(
    column: $table.intervalMonths,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastServiceDate => $composableBuilder(
    column: $table.lastServiceDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nextServiceDate => $composableBuilder(
    column: $table.nextServiceDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$InstallationsTableAnnotationComposer
    extends Composer<_$AppDatabase, $InstallationsTable> {
  $$InstallationsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get tenantId =>
      $composableBuilder(column: $table.tenantId, builder: (column) => column);

  GeneratedColumn<String> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<int> get version =>
      $composableBuilder(column: $table.version, builder: (column) => column);

  GeneratedColumn<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => column,
  );

  GeneratedColumn<String> get lastSyncedAt => $composableBuilder(
    column: $table.lastSyncedAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get objectId =>
      $composableBuilder(column: $table.objectId, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get manufacturer => $composableBuilder(
    column: $table.manufacturer,
    builder: (column) => column,
  );

  GeneratedColumn<String> get model =>
      $composableBuilder(column: $table.model, builder: (column) => column);

  GeneratedColumn<String> get serialNumber => $composableBuilder(
    column: $table.serialNumber,
    builder: (column) => column,
  );

  GeneratedColumn<String> get fuelType =>
      $composableBuilder(column: $table.fuelType, builder: (column) => column);

  GeneratedColumn<int> get installationYear => $composableBuilder(
    column: $table.installationYear,
    builder: (column) => column,
  );

  GeneratedColumn<String> get locationDescription => $composableBuilder(
    column: $table.locationDescription,
    builder: (column) => column,
  );

  GeneratedColumn<int> get intervalMonths => $composableBuilder(
    column: $table.intervalMonths,
    builder: (column) => column,
  );

  GeneratedColumn<String> get lastServiceDate => $composableBuilder(
    column: $table.lastServiceDate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get nextServiceDate => $composableBuilder(
    column: $table.nextServiceDate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);
}

class $$InstallationsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $InstallationsTable,
          InstallationRow,
          $$InstallationsTableFilterComposer,
          $$InstallationsTableOrderingComposer,
          $$InstallationsTableAnnotationComposer,
          $$InstallationsTableCreateCompanionBuilder,
          $$InstallationsTableUpdateCompanionBuilder,
          (
            InstallationRow,
            BaseReferences<_$AppDatabase, $InstallationsTable, InstallationRow>,
          ),
          InstallationRow,
          PrefetchHooks Function()
        > {
  $$InstallationsTableTableManager(_$AppDatabase db, $InstallationsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$InstallationsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$InstallationsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$InstallationsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> tenantId = const Value.absent(),
                Value<String> createdAt = const Value.absent(),
                Value<String> updatedAt = const Value.absent(),
                Value<String?> deletedAt = const Value.absent(),
                Value<int> version = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<String?> lastSyncedAt = const Value.absent(),
                Value<String> objectId = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<String?> manufacturer = const Value.absent(),
                Value<String?> model = const Value.absent(),
                Value<String?> serialNumber = const Value.absent(),
                Value<String?> fuelType = const Value.absent(),
                Value<int?> installationYear = const Value.absent(),
                Value<String?> locationDescription = const Value.absent(),
                Value<int?> intervalMonths = const Value.absent(),
                Value<String?> lastServiceDate = const Value.absent(),
                Value<String?> nextServiceDate = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => InstallationsCompanion(
                id: id,
                tenantId: tenantId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                version: version,
                syncStatus: syncStatus,
                lastSyncedAt: lastSyncedAt,
                objectId: objectId,
                type: type,
                manufacturer: manufacturer,
                model: model,
                serialNumber: serialNumber,
                fuelType: fuelType,
                installationYear: installationYear,
                locationDescription: locationDescription,
                intervalMonths: intervalMonths,
                lastServiceDate: lastServiceDate,
                nextServiceDate: nextServiceDate,
                notes: notes,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String tenantId,
                Value<String> createdAt = const Value.absent(),
                Value<String> updatedAt = const Value.absent(),
                Value<String?> deletedAt = const Value.absent(),
                Value<int> version = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<String?> lastSyncedAt = const Value.absent(),
                required String objectId,
                required String type,
                Value<String?> manufacturer = const Value.absent(),
                Value<String?> model = const Value.absent(),
                Value<String?> serialNumber = const Value.absent(),
                Value<String?> fuelType = const Value.absent(),
                Value<int?> installationYear = const Value.absent(),
                Value<String?> locationDescription = const Value.absent(),
                Value<int?> intervalMonths = const Value.absent(),
                Value<String?> lastServiceDate = const Value.absent(),
                Value<String?> nextServiceDate = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => InstallationsCompanion.insert(
                id: id,
                tenantId: tenantId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                version: version,
                syncStatus: syncStatus,
                lastSyncedAt: lastSyncedAt,
                objectId: objectId,
                type: type,
                manufacturer: manufacturer,
                model: model,
                serialNumber: serialNumber,
                fuelType: fuelType,
                installationYear: installationYear,
                locationDescription: locationDescription,
                intervalMonths: intervalMonths,
                lastServiceDate: lastServiceDate,
                nextServiceDate: nextServiceDate,
                notes: notes,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$InstallationsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $InstallationsTable,
      InstallationRow,
      $$InstallationsTableFilterComposer,
      $$InstallationsTableOrderingComposer,
      $$InstallationsTableAnnotationComposer,
      $$InstallationsTableCreateCompanionBuilder,
      $$InstallationsTableUpdateCompanionBuilder,
      (
        InstallationRow,
        BaseReferences<_$AppDatabase, $InstallationsTable, InstallationRow>,
      ),
      InstallationRow,
      PrefetchHooks Function()
    >;
typedef $$WorkOrdersTableCreateCompanionBuilder =
    WorkOrdersCompanion Function({
      required String id,
      required String tenantId,
      Value<String> createdAt,
      Value<String> updatedAt,
      Value<String?> deletedAt,
      Value<int> version,
      Value<String> syncStatus,
      Value<String?> lastSyncedAt,
      required String customerId,
      required String objectId,
      Value<String?> assignedUserId,
      required String orderNumber,
      required String title,
      Value<String?> description,
      required String type,
      required String status,
      required String priority,
      Value<String?> scheduledStart,
      Value<String?> scheduledEnd,
      Value<String?> actualStart,
      Value<String?> actualEnd,
      Value<String?> customerSignatureFileId,
      Value<String?> reportFileId,
      Value<String?> completionNotes,
      Value<int> rowid,
    });
typedef $$WorkOrdersTableUpdateCompanionBuilder =
    WorkOrdersCompanion Function({
      Value<String> id,
      Value<String> tenantId,
      Value<String> createdAt,
      Value<String> updatedAt,
      Value<String?> deletedAt,
      Value<int> version,
      Value<String> syncStatus,
      Value<String?> lastSyncedAt,
      Value<String> customerId,
      Value<String> objectId,
      Value<String?> assignedUserId,
      Value<String> orderNumber,
      Value<String> title,
      Value<String?> description,
      Value<String> type,
      Value<String> status,
      Value<String> priority,
      Value<String?> scheduledStart,
      Value<String?> scheduledEnd,
      Value<String?> actualStart,
      Value<String?> actualEnd,
      Value<String?> customerSignatureFileId,
      Value<String?> reportFileId,
      Value<String?> completionNotes,
      Value<int> rowid,
    });

class $$WorkOrdersTableFilterComposer
    extends Composer<_$AppDatabase, $WorkOrdersTable> {
  $$WorkOrdersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tenantId => $composableBuilder(
    column: $table.tenantId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastSyncedAt => $composableBuilder(
    column: $table.lastSyncedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get customerId => $composableBuilder(
    column: $table.customerId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get objectId => $composableBuilder(
    column: $table.objectId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get assignedUserId => $composableBuilder(
    column: $table.assignedUserId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get orderNumber => $composableBuilder(
    column: $table.orderNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get priority => $composableBuilder(
    column: $table.priority,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get scheduledStart => $composableBuilder(
    column: $table.scheduledStart,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get scheduledEnd => $composableBuilder(
    column: $table.scheduledEnd,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get actualStart => $composableBuilder(
    column: $table.actualStart,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get actualEnd => $composableBuilder(
    column: $table.actualEnd,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get customerSignatureFileId => $composableBuilder(
    column: $table.customerSignatureFileId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get reportFileId => $composableBuilder(
    column: $table.reportFileId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get completionNotes => $composableBuilder(
    column: $table.completionNotes,
    builder: (column) => ColumnFilters(column),
  );
}

class $$WorkOrdersTableOrderingComposer
    extends Composer<_$AppDatabase, $WorkOrdersTable> {
  $$WorkOrdersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tenantId => $composableBuilder(
    column: $table.tenantId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastSyncedAt => $composableBuilder(
    column: $table.lastSyncedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get customerId => $composableBuilder(
    column: $table.customerId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get objectId => $composableBuilder(
    column: $table.objectId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get assignedUserId => $composableBuilder(
    column: $table.assignedUserId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get orderNumber => $composableBuilder(
    column: $table.orderNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get priority => $composableBuilder(
    column: $table.priority,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get scheduledStart => $composableBuilder(
    column: $table.scheduledStart,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get scheduledEnd => $composableBuilder(
    column: $table.scheduledEnd,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get actualStart => $composableBuilder(
    column: $table.actualStart,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get actualEnd => $composableBuilder(
    column: $table.actualEnd,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get customerSignatureFileId => $composableBuilder(
    column: $table.customerSignatureFileId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get reportFileId => $composableBuilder(
    column: $table.reportFileId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get completionNotes => $composableBuilder(
    column: $table.completionNotes,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$WorkOrdersTableAnnotationComposer
    extends Composer<_$AppDatabase, $WorkOrdersTable> {
  $$WorkOrdersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get tenantId =>
      $composableBuilder(column: $table.tenantId, builder: (column) => column);

  GeneratedColumn<String> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<int> get version =>
      $composableBuilder(column: $table.version, builder: (column) => column);

  GeneratedColumn<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => column,
  );

  GeneratedColumn<String> get lastSyncedAt => $composableBuilder(
    column: $table.lastSyncedAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get customerId => $composableBuilder(
    column: $table.customerId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get objectId =>
      $composableBuilder(column: $table.objectId, builder: (column) => column);

  GeneratedColumn<String> get assignedUserId => $composableBuilder(
    column: $table.assignedUserId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get orderNumber => $composableBuilder(
    column: $table.orderNumber,
    builder: (column) => column,
  );

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get priority =>
      $composableBuilder(column: $table.priority, builder: (column) => column);

  GeneratedColumn<String> get scheduledStart => $composableBuilder(
    column: $table.scheduledStart,
    builder: (column) => column,
  );

  GeneratedColumn<String> get scheduledEnd => $composableBuilder(
    column: $table.scheduledEnd,
    builder: (column) => column,
  );

  GeneratedColumn<String> get actualStart => $composableBuilder(
    column: $table.actualStart,
    builder: (column) => column,
  );

  GeneratedColumn<String> get actualEnd =>
      $composableBuilder(column: $table.actualEnd, builder: (column) => column);

  GeneratedColumn<String> get customerSignatureFileId => $composableBuilder(
    column: $table.customerSignatureFileId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get reportFileId => $composableBuilder(
    column: $table.reportFileId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get completionNotes => $composableBuilder(
    column: $table.completionNotes,
    builder: (column) => column,
  );
}

class $$WorkOrdersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $WorkOrdersTable,
          WorkOrderRow,
          $$WorkOrdersTableFilterComposer,
          $$WorkOrdersTableOrderingComposer,
          $$WorkOrdersTableAnnotationComposer,
          $$WorkOrdersTableCreateCompanionBuilder,
          $$WorkOrdersTableUpdateCompanionBuilder,
          (
            WorkOrderRow,
            BaseReferences<_$AppDatabase, $WorkOrdersTable, WorkOrderRow>,
          ),
          WorkOrderRow,
          PrefetchHooks Function()
        > {
  $$WorkOrdersTableTableManager(_$AppDatabase db, $WorkOrdersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WorkOrdersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WorkOrdersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WorkOrdersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> tenantId = const Value.absent(),
                Value<String> createdAt = const Value.absent(),
                Value<String> updatedAt = const Value.absent(),
                Value<String?> deletedAt = const Value.absent(),
                Value<int> version = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<String?> lastSyncedAt = const Value.absent(),
                Value<String> customerId = const Value.absent(),
                Value<String> objectId = const Value.absent(),
                Value<String?> assignedUserId = const Value.absent(),
                Value<String> orderNumber = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String> priority = const Value.absent(),
                Value<String?> scheduledStart = const Value.absent(),
                Value<String?> scheduledEnd = const Value.absent(),
                Value<String?> actualStart = const Value.absent(),
                Value<String?> actualEnd = const Value.absent(),
                Value<String?> customerSignatureFileId = const Value.absent(),
                Value<String?> reportFileId = const Value.absent(),
                Value<String?> completionNotes = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => WorkOrdersCompanion(
                id: id,
                tenantId: tenantId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                version: version,
                syncStatus: syncStatus,
                lastSyncedAt: lastSyncedAt,
                customerId: customerId,
                objectId: objectId,
                assignedUserId: assignedUserId,
                orderNumber: orderNumber,
                title: title,
                description: description,
                type: type,
                status: status,
                priority: priority,
                scheduledStart: scheduledStart,
                scheduledEnd: scheduledEnd,
                actualStart: actualStart,
                actualEnd: actualEnd,
                customerSignatureFileId: customerSignatureFileId,
                reportFileId: reportFileId,
                completionNotes: completionNotes,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String tenantId,
                Value<String> createdAt = const Value.absent(),
                Value<String> updatedAt = const Value.absent(),
                Value<String?> deletedAt = const Value.absent(),
                Value<int> version = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<String?> lastSyncedAt = const Value.absent(),
                required String customerId,
                required String objectId,
                Value<String?> assignedUserId = const Value.absent(),
                required String orderNumber,
                required String title,
                Value<String?> description = const Value.absent(),
                required String type,
                required String status,
                required String priority,
                Value<String?> scheduledStart = const Value.absent(),
                Value<String?> scheduledEnd = const Value.absent(),
                Value<String?> actualStart = const Value.absent(),
                Value<String?> actualEnd = const Value.absent(),
                Value<String?> customerSignatureFileId = const Value.absent(),
                Value<String?> reportFileId = const Value.absent(),
                Value<String?> completionNotes = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => WorkOrdersCompanion.insert(
                id: id,
                tenantId: tenantId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                version: version,
                syncStatus: syncStatus,
                lastSyncedAt: lastSyncedAt,
                customerId: customerId,
                objectId: objectId,
                assignedUserId: assignedUserId,
                orderNumber: orderNumber,
                title: title,
                description: description,
                type: type,
                status: status,
                priority: priority,
                scheduledStart: scheduledStart,
                scheduledEnd: scheduledEnd,
                actualStart: actualStart,
                actualEnd: actualEnd,
                customerSignatureFileId: customerSignatureFileId,
                reportFileId: reportFileId,
                completionNotes: completionNotes,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$WorkOrdersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $WorkOrdersTable,
      WorkOrderRow,
      $$WorkOrdersTableFilterComposer,
      $$WorkOrdersTableOrderingComposer,
      $$WorkOrdersTableAnnotationComposer,
      $$WorkOrdersTableCreateCompanionBuilder,
      $$WorkOrdersTableUpdateCompanionBuilder,
      (
        WorkOrderRow,
        BaseReferences<_$AppDatabase, $WorkOrdersTable, WorkOrderRow>,
      ),
      WorkOrderRow,
      PrefetchHooks Function()
    >;
typedef $$WorkOrderInstallationsTableCreateCompanionBuilder =
    WorkOrderInstallationsCompanion Function({
      required String id,
      required String tenantId,
      Value<String> createdAt,
      Value<String> updatedAt,
      Value<String?> deletedAt,
      Value<int> version,
      Value<String> syncStatus,
      Value<String?> lastSyncedAt,
      required String workOrderId,
      required String installationId,
      Value<int> rowid,
    });
typedef $$WorkOrderInstallationsTableUpdateCompanionBuilder =
    WorkOrderInstallationsCompanion Function({
      Value<String> id,
      Value<String> tenantId,
      Value<String> createdAt,
      Value<String> updatedAt,
      Value<String?> deletedAt,
      Value<int> version,
      Value<String> syncStatus,
      Value<String?> lastSyncedAt,
      Value<String> workOrderId,
      Value<String> installationId,
      Value<int> rowid,
    });

class $$WorkOrderInstallationsTableFilterComposer
    extends Composer<_$AppDatabase, $WorkOrderInstallationsTable> {
  $$WorkOrderInstallationsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tenantId => $composableBuilder(
    column: $table.tenantId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastSyncedAt => $composableBuilder(
    column: $table.lastSyncedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get workOrderId => $composableBuilder(
    column: $table.workOrderId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get installationId => $composableBuilder(
    column: $table.installationId,
    builder: (column) => ColumnFilters(column),
  );
}

class $$WorkOrderInstallationsTableOrderingComposer
    extends Composer<_$AppDatabase, $WorkOrderInstallationsTable> {
  $$WorkOrderInstallationsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tenantId => $composableBuilder(
    column: $table.tenantId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastSyncedAt => $composableBuilder(
    column: $table.lastSyncedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get workOrderId => $composableBuilder(
    column: $table.workOrderId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get installationId => $composableBuilder(
    column: $table.installationId,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$WorkOrderInstallationsTableAnnotationComposer
    extends Composer<_$AppDatabase, $WorkOrderInstallationsTable> {
  $$WorkOrderInstallationsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get tenantId =>
      $composableBuilder(column: $table.tenantId, builder: (column) => column);

  GeneratedColumn<String> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<int> get version =>
      $composableBuilder(column: $table.version, builder: (column) => column);

  GeneratedColumn<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => column,
  );

  GeneratedColumn<String> get lastSyncedAt => $composableBuilder(
    column: $table.lastSyncedAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get workOrderId => $composableBuilder(
    column: $table.workOrderId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get installationId => $composableBuilder(
    column: $table.installationId,
    builder: (column) => column,
  );
}

class $$WorkOrderInstallationsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $WorkOrderInstallationsTable,
          WorkOrderInstallationRow,
          $$WorkOrderInstallationsTableFilterComposer,
          $$WorkOrderInstallationsTableOrderingComposer,
          $$WorkOrderInstallationsTableAnnotationComposer,
          $$WorkOrderInstallationsTableCreateCompanionBuilder,
          $$WorkOrderInstallationsTableUpdateCompanionBuilder,
          (
            WorkOrderInstallationRow,
            BaseReferences<
              _$AppDatabase,
              $WorkOrderInstallationsTable,
              WorkOrderInstallationRow
            >,
          ),
          WorkOrderInstallationRow,
          PrefetchHooks Function()
        > {
  $$WorkOrderInstallationsTableTableManager(
    _$AppDatabase db,
    $WorkOrderInstallationsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WorkOrderInstallationsTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$WorkOrderInstallationsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$WorkOrderInstallationsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> tenantId = const Value.absent(),
                Value<String> createdAt = const Value.absent(),
                Value<String> updatedAt = const Value.absent(),
                Value<String?> deletedAt = const Value.absent(),
                Value<int> version = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<String?> lastSyncedAt = const Value.absent(),
                Value<String> workOrderId = const Value.absent(),
                Value<String> installationId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => WorkOrderInstallationsCompanion(
                id: id,
                tenantId: tenantId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                version: version,
                syncStatus: syncStatus,
                lastSyncedAt: lastSyncedAt,
                workOrderId: workOrderId,
                installationId: installationId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String tenantId,
                Value<String> createdAt = const Value.absent(),
                Value<String> updatedAt = const Value.absent(),
                Value<String?> deletedAt = const Value.absent(),
                Value<int> version = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<String?> lastSyncedAt = const Value.absent(),
                required String workOrderId,
                required String installationId,
                Value<int> rowid = const Value.absent(),
              }) => WorkOrderInstallationsCompanion.insert(
                id: id,
                tenantId: tenantId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                version: version,
                syncStatus: syncStatus,
                lastSyncedAt: lastSyncedAt,
                workOrderId: workOrderId,
                installationId: installationId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$WorkOrderInstallationsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $WorkOrderInstallationsTable,
      WorkOrderInstallationRow,
      $$WorkOrderInstallationsTableFilterComposer,
      $$WorkOrderInstallationsTableOrderingComposer,
      $$WorkOrderInstallationsTableAnnotationComposer,
      $$WorkOrderInstallationsTableCreateCompanionBuilder,
      $$WorkOrderInstallationsTableUpdateCompanionBuilder,
      (
        WorkOrderInstallationRow,
        BaseReferences<
          _$AppDatabase,
          $WorkOrderInstallationsTable,
          WorkOrderInstallationRow
        >,
      ),
      WorkOrderInstallationRow,
      PrefetchHooks Function()
    >;
typedef $$ChecklistTemplatesTableCreateCompanionBuilder =
    ChecklistTemplatesCompanion Function({
      required String id,
      required String tenantId,
      Value<String> createdAt,
      Value<String> updatedAt,
      Value<String?> deletedAt,
      Value<int> version,
      Value<String> syncStatus,
      Value<String?> lastSyncedAt,
      required String name,
      required String type,
      required int versionNumber,
      Value<bool> isActive,
      Value<int> rowid,
    });
typedef $$ChecklistTemplatesTableUpdateCompanionBuilder =
    ChecklistTemplatesCompanion Function({
      Value<String> id,
      Value<String> tenantId,
      Value<String> createdAt,
      Value<String> updatedAt,
      Value<String?> deletedAt,
      Value<int> version,
      Value<String> syncStatus,
      Value<String?> lastSyncedAt,
      Value<String> name,
      Value<String> type,
      Value<int> versionNumber,
      Value<bool> isActive,
      Value<int> rowid,
    });

class $$ChecklistTemplatesTableFilterComposer
    extends Composer<_$AppDatabase, $ChecklistTemplatesTable> {
  $$ChecklistTemplatesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tenantId => $composableBuilder(
    column: $table.tenantId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastSyncedAt => $composableBuilder(
    column: $table.lastSyncedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get versionNumber => $composableBuilder(
    column: $table.versionNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ChecklistTemplatesTableOrderingComposer
    extends Composer<_$AppDatabase, $ChecklistTemplatesTable> {
  $$ChecklistTemplatesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tenantId => $composableBuilder(
    column: $table.tenantId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastSyncedAt => $composableBuilder(
    column: $table.lastSyncedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get versionNumber => $composableBuilder(
    column: $table.versionNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ChecklistTemplatesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ChecklistTemplatesTable> {
  $$ChecklistTemplatesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get tenantId =>
      $composableBuilder(column: $table.tenantId, builder: (column) => column);

  GeneratedColumn<String> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<int> get version =>
      $composableBuilder(column: $table.version, builder: (column) => column);

  GeneratedColumn<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => column,
  );

  GeneratedColumn<String> get lastSyncedAt => $composableBuilder(
    column: $table.lastSyncedAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<int> get versionNumber => $composableBuilder(
    column: $table.versionNumber,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);
}

class $$ChecklistTemplatesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ChecklistTemplatesTable,
          ChecklistTemplateRow,
          $$ChecklistTemplatesTableFilterComposer,
          $$ChecklistTemplatesTableOrderingComposer,
          $$ChecklistTemplatesTableAnnotationComposer,
          $$ChecklistTemplatesTableCreateCompanionBuilder,
          $$ChecklistTemplatesTableUpdateCompanionBuilder,
          (
            ChecklistTemplateRow,
            BaseReferences<
              _$AppDatabase,
              $ChecklistTemplatesTable,
              ChecklistTemplateRow
            >,
          ),
          ChecklistTemplateRow,
          PrefetchHooks Function()
        > {
  $$ChecklistTemplatesTableTableManager(
    _$AppDatabase db,
    $ChecklistTemplatesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ChecklistTemplatesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ChecklistTemplatesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ChecklistTemplatesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> tenantId = const Value.absent(),
                Value<String> createdAt = const Value.absent(),
                Value<String> updatedAt = const Value.absent(),
                Value<String?> deletedAt = const Value.absent(),
                Value<int> version = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<String?> lastSyncedAt = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<int> versionNumber = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ChecklistTemplatesCompanion(
                id: id,
                tenantId: tenantId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                version: version,
                syncStatus: syncStatus,
                lastSyncedAt: lastSyncedAt,
                name: name,
                type: type,
                versionNumber: versionNumber,
                isActive: isActive,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String tenantId,
                Value<String> createdAt = const Value.absent(),
                Value<String> updatedAt = const Value.absent(),
                Value<String?> deletedAt = const Value.absent(),
                Value<int> version = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<String?> lastSyncedAt = const Value.absent(),
                required String name,
                required String type,
                required int versionNumber,
                Value<bool> isActive = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ChecklistTemplatesCompanion.insert(
                id: id,
                tenantId: tenantId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                version: version,
                syncStatus: syncStatus,
                lastSyncedAt: lastSyncedAt,
                name: name,
                type: type,
                versionNumber: versionNumber,
                isActive: isActive,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ChecklistTemplatesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ChecklistTemplatesTable,
      ChecklistTemplateRow,
      $$ChecklistTemplatesTableFilterComposer,
      $$ChecklistTemplatesTableOrderingComposer,
      $$ChecklistTemplatesTableAnnotationComposer,
      $$ChecklistTemplatesTableCreateCompanionBuilder,
      $$ChecklistTemplatesTableUpdateCompanionBuilder,
      (
        ChecklistTemplateRow,
        BaseReferences<
          _$AppDatabase,
          $ChecklistTemplatesTable,
          ChecklistTemplateRow
        >,
      ),
      ChecklistTemplateRow,
      PrefetchHooks Function()
    >;
typedef $$ChecklistTemplateItemsTableCreateCompanionBuilder =
    ChecklistTemplateItemsCompanion Function({
      required String id,
      required String tenantId,
      Value<String> createdAt,
      Value<String> updatedAt,
      Value<String?> deletedAt,
      Value<int> version,
      Value<String> syncStatus,
      Value<String?> lastSyncedAt,
      required String templateId,
      required int position,
      required String label,
      Value<String?> helpText,
      required String answerType,
      Value<bool> required,
      Value<String?> optionsJson,
      Value<int> rowid,
    });
typedef $$ChecklistTemplateItemsTableUpdateCompanionBuilder =
    ChecklistTemplateItemsCompanion Function({
      Value<String> id,
      Value<String> tenantId,
      Value<String> createdAt,
      Value<String> updatedAt,
      Value<String?> deletedAt,
      Value<int> version,
      Value<String> syncStatus,
      Value<String?> lastSyncedAt,
      Value<String> templateId,
      Value<int> position,
      Value<String> label,
      Value<String?> helpText,
      Value<String> answerType,
      Value<bool> required,
      Value<String?> optionsJson,
      Value<int> rowid,
    });

class $$ChecklistTemplateItemsTableFilterComposer
    extends Composer<_$AppDatabase, $ChecklistTemplateItemsTable> {
  $$ChecklistTemplateItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tenantId => $composableBuilder(
    column: $table.tenantId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastSyncedAt => $composableBuilder(
    column: $table.lastSyncedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get templateId => $composableBuilder(
    column: $table.templateId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get label => $composableBuilder(
    column: $table.label,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get helpText => $composableBuilder(
    column: $table.helpText,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get answerType => $composableBuilder(
    column: $table.answerType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get required => $composableBuilder(
    column: $table.required,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get optionsJson => $composableBuilder(
    column: $table.optionsJson,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ChecklistTemplateItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $ChecklistTemplateItemsTable> {
  $$ChecklistTemplateItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tenantId => $composableBuilder(
    column: $table.tenantId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastSyncedAt => $composableBuilder(
    column: $table.lastSyncedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get templateId => $composableBuilder(
    column: $table.templateId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get label => $composableBuilder(
    column: $table.label,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get helpText => $composableBuilder(
    column: $table.helpText,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get answerType => $composableBuilder(
    column: $table.answerType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get required => $composableBuilder(
    column: $table.required,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get optionsJson => $composableBuilder(
    column: $table.optionsJson,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ChecklistTemplateItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ChecklistTemplateItemsTable> {
  $$ChecklistTemplateItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get tenantId =>
      $composableBuilder(column: $table.tenantId, builder: (column) => column);

  GeneratedColumn<String> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<int> get version =>
      $composableBuilder(column: $table.version, builder: (column) => column);

  GeneratedColumn<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => column,
  );

  GeneratedColumn<String> get lastSyncedAt => $composableBuilder(
    column: $table.lastSyncedAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get templateId => $composableBuilder(
    column: $table.templateId,
    builder: (column) => column,
  );

  GeneratedColumn<int> get position =>
      $composableBuilder(column: $table.position, builder: (column) => column);

  GeneratedColumn<String> get label =>
      $composableBuilder(column: $table.label, builder: (column) => column);

  GeneratedColumn<String> get helpText =>
      $composableBuilder(column: $table.helpText, builder: (column) => column);

  GeneratedColumn<String> get answerType => $composableBuilder(
    column: $table.answerType,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get required =>
      $composableBuilder(column: $table.required, builder: (column) => column);

  GeneratedColumn<String> get optionsJson => $composableBuilder(
    column: $table.optionsJson,
    builder: (column) => column,
  );
}

class $$ChecklistTemplateItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ChecklistTemplateItemsTable,
          ChecklistTemplateItemRow,
          $$ChecklistTemplateItemsTableFilterComposer,
          $$ChecklistTemplateItemsTableOrderingComposer,
          $$ChecklistTemplateItemsTableAnnotationComposer,
          $$ChecklistTemplateItemsTableCreateCompanionBuilder,
          $$ChecklistTemplateItemsTableUpdateCompanionBuilder,
          (
            ChecklistTemplateItemRow,
            BaseReferences<
              _$AppDatabase,
              $ChecklistTemplateItemsTable,
              ChecklistTemplateItemRow
            >,
          ),
          ChecklistTemplateItemRow,
          PrefetchHooks Function()
        > {
  $$ChecklistTemplateItemsTableTableManager(
    _$AppDatabase db,
    $ChecklistTemplateItemsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ChecklistTemplateItemsTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$ChecklistTemplateItemsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$ChecklistTemplateItemsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> tenantId = const Value.absent(),
                Value<String> createdAt = const Value.absent(),
                Value<String> updatedAt = const Value.absent(),
                Value<String?> deletedAt = const Value.absent(),
                Value<int> version = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<String?> lastSyncedAt = const Value.absent(),
                Value<String> templateId = const Value.absent(),
                Value<int> position = const Value.absent(),
                Value<String> label = const Value.absent(),
                Value<String?> helpText = const Value.absent(),
                Value<String> answerType = const Value.absent(),
                Value<bool> required = const Value.absent(),
                Value<String?> optionsJson = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ChecklistTemplateItemsCompanion(
                id: id,
                tenantId: tenantId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                version: version,
                syncStatus: syncStatus,
                lastSyncedAt: lastSyncedAt,
                templateId: templateId,
                position: position,
                label: label,
                helpText: helpText,
                answerType: answerType,
                required: required,
                optionsJson: optionsJson,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String tenantId,
                Value<String> createdAt = const Value.absent(),
                Value<String> updatedAt = const Value.absent(),
                Value<String?> deletedAt = const Value.absent(),
                Value<int> version = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<String?> lastSyncedAt = const Value.absent(),
                required String templateId,
                required int position,
                required String label,
                Value<String?> helpText = const Value.absent(),
                required String answerType,
                Value<bool> required = const Value.absent(),
                Value<String?> optionsJson = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ChecklistTemplateItemsCompanion.insert(
                id: id,
                tenantId: tenantId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                version: version,
                syncStatus: syncStatus,
                lastSyncedAt: lastSyncedAt,
                templateId: templateId,
                position: position,
                label: label,
                helpText: helpText,
                answerType: answerType,
                required: required,
                optionsJson: optionsJson,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ChecklistTemplateItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ChecklistTemplateItemsTable,
      ChecklistTemplateItemRow,
      $$ChecklistTemplateItemsTableFilterComposer,
      $$ChecklistTemplateItemsTableOrderingComposer,
      $$ChecklistTemplateItemsTableAnnotationComposer,
      $$ChecklistTemplateItemsTableCreateCompanionBuilder,
      $$ChecklistTemplateItemsTableUpdateCompanionBuilder,
      (
        ChecklistTemplateItemRow,
        BaseReferences<
          _$AppDatabase,
          $ChecklistTemplateItemsTable,
          ChecklistTemplateItemRow
        >,
      ),
      ChecklistTemplateItemRow,
      PrefetchHooks Function()
    >;
typedef $$ChecklistAnswersTableCreateCompanionBuilder =
    ChecklistAnswersCompanion Function({
      required String id,
      required String tenantId,
      Value<String> createdAt,
      Value<String> updatedAt,
      Value<String?> deletedAt,
      Value<int> version,
      Value<String> syncStatus,
      Value<String?> lastSyncedAt,
      required String workOrderId,
      required String templateItemId,
      Value<String?> answerValue,
      Value<String?> comment,
      Value<bool?> isOk,
      Value<int> rowid,
    });
typedef $$ChecklistAnswersTableUpdateCompanionBuilder =
    ChecklistAnswersCompanion Function({
      Value<String> id,
      Value<String> tenantId,
      Value<String> createdAt,
      Value<String> updatedAt,
      Value<String?> deletedAt,
      Value<int> version,
      Value<String> syncStatus,
      Value<String?> lastSyncedAt,
      Value<String> workOrderId,
      Value<String> templateItemId,
      Value<String?> answerValue,
      Value<String?> comment,
      Value<bool?> isOk,
      Value<int> rowid,
    });

class $$ChecklistAnswersTableFilterComposer
    extends Composer<_$AppDatabase, $ChecklistAnswersTable> {
  $$ChecklistAnswersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tenantId => $composableBuilder(
    column: $table.tenantId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastSyncedAt => $composableBuilder(
    column: $table.lastSyncedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get workOrderId => $composableBuilder(
    column: $table.workOrderId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get templateItemId => $composableBuilder(
    column: $table.templateItemId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get answerValue => $composableBuilder(
    column: $table.answerValue,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get comment => $composableBuilder(
    column: $table.comment,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isOk => $composableBuilder(
    column: $table.isOk,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ChecklistAnswersTableOrderingComposer
    extends Composer<_$AppDatabase, $ChecklistAnswersTable> {
  $$ChecklistAnswersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tenantId => $composableBuilder(
    column: $table.tenantId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastSyncedAt => $composableBuilder(
    column: $table.lastSyncedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get workOrderId => $composableBuilder(
    column: $table.workOrderId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get templateItemId => $composableBuilder(
    column: $table.templateItemId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get answerValue => $composableBuilder(
    column: $table.answerValue,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get comment => $composableBuilder(
    column: $table.comment,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isOk => $composableBuilder(
    column: $table.isOk,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ChecklistAnswersTableAnnotationComposer
    extends Composer<_$AppDatabase, $ChecklistAnswersTable> {
  $$ChecklistAnswersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get tenantId =>
      $composableBuilder(column: $table.tenantId, builder: (column) => column);

  GeneratedColumn<String> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<int> get version =>
      $composableBuilder(column: $table.version, builder: (column) => column);

  GeneratedColumn<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => column,
  );

  GeneratedColumn<String> get lastSyncedAt => $composableBuilder(
    column: $table.lastSyncedAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get workOrderId => $composableBuilder(
    column: $table.workOrderId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get templateItemId => $composableBuilder(
    column: $table.templateItemId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get answerValue => $composableBuilder(
    column: $table.answerValue,
    builder: (column) => column,
  );

  GeneratedColumn<String> get comment =>
      $composableBuilder(column: $table.comment, builder: (column) => column);

  GeneratedColumn<bool> get isOk =>
      $composableBuilder(column: $table.isOk, builder: (column) => column);
}

class $$ChecklistAnswersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ChecklistAnswersTable,
          ChecklistAnswerRow,
          $$ChecklistAnswersTableFilterComposer,
          $$ChecklistAnswersTableOrderingComposer,
          $$ChecklistAnswersTableAnnotationComposer,
          $$ChecklistAnswersTableCreateCompanionBuilder,
          $$ChecklistAnswersTableUpdateCompanionBuilder,
          (
            ChecklistAnswerRow,
            BaseReferences<
              _$AppDatabase,
              $ChecklistAnswersTable,
              ChecklistAnswerRow
            >,
          ),
          ChecklistAnswerRow,
          PrefetchHooks Function()
        > {
  $$ChecklistAnswersTableTableManager(
    _$AppDatabase db,
    $ChecklistAnswersTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ChecklistAnswersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ChecklistAnswersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ChecklistAnswersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> tenantId = const Value.absent(),
                Value<String> createdAt = const Value.absent(),
                Value<String> updatedAt = const Value.absent(),
                Value<String?> deletedAt = const Value.absent(),
                Value<int> version = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<String?> lastSyncedAt = const Value.absent(),
                Value<String> workOrderId = const Value.absent(),
                Value<String> templateItemId = const Value.absent(),
                Value<String?> answerValue = const Value.absent(),
                Value<String?> comment = const Value.absent(),
                Value<bool?> isOk = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ChecklistAnswersCompanion(
                id: id,
                tenantId: tenantId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                version: version,
                syncStatus: syncStatus,
                lastSyncedAt: lastSyncedAt,
                workOrderId: workOrderId,
                templateItemId: templateItemId,
                answerValue: answerValue,
                comment: comment,
                isOk: isOk,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String tenantId,
                Value<String> createdAt = const Value.absent(),
                Value<String> updatedAt = const Value.absent(),
                Value<String?> deletedAt = const Value.absent(),
                Value<int> version = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<String?> lastSyncedAt = const Value.absent(),
                required String workOrderId,
                required String templateItemId,
                Value<String?> answerValue = const Value.absent(),
                Value<String?> comment = const Value.absent(),
                Value<bool?> isOk = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ChecklistAnswersCompanion.insert(
                id: id,
                tenantId: tenantId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                version: version,
                syncStatus: syncStatus,
                lastSyncedAt: lastSyncedAt,
                workOrderId: workOrderId,
                templateItemId: templateItemId,
                answerValue: answerValue,
                comment: comment,
                isOk: isOk,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ChecklistAnswersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ChecklistAnswersTable,
      ChecklistAnswerRow,
      $$ChecklistAnswersTableFilterComposer,
      $$ChecklistAnswersTableOrderingComposer,
      $$ChecklistAnswersTableAnnotationComposer,
      $$ChecklistAnswersTableCreateCompanionBuilder,
      $$ChecklistAnswersTableUpdateCompanionBuilder,
      (
        ChecklistAnswerRow,
        BaseReferences<
          _$AppDatabase,
          $ChecklistAnswersTable,
          ChecklistAnswerRow
        >,
      ),
      ChecklistAnswerRow,
      PrefetchHooks Function()
    >;
typedef $$MeasurementsTableCreateCompanionBuilder =
    MeasurementsCompanion Function({
      required String id,
      required String tenantId,
      Value<String> createdAt,
      Value<String> updatedAt,
      Value<String?> deletedAt,
      Value<int> version,
      Value<String> syncStatus,
      Value<String?> lastSyncedAt,
      required String workOrderId,
      Value<String?> installationId,
      required String measurementType,
      required double value,
      required String unit,
      required String measuredAt,
      Value<String?> deviceName,
      Value<String?> deviceSerial,
      Value<String?> notes,
      Value<int> rowid,
    });
typedef $$MeasurementsTableUpdateCompanionBuilder =
    MeasurementsCompanion Function({
      Value<String> id,
      Value<String> tenantId,
      Value<String> createdAt,
      Value<String> updatedAt,
      Value<String?> deletedAt,
      Value<int> version,
      Value<String> syncStatus,
      Value<String?> lastSyncedAt,
      Value<String> workOrderId,
      Value<String?> installationId,
      Value<String> measurementType,
      Value<double> value,
      Value<String> unit,
      Value<String> measuredAt,
      Value<String?> deviceName,
      Value<String?> deviceSerial,
      Value<String?> notes,
      Value<int> rowid,
    });

class $$MeasurementsTableFilterComposer
    extends Composer<_$AppDatabase, $MeasurementsTable> {
  $$MeasurementsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tenantId => $composableBuilder(
    column: $table.tenantId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastSyncedAt => $composableBuilder(
    column: $table.lastSyncedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get workOrderId => $composableBuilder(
    column: $table.workOrderId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get installationId => $composableBuilder(
    column: $table.installationId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get measurementType => $composableBuilder(
    column: $table.measurementType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get unit => $composableBuilder(
    column: $table.unit,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get measuredAt => $composableBuilder(
    column: $table.measuredAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get deviceName => $composableBuilder(
    column: $table.deviceName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get deviceSerial => $composableBuilder(
    column: $table.deviceSerial,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );
}

class $$MeasurementsTableOrderingComposer
    extends Composer<_$AppDatabase, $MeasurementsTable> {
  $$MeasurementsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tenantId => $composableBuilder(
    column: $table.tenantId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastSyncedAt => $composableBuilder(
    column: $table.lastSyncedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get workOrderId => $composableBuilder(
    column: $table.workOrderId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get installationId => $composableBuilder(
    column: $table.installationId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get measurementType => $composableBuilder(
    column: $table.measurementType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get unit => $composableBuilder(
    column: $table.unit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get measuredAt => $composableBuilder(
    column: $table.measuredAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get deviceName => $composableBuilder(
    column: $table.deviceName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get deviceSerial => $composableBuilder(
    column: $table.deviceSerial,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$MeasurementsTableAnnotationComposer
    extends Composer<_$AppDatabase, $MeasurementsTable> {
  $$MeasurementsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get tenantId =>
      $composableBuilder(column: $table.tenantId, builder: (column) => column);

  GeneratedColumn<String> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<int> get version =>
      $composableBuilder(column: $table.version, builder: (column) => column);

  GeneratedColumn<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => column,
  );

  GeneratedColumn<String> get lastSyncedAt => $composableBuilder(
    column: $table.lastSyncedAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get workOrderId => $composableBuilder(
    column: $table.workOrderId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get installationId => $composableBuilder(
    column: $table.installationId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get measurementType => $composableBuilder(
    column: $table.measurementType,
    builder: (column) => column,
  );

  GeneratedColumn<double> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);

  GeneratedColumn<String> get unit =>
      $composableBuilder(column: $table.unit, builder: (column) => column);

  GeneratedColumn<String> get measuredAt => $composableBuilder(
    column: $table.measuredAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get deviceName => $composableBuilder(
    column: $table.deviceName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get deviceSerial => $composableBuilder(
    column: $table.deviceSerial,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);
}

class $$MeasurementsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MeasurementsTable,
          MeasurementRow,
          $$MeasurementsTableFilterComposer,
          $$MeasurementsTableOrderingComposer,
          $$MeasurementsTableAnnotationComposer,
          $$MeasurementsTableCreateCompanionBuilder,
          $$MeasurementsTableUpdateCompanionBuilder,
          (
            MeasurementRow,
            BaseReferences<_$AppDatabase, $MeasurementsTable, MeasurementRow>,
          ),
          MeasurementRow,
          PrefetchHooks Function()
        > {
  $$MeasurementsTableTableManager(_$AppDatabase db, $MeasurementsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MeasurementsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MeasurementsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MeasurementsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> tenantId = const Value.absent(),
                Value<String> createdAt = const Value.absent(),
                Value<String> updatedAt = const Value.absent(),
                Value<String?> deletedAt = const Value.absent(),
                Value<int> version = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<String?> lastSyncedAt = const Value.absent(),
                Value<String> workOrderId = const Value.absent(),
                Value<String?> installationId = const Value.absent(),
                Value<String> measurementType = const Value.absent(),
                Value<double> value = const Value.absent(),
                Value<String> unit = const Value.absent(),
                Value<String> measuredAt = const Value.absent(),
                Value<String?> deviceName = const Value.absent(),
                Value<String?> deviceSerial = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MeasurementsCompanion(
                id: id,
                tenantId: tenantId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                version: version,
                syncStatus: syncStatus,
                lastSyncedAt: lastSyncedAt,
                workOrderId: workOrderId,
                installationId: installationId,
                measurementType: measurementType,
                value: value,
                unit: unit,
                measuredAt: measuredAt,
                deviceName: deviceName,
                deviceSerial: deviceSerial,
                notes: notes,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String tenantId,
                Value<String> createdAt = const Value.absent(),
                Value<String> updatedAt = const Value.absent(),
                Value<String?> deletedAt = const Value.absent(),
                Value<int> version = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<String?> lastSyncedAt = const Value.absent(),
                required String workOrderId,
                Value<String?> installationId = const Value.absent(),
                required String measurementType,
                required double value,
                required String unit,
                required String measuredAt,
                Value<String?> deviceName = const Value.absent(),
                Value<String?> deviceSerial = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MeasurementsCompanion.insert(
                id: id,
                tenantId: tenantId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                version: version,
                syncStatus: syncStatus,
                lastSyncedAt: lastSyncedAt,
                workOrderId: workOrderId,
                installationId: installationId,
                measurementType: measurementType,
                value: value,
                unit: unit,
                measuredAt: measuredAt,
                deviceName: deviceName,
                deviceSerial: deviceSerial,
                notes: notes,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$MeasurementsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MeasurementsTable,
      MeasurementRow,
      $$MeasurementsTableFilterComposer,
      $$MeasurementsTableOrderingComposer,
      $$MeasurementsTableAnnotationComposer,
      $$MeasurementsTableCreateCompanionBuilder,
      $$MeasurementsTableUpdateCompanionBuilder,
      (
        MeasurementRow,
        BaseReferences<_$AppDatabase, $MeasurementsTable, MeasurementRow>,
      ),
      MeasurementRow,
      PrefetchHooks Function()
    >;
typedef $$DefectsTableCreateCompanionBuilder =
    DefectsCompanion Function({
      required String id,
      required String tenantId,
      Value<String> createdAt,
      Value<String> updatedAt,
      Value<String?> deletedAt,
      Value<int> version,
      Value<String> syncStatus,
      Value<String?> lastSyncedAt,
      required String workOrderId,
      Value<String?> installationId,
      required String severity,
      required String title,
      required String description,
      Value<String?> recommendedAction,
      Value<String?> dueDate,
      Value<bool> resolved,
      Value<int> rowid,
    });
typedef $$DefectsTableUpdateCompanionBuilder =
    DefectsCompanion Function({
      Value<String> id,
      Value<String> tenantId,
      Value<String> createdAt,
      Value<String> updatedAt,
      Value<String?> deletedAt,
      Value<int> version,
      Value<String> syncStatus,
      Value<String?> lastSyncedAt,
      Value<String> workOrderId,
      Value<String?> installationId,
      Value<String> severity,
      Value<String> title,
      Value<String> description,
      Value<String?> recommendedAction,
      Value<String?> dueDate,
      Value<bool> resolved,
      Value<int> rowid,
    });

class $$DefectsTableFilterComposer
    extends Composer<_$AppDatabase, $DefectsTable> {
  $$DefectsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tenantId => $composableBuilder(
    column: $table.tenantId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastSyncedAt => $composableBuilder(
    column: $table.lastSyncedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get workOrderId => $composableBuilder(
    column: $table.workOrderId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get installationId => $composableBuilder(
    column: $table.installationId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get severity => $composableBuilder(
    column: $table.severity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get recommendedAction => $composableBuilder(
    column: $table.recommendedAction,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get dueDate => $composableBuilder(
    column: $table.dueDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get resolved => $composableBuilder(
    column: $table.resolved,
    builder: (column) => ColumnFilters(column),
  );
}

class $$DefectsTableOrderingComposer
    extends Composer<_$AppDatabase, $DefectsTable> {
  $$DefectsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tenantId => $composableBuilder(
    column: $table.tenantId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastSyncedAt => $composableBuilder(
    column: $table.lastSyncedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get workOrderId => $composableBuilder(
    column: $table.workOrderId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get installationId => $composableBuilder(
    column: $table.installationId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get severity => $composableBuilder(
    column: $table.severity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get recommendedAction => $composableBuilder(
    column: $table.recommendedAction,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get dueDate => $composableBuilder(
    column: $table.dueDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get resolved => $composableBuilder(
    column: $table.resolved,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DefectsTableAnnotationComposer
    extends Composer<_$AppDatabase, $DefectsTable> {
  $$DefectsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get tenantId =>
      $composableBuilder(column: $table.tenantId, builder: (column) => column);

  GeneratedColumn<String> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<int> get version =>
      $composableBuilder(column: $table.version, builder: (column) => column);

  GeneratedColumn<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => column,
  );

  GeneratedColumn<String> get lastSyncedAt => $composableBuilder(
    column: $table.lastSyncedAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get workOrderId => $composableBuilder(
    column: $table.workOrderId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get installationId => $composableBuilder(
    column: $table.installationId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get severity =>
      $composableBuilder(column: $table.severity, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get recommendedAction => $composableBuilder(
    column: $table.recommendedAction,
    builder: (column) => column,
  );

  GeneratedColumn<String> get dueDate =>
      $composableBuilder(column: $table.dueDate, builder: (column) => column);

  GeneratedColumn<bool> get resolved =>
      $composableBuilder(column: $table.resolved, builder: (column) => column);
}

class $$DefectsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DefectsTable,
          DefectRow,
          $$DefectsTableFilterComposer,
          $$DefectsTableOrderingComposer,
          $$DefectsTableAnnotationComposer,
          $$DefectsTableCreateCompanionBuilder,
          $$DefectsTableUpdateCompanionBuilder,
          (DefectRow, BaseReferences<_$AppDatabase, $DefectsTable, DefectRow>),
          DefectRow,
          PrefetchHooks Function()
        > {
  $$DefectsTableTableManager(_$AppDatabase db, $DefectsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DefectsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DefectsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DefectsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> tenantId = const Value.absent(),
                Value<String> createdAt = const Value.absent(),
                Value<String> updatedAt = const Value.absent(),
                Value<String?> deletedAt = const Value.absent(),
                Value<int> version = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<String?> lastSyncedAt = const Value.absent(),
                Value<String> workOrderId = const Value.absent(),
                Value<String?> installationId = const Value.absent(),
                Value<String> severity = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<String?> recommendedAction = const Value.absent(),
                Value<String?> dueDate = const Value.absent(),
                Value<bool> resolved = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DefectsCompanion(
                id: id,
                tenantId: tenantId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                version: version,
                syncStatus: syncStatus,
                lastSyncedAt: lastSyncedAt,
                workOrderId: workOrderId,
                installationId: installationId,
                severity: severity,
                title: title,
                description: description,
                recommendedAction: recommendedAction,
                dueDate: dueDate,
                resolved: resolved,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String tenantId,
                Value<String> createdAt = const Value.absent(),
                Value<String> updatedAt = const Value.absent(),
                Value<String?> deletedAt = const Value.absent(),
                Value<int> version = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<String?> lastSyncedAt = const Value.absent(),
                required String workOrderId,
                Value<String?> installationId = const Value.absent(),
                required String severity,
                required String title,
                required String description,
                Value<String?> recommendedAction = const Value.absent(),
                Value<String?> dueDate = const Value.absent(),
                Value<bool> resolved = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DefectsCompanion.insert(
                id: id,
                tenantId: tenantId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                version: version,
                syncStatus: syncStatus,
                lastSyncedAt: lastSyncedAt,
                workOrderId: workOrderId,
                installationId: installationId,
                severity: severity,
                title: title,
                description: description,
                recommendedAction: recommendedAction,
                dueDate: dueDate,
                resolved: resolved,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$DefectsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DefectsTable,
      DefectRow,
      $$DefectsTableFilterComposer,
      $$DefectsTableOrderingComposer,
      $$DefectsTableAnnotationComposer,
      $$DefectsTableCreateCompanionBuilder,
      $$DefectsTableUpdateCompanionBuilder,
      (DefectRow, BaseReferences<_$AppDatabase, $DefectsTable, DefectRow>),
      DefectRow,
      PrefetchHooks Function()
    >;
typedef $$PhotosTableCreateCompanionBuilder =
    PhotosCompanion Function({
      required String id,
      required String tenantId,
      Value<String> createdAt,
      Value<String> updatedAt,
      Value<String?> deletedAt,
      Value<int> version,
      Value<String> syncStatus,
      Value<String?> lastSyncedAt,
      Value<String?> workOrderId,
      Value<String?> objectId,
      Value<String?> installationId,
      Value<String?> defectId,
      required String localPath,
      Value<String?> remoteUrl,
      required String fileName,
      required String mimeType,
      required int sizeBytes,
      Value<String?> caption,
      required String takenAt,
      required String uploadStatus,
      Value<int> rowid,
    });
typedef $$PhotosTableUpdateCompanionBuilder =
    PhotosCompanion Function({
      Value<String> id,
      Value<String> tenantId,
      Value<String> createdAt,
      Value<String> updatedAt,
      Value<String?> deletedAt,
      Value<int> version,
      Value<String> syncStatus,
      Value<String?> lastSyncedAt,
      Value<String?> workOrderId,
      Value<String?> objectId,
      Value<String?> installationId,
      Value<String?> defectId,
      Value<String> localPath,
      Value<String?> remoteUrl,
      Value<String> fileName,
      Value<String> mimeType,
      Value<int> sizeBytes,
      Value<String?> caption,
      Value<String> takenAt,
      Value<String> uploadStatus,
      Value<int> rowid,
    });

class $$PhotosTableFilterComposer
    extends Composer<_$AppDatabase, $PhotosTable> {
  $$PhotosTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tenantId => $composableBuilder(
    column: $table.tenantId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastSyncedAt => $composableBuilder(
    column: $table.lastSyncedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get workOrderId => $composableBuilder(
    column: $table.workOrderId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get objectId => $composableBuilder(
    column: $table.objectId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get installationId => $composableBuilder(
    column: $table.installationId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get defectId => $composableBuilder(
    column: $table.defectId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get localPath => $composableBuilder(
    column: $table.localPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get remoteUrl => $composableBuilder(
    column: $table.remoteUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fileName => $composableBuilder(
    column: $table.fileName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get mimeType => $composableBuilder(
    column: $table.mimeType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sizeBytes => $composableBuilder(
    column: $table.sizeBytes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get caption => $composableBuilder(
    column: $table.caption,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get takenAt => $composableBuilder(
    column: $table.takenAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get uploadStatus => $composableBuilder(
    column: $table.uploadStatus,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PhotosTableOrderingComposer
    extends Composer<_$AppDatabase, $PhotosTable> {
  $$PhotosTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tenantId => $composableBuilder(
    column: $table.tenantId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastSyncedAt => $composableBuilder(
    column: $table.lastSyncedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get workOrderId => $composableBuilder(
    column: $table.workOrderId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get objectId => $composableBuilder(
    column: $table.objectId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get installationId => $composableBuilder(
    column: $table.installationId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get defectId => $composableBuilder(
    column: $table.defectId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get localPath => $composableBuilder(
    column: $table.localPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get remoteUrl => $composableBuilder(
    column: $table.remoteUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fileName => $composableBuilder(
    column: $table.fileName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get mimeType => $composableBuilder(
    column: $table.mimeType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sizeBytes => $composableBuilder(
    column: $table.sizeBytes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get caption => $composableBuilder(
    column: $table.caption,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get takenAt => $composableBuilder(
    column: $table.takenAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get uploadStatus => $composableBuilder(
    column: $table.uploadStatus,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PhotosTableAnnotationComposer
    extends Composer<_$AppDatabase, $PhotosTable> {
  $$PhotosTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get tenantId =>
      $composableBuilder(column: $table.tenantId, builder: (column) => column);

  GeneratedColumn<String> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<int> get version =>
      $composableBuilder(column: $table.version, builder: (column) => column);

  GeneratedColumn<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => column,
  );

  GeneratedColumn<String> get lastSyncedAt => $composableBuilder(
    column: $table.lastSyncedAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get workOrderId => $composableBuilder(
    column: $table.workOrderId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get objectId =>
      $composableBuilder(column: $table.objectId, builder: (column) => column);

  GeneratedColumn<String> get installationId => $composableBuilder(
    column: $table.installationId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get defectId =>
      $composableBuilder(column: $table.defectId, builder: (column) => column);

  GeneratedColumn<String> get localPath =>
      $composableBuilder(column: $table.localPath, builder: (column) => column);

  GeneratedColumn<String> get remoteUrl =>
      $composableBuilder(column: $table.remoteUrl, builder: (column) => column);

  GeneratedColumn<String> get fileName =>
      $composableBuilder(column: $table.fileName, builder: (column) => column);

  GeneratedColumn<String> get mimeType =>
      $composableBuilder(column: $table.mimeType, builder: (column) => column);

  GeneratedColumn<int> get sizeBytes =>
      $composableBuilder(column: $table.sizeBytes, builder: (column) => column);

  GeneratedColumn<String> get caption =>
      $composableBuilder(column: $table.caption, builder: (column) => column);

  GeneratedColumn<String> get takenAt =>
      $composableBuilder(column: $table.takenAt, builder: (column) => column);

  GeneratedColumn<String> get uploadStatus => $composableBuilder(
    column: $table.uploadStatus,
    builder: (column) => column,
  );
}

class $$PhotosTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PhotosTable,
          PhotoRow,
          $$PhotosTableFilterComposer,
          $$PhotosTableOrderingComposer,
          $$PhotosTableAnnotationComposer,
          $$PhotosTableCreateCompanionBuilder,
          $$PhotosTableUpdateCompanionBuilder,
          (PhotoRow, BaseReferences<_$AppDatabase, $PhotosTable, PhotoRow>),
          PhotoRow,
          PrefetchHooks Function()
        > {
  $$PhotosTableTableManager(_$AppDatabase db, $PhotosTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PhotosTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PhotosTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PhotosTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> tenantId = const Value.absent(),
                Value<String> createdAt = const Value.absent(),
                Value<String> updatedAt = const Value.absent(),
                Value<String?> deletedAt = const Value.absent(),
                Value<int> version = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<String?> lastSyncedAt = const Value.absent(),
                Value<String?> workOrderId = const Value.absent(),
                Value<String?> objectId = const Value.absent(),
                Value<String?> installationId = const Value.absent(),
                Value<String?> defectId = const Value.absent(),
                Value<String> localPath = const Value.absent(),
                Value<String?> remoteUrl = const Value.absent(),
                Value<String> fileName = const Value.absent(),
                Value<String> mimeType = const Value.absent(),
                Value<int> sizeBytes = const Value.absent(),
                Value<String?> caption = const Value.absent(),
                Value<String> takenAt = const Value.absent(),
                Value<String> uploadStatus = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PhotosCompanion(
                id: id,
                tenantId: tenantId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                version: version,
                syncStatus: syncStatus,
                lastSyncedAt: lastSyncedAt,
                workOrderId: workOrderId,
                objectId: objectId,
                installationId: installationId,
                defectId: defectId,
                localPath: localPath,
                remoteUrl: remoteUrl,
                fileName: fileName,
                mimeType: mimeType,
                sizeBytes: sizeBytes,
                caption: caption,
                takenAt: takenAt,
                uploadStatus: uploadStatus,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String tenantId,
                Value<String> createdAt = const Value.absent(),
                Value<String> updatedAt = const Value.absent(),
                Value<String?> deletedAt = const Value.absent(),
                Value<int> version = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<String?> lastSyncedAt = const Value.absent(),
                Value<String?> workOrderId = const Value.absent(),
                Value<String?> objectId = const Value.absent(),
                Value<String?> installationId = const Value.absent(),
                Value<String?> defectId = const Value.absent(),
                required String localPath,
                Value<String?> remoteUrl = const Value.absent(),
                required String fileName,
                required String mimeType,
                required int sizeBytes,
                Value<String?> caption = const Value.absent(),
                required String takenAt,
                required String uploadStatus,
                Value<int> rowid = const Value.absent(),
              }) => PhotosCompanion.insert(
                id: id,
                tenantId: tenantId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                version: version,
                syncStatus: syncStatus,
                lastSyncedAt: lastSyncedAt,
                workOrderId: workOrderId,
                objectId: objectId,
                installationId: installationId,
                defectId: defectId,
                localPath: localPath,
                remoteUrl: remoteUrl,
                fileName: fileName,
                mimeType: mimeType,
                sizeBytes: sizeBytes,
                caption: caption,
                takenAt: takenAt,
                uploadStatus: uploadStatus,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PhotosTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PhotosTable,
      PhotoRow,
      $$PhotosTableFilterComposer,
      $$PhotosTableOrderingComposer,
      $$PhotosTableAnnotationComposer,
      $$PhotosTableCreateCompanionBuilder,
      $$PhotosTableUpdateCompanionBuilder,
      (PhotoRow, BaseReferences<_$AppDatabase, $PhotosTable, PhotoRow>),
      PhotoRow,
      PrefetchHooks Function()
    >;
typedef $$TimeEntriesTableCreateCompanionBuilder =
    TimeEntriesCompanion Function({
      required String id,
      required String tenantId,
      Value<String> createdAt,
      Value<String> updatedAt,
      Value<String?> deletedAt,
      Value<int> version,
      Value<String> syncStatus,
      Value<String?> lastSyncedAt,
      required String workOrderId,
      required String userId,
      required String type,
      required String startTime,
      Value<String?> endTime,
      Value<int?> durationMinutes,
      Value<String?> notes,
      Value<int> rowid,
    });
typedef $$TimeEntriesTableUpdateCompanionBuilder =
    TimeEntriesCompanion Function({
      Value<String> id,
      Value<String> tenantId,
      Value<String> createdAt,
      Value<String> updatedAt,
      Value<String?> deletedAt,
      Value<int> version,
      Value<String> syncStatus,
      Value<String?> lastSyncedAt,
      Value<String> workOrderId,
      Value<String> userId,
      Value<String> type,
      Value<String> startTime,
      Value<String?> endTime,
      Value<int?> durationMinutes,
      Value<String?> notes,
      Value<int> rowid,
    });

class $$TimeEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $TimeEntriesTable> {
  $$TimeEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tenantId => $composableBuilder(
    column: $table.tenantId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastSyncedAt => $composableBuilder(
    column: $table.lastSyncedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get workOrderId => $composableBuilder(
    column: $table.workOrderId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get startTime => $composableBuilder(
    column: $table.startTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get endTime => $composableBuilder(
    column: $table.endTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get durationMinutes => $composableBuilder(
    column: $table.durationMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );
}

class $$TimeEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $TimeEntriesTable> {
  $$TimeEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tenantId => $composableBuilder(
    column: $table.tenantId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastSyncedAt => $composableBuilder(
    column: $table.lastSyncedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get workOrderId => $composableBuilder(
    column: $table.workOrderId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get startTime => $composableBuilder(
    column: $table.startTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get endTime => $composableBuilder(
    column: $table.endTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get durationMinutes => $composableBuilder(
    column: $table.durationMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TimeEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $TimeEntriesTable> {
  $$TimeEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get tenantId =>
      $composableBuilder(column: $table.tenantId, builder: (column) => column);

  GeneratedColumn<String> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<int> get version =>
      $composableBuilder(column: $table.version, builder: (column) => column);

  GeneratedColumn<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => column,
  );

  GeneratedColumn<String> get lastSyncedAt => $composableBuilder(
    column: $table.lastSyncedAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get workOrderId => $composableBuilder(
    column: $table.workOrderId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get startTime =>
      $composableBuilder(column: $table.startTime, builder: (column) => column);

  GeneratedColumn<String> get endTime =>
      $composableBuilder(column: $table.endTime, builder: (column) => column);

  GeneratedColumn<int> get durationMinutes => $composableBuilder(
    column: $table.durationMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);
}

class $$TimeEntriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TimeEntriesTable,
          TimeEntryRow,
          $$TimeEntriesTableFilterComposer,
          $$TimeEntriesTableOrderingComposer,
          $$TimeEntriesTableAnnotationComposer,
          $$TimeEntriesTableCreateCompanionBuilder,
          $$TimeEntriesTableUpdateCompanionBuilder,
          (
            TimeEntryRow,
            BaseReferences<_$AppDatabase, $TimeEntriesTable, TimeEntryRow>,
          ),
          TimeEntryRow,
          PrefetchHooks Function()
        > {
  $$TimeEntriesTableTableManager(_$AppDatabase db, $TimeEntriesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TimeEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TimeEntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TimeEntriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> tenantId = const Value.absent(),
                Value<String> createdAt = const Value.absent(),
                Value<String> updatedAt = const Value.absent(),
                Value<String?> deletedAt = const Value.absent(),
                Value<int> version = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<String?> lastSyncedAt = const Value.absent(),
                Value<String> workOrderId = const Value.absent(),
                Value<String> userId = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<String> startTime = const Value.absent(),
                Value<String?> endTime = const Value.absent(),
                Value<int?> durationMinutes = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TimeEntriesCompanion(
                id: id,
                tenantId: tenantId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                version: version,
                syncStatus: syncStatus,
                lastSyncedAt: lastSyncedAt,
                workOrderId: workOrderId,
                userId: userId,
                type: type,
                startTime: startTime,
                endTime: endTime,
                durationMinutes: durationMinutes,
                notes: notes,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String tenantId,
                Value<String> createdAt = const Value.absent(),
                Value<String> updatedAt = const Value.absent(),
                Value<String?> deletedAt = const Value.absent(),
                Value<int> version = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<String?> lastSyncedAt = const Value.absent(),
                required String workOrderId,
                required String userId,
                required String type,
                required String startTime,
                Value<String?> endTime = const Value.absent(),
                Value<int?> durationMinutes = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TimeEntriesCompanion.insert(
                id: id,
                tenantId: tenantId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                version: version,
                syncStatus: syncStatus,
                lastSyncedAt: lastSyncedAt,
                workOrderId: workOrderId,
                userId: userId,
                type: type,
                startTime: startTime,
                endTime: endTime,
                durationMinutes: durationMinutes,
                notes: notes,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$TimeEntriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TimeEntriesTable,
      TimeEntryRow,
      $$TimeEntriesTableFilterComposer,
      $$TimeEntriesTableOrderingComposer,
      $$TimeEntriesTableAnnotationComposer,
      $$TimeEntriesTableCreateCompanionBuilder,
      $$TimeEntriesTableUpdateCompanionBuilder,
      (
        TimeEntryRow,
        BaseReferences<_$AppDatabase, $TimeEntriesTable, TimeEntryRow>,
      ),
      TimeEntryRow,
      PrefetchHooks Function()
    >;
typedef $$MaterialsTableCreateCompanionBuilder =
    MaterialsCompanion Function({
      required String id,
      required String tenantId,
      Value<String> createdAt,
      Value<String> updatedAt,
      Value<String?> deletedAt,
      Value<int> version,
      Value<String> syncStatus,
      Value<String?> lastSyncedAt,
      Value<String?> sku,
      required String name,
      required String unit,
      Value<double?> defaultPrice,
      Value<bool> isActive,
      Value<int> rowid,
    });
typedef $$MaterialsTableUpdateCompanionBuilder =
    MaterialsCompanion Function({
      Value<String> id,
      Value<String> tenantId,
      Value<String> createdAt,
      Value<String> updatedAt,
      Value<String?> deletedAt,
      Value<int> version,
      Value<String> syncStatus,
      Value<String?> lastSyncedAt,
      Value<String?> sku,
      Value<String> name,
      Value<String> unit,
      Value<double?> defaultPrice,
      Value<bool> isActive,
      Value<int> rowid,
    });

class $$MaterialsTableFilterComposer
    extends Composer<_$AppDatabase, $MaterialsTable> {
  $$MaterialsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tenantId => $composableBuilder(
    column: $table.tenantId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastSyncedAt => $composableBuilder(
    column: $table.lastSyncedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sku => $composableBuilder(
    column: $table.sku,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get unit => $composableBuilder(
    column: $table.unit,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get defaultPrice => $composableBuilder(
    column: $table.defaultPrice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );
}

class $$MaterialsTableOrderingComposer
    extends Composer<_$AppDatabase, $MaterialsTable> {
  $$MaterialsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tenantId => $composableBuilder(
    column: $table.tenantId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastSyncedAt => $composableBuilder(
    column: $table.lastSyncedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sku => $composableBuilder(
    column: $table.sku,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get unit => $composableBuilder(
    column: $table.unit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get defaultPrice => $composableBuilder(
    column: $table.defaultPrice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$MaterialsTableAnnotationComposer
    extends Composer<_$AppDatabase, $MaterialsTable> {
  $$MaterialsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get tenantId =>
      $composableBuilder(column: $table.tenantId, builder: (column) => column);

  GeneratedColumn<String> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<int> get version =>
      $composableBuilder(column: $table.version, builder: (column) => column);

  GeneratedColumn<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => column,
  );

  GeneratedColumn<String> get lastSyncedAt => $composableBuilder(
    column: $table.lastSyncedAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get sku =>
      $composableBuilder(column: $table.sku, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get unit =>
      $composableBuilder(column: $table.unit, builder: (column) => column);

  GeneratedColumn<double> get defaultPrice => $composableBuilder(
    column: $table.defaultPrice,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);
}

class $$MaterialsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MaterialsTable,
          MaterialRow,
          $$MaterialsTableFilterComposer,
          $$MaterialsTableOrderingComposer,
          $$MaterialsTableAnnotationComposer,
          $$MaterialsTableCreateCompanionBuilder,
          $$MaterialsTableUpdateCompanionBuilder,
          (
            MaterialRow,
            BaseReferences<_$AppDatabase, $MaterialsTable, MaterialRow>,
          ),
          MaterialRow,
          PrefetchHooks Function()
        > {
  $$MaterialsTableTableManager(_$AppDatabase db, $MaterialsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MaterialsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MaterialsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MaterialsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> tenantId = const Value.absent(),
                Value<String> createdAt = const Value.absent(),
                Value<String> updatedAt = const Value.absent(),
                Value<String?> deletedAt = const Value.absent(),
                Value<int> version = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<String?> lastSyncedAt = const Value.absent(),
                Value<String?> sku = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> unit = const Value.absent(),
                Value<double?> defaultPrice = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MaterialsCompanion(
                id: id,
                tenantId: tenantId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                version: version,
                syncStatus: syncStatus,
                lastSyncedAt: lastSyncedAt,
                sku: sku,
                name: name,
                unit: unit,
                defaultPrice: defaultPrice,
                isActive: isActive,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String tenantId,
                Value<String> createdAt = const Value.absent(),
                Value<String> updatedAt = const Value.absent(),
                Value<String?> deletedAt = const Value.absent(),
                Value<int> version = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<String?> lastSyncedAt = const Value.absent(),
                Value<String?> sku = const Value.absent(),
                required String name,
                required String unit,
                Value<double?> defaultPrice = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MaterialsCompanion.insert(
                id: id,
                tenantId: tenantId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                version: version,
                syncStatus: syncStatus,
                lastSyncedAt: lastSyncedAt,
                sku: sku,
                name: name,
                unit: unit,
                defaultPrice: defaultPrice,
                isActive: isActive,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$MaterialsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MaterialsTable,
      MaterialRow,
      $$MaterialsTableFilterComposer,
      $$MaterialsTableOrderingComposer,
      $$MaterialsTableAnnotationComposer,
      $$MaterialsTableCreateCompanionBuilder,
      $$MaterialsTableUpdateCompanionBuilder,
      (
        MaterialRow,
        BaseReferences<_$AppDatabase, $MaterialsTable, MaterialRow>,
      ),
      MaterialRow,
      PrefetchHooks Function()
    >;
typedef $$WorkOrderMaterialsTableCreateCompanionBuilder =
    WorkOrderMaterialsCompanion Function({
      required String id,
      required String tenantId,
      Value<String> createdAt,
      Value<String> updatedAt,
      Value<String?> deletedAt,
      Value<int> version,
      Value<String> syncStatus,
      Value<String?> lastSyncedAt,
      required String workOrderId,
      Value<String?> materialId,
      required String name,
      required double quantity,
      required String unit,
      Value<String?> notes,
      Value<int> rowid,
    });
typedef $$WorkOrderMaterialsTableUpdateCompanionBuilder =
    WorkOrderMaterialsCompanion Function({
      Value<String> id,
      Value<String> tenantId,
      Value<String> createdAt,
      Value<String> updatedAt,
      Value<String?> deletedAt,
      Value<int> version,
      Value<String> syncStatus,
      Value<String?> lastSyncedAt,
      Value<String> workOrderId,
      Value<String?> materialId,
      Value<String> name,
      Value<double> quantity,
      Value<String> unit,
      Value<String?> notes,
      Value<int> rowid,
    });

class $$WorkOrderMaterialsTableFilterComposer
    extends Composer<_$AppDatabase, $WorkOrderMaterialsTable> {
  $$WorkOrderMaterialsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tenantId => $composableBuilder(
    column: $table.tenantId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastSyncedAt => $composableBuilder(
    column: $table.lastSyncedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get workOrderId => $composableBuilder(
    column: $table.workOrderId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get materialId => $composableBuilder(
    column: $table.materialId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get unit => $composableBuilder(
    column: $table.unit,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );
}

class $$WorkOrderMaterialsTableOrderingComposer
    extends Composer<_$AppDatabase, $WorkOrderMaterialsTable> {
  $$WorkOrderMaterialsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tenantId => $composableBuilder(
    column: $table.tenantId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastSyncedAt => $composableBuilder(
    column: $table.lastSyncedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get workOrderId => $composableBuilder(
    column: $table.workOrderId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get materialId => $composableBuilder(
    column: $table.materialId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get unit => $composableBuilder(
    column: $table.unit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$WorkOrderMaterialsTableAnnotationComposer
    extends Composer<_$AppDatabase, $WorkOrderMaterialsTable> {
  $$WorkOrderMaterialsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get tenantId =>
      $composableBuilder(column: $table.tenantId, builder: (column) => column);

  GeneratedColumn<String> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<int> get version =>
      $composableBuilder(column: $table.version, builder: (column) => column);

  GeneratedColumn<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => column,
  );

  GeneratedColumn<String> get lastSyncedAt => $composableBuilder(
    column: $table.lastSyncedAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get workOrderId => $composableBuilder(
    column: $table.workOrderId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get materialId => $composableBuilder(
    column: $table.materialId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<double> get quantity =>
      $composableBuilder(column: $table.quantity, builder: (column) => column);

  GeneratedColumn<String> get unit =>
      $composableBuilder(column: $table.unit, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);
}

class $$WorkOrderMaterialsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $WorkOrderMaterialsTable,
          WorkOrderMaterialRow,
          $$WorkOrderMaterialsTableFilterComposer,
          $$WorkOrderMaterialsTableOrderingComposer,
          $$WorkOrderMaterialsTableAnnotationComposer,
          $$WorkOrderMaterialsTableCreateCompanionBuilder,
          $$WorkOrderMaterialsTableUpdateCompanionBuilder,
          (
            WorkOrderMaterialRow,
            BaseReferences<
              _$AppDatabase,
              $WorkOrderMaterialsTable,
              WorkOrderMaterialRow
            >,
          ),
          WorkOrderMaterialRow,
          PrefetchHooks Function()
        > {
  $$WorkOrderMaterialsTableTableManager(
    _$AppDatabase db,
    $WorkOrderMaterialsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WorkOrderMaterialsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WorkOrderMaterialsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WorkOrderMaterialsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> tenantId = const Value.absent(),
                Value<String> createdAt = const Value.absent(),
                Value<String> updatedAt = const Value.absent(),
                Value<String?> deletedAt = const Value.absent(),
                Value<int> version = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<String?> lastSyncedAt = const Value.absent(),
                Value<String> workOrderId = const Value.absent(),
                Value<String?> materialId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<double> quantity = const Value.absent(),
                Value<String> unit = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => WorkOrderMaterialsCompanion(
                id: id,
                tenantId: tenantId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                version: version,
                syncStatus: syncStatus,
                lastSyncedAt: lastSyncedAt,
                workOrderId: workOrderId,
                materialId: materialId,
                name: name,
                quantity: quantity,
                unit: unit,
                notes: notes,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String tenantId,
                Value<String> createdAt = const Value.absent(),
                Value<String> updatedAt = const Value.absent(),
                Value<String?> deletedAt = const Value.absent(),
                Value<int> version = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<String?> lastSyncedAt = const Value.absent(),
                required String workOrderId,
                Value<String?> materialId = const Value.absent(),
                required String name,
                required double quantity,
                required String unit,
                Value<String?> notes = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => WorkOrderMaterialsCompanion.insert(
                id: id,
                tenantId: tenantId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                version: version,
                syncStatus: syncStatus,
                lastSyncedAt: lastSyncedAt,
                workOrderId: workOrderId,
                materialId: materialId,
                name: name,
                quantity: quantity,
                unit: unit,
                notes: notes,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$WorkOrderMaterialsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $WorkOrderMaterialsTable,
      WorkOrderMaterialRow,
      $$WorkOrderMaterialsTableFilterComposer,
      $$WorkOrderMaterialsTableOrderingComposer,
      $$WorkOrderMaterialsTableAnnotationComposer,
      $$WorkOrderMaterialsTableCreateCompanionBuilder,
      $$WorkOrderMaterialsTableUpdateCompanionBuilder,
      (
        WorkOrderMaterialRow,
        BaseReferences<
          _$AppDatabase,
          $WorkOrderMaterialsTable,
          WorkOrderMaterialRow
        >,
      ),
      WorkOrderMaterialRow,
      PrefetchHooks Function()
    >;
typedef $$ReportsTableCreateCompanionBuilder =
    ReportsCompanion Function({
      required String id,
      required String tenantId,
      Value<String> createdAt,
      Value<String> updatedAt,
      Value<String?> deletedAt,
      Value<int> version,
      Value<String> syncStatus,
      Value<String?> lastSyncedAt,
      required String workOrderId,
      required String reportNumber,
      required String status,
      Value<String?> pdfLocalPath,
      Value<String?> pdfRemoteUrl,
      Value<String?> generatedAt,
      Value<String?> signedAt,
      Value<String?> customerNameSigned,
      Value<int> rowid,
    });
typedef $$ReportsTableUpdateCompanionBuilder =
    ReportsCompanion Function({
      Value<String> id,
      Value<String> tenantId,
      Value<String> createdAt,
      Value<String> updatedAt,
      Value<String?> deletedAt,
      Value<int> version,
      Value<String> syncStatus,
      Value<String?> lastSyncedAt,
      Value<String> workOrderId,
      Value<String> reportNumber,
      Value<String> status,
      Value<String?> pdfLocalPath,
      Value<String?> pdfRemoteUrl,
      Value<String?> generatedAt,
      Value<String?> signedAt,
      Value<String?> customerNameSigned,
      Value<int> rowid,
    });

class $$ReportsTableFilterComposer
    extends Composer<_$AppDatabase, $ReportsTable> {
  $$ReportsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tenantId => $composableBuilder(
    column: $table.tenantId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastSyncedAt => $composableBuilder(
    column: $table.lastSyncedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get workOrderId => $composableBuilder(
    column: $table.workOrderId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get reportNumber => $composableBuilder(
    column: $table.reportNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get pdfLocalPath => $composableBuilder(
    column: $table.pdfLocalPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get pdfRemoteUrl => $composableBuilder(
    column: $table.pdfRemoteUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get generatedAt => $composableBuilder(
    column: $table.generatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get signedAt => $composableBuilder(
    column: $table.signedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get customerNameSigned => $composableBuilder(
    column: $table.customerNameSigned,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ReportsTableOrderingComposer
    extends Composer<_$AppDatabase, $ReportsTable> {
  $$ReportsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tenantId => $composableBuilder(
    column: $table.tenantId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastSyncedAt => $composableBuilder(
    column: $table.lastSyncedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get workOrderId => $composableBuilder(
    column: $table.workOrderId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get reportNumber => $composableBuilder(
    column: $table.reportNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get pdfLocalPath => $composableBuilder(
    column: $table.pdfLocalPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get pdfRemoteUrl => $composableBuilder(
    column: $table.pdfRemoteUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get generatedAt => $composableBuilder(
    column: $table.generatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get signedAt => $composableBuilder(
    column: $table.signedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get customerNameSigned => $composableBuilder(
    column: $table.customerNameSigned,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ReportsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ReportsTable> {
  $$ReportsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get tenantId =>
      $composableBuilder(column: $table.tenantId, builder: (column) => column);

  GeneratedColumn<String> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<int> get version =>
      $composableBuilder(column: $table.version, builder: (column) => column);

  GeneratedColumn<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => column,
  );

  GeneratedColumn<String> get lastSyncedAt => $composableBuilder(
    column: $table.lastSyncedAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get workOrderId => $composableBuilder(
    column: $table.workOrderId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get reportNumber => $composableBuilder(
    column: $table.reportNumber,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get pdfLocalPath => $composableBuilder(
    column: $table.pdfLocalPath,
    builder: (column) => column,
  );

  GeneratedColumn<String> get pdfRemoteUrl => $composableBuilder(
    column: $table.pdfRemoteUrl,
    builder: (column) => column,
  );

  GeneratedColumn<String> get generatedAt => $composableBuilder(
    column: $table.generatedAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get signedAt =>
      $composableBuilder(column: $table.signedAt, builder: (column) => column);

  GeneratedColumn<String> get customerNameSigned => $composableBuilder(
    column: $table.customerNameSigned,
    builder: (column) => column,
  );
}

class $$ReportsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ReportsTable,
          ReportRow,
          $$ReportsTableFilterComposer,
          $$ReportsTableOrderingComposer,
          $$ReportsTableAnnotationComposer,
          $$ReportsTableCreateCompanionBuilder,
          $$ReportsTableUpdateCompanionBuilder,
          (ReportRow, BaseReferences<_$AppDatabase, $ReportsTable, ReportRow>),
          ReportRow,
          PrefetchHooks Function()
        > {
  $$ReportsTableTableManager(_$AppDatabase db, $ReportsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ReportsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ReportsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ReportsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> tenantId = const Value.absent(),
                Value<String> createdAt = const Value.absent(),
                Value<String> updatedAt = const Value.absent(),
                Value<String?> deletedAt = const Value.absent(),
                Value<int> version = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<String?> lastSyncedAt = const Value.absent(),
                Value<String> workOrderId = const Value.absent(),
                Value<String> reportNumber = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String?> pdfLocalPath = const Value.absent(),
                Value<String?> pdfRemoteUrl = const Value.absent(),
                Value<String?> generatedAt = const Value.absent(),
                Value<String?> signedAt = const Value.absent(),
                Value<String?> customerNameSigned = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ReportsCompanion(
                id: id,
                tenantId: tenantId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                version: version,
                syncStatus: syncStatus,
                lastSyncedAt: lastSyncedAt,
                workOrderId: workOrderId,
                reportNumber: reportNumber,
                status: status,
                pdfLocalPath: pdfLocalPath,
                pdfRemoteUrl: pdfRemoteUrl,
                generatedAt: generatedAt,
                signedAt: signedAt,
                customerNameSigned: customerNameSigned,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String tenantId,
                Value<String> createdAt = const Value.absent(),
                Value<String> updatedAt = const Value.absent(),
                Value<String?> deletedAt = const Value.absent(),
                Value<int> version = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<String?> lastSyncedAt = const Value.absent(),
                required String workOrderId,
                required String reportNumber,
                required String status,
                Value<String?> pdfLocalPath = const Value.absent(),
                Value<String?> pdfRemoteUrl = const Value.absent(),
                Value<String?> generatedAt = const Value.absent(),
                Value<String?> signedAt = const Value.absent(),
                Value<String?> customerNameSigned = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ReportsCompanion.insert(
                id: id,
                tenantId: tenantId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                version: version,
                syncStatus: syncStatus,
                lastSyncedAt: lastSyncedAt,
                workOrderId: workOrderId,
                reportNumber: reportNumber,
                status: status,
                pdfLocalPath: pdfLocalPath,
                pdfRemoteUrl: pdfRemoteUrl,
                generatedAt: generatedAt,
                signedAt: signedAt,
                customerNameSigned: customerNameSigned,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ReportsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ReportsTable,
      ReportRow,
      $$ReportsTableFilterComposer,
      $$ReportsTableOrderingComposer,
      $$ReportsTableAnnotationComposer,
      $$ReportsTableCreateCompanionBuilder,
      $$ReportsTableUpdateCompanionBuilder,
      (ReportRow, BaseReferences<_$AppDatabase, $ReportsTable, ReportRow>),
      ReportRow,
      PrefetchHooks Function()
    >;
typedef $$OutboxEntriesTableCreateCompanionBuilder =
    OutboxEntriesCompanion Function({
      required String id,
      required String tenantId,
      Value<String> createdAt,
      Value<String> updatedAt,
      Value<String?> deletedAt,
      Value<int> version,
      Value<String> syncStatus,
      Value<String?> lastSyncedAt,
      required String entityType,
      required String entityId,
      required String operation,
      required String payloadJson,
      Value<int> attempts,
      Value<String?> lastAttemptAt,
      Value<String> status,
      Value<String?> errorMessage,
      Value<int> rowid,
    });
typedef $$OutboxEntriesTableUpdateCompanionBuilder =
    OutboxEntriesCompanion Function({
      Value<String> id,
      Value<String> tenantId,
      Value<String> createdAt,
      Value<String> updatedAt,
      Value<String?> deletedAt,
      Value<int> version,
      Value<String> syncStatus,
      Value<String?> lastSyncedAt,
      Value<String> entityType,
      Value<String> entityId,
      Value<String> operation,
      Value<String> payloadJson,
      Value<int> attempts,
      Value<String?> lastAttemptAt,
      Value<String> status,
      Value<String?> errorMessage,
      Value<int> rowid,
    });

class $$OutboxEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $OutboxEntriesTable> {
  $$OutboxEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tenantId => $composableBuilder(
    column: $table.tenantId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastSyncedAt => $composableBuilder(
    column: $table.lastSyncedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get entityType => $composableBuilder(
    column: $table.entityType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get entityId => $composableBuilder(
    column: $table.entityId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get operation => $composableBuilder(
    column: $table.operation,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get payloadJson => $composableBuilder(
    column: $table.payloadJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get attempts => $composableBuilder(
    column: $table.attempts,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastAttemptAt => $composableBuilder(
    column: $table.lastAttemptAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get errorMessage => $composableBuilder(
    column: $table.errorMessage,
    builder: (column) => ColumnFilters(column),
  );
}

class $$OutboxEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $OutboxEntriesTable> {
  $$OutboxEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tenantId => $composableBuilder(
    column: $table.tenantId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastSyncedAt => $composableBuilder(
    column: $table.lastSyncedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get entityType => $composableBuilder(
    column: $table.entityType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get entityId => $composableBuilder(
    column: $table.entityId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get operation => $composableBuilder(
    column: $table.operation,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get payloadJson => $composableBuilder(
    column: $table.payloadJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get attempts => $composableBuilder(
    column: $table.attempts,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastAttemptAt => $composableBuilder(
    column: $table.lastAttemptAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get errorMessage => $composableBuilder(
    column: $table.errorMessage,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$OutboxEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $OutboxEntriesTable> {
  $$OutboxEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get tenantId =>
      $composableBuilder(column: $table.tenantId, builder: (column) => column);

  GeneratedColumn<String> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<int> get version =>
      $composableBuilder(column: $table.version, builder: (column) => column);

  GeneratedColumn<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => column,
  );

  GeneratedColumn<String> get lastSyncedAt => $composableBuilder(
    column: $table.lastSyncedAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get entityType => $composableBuilder(
    column: $table.entityType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get entityId =>
      $composableBuilder(column: $table.entityId, builder: (column) => column);

  GeneratedColumn<String> get operation =>
      $composableBuilder(column: $table.operation, builder: (column) => column);

  GeneratedColumn<String> get payloadJson => $composableBuilder(
    column: $table.payloadJson,
    builder: (column) => column,
  );

  GeneratedColumn<int> get attempts =>
      $composableBuilder(column: $table.attempts, builder: (column) => column);

  GeneratedColumn<String> get lastAttemptAt => $composableBuilder(
    column: $table.lastAttemptAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get errorMessage => $composableBuilder(
    column: $table.errorMessage,
    builder: (column) => column,
  );
}

class $$OutboxEntriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $OutboxEntriesTable,
          OutboxEntryRow,
          $$OutboxEntriesTableFilterComposer,
          $$OutboxEntriesTableOrderingComposer,
          $$OutboxEntriesTableAnnotationComposer,
          $$OutboxEntriesTableCreateCompanionBuilder,
          $$OutboxEntriesTableUpdateCompanionBuilder,
          (
            OutboxEntryRow,
            BaseReferences<_$AppDatabase, $OutboxEntriesTable, OutboxEntryRow>,
          ),
          OutboxEntryRow,
          PrefetchHooks Function()
        > {
  $$OutboxEntriesTableTableManager(_$AppDatabase db, $OutboxEntriesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$OutboxEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$OutboxEntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$OutboxEntriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> tenantId = const Value.absent(),
                Value<String> createdAt = const Value.absent(),
                Value<String> updatedAt = const Value.absent(),
                Value<String?> deletedAt = const Value.absent(),
                Value<int> version = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<String?> lastSyncedAt = const Value.absent(),
                Value<String> entityType = const Value.absent(),
                Value<String> entityId = const Value.absent(),
                Value<String> operation = const Value.absent(),
                Value<String> payloadJson = const Value.absent(),
                Value<int> attempts = const Value.absent(),
                Value<String?> lastAttemptAt = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String?> errorMessage = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => OutboxEntriesCompanion(
                id: id,
                tenantId: tenantId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                version: version,
                syncStatus: syncStatus,
                lastSyncedAt: lastSyncedAt,
                entityType: entityType,
                entityId: entityId,
                operation: operation,
                payloadJson: payloadJson,
                attempts: attempts,
                lastAttemptAt: lastAttemptAt,
                status: status,
                errorMessage: errorMessage,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String tenantId,
                Value<String> createdAt = const Value.absent(),
                Value<String> updatedAt = const Value.absent(),
                Value<String?> deletedAt = const Value.absent(),
                Value<int> version = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<String?> lastSyncedAt = const Value.absent(),
                required String entityType,
                required String entityId,
                required String operation,
                required String payloadJson,
                Value<int> attempts = const Value.absent(),
                Value<String?> lastAttemptAt = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String?> errorMessage = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => OutboxEntriesCompanion.insert(
                id: id,
                tenantId: tenantId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                version: version,
                syncStatus: syncStatus,
                lastSyncedAt: lastSyncedAt,
                entityType: entityType,
                entityId: entityId,
                operation: operation,
                payloadJson: payloadJson,
                attempts: attempts,
                lastAttemptAt: lastAttemptAt,
                status: status,
                errorMessage: errorMessage,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$OutboxEntriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $OutboxEntriesTable,
      OutboxEntryRow,
      $$OutboxEntriesTableFilterComposer,
      $$OutboxEntriesTableOrderingComposer,
      $$OutboxEntriesTableAnnotationComposer,
      $$OutboxEntriesTableCreateCompanionBuilder,
      $$OutboxEntriesTableUpdateCompanionBuilder,
      (
        OutboxEntryRow,
        BaseReferences<_$AppDatabase, $OutboxEntriesTable, OutboxEntryRow>,
      ),
      OutboxEntryRow,
      PrefetchHooks Function()
    >;
typedef $$SyncStatesTableCreateCompanionBuilder =
    SyncStatesCompanion Function({
      required String id,
      required String tenantId,
      required String entityType,
      Value<String?> lastPullAt,
      Value<String?> lastSuccessfulSyncAt,
      Value<String?> cursor,
      Value<int> rowid,
    });
typedef $$SyncStatesTableUpdateCompanionBuilder =
    SyncStatesCompanion Function({
      Value<String> id,
      Value<String> tenantId,
      Value<String> entityType,
      Value<String?> lastPullAt,
      Value<String?> lastSuccessfulSyncAt,
      Value<String?> cursor,
      Value<int> rowid,
    });

class $$SyncStatesTableFilterComposer
    extends Composer<_$AppDatabase, $SyncStatesTable> {
  $$SyncStatesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tenantId => $composableBuilder(
    column: $table.tenantId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get entityType => $composableBuilder(
    column: $table.entityType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastPullAt => $composableBuilder(
    column: $table.lastPullAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastSuccessfulSyncAt => $composableBuilder(
    column: $table.lastSuccessfulSyncAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get cursor => $composableBuilder(
    column: $table.cursor,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SyncStatesTableOrderingComposer
    extends Composer<_$AppDatabase, $SyncStatesTable> {
  $$SyncStatesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tenantId => $composableBuilder(
    column: $table.tenantId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get entityType => $composableBuilder(
    column: $table.entityType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastPullAt => $composableBuilder(
    column: $table.lastPullAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastSuccessfulSyncAt => $composableBuilder(
    column: $table.lastSuccessfulSyncAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get cursor => $composableBuilder(
    column: $table.cursor,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SyncStatesTableAnnotationComposer
    extends Composer<_$AppDatabase, $SyncStatesTable> {
  $$SyncStatesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get tenantId =>
      $composableBuilder(column: $table.tenantId, builder: (column) => column);

  GeneratedColumn<String> get entityType => $composableBuilder(
    column: $table.entityType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get lastPullAt => $composableBuilder(
    column: $table.lastPullAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get lastSuccessfulSyncAt => $composableBuilder(
    column: $table.lastSuccessfulSyncAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get cursor =>
      $composableBuilder(column: $table.cursor, builder: (column) => column);
}

class $$SyncStatesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SyncStatesTable,
          SyncStateRow,
          $$SyncStatesTableFilterComposer,
          $$SyncStatesTableOrderingComposer,
          $$SyncStatesTableAnnotationComposer,
          $$SyncStatesTableCreateCompanionBuilder,
          $$SyncStatesTableUpdateCompanionBuilder,
          (
            SyncStateRow,
            BaseReferences<_$AppDatabase, $SyncStatesTable, SyncStateRow>,
          ),
          SyncStateRow,
          PrefetchHooks Function()
        > {
  $$SyncStatesTableTableManager(_$AppDatabase db, $SyncStatesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SyncStatesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SyncStatesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SyncStatesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> tenantId = const Value.absent(),
                Value<String> entityType = const Value.absent(),
                Value<String?> lastPullAt = const Value.absent(),
                Value<String?> lastSuccessfulSyncAt = const Value.absent(),
                Value<String?> cursor = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SyncStatesCompanion(
                id: id,
                tenantId: tenantId,
                entityType: entityType,
                lastPullAt: lastPullAt,
                lastSuccessfulSyncAt: lastSuccessfulSyncAt,
                cursor: cursor,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String tenantId,
                required String entityType,
                Value<String?> lastPullAt = const Value.absent(),
                Value<String?> lastSuccessfulSyncAt = const Value.absent(),
                Value<String?> cursor = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SyncStatesCompanion.insert(
                id: id,
                tenantId: tenantId,
                entityType: entityType,
                lastPullAt: lastPullAt,
                lastSuccessfulSyncAt: lastSuccessfulSyncAt,
                cursor: cursor,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SyncStatesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SyncStatesTable,
      SyncStateRow,
      $$SyncStatesTableFilterComposer,
      $$SyncStatesTableOrderingComposer,
      $$SyncStatesTableAnnotationComposer,
      $$SyncStatesTableCreateCompanionBuilder,
      $$SyncStatesTableUpdateCompanionBuilder,
      (
        SyncStateRow,
        BaseReferences<_$AppDatabase, $SyncStatesTable, SyncStateRow>,
      ),
      SyncStateRow,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$TenantsTableTableManager get tenants =>
      $$TenantsTableTableManager(_db, _db.tenants);
  $$UsersTableTableManager get users =>
      $$UsersTableTableManager(_db, _db.users);
  $$CustomersTableTableManager get customers =>
      $$CustomersTableTableManager(_db, _db.customers);
  $$CustomerObjectsTableTableManager get customerObjects =>
      $$CustomerObjectsTableTableManager(_db, _db.customerObjects);
  $$InstallationsTableTableManager get installations =>
      $$InstallationsTableTableManager(_db, _db.installations);
  $$WorkOrdersTableTableManager get workOrders =>
      $$WorkOrdersTableTableManager(_db, _db.workOrders);
  $$WorkOrderInstallationsTableTableManager get workOrderInstallations =>
      $$WorkOrderInstallationsTableTableManager(
        _db,
        _db.workOrderInstallations,
      );
  $$ChecklistTemplatesTableTableManager get checklistTemplates =>
      $$ChecklistTemplatesTableTableManager(_db, _db.checklistTemplates);
  $$ChecklistTemplateItemsTableTableManager get checklistTemplateItems =>
      $$ChecklistTemplateItemsTableTableManager(
        _db,
        _db.checklistTemplateItems,
      );
  $$ChecklistAnswersTableTableManager get checklistAnswers =>
      $$ChecklistAnswersTableTableManager(_db, _db.checklistAnswers);
  $$MeasurementsTableTableManager get measurements =>
      $$MeasurementsTableTableManager(_db, _db.measurements);
  $$DefectsTableTableManager get defects =>
      $$DefectsTableTableManager(_db, _db.defects);
  $$PhotosTableTableManager get photos =>
      $$PhotosTableTableManager(_db, _db.photos);
  $$TimeEntriesTableTableManager get timeEntries =>
      $$TimeEntriesTableTableManager(_db, _db.timeEntries);
  $$MaterialsTableTableManager get materials =>
      $$MaterialsTableTableManager(_db, _db.materials);
  $$WorkOrderMaterialsTableTableManager get workOrderMaterials =>
      $$WorkOrderMaterialsTableTableManager(_db, _db.workOrderMaterials);
  $$ReportsTableTableManager get reports =>
      $$ReportsTableTableManager(_db, _db.reports);
  $$OutboxEntriesTableTableManager get outboxEntries =>
      $$OutboxEntriesTableTableManager(_db, _db.outboxEntries);
  $$SyncStatesTableTableManager get syncStates =>
      $$SyncStatesTableTableManager(_db, _db.syncStates);
}

mixin _$UserDaoMixin on DatabaseAccessor<AppDatabase> {
  $UsersTable get users => attachedDatabase.users;
  UserDaoManager get managers => UserDaoManager(this);
}

class UserDaoManager {
  final _$UserDaoMixin _db;
  UserDaoManager(this._db);
  $$UsersTableTableManager get users =>
      $$UsersTableTableManager(_db.attachedDatabase, _db.users);
}

mixin _$CustomerDaoMixin on DatabaseAccessor<AppDatabase> {
  $CustomersTable get customers => attachedDatabase.customers;
  CustomerDaoManager get managers => CustomerDaoManager(this);
}

class CustomerDaoManager {
  final _$CustomerDaoMixin _db;
  CustomerDaoManager(this._db);
  $$CustomersTableTableManager get customers =>
      $$CustomersTableTableManager(_db.attachedDatabase, _db.customers);
}

mixin _$ObjectDaoMixin on DatabaseAccessor<AppDatabase> {
  $CustomerObjectsTable get customerObjects => attachedDatabase.customerObjects;
  ObjectDaoManager get managers => ObjectDaoManager(this);
}

class ObjectDaoManager {
  final _$ObjectDaoMixin _db;
  ObjectDaoManager(this._db);
  $$CustomerObjectsTableTableManager get customerObjects =>
      $$CustomerObjectsTableTableManager(
        _db.attachedDatabase,
        _db.customerObjects,
      );
}

mixin _$InstallationDaoMixin on DatabaseAccessor<AppDatabase> {
  $InstallationsTable get installations => attachedDatabase.installations;
  InstallationDaoManager get managers => InstallationDaoManager(this);
}

class InstallationDaoManager {
  final _$InstallationDaoMixin _db;
  InstallationDaoManager(this._db);
  $$InstallationsTableTableManager get installations =>
      $$InstallationsTableTableManager(_db.attachedDatabase, _db.installations);
}

mixin _$WorkOrderDaoMixin on DatabaseAccessor<AppDatabase> {
  $WorkOrdersTable get workOrders => attachedDatabase.workOrders;
  $CustomersTable get customers => attachedDatabase.customers;
  $CustomerObjectsTable get customerObjects => attachedDatabase.customerObjects;
  $InstallationsTable get installations => attachedDatabase.installations;
  $TimeEntriesTable get timeEntries => attachedDatabase.timeEntries;
  $OutboxEntriesTable get outboxEntries => attachedDatabase.outboxEntries;
  WorkOrderDaoManager get managers => WorkOrderDaoManager(this);
}

class WorkOrderDaoManager {
  final _$WorkOrderDaoMixin _db;
  WorkOrderDaoManager(this._db);
  $$WorkOrdersTableTableManager get workOrders =>
      $$WorkOrdersTableTableManager(_db.attachedDatabase, _db.workOrders);
  $$CustomersTableTableManager get customers =>
      $$CustomersTableTableManager(_db.attachedDatabase, _db.customers);
  $$CustomerObjectsTableTableManager get customerObjects =>
      $$CustomerObjectsTableTableManager(
        _db.attachedDatabase,
        _db.customerObjects,
      );
  $$InstallationsTableTableManager get installations =>
      $$InstallationsTableTableManager(_db.attachedDatabase, _db.installations);
  $$TimeEntriesTableTableManager get timeEntries =>
      $$TimeEntriesTableTableManager(_db.attachedDatabase, _db.timeEntries);
  $$OutboxEntriesTableTableManager get outboxEntries =>
      $$OutboxEntriesTableTableManager(_db.attachedDatabase, _db.outboxEntries);
}

mixin _$ChecklistDaoMixin on DatabaseAccessor<AppDatabase> {
  $ChecklistTemplatesTable get checklistTemplates =>
      attachedDatabase.checklistTemplates;
  $ChecklistTemplateItemsTable get checklistTemplateItems =>
      attachedDatabase.checklistTemplateItems;
  $ChecklistAnswersTable get checklistAnswers =>
      attachedDatabase.checklistAnswers;
  ChecklistDaoManager get managers => ChecklistDaoManager(this);
}

class ChecklistDaoManager {
  final _$ChecklistDaoMixin _db;
  ChecklistDaoManager(this._db);
  $$ChecklistTemplatesTableTableManager get checklistTemplates =>
      $$ChecklistTemplatesTableTableManager(
        _db.attachedDatabase,
        _db.checklistTemplates,
      );
  $$ChecklistTemplateItemsTableTableManager get checklistTemplateItems =>
      $$ChecklistTemplateItemsTableTableManager(
        _db.attachedDatabase,
        _db.checklistTemplateItems,
      );
  $$ChecklistAnswersTableTableManager get checklistAnswers =>
      $$ChecklistAnswersTableTableManager(
        _db.attachedDatabase,
        _db.checklistAnswers,
      );
}

mixin _$MeasurementDaoMixin on DatabaseAccessor<AppDatabase> {
  $MeasurementsTable get measurements => attachedDatabase.measurements;
  MeasurementDaoManager get managers => MeasurementDaoManager(this);
}

class MeasurementDaoManager {
  final _$MeasurementDaoMixin _db;
  MeasurementDaoManager(this._db);
  $$MeasurementsTableTableManager get measurements =>
      $$MeasurementsTableTableManager(_db.attachedDatabase, _db.measurements);
}

mixin _$DefectDaoMixin on DatabaseAccessor<AppDatabase> {
  $DefectsTable get defects => attachedDatabase.defects;
  DefectDaoManager get managers => DefectDaoManager(this);
}

class DefectDaoManager {
  final _$DefectDaoMixin _db;
  DefectDaoManager(this._db);
  $$DefectsTableTableManager get defects =>
      $$DefectsTableTableManager(_db.attachedDatabase, _db.defects);
}

mixin _$PhotoDaoMixin on DatabaseAccessor<AppDatabase> {
  $PhotosTable get photos => attachedDatabase.photos;
  PhotoDaoManager get managers => PhotoDaoManager(this);
}

class PhotoDaoManager {
  final _$PhotoDaoMixin _db;
  PhotoDaoManager(this._db);
  $$PhotosTableTableManager get photos =>
      $$PhotosTableTableManager(_db.attachedDatabase, _db.photos);
}

mixin _$TimeEntryDaoMixin on DatabaseAccessor<AppDatabase> {
  $TimeEntriesTable get timeEntries => attachedDatabase.timeEntries;
  TimeEntryDaoManager get managers => TimeEntryDaoManager(this);
}

class TimeEntryDaoManager {
  final _$TimeEntryDaoMixin _db;
  TimeEntryDaoManager(this._db);
  $$TimeEntriesTableTableManager get timeEntries =>
      $$TimeEntriesTableTableManager(_db.attachedDatabase, _db.timeEntries);
}

mixin _$MaterialDaoMixin on DatabaseAccessor<AppDatabase> {
  $MaterialsTable get materials => attachedDatabase.materials;
  $WorkOrderMaterialsTable get workOrderMaterials =>
      attachedDatabase.workOrderMaterials;
  MaterialDaoManager get managers => MaterialDaoManager(this);
}

class MaterialDaoManager {
  final _$MaterialDaoMixin _db;
  MaterialDaoManager(this._db);
  $$MaterialsTableTableManager get materials =>
      $$MaterialsTableTableManager(_db.attachedDatabase, _db.materials);
  $$WorkOrderMaterialsTableTableManager get workOrderMaterials =>
      $$WorkOrderMaterialsTableTableManager(
        _db.attachedDatabase,
        _db.workOrderMaterials,
      );
}

mixin _$ReportDaoMixin on DatabaseAccessor<AppDatabase> {
  $ReportsTable get reports => attachedDatabase.reports;
  ReportDaoManager get managers => ReportDaoManager(this);
}

class ReportDaoManager {
  final _$ReportDaoMixin _db;
  ReportDaoManager(this._db);
  $$ReportsTableTableManager get reports =>
      $$ReportsTableTableManager(_db.attachedDatabase, _db.reports);
}

mixin _$OutboxDaoMixin on DatabaseAccessor<AppDatabase> {
  $OutboxEntriesTable get outboxEntries => attachedDatabase.outboxEntries;
  OutboxDaoManager get managers => OutboxDaoManager(this);
}

class OutboxDaoManager {
  final _$OutboxDaoMixin _db;
  OutboxDaoManager(this._db);
  $$OutboxEntriesTableTableManager get outboxEntries =>
      $$OutboxEntriesTableTableManager(_db.attachedDatabase, _db.outboxEntries);
}

mixin _$SyncStateDaoMixin on DatabaseAccessor<AppDatabase> {
  $SyncStatesTable get syncStates => attachedDatabase.syncStates;
  SyncStateDaoManager get managers => SyncStateDaoManager(this);
}

class SyncStateDaoManager {
  final _$SyncStateDaoMixin _db;
  SyncStateDaoManager(this._db);
  $$SyncStatesTableTableManager get syncStates =>
      $$SyncStatesTableTableManager(_db.attachedDatabase, _db.syncStates);
}
