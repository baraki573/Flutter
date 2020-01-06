import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';

class Tour {
  String name;
  String author;
  String description;
  ImageProvider img;
  List<Item> stops;
  double rating = 0;
  DateTime ttl;

  Tour(
      {@required this.name,
      @required this.author,
      this.description="",
      this.img,
      this.stops,
      this.ttl,
      this.rating});
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
  ImageProvider img;
  Devision dev;
  int year;
  String artType;
  String creator;
  String material;
  String size;
  String location;
  String descr;
  String interContext;

  Item(
      {@required this.name,
      @required this.img,
      this.year,
      this.artType,
      this.creator,
      this.material,
      this.size,
      this.location,
      this.descr,
      this.interContext,
      @required this.dev});
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
            img: AssetImage('assets/images/profile_test' + s + '.png'),
          );
        }) +
        List.generate(2, (index) {
          String s = (index % 2 == 0 ? "" : "2");
          return Item(
            name: "Skulpturen $index",
            dev: devisions[1],
            img: AssetImage('assets/images/profile_test' + s + '.png'),
          );
        }) +
        List.generate(10, (index) {
          String s = (index % 3 == 0 ? "" : "2");
          return Item(
            dev: devisions[2],
            name: "Bilder $index",
            img: AssetImage('assets/images/profile_test' + s + '.png'),
          );
        }) +
        List.generate(1, (index) {
          return Item(
            dev: devisions[3],
            name: "Bonus $index",
            img: AssetImage('assets/images/haupthalle_hlm_blue.png'),
          );
        }),
    tours: [
      Tour(
        name: "Test Tour",
        rating: 4.6,
        //author: u.username,
        description: "Diese Beschreibung ist zum Glück nicht so lang.",
        img: AssetImage('assets/images/profile_test.png'),
        stops: List.generate(17, (index) {
          return Item(
            name: "Zoologisch $index",
            dev: devisions[0],
            img: AssetImage('assets/images/profile_test.png'),
          );
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
            img: AssetImage('assets/images/profile_test.png'),
            dev: devisions[0],
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
            img: AssetImage('assets/images/profile_test.png'),
          );
        }),
      ),
    ],
  );
  u.tours[0].author = u.username;
  return u;
}
