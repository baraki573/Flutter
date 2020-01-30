// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class User extends DataClass implements Insertable<User> {
  final String username;
  final String imgPath;
  final bool onboardEnd;
  User(
      {@required this.username,
      @required this.imgPath,
      @required this.onboardEnd});
  factory User.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    final boolType = db.typeSystem.forDartType<bool>();
    return User(
      username: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}username']),
      imgPath: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}img_path']),
      onboardEnd: boolType
          .mapFromDatabaseResponse(data['${effectivePrefix}onboard_end']),
    );
  }
  factory User.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return User(
      username: serializer.fromJson<String>(json['username']),
      imgPath: serializer.fromJson<String>(json['imgPath']),
      onboardEnd: serializer.fromJson<bool>(json['onboardEnd']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'username': serializer.toJson<String>(username),
      'imgPath': serializer.toJson<String>(imgPath),
      'onboardEnd': serializer.toJson<bool>(onboardEnd),
    };
  }

  @override
  UsersCompanion createCompanion(bool nullToAbsent) {
    return UsersCompanion(
      username: username == null && nullToAbsent
          ? const Value.absent()
          : Value(username),
      imgPath: imgPath == null && nullToAbsent
          ? const Value.absent()
          : Value(imgPath),
      onboardEnd: onboardEnd == null && nullToAbsent
          ? const Value.absent()
          : Value(onboardEnd),
    );
  }

  User copyWith({String username, String imgPath, bool onboardEnd}) => User(
        username: username ?? this.username,
        imgPath: imgPath ?? this.imgPath,
        onboardEnd: onboardEnd ?? this.onboardEnd,
      );
  @override
  String toString() {
    return (StringBuffer('User(')
          ..write('username: $username, ')
          ..write('imgPath: $imgPath, ')
          ..write('onboardEnd: $onboardEnd')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf(
      $mrjc(username.hashCode, $mrjc(imgPath.hashCode, onboardEnd.hashCode)));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is User &&
          other.username == this.username &&
          other.imgPath == this.imgPath &&
          other.onboardEnd == this.onboardEnd);
}

class UsersCompanion extends UpdateCompanion<User> {
  final Value<String> username;
  final Value<String> imgPath;
  final Value<bool> onboardEnd;
  const UsersCompanion({
    this.username = const Value.absent(),
    this.imgPath = const Value.absent(),
    this.onboardEnd = const Value.absent(),
  });
  UsersCompanion.insert({
    @required String username,
    @required String imgPath,
    this.onboardEnd = const Value.absent(),
  })  : username = Value(username),
        imgPath = Value(imgPath);
  UsersCompanion copyWith(
      {Value<String> username, Value<String> imgPath, Value<bool> onboardEnd}) {
    return UsersCompanion(
      username: username ?? this.username,
      imgPath: imgPath ?? this.imgPath,
      onboardEnd: onboardEnd ?? this.onboardEnd,
    );
  }
}

class $UsersTable extends Users with TableInfo<$UsersTable, User> {
  final GeneratedDatabase _db;
  final String _alias;
  $UsersTable(this._db, [this._alias]);
  final VerificationMeta _usernameMeta = const VerificationMeta('username');
  GeneratedTextColumn _username;
  @override
  GeneratedTextColumn get username => _username ??= _constructUsername();
  GeneratedTextColumn _constructUsername() {
    return GeneratedTextColumn(
      'username',
      $tableName,
      false,
    );
  }

  final VerificationMeta _imgPathMeta = const VerificationMeta('imgPath');
  GeneratedTextColumn _imgPath;
  @override
  GeneratedTextColumn get imgPath => _imgPath ??= _constructImgPath();
  GeneratedTextColumn _constructImgPath() {
    return GeneratedTextColumn(
      'img_path',
      $tableName,
      false,
    );
  }

  final VerificationMeta _onboardEndMeta = const VerificationMeta('onboardEnd');
  GeneratedBoolColumn _onboardEnd;
  @override
  GeneratedBoolColumn get onboardEnd => _onboardEnd ??= _constructOnboardEnd();
  GeneratedBoolColumn _constructOnboardEnd() {
    return GeneratedBoolColumn('onboard_end', $tableName, false,
        defaultValue: const Constant(false));
  }

