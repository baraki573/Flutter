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
part 'database.g.dart';

class Users extends Table {
  TextColumn get username =>
      text().withLength(min: MIN_USERNAME, max: MAX_USERNAME)();

  TextColumn get imgPath => text()();

  BoolColumn get onboardEnd => boolean().withDefault(const Constant(false))();

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

  TextColumn get time => text().withLength(min: 1, max: 15).nullable()();

  TextColumn get creator => text().withLength(min: 1, max: 15).nullable()();

  TextColumn get devision =>
      text().customConstraint("REFERENCES devisions(name)").nullable()();

  TextColumn get artType => text().nullable()();

  TextColumn get material => text().nullable()();

  TextColumn get size => text().nullable()();

  TextColumn get location => text().nullable()();

  TextColumn get interContext => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

class TourStops extends Table {
  IntColumn get id_tour => integer().customConstraint("REFERENCES tours(id)")();

  IntColumn get id_stop => integer().customConstraint("REFERENCES stops(id)")();
}

class TourWithStops {
  final Tour tour;
  final List<Stop> stops;

  TourWithStops(this.tour, this.stops);
}

class Devisions extends Table {
  TextColumn get name => text()();

  IntColumn get color =>
      integer().withDefault(const Constant(0xFFFFFFFF)).map(ColorConverter())();

  @override
  Set<Column> get primaryKey => {name};
}

class Tasks extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get id_tour => integer().customConstraint("REFERENCES tours(id)")();

  IntColumn get id_stop => integer().customConstraint("REFERENCES stops(id)")();

  TextColumn get desc => text().withDefault(const Constant(""))();

  TextColumn get task => text()();

  @override
  Set<Column> get primaryKey => {id, id_tour, id_stop};
}

class ColorConverter extends TypeConverter<Color, int> {
  const ColorConverter();

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
    return value.join(";");
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
@UseMoor(tables: [Users, Badges, Stops, Devisions, Tours, TourStops, Tasks])
class MuseumDatabase extends _$MuseumDatabase {
  static MuseumDatabase _db;

  static MuseumDatabase get() {
    _db ??= MuseumDatabase();
    return _db;
  }

  MuseumDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 4;

  Stream<User> getUser() => select(users).watchSingle();

  Future setUser(UsersCompanion uc) {
    customStatement("DELETE FROM users");
    return into(users).insert(uc);
  }

  Future updateUsername(String name) {
    return update(users).write(UsersCompanion(username: Value(name)));
  }

  Future updateOnboard(bool b){
    return update(users).write(UsersCompanion(onboardEnd: Value(b)));
  }

  Future reset(UsersCompanion uc) {
    return delete(users).delete(uc);
  }

  void clear() {
    customStatement("DELETE FROM users");
    //customStatement("DELETE FROM tourStops");
    customStatement("DELETE FROM stops");
    customStatement("DELETE FROM tours");
    customStatement("DELETE FROM badges");
    customStatement("DELETE FROM devisions");
  }

  Stream<List<Badge>> getBadges() => select(badges).watch();

  Future<int> addBadge(BadgesCompanion bc) {
    return into(badges).insert(bc);
  }

  Stream<List<Devision>> getDevisions() => select(devisions).watch();

  Stream<List<Tour>> getTours() => select(tours).watch();

  Stream<List<Stop>> getStops() => select(stops).watch();

  Stream<List<Task>> getTasksId(int id_tour, int id_stop) {
    final contentQuery = select(tasks)
        //.join([innerJoin(stops, stops.id.equalsExp(tourStops.id_stop))])
      ..where((t) => t.id_tour.equals(id_tour))
      ..where((t) => t.id_stop.equals(id_stop));

    return contentQuery.watch();
  }

  Future<int> addTask(TasksCompanion tc) {
    return into(tasks).insert(tc);
  }

  Stream<List<Stop>> getStopsId(int id) {
    //final tourQuery = select(tours)..where((t) => t.id.equals(id));

    final contentQuery = select(tourStops)
        .join([innerJoin(stops, stops.id.equalsExp(tourStops.id_stop))])
          ..where(tourStops.id_tour.equals(id));

    //final tourStream = tourQuery.watchSingle();
    final contentStream = contentQuery
        .watch()
        .map((rows) => rows.map((row) => row.readTable(stops)).toList());

    return contentStream;

    /*var t = (select(tours)..where((t) => t.name.equals(name)));
    var t2 = t.join([
      leftOuterJoin(tourStops, tours.id.equalsExp(tourStops.id_tour)),
      leftOuterJoin(stops, tourStops.id_stop.equalsExp(stops.id))
    ]);
    return t2.watch().map((rows) => rows.map((row) => row.readTable(stops)));
    //return (select(tours)..where((t) => t.name.equals(name))).join(
    //  [leftOuterJoin(stops, tours.id.equalsExp(stops.tour_id))]);
    //customStatement(
    //  "SELECT * FROM tours t, stops s, tourStops ts WHERE t.name=? AND t.id=ts.id_tour AND s.id=ts.id_stop");
  */
  }

  Future<void> writeTourStops(TourWithStops entry) {
    return transaction(() async {
      final tour = entry.tour.createCompanion(true);

      var id = await into(tours).insert(tour, orReplace: true);

      await //INSERT STOPSjolk

          await (delete(tourStops)..where((e) => e.id_tour.equals(id))).go();

      await batch((batch) {
        batch.insertAll(
            tourStops,
            entry.stops
                .map((s) => TourStop(id_tour: id, id_stop: s.id))
                .toList(),
            mode: InsertMode.insertOrReplace);
      });
    });
  }

