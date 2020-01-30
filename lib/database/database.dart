import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:moor/moor.dart';

//import 'package:flutter/cupertino.dart';
import 'package:moor_ffi/moor_ffi.dart';
import 'package:museum_app/constants.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:flutter/material.dart' as m;

// assuming that your file is called filename.dart. This will give an error at first,
// but it's needed for moor to know about the generated code
part 'modelling.g.dart';

/*// this will generate a table called "todos" for us. The rows of that table will
// be represented by a class called "Todo".
class Todos extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text().withLength(min: 6, max: 32)();
  TextColumn get content => text().named('body')();
  IntColumn get category => integer().nullable()();
}

// This will make moor generate a class called "Category" to represent a row in this table.
// By default, "Categorie" would have been used because it only strips away the trailing "s"
// in the table name.
@DataClassName("Category")
class Categories extends Table {

  IntColumn get id => integer().autoIncrement()();
  TextColumn get description => text()();
}*/

class Users extends Table {
  TextColumn get username =>
      text().withLength(min: MIN_USERNAME, max: MAX_USERNAME)();

  TextColumn get imgPath => text()();

  @override
  Set<Column> get primaryKey => {username};
}

class Badges extends Table {
  TextColumn get name => text().withLength(min: 3, max: 15)();

  RealColumn get current => real().withDefault(const Constant(0.0))();

  RealColumn get toGet => real()();

  IntColumn get color =>
      integer().withDefault(const Constant(0)).map(ColorConverter())();

  TextColumn get imgPath => text()();

  @override
  Set<Column> get primaryKey => {name};
}

class Tours extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get name => text().withLength(min: 3, max: 30)();

  TextColumn get author => text().withLength(min: 3, max: 20)();

  RealColumn get rating => real()();

  DateTimeColumn get creationTime => dateTime()();

  TextColumn get desc => text()();

  @override
  Set<Column> get primaryKey => {id};
}

class Stops extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get name => text().withLength(min: 3, max: 20)();

  TextColumn get descr => text()();

  //IMAGES
  TextColumn get images => text().map(StringListConverter())();

  @override
  Set<Column> get primaryKey => {id};
}

class Exhibits extends Stops {
  TextColumn get time => text().withLength(min: 1, max: 15).nullable()();

  TextColumn get creator => text().withLength(min: 1, max: 15).nullable()();

  TextColumn get devision => text().customConstraint("REFERENCES devisions(name)")();
}

class Devisions extends Table {
  TextColumn get name => text()();

  IntColumn get color => integer().map(ColorConverter())();

  @override
  Set<Column> get primaryKey => {name};
}

class ColorConverter extends TypeConverter<Color, int> {
  @override
  Color mapToDart(int fromDb) {
    return Color(fromDb);
  }

  @override
  int mapToSql(Color value) {
    return value.value;
  }
}

class StringListConverter extends TypeConverter<List<String>, String> {
  @override
  List<String> mapToDart(String fromDb) {
    return fromDb.split(";");
  }

  @override
  String mapToSql(List<String> value) {
    return value.fold("", (p, e) => p + e + ";");
  }
}

LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return VmDatabase(file);
  });
}

// this annotation tells moor to prepare a database class that uses both of the
// tables we just defined. We'll see how to use that database class in a moment.
@UseMoor(tables: [Users, Badges, Stops, Exhibits, Devisions, Tours])
class MuseumDatabase extends _$MuseumDatabase {
  static MuseumDatabase _db;

  static MuseumDatabase get() {
    _db ??= MuseumDatabase();
    return _db;
  }

  MuseumDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 2;

  Stream<List<User>> getUser() => select(users).watch();

  Future setUser(UsersCompanion uc) {
    customStatement("DELETE FROM users");
    return into(users).insert(uc);
  }

  Future updateUsername(String name) {
    return update(users).write(UsersCompanion(username: Value(name)));
  }

