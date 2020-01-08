import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:photo_view/photo_view.dart';

import '../SizeConfig.dart';

class MapPage extends StatefulWidget {
  MapPage({Key key}) : super(key: key);

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: Colors.white,
          padding: EdgeInsets.only(top: 21, bottom: 16),
          child: PhotoView(
            basePosition: Alignment.center,
            backgroundDecoration: BoxDecoration(color: Colors.white),
            maxScale: 3.0,
            minScale: PhotoViewComputedScale.covered,
            imageProvider: AssetImage("assets/images/orientierungsplan_high.png"),
          ),
        ),
        Positioned(
          top: 35,
          left: 7,
          height: verSize(6, 11),
          width: verSize(6, 11),
          child: FlatButton(
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.black),
                borderRadius: BorderRadius.circular(8),
            ),
            padding: EdgeInsets.all(0),
            color: Colors.white.withOpacity(.5),
            child: Icon(Icons.arrow_back, color: Colors.black, size: 32),
            onPressed: () => Navigator.pop(context),
          ),
        ),
      ],
    );
  }
}
