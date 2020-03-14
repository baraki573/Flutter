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

part 'database.g.dart';

String _customName = "Individuell";

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

  //TODO convert to difficulty
  RealColumn get rating => real()();

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
  //Tour tour;
  final m.TextEditingController name = m.TextEditingController();
  final m.TextEditingController descr = m.TextEditingController();
  String author;
  double difficulty;
  DateTime creationTime;
  List<ActualStop> stops;

  TourWithStops(Tour t, this.stops) {
    this.name.text = t.name;
    this.descr.text = t.desc;
    author = t.author;
    difficulty = t.rating;
    creationTime = t.creationTime;
  }

  TourWithStops.empty(String author)
      : this(
      Tour(
          id: null,
          name: "",
          author: author,
          rating: 0,
          creationTime: null,
          desc: ""),
      <ActualStop>[]);

  ToursCompanion createToursCompanion(bool nullToAbsent) {
    return Tour(name: name.text,
        author: author,
        rating: difficulty,
        creationTime: creationTime,
        desc: descr.text, id: null).createCompanion(nullToAbsent);
  }
}

class ActualStop {
  Stop stop;
  StopFeature features;
  List<ActualExtra> extras;

  bool isCustom() => stop != null && stop.name == _customName;

  ActualStop(this.stop, this.features, this.extras);

  ActualStop.custom()
      : this(
      Stop(
          id: MuseumDatabase.customID,
          images: <String>[],
          name: "HAALLO",
          descr: ""),
      StopFeature(
          id_tour: null,
          id_stop: MuseumDatabase.customID,
          showImages: false,
          showText: true,
          showDetails: false),
      <ActualExtra>[]);
}

enum ExtraType { TASK_TEXT, TASK_SINGLE, TASK_MULTI, IMAGE, TEXT }

class ActualExtra {
  final m.TextEditingController textInfo = m.TextEditingController();
  final ActualTask task;
  final ExtraType type;

  ActualExtra(this.type, {text = "", sel = const [""]}) : task = ActualTask(type, answerNames: sel) {
    textInfo.text = text;
  }

  /*
  ActualExtra.onlyText(String text) : image = false {
    this.textInfo.text = text;
  }

  ActualExtra.realTask(task, type, answerNames) : image = false {
    this.textInfo.text = task;
    this.task = ActualTask(type, answerNames: answerNames);
  }

  ActualExtra.images(String images) : image = true {
    this.textInfo.text = images;
  }*/
}

class Tuple<K, V> {
  K valA;
  V valB;

  Tuple(this.valA, this.valB);
}

class ActualTask {
  //final ExtraType type;
  //Map<String, m.TextEditingController> answers;
  //final List<m.TextEditingController> labels;
  //final List<m.TextEditingController> answers;
  //final Set<int> selected;
  //final List<String> answers;
  final List<Tuple> entries;
  int selected;

  factory ActualTask(type, {answerNames = const [""]}) {
    var w;
    switch (type) {
      case ExtraType.TASK_TEXT: w = m.TextEditingController(); break;
      case ExtraType.TASK_MULTI:
      case ExtraType.TASK_SINGLE: w = false; break;
      default: return null;
    }

    return ActualTask.text(answerNames, w);
  }

  ActualTask.text(names, start) : entries = <Tuple>[] {//labels = <m.TextEditingController>[], answers = <m.TextEditingController>[]{
    //answers = Map<String, m.TextEditingController>();
    for (String s in names) {
      addLabel(s, start);
    }
  }

  addLabel(String label, value) {
    var tedit = m.TextEditingController();
    tedit.text = label;
    //labels.add(tedit);
    //answers.add(m.TextEditingController());
    entries.add(Tuple(tedit, value));
  }

  removeLast() {
    if (entries.length < 1) return;
    entries.removeLast();
  }

}

class Devisions extends Table {
  TextColumn get name => text()();

  IntColumn get color =>
      integer().withDefault(const Constant(0xFFFFFFFF)).map(ColorConverter())();

  @override
  Set<Column> get primaryKey => {name};
}

class Extras extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get id_tour => integer().customConstraint("REFERENCES tours(id)")();

  IntColumn get id_stop => integer().customConstraint("REFERENCES stops(id)")();

  TextColumn get textInfo => text()();

  IntColumn get type => integer().map(TaskTypeConverter()).nullable()();

  TextColumn get answerOpt => text().map(StringListConverter()).nullable()();

  @override
  Set<Column> get primaryKey => {id, id_tour, id_stop};
}

class StopFeatures extends Table {
  IntColumn get id_tour => integer().customConstraint("REFERENCES tours(id)")();

  IntColumn get id_stop => integer().customConstraint("REFERENCES stops(id)")();

  BoolColumn get showImages => boolean().withDefault(const Constant(true))();

  BoolColumn get showText => boolean().withDefault(const Constant(true))();

  BoolColumn get showDetails => boolean().withDefault(const Constant(true))();
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

class TaskTypeConverter extends TypeConverter<ExtraType, int> {
  const TaskTypeConverter();

  @override
  ExtraType mapToDart(int fromDb) {
    if (fromDb == null) return null;
    var values = ExtraType.values;
    if (0 <= fromDb && fromDb < values.length)
      return values[fromDb];
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
  Devisions,
  Tours,
  TourStops,
  Extras,
  StopFeatures
])
class MuseumDatabase extends _$MuseumDatabase {
  static MuseumDatabase _db;
  static int customID = 0;

  static MuseumDatabase get() {
    _db ??= MuseumDatabase();
    return _db;
  }

  MuseumDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 5;

  Stream<User> watchUser() => select(users).watchSingle();

  Future<User> getUser() => select(users).getSingle();

  Future setUser(UsersCompanion uc) {
    customStatement("DELETE FROM users");
    return into(users).insert(uc);
  }

