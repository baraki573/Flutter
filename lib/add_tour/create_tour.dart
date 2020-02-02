import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:museum_app/database/database.dart';
import 'package:museum_app/tours_page/walk_tour/walk_tour_content.dart';
import 'package:museum_app/tours_page/walk_tour/walk_tour_tasks.dart';
import 'package:reorderables/reorderables.dart';

import '../SizeConfig.dart';

class CreateTour extends StatefulWidget {
  final void Function() goBack;

  CreateTour(this.goBack, {Key key}) : super(key: key);

  @override
  _CreateTourState createState() => _CreateTourState();
}

enum CreateType { GENERAL, STOP }

class _CreateTourState extends State<CreateTour> {
  //List<MyString> list = [MyString("Stop 0")];
  int index = 0;
  CreateType _type = CreateType.GENERAL;

  final List<ActualStop> stops = [ActualStop(null, null, [])];

  final ctrl = TextEditingController();

  Widget _draggable() {
    var horPad = horSize(27.5, 32.5);
    return ReorderableWrap(
      //alignment: WrapAlignment.center,
      //crossAxisAlignment: WrapCrossAlignment.center,
      needsLongPressDraggable: true,
      padding: EdgeInsets.only(top: 30, right: horPad, left: horPad),
      //spacing: 50.0,
      maxMainAxisCount: 1,
      onReorder: (int oldIndex, int newIndex) => setState(() {
        var old = stops[oldIndex];

        oldIndex += newIndex < oldIndex ? 1 : 0;
        newIndex += newIndex > oldIndex ? 1 : 0;

        stops.insert(newIndex, old);
        stops.removeAt(oldIndex);
      }),
      footer: Column(
        children: [
          TextFormField(
            controller: ctrl,
            decoration: InputDecoration(
              icon: Icon(Icons.person),
              labelText: "Name",
              border: InputBorder.none,
            ),
          ),
          Text("OTHER OPTIONS..."),
          FlatButton(
            color: Colors.red,
            onPressed: () {
              Tour t = Tour(
                id: null,
                name: ctrl.text,
                author: "Maria35",
                difficulty: 2.5,
                creationTime: DateTime.now(),
                desc: "Gefunden auf Otto.de",
              );
              MuseumDatabase.get().writeTourStops(TourWithStops(t, this.stops));
            },
            child: Text("SUBMIT"),
          ),
        ],
      ),
      children: stops
          .map((elem) => GestureDetector(
                onTap: () => setState(() {
                  index = stops.indexOf(elem);
                  _type = CreateType.STOP;
                }),
                child: Container(
                  color: Colors.white,
                  alignment: Alignment.center,
                  height: verSize(20, 10),
                  width: horSize(45, 35),
                  margin: EdgeInsets.symmetric(vertical: 5),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 70,
                        child: Text(
                          elem.stop?.name ?? "Empty",
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 25),
                        width: 60,
                        child: ButtonBar(
                          mainAxisSize: MainAxisSize.min,
                          buttonMinWidth: 50,
                          buttonHeight: 40,
                          children: [
                            FlatButton(
                                color: Colors.green,
                                onPressed: () => setState(() {
                                      var index = stops.indexOf(elem);
                                      stops.insert(index + 1,
                                          ActualStop(null, null, []));
                                    }),
                                child: Icon(Icons.add_circle)),
                            FlatButton(
                                color: Colors.red,
                                onPressed: () => setState(() {
                                      if (stops.length > 1) stops.remove(elem);
                                      if (index >= stops.length) index--;
                                    }),
                                child: Icon(Icons.remove_circle)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ))
          .toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      height: SizeConfig.safeBlockVertical * 100,
      child: Stack(
        children: [
          _type == CreateType.GENERAL ? _draggable() : _EditStop(stops[index]),
          Positioned(
            top: 23,
            child: IconButton(
              onPressed: _type == CreateType.GENERAL
                  ? widget.goBack
                  : () => setState(() => _type = CreateType.GENERAL),
              icon: Icon(Icons.arrow_back),
              iconSize: 30,
            ),
          ),
        ],
      ),
    );
  }
}

class _EditStop extends StatefulWidget {
  final ActualStop stop;

  _EditStop(this.stop, {Key key}) : super(key: key);

  @override
  _EditStopState createState() => _EditStopState();
}

class _EditStopState extends State<_EditStop> {

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: Row(
          children: [
            Container(
              //color: Colors.orange,
              alignment: Alignment.center,
              width: horSize(83, 70),
              height: verSize(100, 100),
              child: ListView(
                children: [
                  StreamBuilder(
                    stream: MuseumDatabase.get().getStops(),
                    builder: (context, snap) {
                      List<Stop> list = snap.data ?? List<Stop>();
                      return DropdownButton(
                        items: list
                            .map((stop) => DropdownMenuItem(
                                child: Text(stop.name), value: stop))
                            .toList(),
                        onChanged: (value) => setState(() {
                          widget.stop.stop = value;
                          widget.stop.features = StopFeature(
                            id_tour: null,
                            id_stop: value.id,
                            showImages: true,
                            showText: true,
                            showDetails: true,
                          );
                        }),
                      );
                    },
                  ),
                  _maker(),
                ],
              ),
            ),
            Container(
              color: Colors.blue,
              width: horSize(17, 20),
              height: verSize(100, 100),
              padding: EdgeInsets.only(top: 27),
              child: Column(
                //buttonMinWidth: horSize(15, 20),
                //buttonHeight: 15,//verSize(1, 15),
                mainAxisSize: MainAxisSize.min,
                children: [
                  FlatButton(
                    color: (widget.stop.features?.showImages) ?? false
                        ? Colors.red
                        : Colors.green,
                    onPressed: () => setState(() {
                      if (widget.stop.features == null) return;
                      var showImgs = widget.stop.features.showImages;
                      widget.stop.features =
                          widget.stop.features.copyWith(showImages: !showImgs);
                    }),
                    child: Text("Bilder"),
                    padding: EdgeInsets.all(0),
                  ),
                  FlatButton(
                    color: (widget.stop.features?.showText) ?? false
                        ? Colors.red
                        : Colors.green,
                    onPressed: () => setState(() {
                      if (widget.stop.features == null) return;
                      var showText = widget.stop.features.showText;
                      widget.stop.features =
                          widget.stop.features.copyWith(showText: !showText);
                    }),
                    child: Text("Text"),
                    padding: EdgeInsets.all(0),
                  ),
                  FlatButton(
                    color: (widget.stop.features?.showDetails) ?? false
                        ? Colors.red
                        : Colors.green,
                    onPressed: () => setState(() {
                      if (widget.stop.features == null) return;
                      var showDetails = widget.stop.features.showDetails;
                      widget.stop.features = widget.stop.features
                          .copyWith(showDetails: !showDetails);
                    }),
                    child: Text("Details"),
                    padding: EdgeInsets.all(0),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() => widget.stop.tasks.add(ActualTask(
                          "HALLO " + DateTime.now().toIso8601String(),
                          TaskType.TEXT)));
                    },
                    icon: Icon(Icons.text_fields),
                  ),
                ],
              ),
            ),
          ],
        ));
  }

  Widget _maker() {
    SizeConfig().init(context);
    return ReorderableWrap(
      header: TourWalkerContent(
        widget.stop,
        color: Colors.black,
        showTasks: false,
      ),
      onReorder: (int oldIndex, int newIndex) => setState(() {
        var old = widget.stop.tasks[oldIndex];

        oldIndex += newIndex < oldIndex ? 1 : 0;
        newIndex += newIndex > oldIndex ? 1 : 0;

        widget.stop.tasks.insert(newIndex, old);
        widget.stop.tasks.removeAt(oldIndex);
      }),
      children: widget.stop.tasks
          .map(
            (t) => Row(
              children: [
                Expanded(
                    child: taskWidget(widget.stop.tasks.indexOf(t) + 1, t,
                        edit: true)),
                Column(
                  children: [
                    Icon(Icons.drag_handle),
                    IconButton(
                        onPressed: () =>
                            setState(() => widget.stop.tasks.remove(t)),
                        icon: Icon(Icons.remove_circle)),
                  ],
                )
              ],
            ),
          )
          .toList(),
      footer: Container(height: verSize(4, 4)),
    );
  }
}
