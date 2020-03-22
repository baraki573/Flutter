import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart' as m;
import 'package:moor/moor.dart';
import 'package:moor_ffi/moor_ffi.dart';
import 'package:museum_app/constants.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:rxdart/rxdart.dart';

import 'modelling.dart';

part 'database.g.dart';

String customName = "Individuell";

class Users extends Table {
  TextColumn get username =>
      text().withLength(min: MIN_USERNAME, max: MAX_USERNAME)();

  TextColumn get imgPath => text().named("imgPath")();

  BoolColumn get onboardEnd => boolean().withDefault(const Constant(false)).named("onboardEnd")();

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

  TextColumn get name =>
      text().withLength(min: MIN_TOURNAME, max: MAX_TOURNAME)();

  TextColumn get author =>
      text().withLength(min: MIN_USERNAME, max: MAX_USERNAME)();

  //TODO convert to difficulty
  RealColumn get difficulty => real()();

  DateTimeColumn get creationTime => dateTime()();

  TextColumn get desc => text()();

  @override
  Set<Column> get primaryKey => {id};
}

class Stops extends Table {
  IntColumn get id => integer().autoIncrement()();

  //IMAGES
  TextColumn get images => text().map(StringListConverter())();

  TextColumn get name => text().withLength(min: 3, max: 20)();

  TextColumn get descr => text()();

  //TODO add Map<String, String>-Converter

  TextColumn get invId => text().nullable()();

  TextColumn get time => text().withLength(min: 1, max: 15).nullable()();

  TextColumn get creator => text().withLength(min: 1, max: 15).nullable()();

  TextColumn get division =>
      text().customConstraint("REFERENCES divisions(name)").nullable()();

  TextColumn get artType => text().nullable()();

  TextColumn get material => text().nullable()();

  TextColumn get size => text().nullable()();

  TextColumn get location => text().nullable()();

  TextColumn get interContext => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

class TourStops extends Table {
  IntColumn get id => integer()();

  IntColumn get id_tour => integer().customConstraint("REFERENCES tours(id)")();

  IntColumn get id_stop => integer().customConstraint("REFERENCES stops(id)")();
}

// TODO typo: change to "Divisions"
class Divisions extends Table {
  TextColumn get name => text()();

  IntColumn get color =>
      integer().withDefault(const Constant(0xFFFFFFFF)).map(ColorConverter())();

  @override
  Set<Column> get primaryKey => {name};
}

class Extras extends Table {
  // the extra's position on a certain page
  IntColumn get pos_extra => integer()();

  // the stop's position in the tour
  IntColumn get pos_stop => integer()();

  IntColumn get id_tour => integer().customConstraint("REFERENCES tours(id)")();

  IntColumn get id_stop => integer().customConstraint("REFERENCES stops(id)")();

  TextColumn get textInfo => text()();

  IntColumn get type => integer().map(TaskTypeConverter()).nullable()();

  TextColumn get answerOpt => text().map(StringListConverter()).nullable()();

  TextColumn get answerCor => text().map(IntListConverter()).nullable()();

  @override
  Set<Column> get primaryKey => {pos_stop, pos_extra, id_tour, id_stop};
}

class StopFeatures extends Table {
  IntColumn get id => integer().customConstraint("REFERENCES tourStops(id)")();

  IntColumn get id_tour => integer().customConstraint("REFERENCES tours(id)")();

  IntColumn get id_stop => integer().customConstraint("REFERENCES stops(id)")();

  BoolColumn get showImages => boolean().withDefault(const Constant(true))();

  BoolColumn get showText => boolean().withDefault(const Constant(true))();

  BoolColumn get showDetails => boolean().withDefault(const Constant(true))();

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
  const StringListConverter();

  @override
  List<String> mapToDart(String fromDb) {
    if (fromDb != null && fromDb.isEmpty) return List<String>();
    return fromDb?.split(";");
  }

  @override
  String mapToSql(List<String> value) {
    return value?.join(";");
  }
}

class IntListConverter extends TypeConverter<List<int>, String> {
  const IntListConverter();

  @override
  List<int> mapToDart(String fromDb) {
    if (fromDb != null && fromDb.isEmpty) return List<int>();
    if (fromDb == null) return null;
    return fromDb.split(";").map((s) {
      var v = int.tryParse(s);
      return v ?? 0;
    }).toList();
  }

  @override
  String mapToSql(List<int> value) {
    return value?.join(";");
  }
}

class TaskTypeConverter extends TypeConverter<ExtraType, int> {
  const TaskTypeConverter();