  @override
  List<GeneratedColumn> get $columns => [username, imgPath, onboardEnd];
  @override
  $UsersTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'users';
  @override
  final String actualTableName = 'users';
  @override
  VerificationContext validateIntegrity(UsersCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.username.present) {
      context.handle(_usernameMeta,
          username.isAcceptableValue(d.username.value, _usernameMeta));
    } else if (isInserting) {
      context.missing(_usernameMeta);
    }
    if (d.imgPath.present) {
      context.handle(_imgPathMeta,
          imgPath.isAcceptableValue(d.imgPath.value, _imgPathMeta));
    } else if (isInserting) {
      context.missing(_imgPathMeta);
    }
    if (d.onboardEnd.present) {
      context.handle(_onboardEndMeta,
          onboardEnd.isAcceptableValue(d.onboardEnd.value, _onboardEndMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {username};
  @override
  User map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return User.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(UsersCompanion d) {
    final map = <String, Variable>{};
    if (d.username.present) {
      map['username'] = Variable<String, StringType>(d.username.value);
    }
    if (d.imgPath.present) {
      map['img_path'] = Variable<String, StringType>(d.imgPath.value);
    }
    if (d.onboardEnd.present) {
      map['onboard_end'] = Variable<bool, BoolType>(d.onboardEnd.value);
    }
    return map;
  }

  @override
  $UsersTable createAlias(String alias) {
    return $UsersTable(_db, alias);
  }
}

class Badge extends DataClass implements Insertable<Badge> {
  final String name;
  final double current;
  final double toGet;
  final dynamic color;
  final String imgPath;
  Badge(
      {@required this.name,
      @required this.current,
      @required this.toGet,
      @required this.color,
      @required this.imgPath});
  factory Badge.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    final doubleType = db.typeSystem.forDartType<double>();
    final intType = db.typeSystem.forDartType<int>();
    return Badge(
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
      current:
          doubleType.mapFromDatabaseResponse(data['${effectivePrefix}current']),
      toGet:
          doubleType.mapFromDatabaseResponse(data['${effectivePrefix}to_get']),
      color: $BadgesTable.$converter0.mapToDart(
          intType.mapFromDatabaseResponse(data['${effectivePrefix}color'])),
      imgPath: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}img_path']),
    );
  }
  factory Badge.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Badge(
      name: serializer.fromJson<String>(json['name']),
      current: serializer.fromJson<double>(json['current']),
      toGet: serializer.fromJson<double>(json['toGet']),
      color: serializer.fromJson<dynamic>(json['color']),
      imgPath: serializer.fromJson<String>(json['imgPath']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'name': serializer.toJson<String>(name),
      'current': serializer.toJson<double>(current),
      'toGet': serializer.toJson<double>(toGet),
      'color': serializer.toJson<dynamic>(color),
      'imgPath': serializer.toJson<String>(imgPath),
    };
  }

  @override
  BadgesCompanion createCompanion(bool nullToAbsent) {
    return BadgesCompanion(
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      current: current == null && nullToAbsent
          ? const Value.absent()
          : Value(current),
      toGet:
          toGet == null && nullToAbsent ? const Value.absent() : Value(toGet),
      color:
          color == null && nullToAbsent ? const Value.absent() : Value(color),
      imgPath: imgPath == null && nullToAbsent
          ? const Value.absent()
          : Value(imgPath),
    );
  }

  Badge copyWith(
          {String name,
          double current,
          double toGet,
          dynamic color,
          String imgPath}) =>
      Badge(
        name: name ?? this.name,
        current: current ?? this.current,
        toGet: toGet ?? this.toGet,
        color: color ?? this.color,
        imgPath: imgPath ?? this.imgPath,
      );
  @override
  String toString() {
    return (StringBuffer('Badge(')
          ..write('name: $name, ')
          ..write('current: $current, ')
          ..write('toGet: $toGet, ')
          ..write('color: $color, ')
          ..write('imgPath: $imgPath')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      name.hashCode,
      $mrjc(current.hashCode,
          $mrjc(toGet.hashCode, $mrjc(color.hashCode, imgPath.hashCode)))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Badge &&
          other.name == this.name &&
          other.current == this.current &&
          other.toGet == this.toGet &&
          other.color == this.color &&
          other.imgPath == this.imgPath);
}

class BadgesCompanion extends UpdateCompanion<Badge> {
  final Value<String> name;
  final Value<double> current;
  final Value<double> toGet;
  final Value<dynamic> color;
  final Value<String> imgPath;
  const BadgesCompanion({
    this.name = const Value.absent(),
    this.current = const Value.absent(),
    this.toGet = const Value.absent(),
    this.color = const Value.absent(),
    this.imgPath = const Value.absent(),
  });
  BadgesCompanion.insert({
    @required String name,
    this.current = const Value.absent(),
    @required double toGet,
    this.color = const Value.absent(),
    @required String imgPath,
  })  : name = Value(name),
        toGet = Value(toGet),
        imgPath = Value(imgPath);
  BadgesCompanion copyWith(
      {Value<String> name,
      Value<double> current,
      Value<double> toGet,
      Value<dynamic> color,
      Value<String> imgPath}) {
    return BadgesCompanion(
      name: name ?? this.name,
      current: current ?? this.current,
      toGet: toGet ?? this.toGet,
      color: color ?? this.color,
      imgPath: imgPath ?? this.imgPath,
    );
  }
}

class $BadgesTable extends Badges with TableInfo<$BadgesTable, Badge> {
  final GeneratedDatabase _db;
  final String _alias;
  $BadgesTable(this._db, [this._alias]);
  final VerificationMeta _nameMeta = const VerificationMeta('name');
  GeneratedTextColumn _name;
  @override
  GeneratedTextColumn get name => _name ??= _constructName();
  GeneratedTextColumn _constructName() {
    return GeneratedTextColumn('name', $tableName, false,
        minTextLength: 3, maxTextLength: 15);
  }

  final VerificationMeta _currentMeta = const VerificationMeta('current');
  GeneratedRealColumn _current;
  @override
  GeneratedRealColumn get current => _current ??= _constructCurrent();
  GeneratedRealColumn _constructCurrent() {
    return GeneratedRealColumn('current', $tableName, false,
        defaultValue: const Constant(0.0));
  }

  final VerificationMeta _toGetMeta = const VerificationMeta('toGet');
  GeneratedRealColumn _toGet;
  @override
  GeneratedRealColumn get toGet => _toGet ??= _constructToGet();
  GeneratedRealColumn _constructToGet() {
    return GeneratedRealColumn(
      'to_get',
      $tableName,
      false,
    );
  }

  final VerificationMeta _colorMeta = const VerificationMeta('color');
  GeneratedIntColumn _color;
  @override
  GeneratedIntColumn get color => _color ??= _constructColor();
  GeneratedIntColumn _constructColor() {
    return GeneratedIntColumn('color', $tableName, false,
        defaultValue: const Constant(0));
  }

  final VerificationMeta _imgPathMeta = const VerificationMeta('imgPath');
  GeneratedTextColumn _imgPath;
  @override
  GeneratedTextColumn get imgPath => _imgPath ??= _constructImgPath();
  GeneratedTextColumn _constructImgPath() {
    return GeneratedTextColumn(
      'img_path',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [name, current, toGet, color, imgPath];
  @override
  $BadgesTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'badges';
  @override
  final String actualTableName = 'badges';
  @override
  VerificationContext validateIntegrity(BadgesCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.name.present) {
      context.handle(
          _nameMeta, name.isAcceptableValue(d.name.value, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (d.current.present) {
      context.handle(_currentMeta,
          current.isAcceptableValue(d.current.value, _currentMeta));
    }
    if (d.toGet.present) {
      context.handle(
          _toGetMeta, toGet.isAcceptableValue(d.toGet.value, _toGetMeta));
    } else if (isInserting) {
      context.missing(_toGetMeta);
    }
    context.handle(_colorMeta, const VerificationResult.success());
    if (d.imgPath.present) {
      context.handle(_imgPathMeta,
          imgPath.isAcceptableValue(d.imgPath.value, _imgPathMeta));
    } else if (isInserting) {
      context.missing(_imgPathMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {name};
  @override
  Badge map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Badge.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(BadgesCompanion d) {
    final map = <String, Variable>{};
    if (d.name.present) {
      map['name'] = Variable<String, StringType>(d.name.value);
    }
    if (d.current.present) {
      map['current'] = Variable<double, RealType>(d.current.value);
    }
    if (d.toGet.present) {
      map['to_get'] = Variable<double, RealType>(d.toGet.value);
    }
    if (d.color.present) {
      final converter = $BadgesTable.$converter0;
      map['color'] = Variable<int, IntType>(converter.mapToSql(d.color.value));
    }
    if (d.imgPath.present) {
      map['img_path'] = Variable<String, StringType>(d.imgPath.value);
    }
    return map;
  }

  @override
  $BadgesTable createAlias(String alias) {
    return $BadgesTable(_db, alias);
  }

  static ColorConverter $converter0 = ColorConverter();
}

class Stop extends DataClass implements Insertable<Stop> {
  final int id;
  final String name;
  final String descr;
  final List<String> images;
  final String time;
  final String creator;
  final String devision;
  final String artType;
  final String material;
  final String size;
  final String location;
  final String interContext;
  Stop(
      {@required this.id,
      @required this.name,
      @required this.descr,
      @required this.images,
      this.time,
      this.creator,
      this.devision,
      this.artType,
      this.material,
      this.size,
      this.location,
      this.interContext});
  factory Stop.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    return Stop(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
      descr:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}descr']),
      images: $StopsTable.$converter0.mapToDart(
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}images'])),
      time: stringType.mapFromDatabaseResponse(data['${effectivePrefix}time']),
      creator:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}creator']),
      devision: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}devision']),
      artType: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}art_type']),
      material: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}material']),
      size: stringType.mapFromDatabaseResponse(data['${effectivePrefix}size']),
      location: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}location']),
      interContext: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}inter_context']),
    );
  }
  factory Stop.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Stop(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      descr: serializer.fromJson<String>(json['descr']),
      images: serializer.fromJson<List<String>>(json['images']),
      time: serializer.fromJson<String>(json['time']),
      creator: serializer.fromJson<String>(json['creator']),
      devision: serializer.fromJson<String>(json['devision']),
      artType: serializer.fromJson<String>(json['artType']),
      material: serializer.fromJson<String>(json['material']),
      size: serializer.fromJson<String>(json['size']),
      location: serializer.fromJson<String>(json['location']),
      interContext: serializer.fromJson<String>(json['interContext']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'descr': serializer.toJson<String>(descr),
      'images': serializer.toJson<List<String>>(images),
      'time': serializer.toJson<String>(time),
      'creator': serializer.toJson<String>(creator),
      'devision': serializer.toJson<String>(devision),
      'artType': serializer.toJson<String>(artType),
      'material': serializer.toJson<String>(material),
      'size': serializer.toJson<String>(size),
      'location': serializer.toJson<String>(location),
      'interContext': serializer.toJson<String>(interContext),
    };
  }

  @override
  StopsCompanion createCompanion(bool nullToAbsent) {
    return StopsCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      descr:
          descr == null && nullToAbsent ? const Value.absent() : Value(descr),
      images:
          images == null && nullToAbsent ? const Value.absent() : Value(images),
      time: time == null && nullToAbsent ? const Value.absent() : Value(time),
      creator: creator == null && nullToAbsent
          ? const Value.absent()
          : Value(creator),
      devision: devision == null && nullToAbsent
          ? const Value.absent()
          : Value(devision),
      artType: artType == null && nullToAbsent
          ? const Value.absent()
          : Value(artType),
      material: material == null && nullToAbsent
          ? const Value.absent()
          : Value(material),
      size: size == null && nullToAbsent ? const Value.absent() : Value(size),
      location: location == null && nullToAbsent
          ? const Value.absent()
          : Value(location),
      interContext: interContext == null && nullToAbsent
          ? const Value.absent()
          : Value(interContext),
    );
  }

