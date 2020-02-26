import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EditTour extends StatefulWidget {
  final void Function() f;

  EditTour(this.f, {Key key}) : super(key: key);

  @override
  _EditTourState createState() => _EditTourState();
}

class _EditTourState extends State<EditTour> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 30),
      child: FlatButton(
        onPressed: widget.f,
        child: Text("GO BACK"),
      ),
    );
  }
}
