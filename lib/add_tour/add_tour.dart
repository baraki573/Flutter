import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:museum_app/add_tour/join_tour.dart';
import 'package:museum_app/museum_tabs.dart';

import 'create_tour.dart';

class AddTour extends StatefulWidget {
  AddTour({Key key}) : super(key: key);

  @override
  _AddTourState createState() => _AddTourState();
}

enum AddType { CHOOSE, CREATE, JOIN }

class _AddTourState extends State<AddTour> {
  AddType _type = AddType.CHOOSE;

  void goBack() => setState(() => _type = AddType.CHOOSE);

  @override
  Widget build(BuildContext context) {
    switch (_type) {
      case AddType.CREATE:
        return CreateTour(goBack);
      case AddType.JOIN:
        return JoinTour(goBack);
      default:
        return MuseumTabs(
          Center(child: Text("SCHÖNES BILD")),
          [_chooseState()], //TestWidget()],
          //names: ["Erstellen", "Beitreten"],
          //color: Colors.orange,
        );
    }
  }

  Widget _chooseState() {
    return Column(
      children: [
        FlatButton(
          onPressed: () => setState(() => _type = AddType.CREATE),
          child: Text("CREATE"),
        ),
        FlatButton(
          onPressed: () => setState(() => _type = AddType.JOIN),
          child: Text("JOIN"),
        )
      ],
    );
  }
}