  Stop copyWith(
          {int id,
          String name,
          String descr,
          List<String> images,
          String time,
          String creator,
          String devision,
          String artType,
          String material,
          String size,
          String location,
          String interContext}) =>
      Stop(
        id: id ?? this.id,
        name: name ?? this.name,
        descr: descr ?? this.descr,
        images: images ?? this.images,
        time: time ?? this.time,
        creator: creator ?? this.creator,
        devision: devision ?? this.devision,
        artType: artType ?? this.artType,
        material: material ?? this.material,
        size: size ?? this.size,
        location: location ?? this.location,
        interContext: interContext ?? this.interContext,
      );
  @override
  String toString() {
    return (StringBuffer('Stop(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('descr: $descr, ')
          ..write('images: $images, ')
          ..write('time: $time, ')
          ..write('creator: $creator, ')
          ..write('devision: $devision, ')
          ..write('artType: $artType, ')
          ..write('material: $material, ')
          ..write('size: $size, ')
          ..write('location: $location, ')
          ..write('interContext: $interContext')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          name.hashCode,
          $mrjc(
              descr.hashCode,
              $mrjc(
                  images.hashCode,
                  $mrjc(
                      time.hashCode,
                      $mrjc(
                          creator.hashCode,
                          $mrjc(
                              devision.hashCode,
                              $mrjc(
                                  artType.hashCode,
                                  $mrjc(
                                      material.hashCode,
                                      $mrjc(
                                          size.hashCode,
                                          $mrjc(location.hashCode,
                                              interContext.hashCode))))))))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Stop &&
          other.id == this.id &&
          other.name == this.name &&
          other.descr == this.descr &&
          other.images == this.images &&
          other.time == this.time &&
          other.creator == this.creator &&
          other.devision == this.devision &&
          other.artType == this.artType &&
          other.material == this.material &&
          other.size == this.size &&
          other.location == this.location &&
          other.interContext == this.interContext);
}

class StopsCompanion extends UpdateCompanion<Stop> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> descr;
  final Value<List<String>> images;
  final Value<String> time;
  final Value<String> creator;
  final Value<String> devision;
  final Value<String> artType;
  final Value<String> material;
  final Value<String> size;
  final Value<String> location;
  final Value<String> interContext;
  const StopsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.descr = const Value.absent(),
    this.images = const Value.absent(),
    this.time = const Value.absent(),
    this.creator = const Value.absent(),
    this.devision = const Value.absent(),
    this.artType = const Value.absent(),
    this.material = const Value.absent(),
    this.size = const Value.absent(),
    this.location = const Value.absent(),
    this.interContext = const Value.absent(),
  });
  StopsCompanion.insert({
    this.id = const Value.absent(),
    @required String name,
    @required String descr,
    @required List<String> images,
    this.time = const Value.absent(),
    this.creator = const Value.absent(),
    this.devision = const Value.absent(),
    this.artType = const Value.absent(),
    this.material = const Value.absent(),
    this.size = const Value.absent(),
    this.location = const Value.absent(),
    this.interContext = const Value.absent(),
  })  : name = Value(name),
        descr = Value(descr),
        images = Value(images);
  StopsCompanion copyWith(
      {Value<int> id,
      Value<String> name,
      Value<String> descr,
      Value<List<String>> images,
      Value<String> time,
      Value<String> creator,
      Value<String> devision,
      Value<String> artType,
      Value<String> material,
      Value<String> size,
      Value<String> location,
      Value<String> interContext}) {
    return StopsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      descr: descr ?? this.descr,
      images: images ?? this.images,
      time: time ?? this.time,
      creator: creator ?? this.creator,
      devision: devision ?? this.devision,
      artType: artType ?? this.artType,
      material: material ?? this.material,
      size: size ?? this.size,
      location: location ?? this.location,
      interContext: interContext ?? this.interContext,
    );
  }
}

