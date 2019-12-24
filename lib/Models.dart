import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';

class Tour {
  String name;
  User author;
  String description;
  ImageProvider img;
  List<Item> stops;
  DateTime ttl = null;

  Tour(
      {this.name,
      this.author,
      this.description,
      this.img,
      this.stops,
      this.ttl});
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
  String username;
  ImageProvider img;
  List<Badge> badges;
  List<Devision> favDev;
  List<Tour> tours;

  User({this.username, this.img, this.badges, this.favDev, this.tours});
}

class Devision {
  String name;
  Color color;
  List<Item> items;

  Devision({this.name, this.color, this.items});
}

class Item {
  String name;
  ImageProvider img;

  Item({this.name, this.img});
}

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
    favDev: [
      Devision(
          name: "Zoologisch",
          color: Colors.red,
          items: List.generate(4, (index) {
            String s = (index % 3 == 0 ? "" : "2");
            return Item(
              name: "Zoologisch $index",
              img: AssetImage('assets/images/profile_test' + s + '.png'),
            );
          })),
      Devision(
          name: "Skulpturen",
          color: Colors.blue,
          items: List.generate(2, (index) {
            String s = (index % 2 == 0 ? "" : "2");
            return Item(
              name: "Skulpturen $index",
              img: AssetImage('assets/images/profile_test' + s + '.png'),
            );
          })),
      Devision(
          name: "Bilder",
          color: Colors.yellow,
          items: List.generate(10, (index) {
            String s = (index % 3 == 0 ? "" : "2");
            return Item(
              name: "Bilder $index",
              img: AssetImage('assets/images/profile_test' + s + '.png'),
            );
          })),
      Devision(
          name: "Bonus",
          color: Colors.deepPurple,
          items: List.generate(1, (index) {
            return Item(
              name: "Bonus $index",
              img: AssetImage('assets/images/haupthalle_hlm_blue.png'),
            );
          })),
    ],
    tours: [
      Tour(
        name: "Test Tour",
        //author: test,
        description: "ABC",
        img: AssetImage('assets/images/profile_test.png'),
        stops: List.generate(4, (index) {
          return Item(
            name: "Zoologisch $index",
            img: AssetImage('assets/images/profile_test.png'),
          );
        }),
        ttl: DateTime.parse("2020-01-01"),
      ),
      Tour(
        name: "Test Tour2",
        author: User(username: "kkd"),
        description: "PKMDF",
        img: AssetImage('assets/images/profile_test2.png'),
        stops: List.generate(4, (index) {
          return Item(
            name: "Zoologisch $index",
            img: AssetImage('assets/images/profile_test.png'),
          );
        }),
        //ttl: DateTime.parse("2020-01-07"),
      ),
    ],
  );
  u.tours[0].author = u;
  return u;
}
