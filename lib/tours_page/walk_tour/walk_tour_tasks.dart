import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:expandable/expandable.dart';
import 'package:expandable_bottom_bar/expandable_bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:museum_app/Models.dart';
import 'package:museum_app/SizeConfig.dart';
import 'package:museum_app/map/map_page.dart';
import 'package:photo_view/photo_view.dart';

class TourWalkerTasks extends StatefulWidget {
  final List<Task> tasks;

  TourWalkerTasks(this.tasks, {Key key}) : super(key: key);

  @override
  _TourWalkerTasksState createState() => _TourWalkerTasksState();
}

class _TourWalkerTasksState extends State<TourWalkerTasks> {
  @override
  Widget build(BuildContext context) {
    if (widget.tasks == null || widget.tasks.length < 1) return Container();
    return Column(
      children: [
        Text("HALLO"),
        Text("TEST"),
      ],
    );
  }
}
