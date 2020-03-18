import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';

import '../SizeConfig.dart';
import 'database.dart';

class TourWithStops {
  //Tour tour;
  final TextEditingController name = TextEditingController();
  final TextEditingController descr = TextEditingController();
  String author;
  double difficulty;
  DateTime creationTime;
  List<ActualStop> stops;

  TourWithStops(Tour t, this.stops) {
    this.name.text = t.name;
    this.descr.text = t.desc;
    author = t.author;
    difficulty = t.difficulty;
    creationTime = t.creationTime;
  }

  TourWithStops.empty(String author)
      : this(
      Tour(
          id: null,
          name: "Neue Tour",
          author: author,
          difficulty: 0,
          creationTime: null,
          desc: ""),
      <ActualStop>[]);

  ToursCompanion createToursCompanion(bool nullToAbsent) {
    return Tour(name: name.text,
        author: author,
        difficulty: difficulty,
        creationTime: creationTime,
        desc: descr.text, id: null).createCompanion(nullToAbsent);
  }

  Widget getRating({color = Colors.black, color2 = Colors.white, size = 40.0}) =>
      RatingBarIndicator(
        rating: min(max(difficulty, 0), 5),
        itemSize: size,
        itemBuilder: (BuildContext context, int index) => Icon(
          Icons.school,
          color: color,
        ),
        unratedColor: color2.withOpacity(.5),
      );

  Widget buildTime({Color color = Colors.pink, Color color2 = Colors.black, scale = 1.0}) {
    if (creationTime == null) return Container();
    String s = DateFormat('dd.MM.yyyy').format(creationTime);
    return Row(
      //crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          Icons.date_range,
          color: color,
          size: size(21, 25) * scale,
        ),
        Container(
          padding: EdgeInsets.only(left: 4, top: 2),
          child: Text(
            s,
            style: TextStyle(
                fontSize: size(13, 14) * scale,
                fontWeight: FontWeight.bold,
                color: color2),
          ),
        ),
      ],
    );
  }
}

class ActualStop {
  Stop stop;
  StopFeature features;
  List<ActualExtra> extras;

  bool isCustom() => stop != null && stop.name == customName;

  ActualStop(this.stop, this.features, this.extras);

  ActualStop.custom()
      : this(
      Stop(
          id: MuseumDatabase.customID,
          images: <String>[],
          name: customName,
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
  final TextEditingController textInfo = TextEditingController();
  final ActualTask task;
  final ExtraType type;

  ActualExtra(this.type, {text = "", sel = const [""], correct = const <int>{}}) : task = ActualTask(type, answerNames: sel, correct: correct) {
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
  final Set<int> correct;
  int selected;

  factory ActualTask(type, {answerNames = const [""], correct}) {
    var w;
    switch (type) {
      case ExtraType.TASK_TEXT: w = TextEditingController(); break;
      case ExtraType.TASK_MULTI:
      case ExtraType.TASK_SINGLE: w = false; break;
      default: return null;
    }

    return ActualTask.create(answerNames, w, correct: correct);
  }

  ActualTask.create(names, start, {this.correct = const <int>{}}) : entries = <Tuple>[] {
    for (String s in names)
      addLabel(s, start);
  }

  addLabel(String label, value) {
    var tedit = TextEditingController();
    tedit.text = label;
    //labels.add(tedit);
    //answers.add(m.TextEditingController());
    entries.add(Tuple(tedit, value));
  }

  removeLast() {
    if (entries.length < 1) return;
    entries.removeLast();
  }

  bool isCorrect(int id) {
    if (id < 0 || entries.length <= id) return false;
    var t = entries[id];
    return (correct.contains(id) && selected == id) || (!correct.contains(id) && selected != id) || (correct.contains(id) && t.valB == true) || (!correct.contains(id) && t.valB != true) ;
  }

  reset() {
    selected = null;
    for (var e in entries) {
      if (e.valB == true)
        e.valB = false;
      else if (e.valB is TextEditingController)
        e.valB.text = "";
    }
  }

}