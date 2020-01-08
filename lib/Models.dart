import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';

class Tour {
  String name;
  String author;
  String description;
  ImageProvider img;
  List<Item> stops;
  double rating;
  DateTime ttl;

  Tour(
      {@required this.name,
      @required this.author,
      this.description = "",
      this.img,
      this.stops,
      this.ttl,
      this.rating = 0});
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

  Badge({this.name, this.current, this.toGet, this.color, this.img});
}

class User {
  //TODO limit username length
  String username;
  ImageProvider img;
  List<Badge> badges;
  List<Item> fav;
  List<Tour> tours;

  User({@required this.username, this.img, this.badges, this.fav, this.tours});
}

class Devision {
  String name;
  Color color;

  //List<Item> items;

  Devision({this.name, this.color});
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
      {@required this.name,
      @required this.imgs,
      this.year,
      this.artType,
      @required this.creator,
      this.material,
      this.size,
      this.location,
      this.descr = "",
      this.interContext,
      @required this.dev});

  Map<String, String> getInformation(){
    Map<String, String> map = {
      "Abteilung": dev.name,
      "Zeitraum": year,
      "Ersteller": creator,
      "Material": material,
      "Größe": size,
      "Ort": location,
      "Kontext": interContext
    };
    map.removeWhere((key, val) => val==null);

    return map;
  }

}

List<Devision> devisions = [
  Devision(name: "Zoologisch", color: Colors.red),
  Devision(name: "Skulpturen", color: Colors.blue),
  Devision(name: "Bilder", color: Colors.yellow),
  Devision(name: "Bonus", color: Colors.deepPurple)
];

User getUser() {
  var u = User(
    username: "Maria123_XD",
    img: AssetImage('assets/images/profile_test.png'),
    badges: List.generate(16, (index) {
      return Badge(
          name: "Badge $index",
          current: index.roundToDouble(),
          toGet: 16,
          img: AssetImage('assets/images/profile_test.png'),
          color: Colors.primaries[index]);
    }),
    fav: List.generate(4, (index) {
          String s = (index % 3 == 0 ? "" : "2");
          return Item(
            name: "Zoologisch $index",
            dev: devisions[0],
            imgs: [AssetImage('assets/images/profile_test' + s + '.png')],
            creator: "Me",
          );
        }) +
        List.generate(2, (index) {
          String s = (index % 2 == 0 ? "" : "2");
          return Item(
            name: "Skulpturen $index",
            dev: devisions[1],
            imgs: [AssetImage('assets/images/profile_test' + s + '.png')],
            creator: "DaVinci",
          );
        }) +
        List.generate(10, (index) {
          String s = (index % 3 == 0 ? "" : "2");
          return Item(
            dev: devisions[2],
            name: "Bilder $index",
            imgs: [AssetImage('assets/images/profile_test' + s + '.png')],
            creator: "Artist",
          );
        }) +
        List.generate(1, (index) {
          return Item(
            dev: devisions[3],
            name: "Bonus $index",
            imgs: [AssetImage('assets/images/haupthalle_hlm_blue.png')],
            creator: "VanGogh",
          );
        }),
    tours: [
      Tour(
        name: "Test Tour",
        rating: 4.6,
        author: "Maria123_XD",
        //author: u.username,
        description: "Diese Beschreibung ist zum Glück nicht so lang.",
        img: AssetImage('assets/images/profile_test.png'),
        stops: List.generate(17, (index) {
          String s = (index % 3 == 0 ? "" : "2");
          return Item(
              name: "Zoologisch $index",
              dev: devisions[0],
              imgs: List.generate((index % 3) + 1,
                  (i) => AssetImage('assets/images/profile_test' + s + '.png')),
              creator: "Who",
              year: "Im Jahre 500 vor DaVinci",
              material: "Feinstes Mahagoni",
              size: "4 Lichtjahre",
              artType: "Radierung",
              location: "Rom",
              descr:
                  "Hier kann man sein gesamtes Herzblut reinstecken und dem User viele wertvolle Informationen präsentieren. Idealerweise wird hier jedoch nicht zu viel geschrieben. Es ist jedoch möglich, hier sehr lange und detailierte Beschreibungen einzugeben, die korrekt angezeigt werden können.");
        }),

        //ttl: DateTime.parse("2020-02-03"),
      ),
      Tour(
        name: "Meine erste Tour",
        rating: 1.2,
        author: "1412",
        description:
            "Einen Roman schreiben die User hier bestimmt nicht hin. Und wenn doch, muss ich mir dafür etwas einfallen lassen.",
        img: AssetImage('assets/images/profile_test2.png'),
        stops: List.generate(4, (index) {
          return Item(
            name: "Zoologisch $index",
            imgs: [AssetImage('assets/images/profile_test.png')],
            dev: devisions[0],
            creator: "Unknown",
          );
        }),
        ttl: DateTime.parse("2020-01-05"),
      ),
      Tour(
        name: "Zoologische Tour mit interessanten Details",
        rating: 2.6,
        //author: User(username: "xXIchHabeNochNieSoEinenLangenUsernamenGesehen573Xx"),
        author: "MyBestUser",
        description: "Diese Tour ist sehr lehrreich.",
        img: AssetImage('assets/images/haupthalle_hlm.png'),
        stops: List.generate(4, (index) {
          return Item(
            name: "Zoologisch $index",
            dev: devisions[0],
            imgs: [AssetImage('assets/images/profile_test.png')],
            creator: "null",
          );
        }),
      ),
    ],
  );
  //u.tours[0].author = u.username;
  return u;
}
