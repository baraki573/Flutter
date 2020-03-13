import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:museum_app/SizeConfig.dart';
import 'package:museum_app/database/database.dart';
import 'package:museum_app/image_carousel.dart';

class TourExtra extends StatefulWidget {
  final int index;
  final ActualExtra extra;
  final edit;

  TourExtra(this.index, this.extra, {this.edit = false, Key key})
      : super(key: key);

  @override
  _TourExtraState createState() => _TourExtraState();
}

class _TourExtraState extends State<TourExtra> {
  /*@override
  void initState() {
    super.initState();
    KeyboardVisibilityNotification().addNewListener(
        onHide: () => FocusScope.of(context).requestFocus(FocusNode()));
  }*/

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
        child: _makeExtra()
    );
  }

  Widget _makeExtra() {
    if (widget.extra.task != null)
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Pink Box
          Container(
            margin: EdgeInsets.only(bottom: 16),
            padding: EdgeInsets.symmetric(horizontal: 13, vertical: 8),
            width: horSize(100, 100),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(18)),
                border: Border.all(color: Colors.pink, width: 2.2)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Aufgabe " + widget.index.toString() + ":",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
                widget.edit
                    ? TextFormField(
                  controller: widget.extra.textInfo,
                  minLines: 1,
                  maxLines: 10,
                  style: TextStyle(fontSize: 20.0),
                )
                    : Text(widget.extra.textInfo.text,
                    style: TextStyle(fontSize: 20.0)),
              ],
            ),
          ),
          // Text Form
          _makeAnswers(widget.extra.type, widget.extra.task),
        ],
      );
    if (widget.extra.type == ExtraType.IMAGE)
      return ImageCaroussel.fromStrings(widget.extra.textInfo.text.split(";"));
    return Container(
        child: widget.edit
            ? TextFormField(
          decoration: InputDecoration(labelText: "Freies Textfeld"),
          controller: widget.extra.textInfo,
          minLines: 1,
          maxLines: 10,
          style: TextStyle(fontSize: 18),
        )
            : Text(
          widget.extra.textInfo.text,
          textAlign: TextAlign.justify,
          style: TextStyle(fontSize: 18),
        ),
      );
  }

  Widget _makeAnswers(ExtraType type, ActualTask t) {
    switch (type) {
      case ExtraType.TASK_TEXT:
        //TODO no labels -> no table
        return Column(children: [
          Container(
              width: horSize(80, 100),
              //padding: EdgeInsets.only(left: 7, right: 4),
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.black)),
              child: Table(
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  columnWidths: {0: FixedColumnWidth(90)},
                  border: TableBorder.all(color: Colors.black),
                  children: t.entries
                      .map((e) => TableRow(
                            //fit: FlexFit.loose,
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 5),
                                      alignment: Alignment.center,
                                      //decoration: BoxDecoration(border: Border.all(color: Colors.black)),
                                      //padding: EdgeInsets.only(right: 5),
                                      child: widget.edit
                                          ? TextField(
                                        controller: e.key,
                                        minLines: 1,
                                        maxLines: 5,
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          //icon: Icon(Icons.create),
                                          hintText: "Label",
                                        ),
                                      )
                                          : Text(e.key.text),
                                    ),
                              TextField(
                                //focusNode: node,
                                //onTap: () => FocusScope.of(context).requestFocus(node),
                                //onEditingComplete: () {if (FocusScope.of(context)==node) node.unfocus();},
                                //textInputAction: TextInputAction.done,
                                controller: e.value,
                                minLines: 1,
                                maxLines: 10,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  icon: Icon(Icons.create),
                                  //labelText: "....",
                                  hintText: "....",
                                ),
                              ),
                            ],
                          ))
                      .toList())),
          widget.edit
              ? ButtonBar(
            children: [
              FlatButton(
                onPressed: () => setState(() => t.addLabel("HH")),
                child: Text("Hinzu"),
              ),
              FlatButton(
                onPressed: () => setState(() => t.removeLast()),
                child: Text("Weg"),
              )
            ],
          )
              : Container(),
        ]);
      default:
        return Container();
    }
  }
}