  @override
  ExtraType mapToDart(int fromDb) {
    if (fromDb == null) return null;
    var values = ExtraType.values;
    if (0 <= fromDb && fromDb < values.length) return values[fromDb];
    print("NOT FOUND");
    return ExtraType.TEXT;
  }

  @override
  int mapToSql(ExtraType value) {
    if (value == null) return null;
    return value.index;
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
@UseMoor(tables: [
  Users,
  Badges,
  Stops,
  Divisions,
  Tours,
  TourStops,
  Extras,
  StopFeatures
])
class MuseumDatabase extends _$MuseumDatabase {
  static MuseumDatabase _db;
  static int customID = 0;

  factory MuseumDatabase() {
    _db ??= MuseumDatabase.create();
    return _db;
  }

  MuseumDatabase.create() : super(_openConnection());

  @override
  int get schemaVersion => 5;

  Stream<User> watchUser() => select(users).watchSingle();

  Future<User> getUser() => select(users).getSingle();

  Future setUser(UsersCompanion uc) {
    customStatement("DELETE FROM users");
    return into(users).insert(uc);
  }

  Future updateUsername(String name) async {
    await initUser();
    String oldName = await select(users).map((u) => u.username).getSingle();
    await batch((batch) {
      batch.update(users, UsersCompanion(username: Value(name)));
      batch.update(tours, ToursCompanion(author: Value(name)), where: ($ToursTable t) => t.author.equals(oldName));
    });
  }

  Future updateImage(String imgPath) async {
    await initUser();
    return update(users).write(UsersCompanion(imgPath: Value(imgPath)));
  }

  Future updateOnboard(bool b) async {
    await initUser();
    return update(users).write(UsersCompanion(onboardEnd: Value(b)));
  }

  Future<bool> onboardEnd() {
    return select(users).map((u) => u.onboardEnd).getSingle();
  }

  Future initUser() {
    customStatement("INSERT INTO users (username, imgPath, onboardEnd) SELECT '', 'assets/images/profile_test.png', false WHERE NOT EXISTS (SELECT * FROM users)");
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
    customStatement("DELETE FROM divisions");
  }

  Stream<StopFeature> getStopFeature(int num, int stop_id, int tour_id) {
    //TODO PART1
    /*if (stop_id == customID)
      return Stream.value(StopFeature(
          id_tour: tour_id,
          id_stop: stop_id,
          showImages: false,
          showText: true,
          showDetails: false));*/
    final query = select(stopFeatures)
      ..where((f) => f.id.equals(num))
      ..where((f) => f.id_stop.equals(stop_id))
      ..where((f) => f.id_tour.equals(tour_id));

    return query.watchSingle();
  }

  Future<void> updateStopFeatures(int stop_id, int tour_id,
      {images, text, details}) {
    if (stop_id != customID)
      update(stopFeatures).replace(
        StopFeature(
          id_stop: stop_id,
          id_tour: tour_id,
          showImages: images,
          showText: text,
          showDetails: details,
          id: null,
        ).createCompanion(true),
      );
  }

  Future addExtra(ActualExtra e, int pos_stop, int pos_extra, int tour_id, int stop_id) {
    if (e.task != null) {
      var list = List<int>();

      if (e.type == ExtraType.TASK_MULTI)
        for (int i = 0; i < e.task.entries.length; i++)
          if (e.task.entries[i].valB == true) list.add(i);

      if (e.type == ExtraType.TASK_SINGLE) list.add(e.task.selected);

      return into(extras).insert(
          ExtrasCompanion.insert(
              pos_extra: pos_extra,
              pos_stop: pos_stop,
              id_tour: tour_id,
              id_stop: stop_id,
              textInfo: e.textInfo.text,
              type: Value(e.type),
              answerOpt: Value(
                  e.task.entries.map((e) => e.valA.text as String).toList()),
              answerCor: Value(list)),
          mode: InsertMode.insertOrReplace);
    }
    return into(extras).insert(
        ExtrasCompanion.insert(
            pos_extra: pos_extra,
            pos_stop: pos_stop,
            id_tour: tour_id,
            id_stop: stop_id,
            type: Value(e.type),
            textInfo: e.textInfo.text),
        mode: InsertMode.insertOrReplace);
  }

  Stream<ActualStop> getActualStop(int pos_stop, int tour_id, int stop_id) {
    final stop = select(stops)
      ..where((s) => s.id.equals(stop_id));

    final feature = getStopFeature(pos_stop, stop_id, tour_id);

    return CombineLatestStream.combine3(
        stop.watchSingle(),
        feature,
        getExtras(pos_stop, tour_id, stop_id),
        (Stop s, StopFeature f, List<ActualExtra> l) => ActualStop(s, f, l));
  }

  Stream<List<ActualExtra>> getExtras(int pos_stop, int tour_id, int stop_id) {
    final query = select(extras)
      ..where((t) => t.pos_stop.equals(pos_stop))
      //..where((t) => t.pos_extra.equals(pos_extra))
      ..where((t) => t.id_tour.equals(tour_id))
      ..where((t) => t.id_stop.equals(stop_id));

    return query.watch().map((rows) => rows
        .map((e) => ActualExtra(e.type,
            text: e.textInfo, sel: e.answerOpt, correct: e.answerCor?.toSet()))
        .toList());
  }

  Stream<Tour> getDBTour(TourWithStops t) {
    var query = select(tours)
      ..where((tour) => tour.name.equals(t.name.text))
      ..where((tour) => tour.author.equals(t.author))
      ..where((tour) => tour.creationTime.equals(t.creationTime));

    return query.watchSingle();
  }

  Future<void> removeTour(int id) async {
    await batch((batch) {
      batch.deleteWhere(tours, (t) => t.id.equals(id));
      batch.deleteWhere(tourStops, (t) => t.id_tour.equals(id));
      batch.deleteWhere(extras, (t) => t.id_tour.equals(id));
      batch.deleteWhere(stopFeatures, (t) => t.id_tour.equals(id));
    });
  }

  Stream<List<Badge>> getBadges() => select(badges).watch();

  Future<int> addBadge(BadgesCompanion bc) {
    return into(badges).insert(bc);
  }

  Stream<List<Division>> getDivisions() => select(divisions).watch();

  Stream<List<Tour>> getTours() => select(tours).watch();

  Stream<List<TourWithStops>> getTourStops() {
    final tour_ids = select(tours, distinct: true).map((t) => t.id).watch();

    var t = tour_ids.map((list) => list.map((id) => getTour(id)).toList());

    return SwitchLatestStream(t.map((list) => CombineLatestStream.list(list)));
  }

  Stream<TourWithStops> getTour(int tour_id) {
    final tour = select(tours)..where((t) => t.id.equals(tour_id));

    final stop_ids = (select(tourStops, distinct: true)
          ..where((ts) => ts.id_tour.equals(tour_id)))
        .map((t) => Tuple(t.id, t.id_stop))
        .watch();

    var l2 = stop_ids.map((list) => list
        .map((stop_id) => getActualStop(stop_id.valA, tour_id, stop_id.valB))
        .toList());

    var res = CombineLatestStream.combine2(tour.watchSingle(), l2,
        (Tour t, List<Stream<ActualStop>> a) {
      Stream<List<ActualStop>> s = CombineLatestStream.list(a);
      return s.map((list) => TourWithStops(t, list.sublist(0)));
    });

    return SwitchLatestStream(res);
  }

  Stream<List<Stop>> watchStops() => select(stops).watch();

  Future<List<Stop>> getStops() => select(stops).get();

  Stream<List<Stop>> stopSearch(String text) {
    if (text.isEmpty) return Stream.value(List<Stop>());

    List<String> input = text.split(RegExp(",|;|&"));

    var query = select(stops)..where((s) => s.name.equals(customName).not());

    for (var part in input) {
      part = part.trim();
      // search for division
      if (part.startsWith(RegExp("div:?"))) {
        part = part.replaceAll(RegExp("div:?"), "").trim();
        query.where((s) => s.division.like(part + "%"));
      }
      // search for object's creator
      else if (part.startsWith(RegExp("cre:?"))) {
        part = part.replaceAll(RegExp("cre:?"), "").trim();
        query.where((s) => s.creator.like(part + "%"));
      }
      // search for object's art type
      else if (part.startsWith(RegExp("art:?"))) {
        part = part.replaceAll(RegExp("art:?"), "").trim();
        query.where((s) => s.artType.like(part + "%"));
      }
      // search for object's material
      else if (part.startsWith(RegExp("mat:?"))) {
        part = part.replaceAll(RegExp("mat:?"), "").trim();
        query.where((s) => s.material.like(part + "%"));
      }
      // search for object's inv number
      else if (part.startsWith(RegExp("inv:?"))) {
        part = part.replaceAll(RegExp("inv:?"), "").trim();
        query.where((s) => s.invId.like(part + "%"));
      }
      // search in the object's name and division
      else
        query.where((s) => s.name.like("%" + part + "%") | s.division.like("%" + part + "%"));
    }

    return query.watch();
    /*if (text.isEmpty)
      return Stream.value(List<Stop>());
    return query.map((list) => list
        .where((s) => s.name.toLowerCase().startsWith(text.toLowerCase()))
        .toList());*/
  }

  Stream<List<Extra>> getExtrasId(int id_tour, int id_stop) {
    final contentQuery = select(extras)
      //.join([innerJoin(stops, stops.id.equalsExp(tourStops.id_stop))])
      ..where((e) => e.id_tour.equals(id_tour))
      ..where((e) => e.id_stop.equals(id_stop));

    return contentQuery.watch();
  }

  Stream<List<Stop>> getStopsId(int id) {
    final contentQuery = select(tourStops)
        .join([innerJoin(stops, stops.id.equalsExp(tourStops.id_stop))])
          ..where(tourStops.id_tour.equals(id));

    //final tourStream = tourQuery.watchSingle();
    final contentStream = contentQuery
        .watch()
        .map((rows) => rows.map((row) => row.readTable(stops)).toList());

    return contentStream;
  }

  Stream<ActualStop> getCustomStop() {
    final query = select(stops)..where((stop) => stop.name.equals(customName));
    return query.watchSingle().map((stop) => ActualStop(
        stop,
        StopFeature(
            id: null,
            id_tour: null,
            id_stop: stop.id,
            showImages: false,
            showText: true,
            showDetails: false),
        <ActualExtra>[]));
  }

  Future<void> writeTourStops(TourWithStops entry) {
    return transaction(() async {
      final tour = entry.createToursCompanion(true);

      var id = await into(tours).insert(tour, orReplace: true);

      await (delete(tourStops)..where((e) => e.id_tour.equals(id))).go();

      await batch((batch) {
        batch.insertAll(
            tourStops,
            entry.stops
                .where((s) => s.stop != null)
                .map((s) => TourStopsCompanion.insert(
                    id: entry.stops.indexOf(s),
                    id_tour: id,
                    id_stop: s.stop.id))
                .toList(),
            mode: InsertMode.insertOrReplace);
        batch.insertAll(
            stopFeatures,
            entry.stops
                .where((s) => s.features != null)
                .map((s) => s.features
                    .copyWith(id: entry.stops.indexOf(s), id_tour: id)
                    .createCompanion(true))
                .toList(),
            mode: InsertMode.insertOrReplace);
      });

      for (var stop in entry.stops)
        for (var extra in stop.extras)
          addExtra(extra, entry.stops.indexOf(stop), stop.extras.indexOf(extra), id, stop.stop.id);
    });
  }

  Future demoUser() {
    customStatement("DELETE FROM users");
    return into(users).insert(UsersCompanion.insert(
        username: "Maria123_XD", imgPath: "assets/images/profile_test.png"));
  }

  Future<void> demoDivisions() async {
    await batch((batch) {
      batch.insertAll(
          divisions,
          [
            DivisionsCompanion.insert(
                name: "Zoologisch", color: Value(Color(0xFFFF0000))),
            DivisionsCompanion.insert(
                name: "Skulpturen", color: Value(Color(0xFF0000FF))),
            DivisionsCompanion.insert(
                name: "Bilder", color: Value(Color(0xFFFFEB3B))),
            DivisionsCompanion.insert(
                name: "Bonus", color: Value(Color(0xFF673AB7))),
          ],
          mode: InsertMode.insertOrReplace);
    });
  }

  Future<void> demoStops() async {
    //customStatement("DELETE FROM stops");
    customID = await into(stops).insert(
        StopsCompanion.insert(images: <String>[], name: customName, descr: ""));
    await batch((batch) {
      batch.insertAll(
          stops,
          List.generate(4, (i) {
                String s = (i % 3 == 0 ? "" : "2");
                return StopsCompanion.insert(
                  name: "Zoologisch $i",
                  division: Value("Zoologisch"),
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
                  division: Value("Skulpturen"),
                  creator: Value("DaVinci"),
                );
              }) +
              List.generate(10, (i) {
                String s = (i % 3 == 0 ? "" : "2");
                return StopsCompanion.insert(
                  name: "Bilder $i",
                  division: Value("Bilder"),
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
                    division: Value("Bonus"),
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
}

void demo() {
  var db = MuseumDatabase();
  //db.clear();
  db.demoUser();
  db.demoDivisions().catchError((_) => print("divisionError"));
  db.demoStops().catchError((_) => print("stopError"));
  db.demoBadges().catchError((_) => print("badgeError"));
  //db.demoTours().catchError((_) => print("tourError"));
  //db.demoTourStops().catchError((_) => print("tourStopsError"));
}

void init() {
  var u = UsersCompanion(
      username: Value("ABC"), imgPath: Value("assets/images/profile_test.png"));
  MuseumDatabase().setUser(u);
}

void reset() {
  MuseumDatabase().clear();
  //MuseumDatabase.get().reset(UsersCompanion(username: Value("TEST"), imgPath: Value("testPath")));
}
