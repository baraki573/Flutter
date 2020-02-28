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
import 'add_tour.dart';

class CreateTour extends StatefulWidget {
  final void Function() goBack;
  final TourWithStops tour;

  CreateTour(this.goBack, this.tour, {Key key}) : super(key: key);

  @override
  _CreateTourState createState() => _CreateTourState();
}

class _CreateTourState extends State<CreateTour> {
  //List<MyString> list = [MyString("Stop 0")];
  int _index = 0;
  CreateType _type = CreateType.GENERAL;

  //final List<ActualStop> stops = [ActualStop.custom()];

  @override
  void initState() {
    super.initState();
    KeyboardVisibilityNotification().addNewListener(
        onHide: () => FocusScope.of(context).requestFocus(FocusNode()));
  }

  Widget _editMultiStop() {
    var horPad = horSize(25, 32.5);
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          _navigator(),
          _info(),
          Expanded(
            child: Container(
              width: horSize(100, 100),
              child: ReorderableWrap(
                //alignment: WrapAlignment.center,
                //crossAxisAlignment: WrapCrossAlignment.center,
                needsLongPressDraggable: true,
                alignment: WrapAlignment.center,
                //padding: EdgeInsets.only(top: 30, right: horPad, left: horPad),
                buildDraggableFeedback: (contexta, constraints, widget) =>
                    Material(child: widget, color: Colors.transparent),
                //spacing: 50.0,
                maxMainAxisCount: 1,
                onReorder: (int oldIndex, int newIndex) => setState(() {
                  var old = widget.tour.stops[oldIndex];

                  oldIndex += newIndex < oldIndex ? 1 : 0;
                  newIndex += newIndex > oldIndex ? 1 : 0;

                  widget.tour.stops.insert(newIndex, old);
                  widget.tour.stops.removeAt(oldIndex);
                }),
                children: widget.tour.stops.map(_draggable).toList(),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _info() {
    var style = TextStyle(color: Colors.white, fontWeight: FontWeight.bold);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      color: Colors.orange.withOpacity(.5),
      height: verSize(13, 10),
      width: horSize(100, 100),
      child: Wrap(
        alignment: WrapAlignment.center,
        spacing: verSize(1, 1),
        runSpacing: horSize(7, 10),
        direction: Axis.vertical,
        children: [
          Row(children: [
            Icon(Icons.add_circle, color: Colors.white),
            Text(" Station ergänzen", style: style),
          ]),
          Row(children: [
            Icon(Icons.remove_circle, color: Colors.white),
            Text(" Station löschen", style: style),
          ]),
          Row(children: [
            Icon(Icons.touch_app, color: Colors.white),
            Text(" Station bearbeiten\n durch tippen", style: style),
          ]),
          Row(children: [
            Icon(Icons.crop_5_4, color: Colors.white),
            Text(" Reihenfolge ändern\n durch gedrückt halten", style: style),
          ]),
        ],
      ),
    );
  }

  Widget _navigator() {
    var topPad = MediaQuery.of(context).padding.top;

    String tourName = widget.tour.name.text.trim();
    if (tourName.isEmpty) tourName = "NEUE TOUR";
    String tourAuthor = widget.tour.author.trim();
    if (tourAuthor.isEmpty) tourAuthor = "mir";
    return Container(
        padding: EdgeInsets.only(left: 15, right: 15, bottom: 9, top: topPad),
        height: verSize(13, 25) + topPad,
        color: Colors.orange,
        child: Row(
          //mainAxisAlignment: MainAxisAlignment.center,
          //mainAxisSize: MainAxisSize.min,
          children: [
            Container(width: horSize(21, 10)),
            Container(
              //color: Colors.red,
              width: horSize(50, 65),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    tourName,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "von " + tourAuthor,
                    style: TextStyle(
                      fontSize: 15,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
            Spacer(),
            MuseumSettings(),
          ],
        ),

    );
  }

  Widget _draggable(ActualStop elem) {
    return GestureDetector(
      onTap: () => setState(() {
        _index = widget.tour.stops.indexOf(elem);
        _type = CreateType.SINGLE_STOP;
      }),
      child: border(
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: horSize(37, 10),
              height: verSize(17, 20),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 8),
                    height: verSize(7, 5),
                    child: Text(
                      "Station " +
                          (widget.tour.stops.indexOf(elem) + 1).toString(),
                      style: TextStyle(
                        color: Colors.orange,
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                      child: Text(
                    elem.stop?.name ?? "Fehler",
                    style: TextStyle(fontSize: 16),
                  ))
                ],
              ),
            ),
            Container(
              //margin: EdgeInsets.only(left: 25),
              width: horSize(16, 20),
              //color: Colors.green,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                //buttonMinWidth: 50,
                //buttonPadding: EdgeInsets.zero,
                //buttonHeight: 40,
                children: [
                  IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: () => setState(() {
                      var index = widget.tour.stops.indexOf(elem);
                      widget.tour.stops.insert(index + 1, ActualStop.custom());
                    }),
                    icon: Icon(Icons.add_circle),
                    iconSize: 50,
                    color: Colors.orange,
                  ),
                  IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: () => setState(() {
                      if (widget.tour.stops.length > 1)
                        widget.tour.stops.remove(elem);
                      if (_index >= widget.tour.stops.length) _index--;
                    }),
                    icon: Icon(Icons.remove_circle),
                    iconSize: 50,
                    color: Colors.orange,
                  ),
                ],
              ),
            ),
          ],
        ),
        margin: EdgeInsets.symmetric(vertical: 10),
      ),
    );
  }

  Widget _general() {
    return MuseumTabs.single(
      Center(child: Text("JAJAJ")),
      border(
        Column(
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
              buttonPadding: EdgeInsets.all(6),
              alignment: MainAxisAlignment.center,
              buttonHeight: verSize(6.5, 6.5),
              buttonMinWidth: horSize(35, 38),
              children: [
                FlatButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  textColor: Colors.white,
                  color: Colors.orange,
                  onPressed: () {
                    // TODO make input variable
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
                ),
                FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    textColor: Colors.white,
                    color: Colors.orange,
                    onPressed: () =>
                        setState(() => _type = CreateType.MULTI_STOP),
                    child: Text("Stationen festlegen"))
              ],
            ),
          ],
        ),
        margin: EdgeInsets.only(left: 16, right: 16, top: 20, bottom: 7),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    Widget mainWidget;
    switch (_type) {
      case CreateType.GENERAL:
        mainWidget = _general();
        break;
      case CreateType.MULTI_STOP:
        mainWidget = _editMultiStop();
        break;
      case CreateType.SINGLE_STOP:
        mainWidget = _EditSingleStop(widget.tour.stops[_index]);
        break;
    }
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Container(
        height: SizeConfig.safeBlockVertical * 100,
        child: Stack(
          children: [
            mainWidget,
            Positioned(
              left: SizeConfig.blockSizeHorizontal * 2,
              top: SizeConfig.blockSizeVertical * 4,
              child: _backButton(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _backButton() {
    var funct;
    String label = "";
    switch (_type) {
      case CreateType.GENERAL:
        funct = widget.goBack;
        label = "Zur Übersicht";
        break;
      case CreateType.MULTI_STOP:
        funct = () => setState(() => _type = CreateType.GENERAL);
        label = "Zu Tourdaten";
        break;
      case CreateType.SINGLE_STOP:
        funct = () => setState(() => _type = CreateType.MULTI_STOP);
        break;
    }
    return Container(
      width: horSize(25, 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconButton(
            onPressed: funct,
            icon: Icon(Icons.arrow_back),
            iconSize: 30,
          ),
          Text(label),
        ],
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
