import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:museum_app/SizeConfig.dart';
import 'package:museum_app/add_tour/add_tour.dart';
import 'package:museum_app/constants.dart';
import 'package:museum_app/database/database.dart';
import 'package:museum_app/database/modelling.dart';
import 'package:museum_app/tours_page/walk_tour/walk_tour.dart';

class TourList extends StatefulWidget {
  final List<TourWithStops> tours;

  TourList(this.tours, {Key key}) : super(key: key);

  @override
  _TourListState createState() => _TourListState();
}

class _TourListState extends State<TourList> {
  Widget _pictureLeft(ActualStop stop, Size s,
      {margin = const EdgeInsets.all(0)}) {
    return Container(
      margin: margin,
      width: SizeConfig.safeBlockHorizontal * s.width,
      height: SizeConfig.safeBlockVertical * s.height,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        image: DecorationImage(
            image: AssetImage(stop.stop.images.isNotEmpty
                ? stop.stop.images[0]
                : "assets/images/profile_test.png"),
            fit: BoxFit.cover),
      ),
    );
  }

  Widget _infoRight(TourWithStops t) => Expanded(
        //width: horSize(50, 55),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _textBox(
              t.name.text,
              Size(size(50, 80), size(6, 11)),
              margin: EdgeInsets.only(bottom: 3),
              fontSize: 22.0,
              fontWeight: FontWeight.bold,
            ),
            //_tourName(t),
            Text(
              "von " + t.author,
              maxLines: 1,
              style: TextStyle(
                fontStyle: FontStyle.italic,
                fontSize: size(14, 15),
              ),
            ),
            //_tourAuthor(t),
            Container(
              height: verSize(4, 5),
              child: Row(
                children: [
                  t.getRating(
                      color: COLOR_TOUR,
                      color2: Colors.grey,
                      size: horSize(5, 3.5)),
                  //Container(width: horSize(1, 3)),
                  t.buildTime(),
                ],
              ),
            ),
            _textBox(
              t.descr.text,
              Size(size(50, 80), size(7, 18)),
              textAlign: TextAlign.justify,
              fontSize: size(13, 15),
            ),
            //_tourDescr(t),
            //width: verSize(30, 30),
            FlatButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              color: COLOR_TOUR,
              child: Text("Anzeigen ",
                  style:
                      TextStyle(fontSize: size(14, 17), color: Colors.white)),
              onPressed: () => _showTour(t),
            ),
          ],
        ),
      );

  Widget _textBox(String text, Size s,
          {fontStyle = FontStyle.normal,
          fontWeight = FontWeight.normal,
          textAlign = TextAlign.left,
          textColor = Colors.black,
          margin = const EdgeInsets.all(0),
          fontSize = 15.0}) =>
      Container(
        margin: margin,
        width: SizeConfig.safeBlockHorizontal * s.width,
        height: SizeConfig.safeBlockVertical * s.height,
        child: Text(
          text,
          textAlign: textAlign,
          style: TextStyle(
            color: textColor,
            fontSize: fontSize,
            fontWeight: fontWeight,
            fontStyle: fontStyle,
          ),
          overflow: TextOverflow.fade,
        ),
      );

  // TODO move these to the tour class

  Widget _tourButtons(TourWithStops t) => ButtonBar(
        buttonPadding: EdgeInsets.symmetric(horizontal: size(5, 9)),
        alignment: MainAxisAlignment.start,
        buttonMinWidth: horSize(22, 19),
        buttonHeight: verSize(6, 10),
        children: [
          FlatButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            color: Colors.pinkAccent,
            child: Text("Anzeigen", style: TextStyle(fontSize: size(14, 17))),
            onPressed: () => _showTour(t),
          ),
        ],
      );

  Widget _buildTour(TourWithStops t) => Container(
        margin: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(17.0)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.8),
              spreadRadius: 1,
              blurRadius: 2,
              offset: Offset.fromDirection(pi / 2),
            )
          ],
        ),
        child: Row(
          children: [
            _pictureLeft(t.stops[0], Size(31, size(28, 63)),
                margin:
                    EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15)),
            _infoRight(t),
          ],
        ),
      );

  Widget _buildBanner(DateTime time) {
    if (time == null) return Container();
    return Transform.rotate(
      angle: -pi / 4,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 2),
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [COLOR_TOUR.shade200, COLOR_ADD],
              tileMode: TileMode.clamp,
              begin: Alignment.topRight,
              stops: [0.0, 1.0],
              end: Alignment.bottomLeft),
        ),
        //child: _buildTime(time),
      ),
    );
  }

  //TODO schöner machen -> soll animiert sein
  void _showTour(TourWithStops t) {
    //SizeConfig().init(context);
    var tours = widget.tours;
    showGeneralDialog(
      barrierColor: Colors.grey.withOpacity(0.7),
      barrierDismissible: true,
      barrierLabel: '',
      transitionDuration: Duration(milliseconds: 270),
      context: context,
      transitionBuilder: (context, a1, a2, widget) => Transform.scale(
        scale: a1.value,
        child: Opacity(
          opacity: a1.value,
          child: SimpleDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            backgroundColor: COLOR_TOUR,
            contentPadding: EdgeInsets.all(16),
            children: [
              // Picture
              _pictureLeft(
                t.stops[0],
                Size(85, size(30, 55)),
                margin: EdgeInsets.only(bottom: 16),
              ),
              // Titel
              Text(
                t.name.text,
                maxLines: 2,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              // Autor
              Text(
                "von " + t.author,
                maxLines: 1,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontStyle: FontStyle.italic,
                ),
              ),
              // Stars
              Container(
                  margin: EdgeInsets.symmetric(vertical: 3.5),
                  child: Row(children: [
                    t.getRating(
                        color: Colors.white,
                        color2: COLOR_TOUR,
                        size: horSize(7, 3.5)),
                    Container(width: 8),
                    t.buildTime(
                        color: Colors.white, color2: Colors.white, scale: 1.2),
                  ])),

              // Description
              Text(
                t.descr.text,
                textAlign: TextAlign.justify,
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              // Buttons
              ButtonBar(
                alignment: MainAxisAlignment.center,
                buttonPadding: EdgeInsets.all(12),
                //buttonHeight: SizeConfig.safeBlockVertical * 12,
                children: [
                  StreamBuilder(
                      stream: MuseumDatabase.get().getDBTour(t),
                      builder: (context, snap) {
                        var id = snap.data?.id ?? -1;
                        return FlatButton(
                          splashColor: COLOR_TOUR.shade100,
                          color: Colors.white,
                          shape: CircleBorder(
                              side: BorderSide(color: Colors.black)),
                          child: Icon(
                            Icons.file_download,
                            color: Colors.black,
                            size: 31,
                          ),
                          onPressed: () => setState(() {
                            // TODO confirmation dialog
                            if (id != -1) {
                              tours.remove(t);
                              MuseumDatabase.get().removeTour(id);
                              Navigator.pop(context);
                            }
                          }),
                        );
                      }),
                  FlatButton(
                    padding: EdgeInsets.all(9),
                    splashColor: COLOR_TOUR.shade100,
                    color: Colors.white,
                    shape: CircleBorder(side: BorderSide(color: Colors.black)),
                    child: Icon(
                      Icons.play_arrow,
                      color: Colors.black,
                      size: 44,
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TourWalker(tour: t)));
                    },
                  ),
                  FlatButton(
                    splashColor: COLOR_TOUR.shade100,
                    color: Colors.white,
                    shape: CircleBorder(side: BorderSide(color: Colors.black)),
                    child: Icon(
                      Icons.favorite,
                      color: Colors.black,
                      size: 31,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      pageBuilder: (context, animation1, animation2) {},
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    /*StreamBuilder(
      stream: MuseumDatabase.get().getTours(),
    builder: (context, snap) {
        var tours = snap.data ?? List<Tour>();
    },*/
    //UserClass u = getUser();
    //var list = ;
    return Column(
      children: widget.tours
          .map((t) => border(
                Row(
                  children: [
                    _pictureLeft(t.stops[0], Size(30, size(26, 57)),
                        margin: EdgeInsets.only(right: 10)),
                    _infoRight(t),
                  ],
                ),
                margin: EdgeInsets.only(left: 16, right: 16, bottom: 16),
                borderColor: COLOR_TOUR,
              ))
          .toList(),
    );
  }
}