class $StopsTable extends Stops with TableInfo<$StopsTable, Stop> {
  final GeneratedDatabase _db;
  final String _alias;
  $StopsTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _nameMeta = const VerificationMeta('name');
  GeneratedTextColumn _name;
  @override
  GeneratedTextColumn get name => _name ??= _constructName();
  GeneratedTextColumn _constructName() {
    return GeneratedTextColumn('name', $tableName, false,
        minTextLength: 3, maxTextLength: 20);
  }

  final VerificationMeta _descrMeta = const VerificationMeta('descr');
  GeneratedTextColumn _descr;
  @override
  GeneratedTextColumn get descr => _descr ??= _constructDescr();
  GeneratedTextColumn _constructDescr() {
    return GeneratedTextColumn(
      'descr',
      $tableName,
      false,
    );
  }

  final VerificationMeta _imagesMeta = const VerificationMeta('images');
  GeneratedTextColumn _images;
  @override
  GeneratedTextColumn get images => _images ??= _constructImages();
  GeneratedTextColumn _constructImages() {
    return GeneratedTextColumn(
      'images',
      $tableName,
      false,
    );
  }

  final VerificationMeta _timeMeta = const VerificationMeta('time');
  GeneratedTextColumn _time;
  @override
  GeneratedTextColumn get time => _time ??= _constructTime();
  GeneratedTextColumn _constructTime() {
    return GeneratedTextColumn('time', $tableName, true,
        minTextLength: 1, maxTextLength: 15);
  }

  final VerificationMeta _creatorMeta = const VerificationMeta('creator');
  GeneratedTextColumn _creator;
  @override
  GeneratedTextColumn get creator => _creator ??= _constructCreator();
  GeneratedTextColumn _constructCreator() {
    return GeneratedTextColumn('creator', $tableName, true,
        minTextLength: 1, maxTextLength: 15);
  }

  final VerificationMeta _devisionMeta = const VerificationMeta('devision');
  GeneratedTextColumn _devision;
  @override
  GeneratedTextColumn get devision => _devision ??= _constructDevision();
  GeneratedTextColumn _constructDevision() {
    return GeneratedTextColumn('devision', $tableName, true,
        $customConstraints: 'REFERENCES devisions(name)');
  }

  final VerificationMeta _artTypeMeta = const VerificationMeta('artType');
  GeneratedTextColumn _artType;
  @override
  GeneratedTextColumn get artType => _artType ??= _constructArtType();
  GeneratedTextColumn _constructArtType() {
    return GeneratedTextColumn(
      'art_type',
      $tableName,
      true,
    );
  }

  final VerificationMeta _materialMeta = const VerificationMeta('material');
  GeneratedTextColumn _material;
  @override
  GeneratedTextColumn get material => _material ??= _constructMaterial();
  GeneratedTextColumn _constructMaterial() {
    return GeneratedTextColumn(
      'material',
      $tableName,
      true,
    );
  }

  final VerificationMeta _sizeMeta = const VerificationMeta('size');
  GeneratedTextColumn _size;
  @override
  GeneratedTextColumn get size => _size ??= _constructSize();
  GeneratedTextColumn _constructSize() {
    return GeneratedTextColumn(
      'size',
      $tableName,
      true,
    );
  }

  final VerificationMeta _locationMeta = const VerificationMeta('location');
  GeneratedTextColumn _location;
  @override
  GeneratedTextColumn get location => _location ??= _constructLocation();
  GeneratedTextColumn _constructLocation() {
    return GeneratedTextColumn(
      'location',
      $tableName,
      true,
    );
  }

