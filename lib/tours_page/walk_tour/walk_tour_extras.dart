import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:museum_app/SizeConfig.dart';
import 'package:museum_app/database/modelling.dart';
import 'package:museum_app/image_carousel.dart';

import '../../constants.dart';

class TourExtra extends StatefulWidget {
  final int index;
  final ActualExtra extra;
  final bool edit;
  final bool result;

  TourExtra(this.index, this.extra,
      {this.edit = false, this.result = false, Key key})
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
        padding: EdgeInsets.symmetric(vertical: 8), child: _makeExtra());
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
                border: Border.all(color: COLOR_TOUR, width: 2.2)),
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
                    ? TextField(
                        controller: widget.extra.textInfo,
                        minLines: 1,
                        maxLines: 5,
                        maxLength: TextField.noMaxLength,
                        style: TextStyle(fontSize: 20.0),
                      )
                    : Text(
                        widget.extra.textInfo.text +
                            (widget.extra.task?.correct)?.toString(),
                        style: TextStyle(fontSize: 20.0),
                      ),
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
          ? TextField(
              decoration: InputDecoration(labelText: "Freies Textfeld"),
              controller: widget.extra.textInfo,
              minLines: 1,
              maxLines: 10,
              maxLength: TextField.noMaxLength,
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
        return Column(
          children: [
            Table(
              //width: horSize(80, 100),
              //padding: EdgeInsets.only(left: 7, right: 4),
              //decoration: BoxDecoration(border: Border.all(color: Colors.black)),
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              columnWidths: {0: FixedColumnWidth(horSize(30, 20))},
              border: TableBorder.all(
                  color:
                      t.entries.isNotEmpty ? Colors.black : Colors.transparent),
              children: t.entries
                  .map(
                    (e) => TableRow(
                      //fit: FlexFit.loose,
                      children: [
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 7, vertical: 6),
                          alignment: Alignment.center,
                          child: widget.edit
                              ? TextField(
                                  controller: e.valA,
                                  minLines: 1,
                                  maxLines: 5,
                                  maxLength: 70,
                                  decoration:
                                      InputDecoration(hintText: "Label"),
                                )
                              : Text(e.valA.text),
                        ),
                        Container(
                          alignment: Alignment.center,
                          child: !widget.result
                              ? TextField(
                                  controller: e.valB,
                                  minLines: 1,
                                  maxLines: 10,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    prefixIcon: Icon(Icons.create),
                                    hintText: "....",
                                  ),
                                )
                              : Text(e.valB.text),
                        ),
                      ],
                    ),
                  )
                  .toList(),
            ),
            widget.edit ? _addLine(t, TextEditingController()) : Container(),
          ],
        );
      case ExtraType.TASK_MULTI:
        return Column(
          children: List<Widget>() +
              t.entries.map((e) {
                int id = t.entries.indexOf(e);
                return CheckboxListTile(
                  value: e.valB,
                  onChanged: widget.result
                      ? null
                      : (newVal) => setState(() => e.valB = newVal),
                  title: widget.edit
                      ? TextField(
                          controller: e.valA,
                          minLines: 1,
                          maxLines: 3,
                          maxLength: 70,
                          decoration: InputDecoration(hintText: "Label"),
                        )
                      : Row(children: [
                          Expanded(child: Text(e.valA.text)),
                          widget.result
                              ? Padding(padding: EdgeInsets.only(left: 5), child: Icon(t.isCorrect(id) ? Icons.check : Icons.stop))
                              : Container()
                        ]),
                );
              }).toList() +
              [widget.edit ? _addLine(t, false) : Container()],
        );
      case ExtraType.TASK_SINGLE:
        return Column(
          children: List<Widget>() +
              t.entries.map((e) {
                int id = t.entries.indexOf(e);
                return RadioListTile(
                  value: id,
                  onChanged: widget.result
                      ? null
                      : (newVal) => setState(() => t.selected = id),
                  title: widget.edit
                      ? TextField(
                          controller: e.valA,
                          minLines: 1,
                          maxLines: 3,
                          maxLength: 70,
                          decoration: InputDecoration(hintText: "Label"),
                        )
                      : Row(children: [
                          widget.result
                              ? Padding(padding: EdgeInsets.only(right: 5), child: Icon(t.isCorrect(id) ? Icons.check : Icons.stop))
                              : Container(),
                    Expanded(child: Text(e.valA.text)),
                        ]),
                  groupValue: t.selected,
                );
              }).toList() +
              [widget.edit ? _addLine(t, false) : Container()],
        );
      default:
        return Container();
    }
  }

  Widget _addLine(ActualTask t, toAdd) {
    return Wrap(
      spacing: 10,
      crossAxisAlignment: WrapCrossAlignment.center,
      //alignment: MainAxisAlignment.spaceEvenly,
      //buttonMinWidth: horSize(20, 20),
      children: [
        Padding(
          padding: EdgeInsets.only(top: 8),
          child: Text(
            "Antworteinstellungen:",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
          ),
        ),
        FlatButton(
          color: COLOR_ADD,
          //borderSide: BorderSide(color: Colors.orange),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          onPressed: () => setState(() => t.addLabel("Antwort", toAdd)),
          child: Text("Hinzufügen", style: TextStyle(color: Colors.white)),
        ),
        FlatButton(
          color: COLOR_ADD,
          //borderSide: BorderSide(color: Colors.orange),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          onPressed: () => setState(() => t.removeLast()),
          child: Text("Entfernen", style: TextStyle(color: Colors.white)),
        )
      ],
    );
  }
}
