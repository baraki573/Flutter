import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'package:museum_app/database/database.dart';
import 'package:museum_app/museum_tabs.dart';
import 'package:museum_app/tours_page/walk_tour/walk_tour_content.dart';
import 'package:museum_app/tours_page/walk_tour/walk_tour_extras.dart';
import 'package:reorderables/reorderables.dart';

import '../SizeConfig.dart';

class CreateTour extends StatefulWidget {
  final void Function() goBack;
  final TourWithStops tour;

  CreateTour(this.goBack, this.tour, {Key key}) : super(key: key);

  @override
  _CreateTourState createState() => _CreateTourState();
}

class _CreateTourState extends State<CreateTour> {
  //List<MyString> list = [MyString("Stop 0")];
  int index = 0;
  CreateType _type = CreateType.GENERAL;

  //final List<ActualStop> stops = [ActualStop.custom()];

  @override
  void initState() {
    super.initState();
    KeyboardVisibilityNotification().addNewListener(
        onHide: () => FocusScope.of(context).requestFocus(FocusNode()));
  }

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
        var old = widget.tour.stops[oldIndex];

        oldIndex += newIndex < oldIndex ? 1 : 0;
        newIndex += newIndex > oldIndex ? 1 : 0;

        widget.tour.stops.insert(newIndex, old);
        widget.tour.stops.removeAt(oldIndex);
      }),
      children: widget.tour.stops
          .map((elem) => GestureDetector(
                onTap: () => setState(() {
                  index = widget.tour.stops.indexOf(elem);
                  _type = CreateType.SINGLE_STOP;
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
                                      var index =
                                          widget.tour.stops.indexOf(elem);
                                      widget.tour.stops.insert(
                                          index + 1, ActualStop.custom());
                                    }),
                                child: Icon(Icons.add_circle)),
                            FlatButton(
                                color: Colors.red,
                                onPressed: () => setState(() {
                                      if (widget.tour.stops.length > 1)
                                        widget.tour.stops.remove(elem);
                                      if (index >= widget.tour.stops.length)
                                        index--;
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

  Widget _foo() {
    return MuseumTabs(Center(child: Text("JAJAJ")), [
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          border: Border.all(color: Colors.orange),
        ),
        margin: EdgeInsets.only(left: 16, right: 16, top: 20),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: widget.tour.name,
              decoration: InputDecoration(
                suffixIcon: Icon(Icons.border_color),
                labelText: "Tournamen festlegen",
                border: InputBorder.none,
              ),
            ),
            Text("Schwierigkeitsgrad bestimmen:"),
            RatingBar(
              initialRating: widget.tour.difficulty,
              minRating: 1,
              allowHalfRating: true,
              onRatingUpdate: (r) => widget.tour.difficulty = r,
              itemBuilder: (context, _) => Icon(Icons.school),
              tapOnlyMode: true,
              itemSize: 33,
            ),
            Text("Eine kurze Beschreibung verfassen:"),
            Container(
              margin: EdgeInsets.only(top: 5),
              height: verSize(18, 10),
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.black)),
              padding: EdgeInsets.symmetric(horizontal: 13),
              child: TextFormField(
                expands: true,
                minLines: null,
                maxLines: null,
                decoration: InputDecoration(
                  border: InputBorder.none,
                ),
                controller: widget.tour.descr,
              ),
            ),
            ButtonBar(
              alignment: MainAxisAlignment.center,
              buttonHeight: verSize(6.5, 6.5),
              buttonMinWidth: horSize(35, 38),
              children: [
                StreamBuilder(
                    stream: MuseumDatabase.get().getUser(),
                    builder: (context, snap) {
                      String username = snap.data?.username;
                      return FlatButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        textColor: Colors.white,
                        color: Colors.orange,
                        onPressed: () {
                          // TODO make input variable
                          widget.tour.author = username;
                          widget.tour.creationTime = DateTime.now();
                          for (var s in widget.tour.stops)
                            for (var e in s.extras)
                              if (e is ActualTask) {
                                //e.descr.text = e.descr.text.trim();
                                e.textInfo.text = e.textInfo.text.trim();
                              }
                          MuseumDatabase.get().writeTourStops(widget.tour);
                          showDialog(
                              context: context,
                              builder: (context) =>
                                  AlertDialog(title: Text("Finish")));
                        },
                        child: Text("Fertigstellen"),
                      );
                    }),
                FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    textColor: Colors.white,
                    color: Colors.orange,
                    onPressed: () =>
                        setState(() => _type = CreateType.MULTI_STOP),
                    child: Text("Stationen wählen"))
              ],
            )
          ],
        ),
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Container(
        height: SizeConfig.safeBlockVertical * 100,
        child: Stack(
          children: [
            _type == CreateType.GENERAL
                ? _foo()
                : (_type == CreateType.MULTI_STOP
                    ? _draggable()
                    : _EditSingleStop(widget.tour.stops[index])),
            Positioned(
              top: 23,
              child: IconButton(
                onPressed: _type == CreateType.GENERAL
                    ? widget.goBack
                    : () => setState(() => _type =
                        (_type == CreateType.MULTI_STOP
                            ? CreateType.GENERAL
                            : CreateType.MULTI_STOP)),
                icon: Icon(Icons.arrow_back),
                iconSize: 30,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

enum CreateType { GENERAL, MULTI_STOP, SINGLE_STOP }

class _EditSingleStop extends StatefulWidget {
  final ActualStop stop;

  _EditSingleStop(this.stop, {Key key}) : super(key: key);

  @override
  _EditSingleStopState createState() => _EditSingleStopState();
}

class _EditSingleStopState extends State<_EditSingleStop> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: Row(
          children: [
            // orange main area
            Container(
              //color: Colors.orange,
              alignment: Alignment.center,
              width: horSize(83, 70),
              height: verSize(100, 100),
              child: ListView(
                children: [
                  Container(height: verSize(5, 5)),
                  StreamBuilder(
                    stream: MuseumDatabase.get().getStops(),
                    builder: (context, snap) {
                      List<Stop> list = snap.data ?? List<Stop>();
                      if (widget.stop.stop == null && list.isNotEmpty) {
                        widget.stop.stop = list[0];
                        widget.stop.features = StopFeature(
                          id_tour: null,
                          id_stop: list[0].id,
                          showImages: true,
                          showText: true,
                          showDetails: true,
                        );
                      }
                      return DropdownButton(
                        isExpanded: true,
                        hint: Text(
                            "  " + (widget.stop.stop?.name) ?? "Auswählen"),
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
            // blue sidebar
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
                    color: widget.stop.features.showImages
                        ? Colors.green
                        : Colors.red,
                    disabledColor: Colors.grey,
                    onPressed: widget.stop.isCustom()
                        ? null
                        : () => setState(() {
                              if (widget.stop.features == null) return;
                              var showImgs = widget.stop.features.showImages;
                              widget.stop.features = widget.stop.features
                                  .copyWith(showImages: !showImgs);
                            }),
                    child: Text("Bilder"),
                    padding: EdgeInsets.all(0),
                  ),
                  FlatButton(
                    color: widget.stop.features.showText
                        ? Colors.green
                        : Colors.red,
                    disabledColor: Colors.grey,
                    onPressed: widget.stop.isCustom()
                        ? null
                        : () => setState(() {
                              if (widget.stop.features == null) return;
                              var showText = widget.stop.features.showText;
                              widget.stop.features = widget.stop.features
                                  .copyWith(showText: !showText);
                            }),
                    child: Text("Text"),
                    padding: EdgeInsets.all(0),
                  ),
                  FlatButton(
                    color: widget.stop.features.showDetails
                        ? Colors.green
                        : Colors.red,
                    disabledColor: Colors.grey,
                    onPressed: widget.stop.isCustom()
                        ? null
                        : () => setState(() {
                              if (widget.stop.features == null) return;
                              var showDetails =
                                  widget.stop.features.showDetails;
                              widget.stop.features = widget.stop.features
                                  .copyWith(showDetails: !showDetails);
                            }),
                    child: Text("Details"),
                    padding: EdgeInsets.all(0),
                  ),
                  IconButton(
                    onPressed: () => setState(() => widget.stop.extras.add(
                        ActualExtra.realTask(
                            "HALLO " + DateTime.now().toIso8601String(),
                            TaskType.TEXT,
                            ["", "TEST", "", "ABBA"]))),
                    icon: Icon(Icons.text_fields),
                  ),
                  IconButton(
                    onPressed: () => setState(() => widget.stop.extras
                        .add(ActualExtra.onlyText("ICH füge hier Sachen ein"))),
                    icon: Icon(Icons.textsms),
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
        showExtras: false,
      ),
      onReorder: (int oldIndex, int newIndex) => setState(() {
        var old = widget.stop.extras[oldIndex];

        oldIndex += newIndex < oldIndex ? 1 : 0;
        newIndex += newIndex > oldIndex ? 1 : 0;

        widget.stop.extras.insert(newIndex, old);
        widget.stop.extras.removeAt(oldIndex);
      }),
      children: widget.stop.extras
          .map(
            (t) => Row(
              children: [
                Expanded(
                    child: extraWidget(widget.stop.extras.indexOf(t) + 1, t,
                        edit: true)),
                Column(
                  children: [
                    Icon(Icons.drag_handle),
                    IconButton(
                        onPressed: () =>
                            setState(() => widget.stop.extras.remove(t)),
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
