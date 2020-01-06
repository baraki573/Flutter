import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:museum_app/Models.dart';
import 'package:museum_app/SizeConfig.dart';

class TourWalker extends StatefulWidget {
  final Tour tour;

  TourWalker({Key key, this.tour}) : super(key: key);

  @override
  _TourWalkerState createState() => _TourWalkerState();
}

class _TourWalkerState extends State<TourWalker> {
  int index = 0;

  Widget _navigator() {
    int length = widget.tour.stops.length;
    return Container(
      decoration: BoxDecoration(
          color: Colors.blue, border: Border.all(color: Colors.black)),
      padding: EdgeInsets.only(top: 21),
      width: SizeConfig.safeBlockHorizontal * 100,
      height: SizeConfig.safeBlockVertical * size(18, 32.5),
      child: Stack(
        children: [
          // Back Arrow
          Positioned(
            top: 7,
            left: 2,
            child: FlatButton(
                onPressed: index == 0 ? null : () => setState(() => index--),
                child: Icon(
                  Icons.arrow_back,
                  size: 30,
                )),
          ),
          // Index Display
          Positioned(
            top: 20,
            left: SizeConfig.safeBlockHorizontal * 25,
            right: SizeConfig.safeBlockHorizontal * 25,
            child: Container(
              //width: SizeConfig.safeBlockHorizontal * 40,
              //color: Colors.red,
              child: Text(
                (index + 1).toString() + " / " + length.toString(),
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
          // Forward Arrow
          Positioned(
            top: 7,
            right: 2,
            child: FlatButton(
                onPressed:
                    index == length - 1 ? null : () => setState(() => index++),
                child: Icon(
                  Icons.arrow_forward,
                  size: 30,
                )),
          ),
          // Tour Name
          Positioned(
            top: 49,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              width: SizeConfig.safeBlockHorizontal * 100,
              height: SizeConfig.safeBlockVertical * size(3, 5),
              child: Text(
                widget.tour.name,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          // Author Name
          Positioned(
            top: 67,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              width: SizeConfig.safeBlockHorizontal * 100,
              height: SizeConfig.safeBlockVertical * size(3, 5),
              child: Text(
                "von " + widget.tour.author,
                style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _content() {
    Item item = widget.tour.stops[index];
    return Container(
      height: SizeConfig.safeBlockVertical * size(86, 75),
      color: Colors.red,
      child: ListView(
        children: [],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.red,
      body: Column(
        children: [
          _navigator(),
          _content(),
        ],
      ),
    );
  }
}
