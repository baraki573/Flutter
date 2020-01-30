import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:museum_app/SizeConfig.dart';
import 'package:museum_app/database/database.dart';

class TestWidget extends StatefulWidget {
  TestWidget({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<TestWidget> {
  List<Stop> selected = List<Stop>();

  var ctrl = TextEditingController(text: "TEST");

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return StreamBuilder(
        stream: MuseumDatabase.get().getStops(),
        builder: (context, snap) {
          List<Stop> stops = snap.data ?? List<Stop>();
          return ListView(
            children: [
              Column(
                  children: stops
                      .map(
                        (s) => FlatButton(
                          onPressed: () {
                            setState(() {
                              if (selected.contains(s))
                                selected.remove(s);
                              else
                                selected.add(s);
                            });
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(vertical: 10),
                            width: SizeConfig.safeBlockHorizontal * 100,
                            height: SizeConfig.safeBlockVertical * 20,
                            foregroundDecoration: BoxDecoration(
                              color: selected.contains(s)
                                  ? Colors.red.withOpacity(0.7)
                                  : Colors.transparent,
                            ),
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(s.images[0]),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      )
                      .toList()),
              TextFormField(
                controller: ctrl,
              ),
              Checkbox(onChanged: (bool value) {setState(() {
                user = value ? "Maria123_XD" : "MeA";
              });}, value: user=="Maria123_XD",

              ),
              FlatButton(
                onPressed: _makeIt,
                child: Text("PRESS"),
              )
            ],
          );
        });
  }

  var user = "MeA";

  void _makeIt() {
    var t = Tour(
        name: ctrl.text,
        author: user,
        rating: 2.7,
        creationTime: DateTime.now(),
        desc: "NULL", id: null);
    var tws = TourWithStops(t, selected);
    MuseumDatabase.get().writeTourStops(tws);
  }
}
