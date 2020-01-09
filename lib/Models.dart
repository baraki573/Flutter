import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';

class Tour {
  String name;
  String author;
  String description;
  List<Item> stops;
  double rating;
  DateTime ttl;

  Tour(this.name, this.author, this.stops,
      {this.description = "", this.rating = 0, this.ttl})
      : assert(stops.length >= 2);
}

class Badge {
  String name;
  double current;
  double toGet;
  Color color;
  ImageProvider img;
  final GlobalKey<AnimatedCircularChartState> key =
      GlobalKey<AnimatedCircularChartState>();
  final GlobalKey<AnimatedCircularChartState> key2 =
      GlobalKey<AnimatedCircularChartState>();

  Badge(this.name, this.toGet, this.color, this.img, {this.current = 0});
}

class User {
  //TODO limit username length
  String username;
  ImageProvider img;
  List<Badge> badges = [];
  List<Item> fav = [];
  List<Tour> tours = [];

  User(this.username,
      {this.img = const AssetImage('assets/images/profile_test.png'),
      this.badges,
      this.fav,
      this.tours});
}

class Devision {
  String name;
  Color color;

  Devision(this.name, this.color);
}

class Item {
  String name;
  List<ImageProvider> imgs;
  Devision dev;
  String year;
  String artType;
  String creator;
  String material;
  String size;
  String location;
  String descr;
  String interContext;

  Item(
    this.name,
    this.dev,
    this.descr,
    this.imgs, {
    this.creator,
    this.year,
    this.artType,
    this.material,
    this.size,
    this.location,
    this.interContext,
  }) : assert(imgs.length >= 1);

  Map<String, String> getInformation() {
    Map<String, String> map = {
      "Abteilung": dev.name,
      "Ersteller": creator,
      "Zeitraum": year,
      "Material": material,
      "Größe": size,
      "Ort": location,
      "Kontext": interContext
    };
    map.removeWhere((key, val) => val == null);

    return map;
  }
}

List<Devision> devisions = [
  Devision("Zoologisch", Colors.red),
  Devision("Skulpturen", Colors.blue),
  Devision("Bilder", Colors.yellow),
  Devision("Bonus", Colors.deepPurple)
];

User getUser() {
  var u = User(
    "Maria123_XD",
    badges: List.generate(16, (index) {
      return Badge(
        "Badge $index",
        16,
        Colors.primaries[index],
        AssetImage('assets/images/profile_test.png'),
        current: index.roundToDouble(),
      );
    }),
    fav: List.generate(4, (index) {
          String s = (index % 3 == 0 ? "" : "2");
          return Item(
            "Zoologisch $index",
            devisions[0],
            "Description foo",
            [AssetImage('assets/images/profile_test' + s + '.png')],
            creator: "Me",
          );
        }) +
        List.generate(2, (index) {
          String s = (index % 2 == 0 ? "" : "2");
          return Item(
            "Skulpturen $index",
            devisions[1],
            "More Descriptions",
            [AssetImage('assets/images/profile_test' + s + '.png')],
            creator: "DaVinci",
          );
        }) +
        List.generate(10, (index) {
          String s = (index % 3 == 0 ? "" : "2");
          return Item(
            "Bilder $index",
            devisions[2],
            "Interessante Details",
            [AssetImage('assets/images/profile_test' + s + '.png')],
            creator: "Artist",
          );
        }) +
        List.generate(1, (index) {
          return Item(
            "Bonus $index",
            devisions[3],
            "To be written",
            [AssetImage('assets/images/haupthalle_hlm_blue.png')],
            creator: "VanGogh",
          );
        }),
    tours: [
      Tour(
        "Test Tour",
        "Maria123_XD",
        List.generate(17, (index) {
          String s = (index % 3 == 0 ? "" : "2");
          return Item(
            "Zoologisch $index",
            devisions[0],
            "Hier kann man sein gesamtes Herzblut reinstecken und dem User viele wertvolle Informationen präsentieren. Idealerweise wird hier jedoch nicht zu viel geschrieben. Es ist jedoch möglich, hier sehr lange und detailierte Beschreibungen einzugeben, die korrekt angezeigt werden können.",
            List.generate((index % 3) + 1,
                (i) => AssetImage('assets/images/profile_test' + s + '.png')),
            creator: "Who",
            year: "Im Jahre 500 vor DaVinci",
            material: "Feinstes Mahagoni",
            size: "4 Lichtjahre",
            artType: "Radierung",
            location: "Rom",
          );
        }),
        rating: 4.6,
        //author: u.username,
        description: "Diese Beschreibung ist zum Glück nicht so lang.",
        //img: AssetImage('assets/images/profile_test.png'),
        //ttl: DateTime.parse("2020-02-03"),
      ),
      Tour(
        "Meine erste Tour",
        "1412",
        List.generate(4, (index) {
          return Item(
            "Zoologisch $index",
            devisions[0],
            "",
            [AssetImage('assets/images/profile_test.png')],
            //creator: "Unknown",
          );
        }),
        ttl: DateTime.parse("2020-01-05"),
        rating: 1.2,
        description:
            "Einen Roman schreiben die User hier bestimmt nicht hin. Und wenn doch, muss ich mir dafür etwas einfallen lassen.",
        //img: AssetImage('assets/images/profile_test2.png'),
      ),
      Tour(
        "Zoologische Tour mit interessanten Details",
        "MyBestUser",
        List.generate(4, (index) {
          return Item(
            "Zoologisch $index",
            devisions[0],
            "Ich weiß nicht, was ich hier rein schreiben soll.",
            [AssetImage('assets/images/profile_test.png')],
            creator: "null",
          );
        }),
        rating: 2.6,
        //author: User(username: "xXIchHabeNochNieSoEinenLangenUsernamenGesehen573Xx"),
        description: "Diese Tour ist sehr lehrreich.",
        //img: AssetImage('assets/images/haupthalle_hlm.png'),
      ),
    ],
  );
  //u.tours[0].author = u.username;
  return u;
}