  Future reset(UsersCompanion uc) {
    return delete(users).delete(uc);
  }

  void clear() {
    customStatement("DELETE FROM users");
  }

  Stream<List<Badge>> getBadges() => select(badges).watch();

  Future<int> addBadge(BadgesCompanion bc) {
    return into(badges).insert(bc);
  }

  Stream<List<Devision>> getDevisions() => select(devisions).watch();

  Stream<List<Exhibit>> getExhibits() => select(exhibits).watch();

  Future demoUser() {
    customStatement("DELETE FROM users");
    return into(users).insert(UsersCompanion.insert(
        username: "Maria123_XD", imgPath: "assets/images/profile_test.png"));
  }

  Future<void> demoDevisions() async {
    customStatement("DELETE FROM devisions");
    await batch((batch) {
      batch.insertAll(
          devisions,
          [
            DevisionsCompanion.insert(
                name: "Zoologisch", color: Color(0xFFFF0000)),
            DevisionsCompanion.insert(
                name: "Skulpturen", color: Color(0xFF0000FF)),
            DevisionsCompanion.insert(name: "Bilder", color: Color(0xFFFFEB3B)),
            DevisionsCompanion.insert(name: "Bonus", color: Color(0xFF673AB7)),
          ],
          mode: InsertMode.insertOrReplace);
    });
  }

  Future<void> demoExhibits() async {
    customStatement("DELETE FROM exhibits");
    await batch((batch) {
      batch.insertAll(
          exhibits,
          List.generate(4, (i) {
                String s = (i % 3 == 0 ? "" : "2");
                return ExhibitsCompanion.insert(
                  name: "Zoologisch $i",
                  devision: "Zoologisch",
                  descr: "Description foo",
                  images: ['assets/images/profile_test' + s + '.png'],
                  creator: Value("Me"),
                );
              }) +
              List.generate(2, (i) {
                String s = (i % 2 == 0 ? "" : "2");
                return ExhibitsCompanion.insert(
                  name: "Skulpturen $i",
                  descr: "More descr",
                  images: ['assets/images/profile_test' + s + '.png'],
                  devision: "Skulpturen",
                  creator: Value("DaVinci"),
                );
              }) +
              List.generate(10, (i) {
                String s = (i % 3 == 0 ? "" : "2");
                return ExhibitsCompanion.insert(
                  name: "Bilder $i",
                  devision: "Bilder",
                  descr: "Interessante Details",
                  images: ['assets/images/profile_test' + s + '.png'],
                  creator: Value("Artist"),
                );
              }) +
              List.generate(1, (i) {
                return ExhibitsCompanion.insert(
                    name: "Bonus $i",
                    descr: "To be written",
                    images: ['assets/images/haupthalle_hlm_blue.png'],
                    devision: "Bonus",
                    creator: Value("VanGogh"));
              }),
          mode: InsertMode.insertOrReplace);
    });
  }

  Future<void> demoBadges() async {
    customStatement("DELETE FROM badges");
    await batch((batch) {
      batch.insertAll(
        badges,
        List.generate(
          16,
          (i) => BadgesCompanion.insert(
            name: "Badge $i",
            toGet: 16.0,
            color: Value(m.Colors.primaries[i]),
            imgPath: "assets/images/profile_test.png",
            current: Value(i.roundToDouble()),
          ),
        ),
      );
    });
  }
}

void demo() {
  var db = MuseumDatabase.get();
  db.demoUser();
  db.demoExhibits().catchError((_) {});
  db.demoDevisions().catchError((_) {});
  db.demoBadges().catchError((_) {});
}

void init() {
  var u = UsersCompanion(
      username: Value("ABC"), imgPath: Value("assets/images/profile_test.png"));
  MuseumDatabase.get().setUser(u);
}

void reset() {
  MuseumDatabase.get().clear();
  //MuseumDatabase.get().reset(UsersCompanion(username: Value("TEST"), imgPath: Value("testPath")));
}
