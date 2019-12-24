import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';

class Tour {
  String name;
  User author;
  String description;
  ImageProvider img;
  List<Item> stops;
  DateTime ttl;

  Tour(
      this.name, this.author, this.description, this.img, this.stops, this.ttl);
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

  User({this.username, this.img, this.badges});
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
