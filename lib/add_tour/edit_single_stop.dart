import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:museum_app/database/database.dart';
import 'package:museum_app/tours_page/walk_tour/walk_tour_content.dart';
import 'package:museum_app/tours_page/walk_tour/walk_tour_extras.dart';
import 'package:popup_menu/popup_menu.dart';
import 'package:reorderables/reorderables.dart';

import '../SizeConfig.dart';

class EditSingleStop extends StatefulWidget {
  final ActualStop stop;

  EditSingleStop(this.stop, {Key key}) : super(key: key);

  @override
  _EditSingleStopState createState() => _EditSingleStopState();
}

class _EditSingleStopState extends State<EditSingleStop> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    //print("SingleStop: "+widget.stop.stop.name);
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          SafeArea(
            bottom: false,
            left: false,
            right: false,
            child: Container(
              color: Colors.orange,
              height: verSize(17, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(
                          left: horSize(16, 4, left: true),
                          top: verSize(-1, 2, top: true)),
                      //alignment: Alignment.center,
                      child: Text("Zurück zur Stationsübersicht"),
                    ),
                  ),
                  _selecter(),
                ],
              ),
            ),
          ),
          Expanded(
            child: Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _maker(),
                _sideBar(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _selecter() {
    return Container(
        color: Colors.white,
        child: StreamBuilder(
          stream: MuseumDatabase.get().getStops(),
          builder: (context, snap) {
            List<Stop> list = snap.data ?? List<Stop>();
            /*if (widget.stop.stop == null && list.isNotEmpty) {
              widget.stop.stop = list[0];
              widget.stop.features = StopFeature(
                id_tour: null,
                id_stop: list[0].id,
                showImages: true,
                showText: true,
                showDetails: true,
              );
            }*/
            return DropdownButton(
              isExpanded: true,
              hint: Text("  " + (widget.stop.stop?.name) ?? "Auswählen"),
              items: list
                  .map((stop) =>
                      DropdownMenuItem(child: Text(stop.name), value: stop))
                  .toList(),
              onChanged: (value) => setState(() {
                widget.stop.stop = value;
                widget.stop.features = StopFeature(
                  id_tour: null,
                  id_stop: value.id,
                  showImages: !widget.stop.isCustom(),
                  showText: true,
                  showDetails: !widget.stop.isCustom(),
                );
              }),
            );
          },
        ));
  }

  // right-hand sidebar
  Widget _sideBar() {
    return Container(
      color: Colors.orange,
      width: horSize(19, 20),
      //height: verSize(80, 90),
      alignment: Alignment.topCenter,
      child: ListView(
        padding: EdgeInsets.only(top: 10),
        //buttonMinWidth: horSize(15, 20),
        //buttonHeight: 15,//verSize(1, 15),
        children: [
          _objectLabel([
            _withLabel(Icons.photo_camera, "Fotos",
                funct: widget.stop.isCustom()
                    ? null
                    : () => setState(() {
                          if (widget.stop.features == null) return;
                          var showImgs = widget.stop.features.showImages;
                          widget.stop.features = widget.stop.features
                              .copyWith(showImages: !showImgs);
                        }),
                cross: !widget.stop.isCustom() &&
                    !widget.stop.features.showImages),
            _withLabel(FontAwesomeIcons.fileAlt, "Text",
                funct: widget.stop.isCustom()
                    ? null
                    : () => setState(() {
                          if (widget.stop.features == null) return;
                          var showText = widget.stop.features.showText;
                          widget.stop.features = widget.stop.features
                              .copyWith(showText: !showText);
                        }),
                cross:
                    !widget.stop.isCustom() && !widget.stop.features.showText),
            _withLabel(
              FontAwesomeIcons.table,
              "Details",
              funct: widget.stop.isCustom()
                  ? null
                  : () => setState(() {
                        if (widget.stop.features == null) return;
                        var showDetails = widget.stop.features.showDetails;
                        widget.stop.features = widget.stop.features
                            .copyWith(showDetails: !showDetails);
                      }),
              cross:
                  !widget.stop.isCustom() && !widget.stop.features.showDetails,
            ),
          ]),
          _withLabel(Icons.text_fields, "Textfeld",
              funct: () => setState(() => widget.stop.extras.add(ActualExtra(
                  ExtraType.TEXT,
                  text: "ICH füge hier Sachen ein")))),
          // TODO pop up for task type
          _withLabel(
            Icons.playlist_add,
            "Aufgabe",
            funct: _onTap,
            key: key,
          ),
          _withLabel(FontAwesomeIcons.fileImage, "Bild",
              //TODO block for individuell
              funct: widget.stop.isCustom()
                  ? null
                  : () => setState(() => widget.stop.extras.add(ActualExtra(
                      ExtraType.IMAGE,
                      text: widget.stop.stop.images[0])))),
        ],
      ),
    );
  }

  void _onTap() {
    /*setState(() => widget.stop.extras.add(
        ActualExtra(ExtraType.TASK_TEXT,
            text: "HALLO " + DateTime.now().toIso8601String(),
            sel: ["", "TEST", "", "ABBA"])));*/
    PopupMenu m = PopupMenu(
      context: context,
      backgroundColor: Colors.orange[300],
      highlightColor: Colors.orange[400],
      items: [
        MenuItem(
            title: "Text",
            image: Icon(Icons.list),
            textStyle: TextStyle(color: Colors.white)),
        MenuItem(
            title: "Multi",
            image: Icon(Icons.check_box),
            textStyle: TextStyle(color: Colors.white)),
        MenuItem(
            title: "Single",
            image: Icon(Icons.check_circle),
            textStyle: TextStyle(color: Colors.white)),
      ],
      onClickMenu: _onClick,
    );
    m.show(widgetKey: key);
  }

  void _onClick(MenuItemProvider prov) {
    switch (prov.menuTitle) {
      case "Text":
        setState(() => widget.stop.extras.add(
              ActualExtra(
                ExtraType.TASK_TEXT,
                text: "HALLO " + DateTime.now().toIso8601String(),
                sel: ["Antwort"]
              ),
            ));
        break;
      case "Multi":
        setState(() => widget.stop.extras.add(
          ActualExtra(
              ExtraType.TASK_MULTI,
              text: "HALLO " + DateTime.now().toIso8601String(),
              sel: ["Antwort"]
          ),
        ));
        break;
      case "Single":
        setState(() => widget.stop.extras.add(
          ActualExtra(
              ExtraType.TASK_SINGLE,
              text: "HALLO " + DateTime.now().toIso8601String(),
              sel: ["Antwort"]
          ),
        ));
        break;
    }
  }

  GlobalKey key = GlobalKey();

  Widget _objectLabel(widgets, {Color color = Colors.white}) {
    return Column(
      children: [
        Text("Objekt", style: TextStyle(color: color)),
        Stack(
          children: [
            Container(
              margin: EdgeInsets.only(top: 21),
              padding: EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: color, width: 3),
              ),
              child: Column(
                children: widgets,
              ),
            ),
            Positioned(
              top: 1,
              left: 2,
              right: 2,
              child: Icon(FontAwesomeIcons.crown, color: color),
            ),
          ],
        ),
      ],
    );
  }

  Widget _withLabel(IconData i, String t,
      {Color color = Colors.white, funct, cross = false, Key key}) {
    if (funct == null) color = color.withOpacity(.5);
    return GestureDetector(
      key: key,
      onTap: funct,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 3),
        margin: EdgeInsets.symmetric(vertical: 2),
        child: Column(
          children: [
            Stack(
              overflow: Overflow.visible,
              children: [
                Icon(i, color: color),
                Positioned(
                  bottom: -10,
                  right: -10,
                  child: Transform.rotate(
                    angle: pi / 4,
                    child: cross
                        ? Icon(
                            Icons.add,
                            size: 45,
                            color: Colors.red,
                          )
                        : Container(),
                  ),
                )
              ],
            ),
            Text(t, style: TextStyle(color: color))
          ],
        ),
      ),
    );
  }

  Widget _maker() {
    List<ActualExtra> tasks =
        widget.stop.extras.where((e) => e.task != null).toList();
    return Expanded(
      child: Container(
        height: verSize(75, 90),
        color: Colors.orange.withOpacity(0.5),
        child: ReorderableWrap(
          controller: ScrollController(),
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
                (e) => Padding(
                  padding: EdgeInsets.only(left: 16),
                  child: Row(
                    children: [
                      Expanded(
                        child: TourExtra(
                          tasks.indexOf(e) + 1,
                          e,
                          edit: true,
                          //images: e.image ? widget.stop.stop.images : []
                        ),
                      ),
                      Column(
                        children: [
                          Icon(Icons.drag_handle),
                          IconButton(
                              onPressed: () =>
                                  setState(() => widget.stop.extras.remove(e)),
                              icon: Icon(Icons.remove_circle)),
                        ],
                      )
                    ],
                  ),
                ),
              )
              .toList(),
          footer: Container(height: verSize(4, 4)),
        ),
      ),
    );
  }
}