  Future demoUser() {
    customStatement("DELETE FROM users");
    return into(users).insert(UsersCompanion.insert(
        username: "Maria123_XD", imgPath: "assets/images/profile_test.png"));
  }

  Future<void> demoDevisions() async {
    //customStatement("DELETE FROM devisions");
    await batch((batch) {
      batch.insertAll(
          devisions,
          [
            DevisionsCompanion.insert(
                name: "Zoologisch", color: Value(Color(0xFFFF0000))),
            DevisionsCompanion.insert(
                name: "Skulpturen", color: Value(Color(0xFF0000FF))),
            DevisionsCompanion.insert(
                name: "Bilder", color: Value(Color(0xFFFFEB3B))),
            DevisionsCompanion.insert(
                name: "Bonus", color: Value(Color(0xFF673AB7))),
          ],
          mode: InsertMode.insertOrReplace);
    });
  }

  Future<void> demoStops() async {
    //customStatement("DELETE FROM stops");
    await batch((batch) {
      batch.insertAll(
          stops,
          List.generate(4, (i) {
                String s = (i % 3 == 0 ? "" : "2");
                return StopsCompanion.insert(
                  name: "Zoologisch $i",
                  devision: Value("Zoologisch"),
                  descr: "Description foo",
                  images: [
                    'assets/images/profile_test' + s + '.png',
                    'assets/images/profile_test.png'
                  ],
                  creator: Value("Me"),
                  material: Value("Holz"),
                  size: Value("32m x 45m"),
                  interContext: Value("Wurde von Napoleon besucht"),
                  location: Value("Zuhause"),
                );
              }) +
              List.generate(2, (i) {
                String s = (i % 2 == 0 ? "" : "2");
                return StopsCompanion.insert(
                  name: "Skulpturen $i",
                  descr: "More descr",
                  images: ['assets/images/profile_test' + s + '.png'],
                  devision: Value("Skulpturen"),
                  creator: Value("DaVinci"),
                );
              }) +
              List.generate(10, (i) {
                String s = (i % 3 == 0 ? "" : "2");
                return StopsCompanion.insert(
                  name: "Bilder $i",
                  devision: Value("Bilder"),
                  descr: "Interessante Details",
                  images: [
                    'assets/images/profile_test' + s + '.png',
                    'assets/images/profile_test' + s + '.png',
                    'assets/images/profile_test2.png'
                  ],
                  creator: Value("Artist"),
                );
              }) +
              List.generate(1, (i) {
                return StopsCompanion.insert(
                    name: "Bonus $i",
                    descr:
                        "Mit dieser Tour werden Sie interessante neue Fakten kennenlernen. Sie werden das Museum so erkunden, wie es bis heute noch kein Mensch getan hat. Nebenbei werden Sie spannende Aufgaben lösen.",
                    images: ['assets/images/haupthalle_hlm_blue.png'],
                    devision: Value("Bonus"),
                    creator: Value("VanGogh"));
              }),
          mode: InsertMode.insertOrReplace);
    });
  }

  Future<void> demoBadges() async {
    //customStatement("DELETE FROM badges");
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
        mode: InsertMode.insertOrReplace,
      );
    });
  }

  Future<void> demoTourStops() async {
    //customStatement("DELETE FROM tourStops");
    await batch((batch) {
      batch.insertAll(
        tourStops,
        List.generate(
              8,
              (i) => TourStopsCompanion.insert(id_tour: 1, id_stop: i + 1),
            ) +
            List.generate(
              5,
              (i) => TourStopsCompanion.insert(id_tour: 2, id_stop: i + 2),
            ) +
            List.generate(
              3,
              (i) => TourStopsCompanion.insert(id_tour: 3, id_stop: i + 3),
            ),
        mode: InsertMode.insertOrReplace,
      );
    });
  }

  Future<void> demoTours() async {
    //customStatement("DELETE FROM tours");
    await batch((batch) {
      batch.insertAll(
        tours,
        [
          ToursCompanion.insert(
              name: "Test Tour",
              author: "Maria123_XD",
              rating: 4.6,
              creationTime: DateTime.now(),
              desc: "Diese Beschreibung ist zum Glück nicht so lang."),
          ToursCompanion.insert(
              name: "Meine erste Tour",
              author: "1412",
              rating: 1.2,
              creationTime: DateTime.parse("2020-02-05"),
              desc:
                  "Einen Roman schreiben die User hier bestimmt nicht hin. Und wenn doch, muss ich mir dafür etwas einfallen lassen."),
          ToursCompanion.insert(
              name: "Zoologische Tour mit int",
              author: "MyBestUser",
              rating: 2.6,
              creationTime: DateTime.parse("1983-05-14"),
              desc: "Diese Tour ist sehr lehrreich."),
        ],
        mode: InsertMode.insertOrReplace,
      );
    });
  }
}

void demo() {
  var db = MuseumDatabase.get();
  //db.clear();
  db.demoUser();
  db.demoDevisions().catchError((_) => print("devisionError"));
  db.demoStops().catchError((_) => print("stopError"));
  db.demoBadges().catchError((_) => print("badgeError"));
  //db.demoTours().catchError((_) => print("tourError"));
  //db.demoTourStops().catchError((_) => print("tourStopsError"));
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