  Future updateUsername(String name) {
    return update(users).write(UsersCompanion(username: Value(name)));
  }

  Future updateOnboard(bool b) {
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

  Stream<StopFeature> getStopFeatures(int stop_id, int tour_id) {
    if (stop_id == customID)
      return Stream.value(StopFeature(id_tour: tour_id, id_stop: stop_id, showImages: false, showText: true, showDetails: false));
    final query = select(stopFeatures)
      ..where((f) => f.id_stop.equals(stop_id))
      ..where((f) => f.id_tour.equals(tour_id));

    return query.watchSingle();
  }

  Future<void> updateStopFeatures(int stop_id, int tour_id, {images, text, details}) {
    if (stop_id != customID)
    update(stopFeatures).replace(
      StopFeature(
        id_stop: stop_id,
        id_tour: tour_id,
        showImages: images,
        showText: text,
        showDetails: details,
      ).createCompanion(true),
    );
  }

  Future addExtra(ActualExtra e, int tour_id, int stop_id) {
    if (e.task != null) {
      return into(extras).insert(
          ExtrasCompanion.insert(
              id_tour: tour_id,
              id_stop: stop_id,
              textInfo: e.textInfo.text,
              type: Value(e.type),
              answerOpt: Value(e.task.entries.map((e) => e.valA.text as String).toList())),
          mode: InsertMode.insertOrReplace);
    }
    return into(extras).insert(
        ExtrasCompanion.insert(
            id_tour: tour_id, id_stop: stop_id, type: Value(e.type), textInfo: e.textInfo.text),
        mode: InsertMode.insertOrReplace);
  }

  Stream<ActualStop> getActualStop(int tour_id, int stop_id) {
    final stop = select(stops)
      ..where((s) => s.id.equals(stop_id));

    final feature = getStopFeatures(stop_id, tour_id);

    return CombineLatestStream.combine3(
        stop.watchSingle(),
        feature,
        getExtras(tour_id, stop_id),
            (Stop s, StopFeature f, List<ActualExtra> l) =>
            ActualStop(s, f, l));
  }

  Stream<List<ActualExtra>> getExtras(int tour_id, int stop_id) {
    final query = select(extras)
      ..where((t) => t.id_tour.equals(tour_id))..where((t) =>
          t.id_stop.equals(stop_id));

    return query.watch().map((rows) =>
        rows.map(
              (e) {
            //if (t.desc != null) return ActualText(t.desc);
            return ActualExtra(e.type, text: e.textInfo, sel: e.answerOpt);
                /*if (e.type != null)
              return ActualExtra.realTask(
                e.textInfo,
                e.type,
                e.answerOpt,
              );
            return ActualExtra.onlyText(e.textInfo);*/
          },
        ).toList());
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

  Stream<List<Devision>> getDevisions() => select(devisions).watch();

  Stream<List<Tour>> getTours() => select(tours).watch();

  Stream<List<TourWithStops>> getTourStops() {
    final tour_ids = select(tours, distinct: true).map((t) => t.id).watch();

    var t = tour_ids.map((list) => list.map((id) => getTour(id)).toList());

    return SwitchLatestStream(t.map((list) => CombineLatestStream.list(list)));
  }

  Stream<TourWithStops> getTour(int tour_id) {
    final tour = select(tours)
      ..where((t) => t.id.equals(tour_id));

    final stop_ids = (select(tourStops, distinct: true)
      ..where((ts) => ts.id_tour.equals(tour_id)))
        .map((t) => t.id_stop)
        .watch();

    var l2 = stop_ids
        .map((list) => list.map((i) => getActualStop(tour_id, i)).toList());

    var res = CombineLatestStream.combine2(tour.watchSingle(), l2,
            (Tour t, List<Stream<ActualStop>> a) {
          Stream<List<ActualStop>> s = CombineLatestStream.list(a);
          return s.map((list) => TourWithStops(t, list));
        });

    return SwitchLatestStream(res);
  }

  Stream<List<Stop>> getStops() => select(stops).watch();

  Stream<List<Extra>> getExtrasId(int id_tour, int id_stop) {
    final contentQuery = select(extras)
    //.join([innerJoin(stops, stops.id.equalsExp(tourStops.id_stop))])
      ..where((e) => e.id_tour.equals(id_tour))..where((e) =>
          e.id_stop.equals(id_stop));

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
    final query = select(stops)
      ..where((stop) => stop.name.equals(_customName));
    return query.watchSingle().map((stop) =>
        ActualStop(
            stop,
            StopFeature(
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

      await (delete(tourStops)
        ..where((e) => e.id_tour.equals(id))).go();

      await batch((batch) {
        batch.insertAll(
            tourStops,
            entry.stops
                .where((s) => s.stop != null)
                .map((s) => TourStop(id_tour: id, id_stop: s.stop.id))
                .toList(),
            mode: InsertMode.insertOrReplace);
        batch.insertAll(
            stopFeatures,
            entry.stops
                .where((s) => s.features != null && !s.isCustom())
                .map((s) => s.features.copyWith(id_tour: id))
                .toList(),
            mode: InsertMode.insertOrReplace);
      });

      for (var stop in entry.stops)
        for (var extra in stop.extras)
          addExtra(extra, id, stop.stop.id);
    });
  }

  Future demoUser() {
    customStatement("DELETE FROM users");
    return into(users).insert(UsersCompanion.insert(
        username: "Maria123_XD", imgPath: "assets/images/profile_test.png"));
  }

  Future<void> demoDevisions() async {
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
    customID = await into(stops).insert(
        StopsCompanion.insert(images: <String>[], name: _customName, descr: ""));
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
              (i) =>
              BadgesCompanion.insert(
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
