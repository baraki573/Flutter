import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:museum_app/onboarding/onboarding.dart';

import '../SizeConfig.dart';

class museum_page extends StatefulWidget {
  museum_page({Key key}) : super(key: key);

  @override
  _museum_pageState createState() => _museum_pageState();
}

class _museum_pageState extends State<museum_page> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          alignment: Alignment.center,
          child: SafeArea(
            bottom: false,
            child: Image.asset("assets/images/haupthalle_enthuellung_museum.jpg")),
        )
      ]
    );
  }
}