import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class JoinTour extends StatefulWidget {
  final void Function() f;

  JoinTour(this.f, {Key key}) : super(key: key);

  @override
  _JoinTourState createState() => _JoinTourState();
}

class _JoinTourState extends State<JoinTour> {
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
