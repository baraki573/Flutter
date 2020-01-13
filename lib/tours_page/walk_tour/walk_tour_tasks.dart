import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:expandable/expandable.dart';
import 'package:expandable_bottom_bar/expandable_bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';
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
  void initState() {
    super.initState();
    KeyboardVisibilityNotification().addNewListener(
      onHide: ()=>FocusScope.of(context).requestFocus(FocusNode())
    );
  }


  Widget _taskWidget(int i, Task t) {
    var node = FocusNode();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(top: t.descr == "" ? 0 : 15),
          //color: Colors.red,
          child: Text(
            t.descr,
            textAlign: TextAlign.justify,
            style: TextStyle(fontSize: 18),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 16),
          padding: EdgeInsets.symmetric(horizontal: 13, vertical: 8),
          width: horSize(100, 100),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(18)),
              border: Border.all(color: Colors.pink, width: 2.2)),
          child: RichText(
            text: TextSpan(
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.black,
              ),
              children: [
                TextSpan(
                    text: "Aufgabe $i:\n",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                TextSpan(text: t.task),
              ],
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: 7, right: 4),
          decoration: BoxDecoration(border: Border.all(color: Colors.black)),
          child: TextField(

            //focusNode: node,
            //onTap: () => FocusScope.of(context).requestFocus(node),
            //onEditingComplete: () {if (FocusScope.of(context)==node) node.unfocus();},
            //textInputAction: TextInputAction.done,
            controller: t.ctrl,
            minLines: 1,
            maxLines: 10,
            decoration: InputDecoration(
              border: InputBorder.none,
              icon: Icon(Icons.create),
              //labelText: "....",
              hintText: "....",
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.tasks == null || widget.tasks.length < 1) return Container();
    return Container(
      padding: EdgeInsets.only(left: 16, right: horSize(17, 17)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: widget.tasks
            .map((t) => _taskWidget(widget.tasks.indexOf(t) + 1, t))
            .toList(),
      ),
    );
  }
}
