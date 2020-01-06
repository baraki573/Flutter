import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:photo_view/photo_view.dart';

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
            imageProvider: AssetImage("assets/images/orientierungsplan.png"),
          ),
        ),
        Positioned(
          left: -15,
          top: 30,
          child: FlatButton(
            color: Colors.white,
            shape: CircleBorder(side: BorderSide(color: Colors.black)),
            child: Icon(
              Icons.arrow_back,
              color: Colors.black,
              size: 47,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ],
    );
  }
}