  final VerificationMeta _interContextMeta =
      const VerificationMeta('interContext');
  GeneratedTextColumn _interContext;
  @override
  GeneratedTextColumn get interContext =>
      _interContext ??= _constructInterContext();
  GeneratedTextColumn _constructInterContext() {
    return GeneratedTextColumn(
      'inter_context',
      $tableName,
      true,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [
        id,
        name,
        descr,
        images,
        time,
        creator,
        devision,
        artType,
        material,
        size,
        location,
        interContext
      ];
  @override
  $StopsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'stops';
  @override
  final String actualTableName = 'stops';
  @override
  VerificationContext validateIntegrity(StopsCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.id.present) {
      context.handle(_idMeta, id.isAcceptableValue(d.id.value, _idMeta));
    }
    if (d.name.present) {
      context.handle(
          _nameMeta, name.isAcceptableValue(d.name.value, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (d.descr.present) {
      context.handle(
          _descrMeta, descr.isAcceptableValue(d.descr.value, _descrMeta));
    } else if (isInserting) {
      context.missing(_descrMeta);
    }
    context.handle(_imagesMeta, const VerificationResult.success());
    if (d.time.present) {
      context.handle(
          _timeMeta, time.isAcceptableValue(d.time.value, _timeMeta));
    }
    if (d.creator.present) {
      context.handle(_creatorMeta,
          creator.isAcceptableValue(d.creator.value, _creatorMeta));
    }
    if (d.devision.present) {
      context.handle(_devisionMeta,
          devision.isAcceptableValue(d.devision.value, _devisionMeta));
    }
    if (d.artType.present) {
      context.handle(_artTypeMeta,
          artType.isAcceptableValue(d.artType.value, _artTypeMeta));
    }
    if (d.material.present) {
      context.handle(_materialMeta,
          material.isAcceptableValue(d.material.value, _materialMeta));
    }
    if (d.size.present) {
      context.handle(
          _sizeMeta, size.isAcceptableValue(d.size.value, _sizeMeta));
    }
    if (d.location.present) {
      context.handle(_locationMeta,
          location.isAcceptableValue(d.location.value, _locationMeta));
    }
    if (d.interContext.present) {
      context.handle(
          _interContextMeta,
          interContext.isAcceptableValue(
              d.interContext.value, _interContextMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Stop map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Stop.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(StopsCompanion d) {
    final map = <String, Variable>{};
    if (d.id.present) {
      map['id'] = Variable<int, IntType>(d.id.value);
    }
    if (d.name.present) {
      map['name'] = Variable<String, StringType>(d.name.value);
    }
    if (d.descr.present) {
      map['descr'] = Variable<String, StringType>(d.descr.value);
    }
    if (d.images.present) {
      final converter = $StopsTable.$converter0;
      map['images'] =
          Variable<String, StringType>(converter.mapToSql(d.images.value));
    }
    if (d.time.present) {
      map['time'] = Variable<String, StringType>(d.time.value);
    }
    if (d.creator.present) {
      map['creator'] = Variable<String, StringType>(d.creator.value);
    }
    if (d.devision.present) {
      map['devision'] = Variable<String, StringType>(d.devision.value);
    }
    if (d.artType.present) {
      map['art_type'] = Variable<String, StringType>(d.artType.value);
    }
    if (d.material.present) {
      map['material'] = Variable<String, StringType>(d.material.value);
    }
    if (d.size.present) {
      map['size'] = Variable<String, StringType>(d.size.value);
    }
    if (d.location.present) {
      map['location'] = Variable<String, StringType>(d.location.value);
    }
    if (d.interContext.present) {
      map['inter_context'] = Variable<String, StringType>(d.interContext.value);
    }
    return map;
  }

  @override
  $StopsTable createAlias(String alias) {
    return $StopsTable(_db, alias);
  }

  static StringListConverter $converter0 = StringListConverter();
}

class Devision extends DataClass implements Insertable<Devision> {
  final String name;
  final dynamic color;
  Devision({@required this.name, @required this.color});
  factory Devision.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    final intType = db.typeSystem.forDartType<int>();
    return Devision(
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
      color: $DevisionsTable.$converter0.mapToDart(
          intType.mapFromDatabaseResponse(data['${effectivePrefix}color'])),
    );
  }
  factory Devision.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Devision(
      name: serializer.fromJson<String>(json['name']),
      color: serializer.fromJson<dynamic>(json['color']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'name': serializer.toJson<String>(name),
      'color': serializer.toJson<dynamic>(color),
    };
  }

  @override
  DevisionsCompanion createCompanion(bool nullToAbsent) {
    return DevisionsCompanion(
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      color:
          color == null && nullToAbsent ? const Value.absent() : Value(color),
    );
  }

  Devision copyWith({String name, dynamic color}) => Devision(
        name: name ?? this.name,
        color: color ?? this.color,
      );
  @override
  String toString() {
    return (StringBuffer('Devision(')
          ..write('name: $name, ')
          ..write('color: $color')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(name.hashCode, color.hashCode));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Devision &&
          other.name == this.name &&
          other.color == this.color);
}

class DevisionsCompanion extends UpdateCompanion<Devision> {
  final Value<String> name;
  final Value<dynamic> color;
  const DevisionsCompanion({
    this.name = const Value.absent(),
    this.color = const Value.absent(),
  });
  DevisionsCompanion.insert({
    @required String name,
    this.color = const Value.absent(),
  }) : name = Value(name);
  DevisionsCompanion copyWith({Value<String> name, Value<dynamic> color}) {
    return DevisionsCompanion(
      name: name ?? this.name,
      color: color ?? this.color,
    );
  }
}

class $DevisionsTable extends Devisions
    with TableInfo<$DevisionsTable, Devision> {
  final GeneratedDatabase _db;
  final String _alias;
  $DevisionsTable(this._db, [this._alias]);
  final VerificationMeta _nameMeta = const VerificationMeta('name');
  GeneratedTextColumn _name;
  @override
  GeneratedTextColumn get name => _name ??= _constructName();
  GeneratedTextColumn _constructName() {
    return GeneratedTextColumn(
      'name',
      $tableName,
      false,
    );
  }

  final VerificationMeta _colorMeta = const VerificationMeta('color');
  GeneratedIntColumn _color;
  @override
  GeneratedIntColumn get color => _color ??= _constructColor();
  GeneratedIntColumn _constructColor() {
    return GeneratedIntColumn('color', $tableName, false,
        defaultValue: const Constant(0xFFFFFFFF));
  }

  @override
  List<GeneratedColumn> get $columns => [name, color];
  @override
  $DevisionsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'devisions';
  @override
  final String actualTableName = 'devisions';
  @override
  VerificationContext validateIntegrity(DevisionsCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.name.present) {
      context.handle(
          _nameMeta, name.isAcceptableValue(d.name.value, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    context.handle(_colorMeta, const VerificationResult.success());
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {name};
  @override
  Devision map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Devision.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(DevisionsCompanion d) {
    final map = <String, Variable>{};
    if (d.name.present) {
      map['name'] = Variable<String, StringType>(d.name.value);
    }
    if (d.color.present) {
      final converter = $DevisionsTable.$converter0;
      map['color'] = Variable<int, IntType>(converter.mapToSql(d.color.value));
    }
    return map;
  }

  @override
  $DevisionsTable createAlias(String alias) {
    return $DevisionsTable(_db, alias);
  }

  static ColorConverter $converter0 = ColorConverter();
}

class Tour extends DataClass implements Insertable<Tour> {
  final int id;
  final String name;
  final String author;
  final double rating;
  final DateTime creationTime;
  final String desc;
  Tour(
      {@required this.id,
      @required this.name,
      @required this.author,
      @required this.rating,
      @required this.creationTime,
      @required this.desc});
  factory Tour.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    final doubleType = db.typeSystem.forDartType<double>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    return Tour(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
      author:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}author']),
      rating:
          doubleType.mapFromDatabaseResponse(data['${effectivePrefix}rating']),
      creationTime: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}creation_time']),
      desc: stringType.mapFromDatabaseResponse(data['${effectivePrefix}desc']),
    );
  }
  factory Tour.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Tour(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      author: serializer.fromJson<String>(json['author']),
      rating: serializer.fromJson<double>(json['rating']),
      creationTime: serializer.fromJson<DateTime>(json['creationTime']),
      desc: serializer.fromJson<String>(json['desc']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'author': serializer.toJson<String>(author),
      'rating': serializer.toJson<double>(rating),
      'creationTime': serializer.toJson<DateTime>(creationTime),
      'desc': serializer.toJson<String>(desc),
    };
  }

  @override
  ToursCompanion createCompanion(bool nullToAbsent) {
    return ToursCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      author:
          author == null && nullToAbsent ? const Value.absent() : Value(author),
      rating:
          rating == null && nullToAbsent ? const Value.absent() : Value(rating),
      creationTime: creationTime == null && nullToAbsent
          ? const Value.absent()
          : Value(creationTime),
      desc: desc == null && nullToAbsent ? const Value.absent() : Value(desc),
    );
  }

  Tour copyWith(
          {int id,
          String name,
          String author,
          double rating,
          DateTime creationTime,
          String desc}) =>
      Tour(
        id: id ?? this.id,
        name: name ?? this.name,
        author: author ?? this.author,
        rating: rating ?? this.rating,
        creationTime: creationTime ?? this.creationTime,
        desc: desc ?? this.desc,
      );
  @override
  String toString() {
    return (StringBuffer('Tour(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('author: $author, ')
          ..write('rating: $rating, ')
          ..write('creationTime: $creationTime, ')
          ..write('desc: $desc')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          name.hashCode,
          $mrjc(
              author.hashCode,
              $mrjc(rating.hashCode,
                  $mrjc(creationTime.hashCode, desc.hashCode))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Tour &&
          other.id == this.id &&
          other.name == this.name &&
          other.author == this.author &&
          other.rating == this.rating &&
          other.creationTime == this.creationTime &&
          other.desc == this.desc);
}

class ToursCompanion extends UpdateCompanion<Tour> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> author;
  final Value<double> rating;
  final Value<DateTime> creationTime;
  final Value<String> desc;
  const ToursCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.author = const Value.absent(),
    this.rating = const Value.absent(),
    this.creationTime = const Value.absent(),
    this.desc = const Value.absent(),
  });
  ToursCompanion.insert({
    this.id = const Value.absent(),
    @required String name,
    @required String author,
    @required double rating,
    @required DateTime creationTime,
    @required String desc,
  })  : name = Value(name),
        author = Value(author),
        rating = Value(rating),
        creationTime = Value(creationTime),
        desc = Value(desc);
  ToursCompanion copyWith(
      {Value<int> id,
      Value<String> name,
      Value<String> author,
      Value<double> rating,
      Value<DateTime> creationTime,
      Value<String> desc}) {
    return ToursCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      author: author ?? this.author,
      rating: rating ?? this.rating,
      creationTime: creationTime ?? this.creationTime,
      desc: desc ?? this.desc,
    );
  }
}

class $ToursTable extends Tours with TableInfo<$ToursTable, Tour> {
  final GeneratedDatabase _db;
  final String _alias;
  $ToursTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _nameMeta = const VerificationMeta('name');
  GeneratedTextColumn _name;
  @override
  GeneratedTextColumn get name => _name ??= _constructName();
  GeneratedTextColumn _constructName() {
    return GeneratedTextColumn('name', $tableName, false,
        minTextLength: 3, maxTextLength: 30);
  }

  final VerificationMeta _authorMeta = const VerificationMeta('author');
  GeneratedTextColumn _author;
  @override
  GeneratedTextColumn get author => _author ??= _constructAuthor();
  GeneratedTextColumn _constructAuthor() {
    return GeneratedTextColumn('author', $tableName, false,
        minTextLength: 3, maxTextLength: 20);
  }

  final VerificationMeta _ratingMeta = const VerificationMeta('rating');
  GeneratedRealColumn _rating;
  @override
  GeneratedRealColumn get rating => _rating ??= _constructRating();
  GeneratedRealColumn _constructRating() {
    return GeneratedRealColumn(
      'rating',
      $tableName,
      false,
    );
  }

  final VerificationMeta _creationTimeMeta =
      const VerificationMeta('creationTime');
  GeneratedDateTimeColumn _creationTime;
  @override
  GeneratedDateTimeColumn get creationTime =>
      _creationTime ??= _constructCreationTime();
  GeneratedDateTimeColumn _constructCreationTime() {
    return GeneratedDateTimeColumn(
      'creation_time',
      $tableName,
      false,
    );
  }

  final VerificationMeta _descMeta = const VerificationMeta('desc');
  GeneratedTextColumn _desc;
  @override
  GeneratedTextColumn get desc => _desc ??= _constructDesc();
  GeneratedTextColumn _constructDesc() {
    return GeneratedTextColumn(
      'desc',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns =>
      [id, name, author, rating, creationTime, desc];
  @override
  $ToursTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'tours';
  @override
  final String actualTableName = 'tours';
  @override
  VerificationContext validateIntegrity(ToursCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.id.present) {
      context.handle(_idMeta, id.isAcceptableValue(d.id.value, _idMeta));
    }
    if (d.name.present) {
      context.handle(
          _nameMeta, name.isAcceptableValue(d.name.value, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (d.author.present) {
      context.handle(
          _authorMeta, author.isAcceptableValue(d.author.value, _authorMeta));
    } else if (isInserting) {
      context.missing(_authorMeta);
    }
    if (d.rating.present) {
      context.handle(
          _ratingMeta, rating.isAcceptableValue(d.rating.value, _ratingMeta));
    } else if (isInserting) {
      context.missing(_ratingMeta);
    }
    if (d.creationTime.present) {
      context.handle(
          _creationTimeMeta,
          creationTime.isAcceptableValue(
              d.creationTime.value, _creationTimeMeta));
    } else if (isInserting) {
      context.missing(_creationTimeMeta);
    }
    if (d.desc.present) {
      context.handle(
          _descMeta, desc.isAcceptableValue(d.desc.value, _descMeta));
    } else if (isInserting) {
      context.missing(_descMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Tour map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Tour.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(ToursCompanion d) {
    final map = <String, Variable>{};
    if (d.id.present) {
      map['id'] = Variable<int, IntType>(d.id.value);
    }
    if (d.name.present) {
      map['name'] = Variable<String, StringType>(d.name.value);
    }
    if (d.author.present) {
      map['author'] = Variable<String, StringType>(d.author.value);
    }
    if (d.rating.present) {
      map['rating'] = Variable<double, RealType>(d.rating.value);
    }
    if (d.creationTime.present) {
      map['creation_time'] =
          Variable<DateTime, DateTimeType>(d.creationTime.value);
    }
    if (d.desc.present) {
      map['desc'] = Variable<String, StringType>(d.desc.value);
    }
    return map;
  }

  @override
  $ToursTable createAlias(String alias) {
    return $ToursTable(_db, alias);
  }
}

class TourStop extends DataClass implements Insertable<TourStop> {
  final int id_tour;
  final int id_stop;
  TourStop({@required this.id_tour, @required this.id_stop});
  factory TourStop.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    return TourStop(
      id_tour:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}id_tour']),
      id_stop:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}id_stop']),
    );
  }
  factory TourStop.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return TourStop(
      id_tour: serializer.fromJson<int>(json['id_tour']),
      id_stop: serializer.fromJson<int>(json['id_stop']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id_tour': serializer.toJson<int>(id_tour),
      'id_stop': serializer.toJson<int>(id_stop),
    };
  }

  @override
  TourStopsCompanion createCompanion(bool nullToAbsent) {
    return TourStopsCompanion(
      id_tour: id_tour == null && nullToAbsent
          ? const Value.absent()
          : Value(id_tour),
      id_stop: id_stop == null && nullToAbsent
          ? const Value.absent()
          : Value(id_stop),
    );
  }

  TourStop copyWith({int id_tour, int id_stop}) => TourStop(
        id_tour: id_tour ?? this.id_tour,
        id_stop: id_stop ?? this.id_stop,
      );
  @override
  String toString() {
    return (StringBuffer('TourStop(')
          ..write('id_tour: $id_tour, ')
          ..write('id_stop: $id_stop')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(id_tour.hashCode, id_stop.hashCode));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is TourStop &&
          other.id_tour == this.id_tour &&
          other.id_stop == this.id_stop);
}

class TourStopsCompanion extends UpdateCompanion<TourStop> {
  final Value<int> id_tour;
  final Value<int> id_stop;
  const TourStopsCompanion({
    this.id_tour = const Value.absent(),
    this.id_stop = const Value.absent(),
  });
  TourStopsCompanion.insert({
    @required int id_tour,
    @required int id_stop,
  })  : id_tour = Value(id_tour),
        id_stop = Value(id_stop);
  TourStopsCompanion copyWith({Value<int> id_tour, Value<int> id_stop}) {
    return TourStopsCompanion(
      id_tour: id_tour ?? this.id_tour,
      id_stop: id_stop ?? this.id_stop,
    );
  }
}

class $TourStopsTable extends TourStops
    with TableInfo<$TourStopsTable, TourStop> {
  final GeneratedDatabase _db;
  final String _alias;
  $TourStopsTable(this._db, [this._alias]);
  final VerificationMeta _id_tourMeta = const VerificationMeta('id_tour');
  GeneratedIntColumn _id_tour;
  @override
  GeneratedIntColumn get id_tour => _id_tour ??= _constructIdTour();
  GeneratedIntColumn _constructIdTour() {
    return GeneratedIntColumn('id_tour', $tableName, false,
        $customConstraints: 'REFERENCES tours(id)');
  }

  final VerificationMeta _id_stopMeta = const VerificationMeta('id_stop');
  GeneratedIntColumn _id_stop;
  @override
  GeneratedIntColumn get id_stop => _id_stop ??= _constructIdStop();
  GeneratedIntColumn _constructIdStop() {
    return GeneratedIntColumn('id_stop', $tableName, false,
        $customConstraints: 'REFERENCES stops(id)');
  }

  @override
  List<GeneratedColumn> get $columns => [id_tour, id_stop];
  @override
  $TourStopsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'tour_stops';
  @override
  final String actualTableName = 'tour_stops';
  @override
  VerificationContext validateIntegrity(TourStopsCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.id_tour.present) {
      context.handle(_id_tourMeta,
          id_tour.isAcceptableValue(d.id_tour.value, _id_tourMeta));
    } else if (isInserting) {
      context.missing(_id_tourMeta);
    }
    if (d.id_stop.present) {
      context.handle(_id_stopMeta,
          id_stop.isAcceptableValue(d.id_stop.value, _id_stopMeta));
    } else if (isInserting) {
      context.missing(_id_stopMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => <GeneratedColumn>{};
  @override
  TourStop map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return TourStop.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(TourStopsCompanion d) {
    final map = <String, Variable>{};
    if (d.id_tour.present) {
      map['id_tour'] = Variable<int, IntType>(d.id_tour.value);
    }
    if (d.id_stop.present) {
      map['id_stop'] = Variable<int, IntType>(d.id_stop.value);
    }
    return map;
  }

  @override
  $TourStopsTable createAlias(String alias) {
    return $TourStopsTable(_db, alias);
  }
}

class Task extends DataClass implements Insertable<Task> {
  final int id;
  final int id_tour;
  final int id_stop;
  final String desc;
  final String task;
  Task(
      {@required this.id,
      @required this.id_tour,
      @required this.id_stop,
      @required this.desc,
      @required this.task});
  factory Task.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    return Task(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      id_tour:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}id_tour']),
      id_stop:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}id_stop']),
      desc: stringType.mapFromDatabaseResponse(data['${effectivePrefix}desc']),
      task: stringType.mapFromDatabaseResponse(data['${effectivePrefix}task']),
    );
  }
  factory Task.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Task(
      id: serializer.fromJson<int>(json['id']),
      id_tour: serializer.fromJson<int>(json['id_tour']),
      id_stop: serializer.fromJson<int>(json['id_stop']),
      desc: serializer.fromJson<String>(json['desc']),
      task: serializer.fromJson<String>(json['task']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'id_tour': serializer.toJson<int>(id_tour),
      'id_stop': serializer.toJson<int>(id_stop),
      'desc': serializer.toJson<String>(desc),
      'task': serializer.toJson<String>(task),
    };
  }

  @override
  TasksCompanion createCompanion(bool nullToAbsent) {
    return TasksCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      id_tour: id_tour == null && nullToAbsent
          ? const Value.absent()
          : Value(id_tour),
      id_stop: id_stop == null && nullToAbsent
          ? const Value.absent()
          : Value(id_stop),
      desc: desc == null && nullToAbsent ? const Value.absent() : Value(desc),
      task: task == null && nullToAbsent ? const Value.absent() : Value(task),
    );
  }

  Task copyWith({int id, int id_tour, int id_stop, String desc, String task}) =>
      Task(
        id: id ?? this.id,
        id_tour: id_tour ?? this.id_tour,
        id_stop: id_stop ?? this.id_stop,
        desc: desc ?? this.desc,
        task: task ?? this.task,
      );
  @override
  String toString() {
    return (StringBuffer('Task(')
          ..write('id: $id, ')
          ..write('id_tour: $id_tour, ')
          ..write('id_stop: $id_stop, ')
          ..write('desc: $desc, ')
          ..write('task: $task')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(id_tour.hashCode,
          $mrjc(id_stop.hashCode, $mrjc(desc.hashCode, task.hashCode)))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Task &&
          other.id == this.id &&
          other.id_tour == this.id_tour &&
          other.id_stop == this.id_stop &&
          other.desc == this.desc &&
          other.task == this.task);
}

class TasksCompanion extends UpdateCompanion<Task> {
  final Value<int> id;
  final Value<int> id_tour;
  final Value<int> id_stop;
  final Value<String> desc;
  final Value<String> task;
  const TasksCompanion({
    this.id = const Value.absent(),
    this.id_tour = const Value.absent(),
    this.id_stop = const Value.absent(),
    this.desc = const Value.absent(),
    this.task = const Value.absent(),
  });
  TasksCompanion.insert({
    this.id = const Value.absent(),
    @required int id_tour,
    @required int id_stop,
    this.desc = const Value.absent(),
    @required String task,
  })  : id_tour = Value(id_tour),
        id_stop = Value(id_stop),
        task = Value(task);
  TasksCompanion copyWith(
      {Value<int> id,
      Value<int> id_tour,
      Value<int> id_stop,
      Value<String> desc,
      Value<String> task}) {
    return TasksCompanion(
      id: id ?? this.id,
      id_tour: id_tour ?? this.id_tour,
      id_stop: id_stop ?? this.id_stop,
      desc: desc ?? this.desc,
      task: task ?? this.task,
    );
  }
}

class $TasksTable extends Tasks with TableInfo<$TasksTable, Task> {
  final GeneratedDatabase _db;
  final String _alias;
  $TasksTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _id_tourMeta = const VerificationMeta('id_tour');
  GeneratedIntColumn _id_tour;
  @override
  GeneratedIntColumn get id_tour => _id_tour ??= _constructIdTour();
  GeneratedIntColumn _constructIdTour() {
    return GeneratedIntColumn('id_tour', $tableName, false,
        $customConstraints: 'REFERENCES tours(id)');
  }

  final VerificationMeta _id_stopMeta = const VerificationMeta('id_stop');
  GeneratedIntColumn _id_stop;
  @override
  GeneratedIntColumn get id_stop => _id_stop ??= _constructIdStop();
  GeneratedIntColumn _constructIdStop() {
    return GeneratedIntColumn('id_stop', $tableName, false,
        $customConstraints: 'REFERENCES stops(id)');
  }

  final VerificationMeta _descMeta = const VerificationMeta('desc');
  GeneratedTextColumn _desc;
  @override
  GeneratedTextColumn get desc => _desc ??= _constructDesc();
  GeneratedTextColumn _constructDesc() {
    return GeneratedTextColumn('desc', $tableName, false,
        defaultValue: const Constant(""));
  }

  final VerificationMeta _taskMeta = const VerificationMeta('task');
  GeneratedTextColumn _task;
  @override
  GeneratedTextColumn get task => _task ??= _constructTask();
  GeneratedTextColumn _constructTask() {
    return GeneratedTextColumn(
      'task',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [id, id_tour, id_stop, desc, task];
  @override
  $TasksTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'tasks';
  @override
  final String actualTableName = 'tasks';
  @override
  VerificationContext validateIntegrity(TasksCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.id.present) {
      context.handle(_idMeta, id.isAcceptableValue(d.id.value, _idMeta));
    }
    if (d.id_tour.present) {
      context.handle(_id_tourMeta,
          id_tour.isAcceptableValue(d.id_tour.value, _id_tourMeta));
    } else if (isInserting) {
      context.missing(_id_tourMeta);
    }
    if (d.id_stop.present) {
      context.handle(_id_stopMeta,
          id_stop.isAcceptableValue(d.id_stop.value, _id_stopMeta));
    } else if (isInserting) {
      context.missing(_id_stopMeta);
    }
    if (d.desc.present) {
      context.handle(
          _descMeta, desc.isAcceptableValue(d.desc.value, _descMeta));
    }
    if (d.task.present) {
      context.handle(
          _taskMeta, task.isAcceptableValue(d.task.value, _taskMeta));
    } else if (isInserting) {
      context.missing(_taskMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id, id_tour, id_stop};
  @override
  Task map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Task.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(TasksCompanion d) {
    final map = <String, Variable>{};
    if (d.id.present) {
      map['id'] = Variable<int, IntType>(d.id.value);
    }
    if (d.id_tour.present) {
      map['id_tour'] = Variable<int, IntType>(d.id_tour.value);
    }
    if (d.id_stop.present) {
      map['id_stop'] = Variable<int, IntType>(d.id_stop.value);
    }
    if (d.desc.present) {
      map['desc'] = Variable<String, StringType>(d.desc.value);
    }
    if (d.task.present) {
      map['task'] = Variable<String, StringType>(d.task.value);
    }
    return map;
  }

  @override
  $TasksTable createAlias(String alias) {
    return $TasksTable(_db, alias);
  }
}

abstract class _$MuseumDatabase extends GeneratedDatabase {
  _$MuseumDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  $UsersTable _users;
  $UsersTable get users => _users ??= $UsersTable(this);
  $BadgesTable _badges;
  $BadgesTable get badges => _badges ??= $BadgesTable(this);
  $StopsTable _stops;
  $StopsTable get stops => _stops ??= $StopsTable(this);
  $DevisionsTable _devisions;
  $DevisionsTable get devisions => _devisions ??= $DevisionsTable(this);
  $ToursTable _tours;
  $ToursTable get tours => _tours ??= $ToursTable(this);
  $TourStopsTable _tourStops;
  $TourStopsTable get tourStops => _tourStops ??= $TourStopsTable(this);
  $TasksTable _tasks;
  $TasksTable get tasks => _tasks ??= $TasksTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [users, badges, stops, devisions, tours, tourStops, tasks];
}
