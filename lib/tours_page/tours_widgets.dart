import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:museum_app/Models.dart';
import 'package:museum_app/SizeConfig.dart';
import 'package:museum_app/tours_page/tours_page.dart';
import 'package:museum_app/tours_page/walk_tour.dart';

class TourList extends StatefulWidget {
  final TourType tt;

  TourList({Key key, this.tt}) : super(key: key);

  @override
  _TourListState createState() => _TourListState();

}

class _TourListState extends State<TourList> {
  Widget _pictureLeft(Tour t, Size s, {margin = const EdgeInsets.all(0)}) =>
      Container(
        margin: margin,
        width: SizeConfig.safeBlockHorizontal * s.width,
        height: SizeConfig.safeBlockVertical * s.height,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          image: DecorationImage(image: t.stops[0].imgs[0], fit: BoxFit.cover),
        ),
      );

  Widget _infoRight(Tour t) =>
      Container(
        width: horSize(51, 55),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _textBox(
              t.name,
              Size(size(50, 80), size(6, 11)),
              margin: EdgeInsets.only(bottom: 3),
              fontSize: 22.0,
              fontWeight: FontWeight.bold,
            ),
            //_tourName(t),
            // TODO better modelling -> the current one implies that every
            // user has acces to the full profile of authors (maybe store
            // the username instead of th whole user?)
            _textBox(
              "von " + t.author,
              Size(size(50, 80), size(3, 6)),
              fontStyle: FontStyle.italic,
              fontSize: size(14, 15),
            ),
            //_tourAuthor(t),
            _tourRating(t),
            _textBox(
              t.description,
              Size(size(50, 80), size(7, 18)),
              textAlign: TextAlign.justify,
              fontSize: size(13, 15),
            ),
            //_tourDescr(t),
            _tourButtons(t),
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
  Widget _tourRating(Tour t) =>
      Container(
        margin: EdgeInsets.symmetric(vertical: 3.5),
        child: RatingBarIndicator(
          rating: min(max(t.rating, 0), 5),
          itemSize: horSize(4.5, 3.5),
          itemBuilder: (BuildContext context, int index) =>
              Icon(
                Icons.star,
                color: Colors.pinkAccent,
              ),
          unratedColor: Colors.grey.withAlpha(50),
        ),
      );

  Widget _tourButtons(Tour t) =>
      ButtonBar(
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
          (t.author == getUser().username
              ? FlatButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            color: Colors.pinkAccent,
            child: Text("Bearbeiten",
                style: TextStyle(fontSize: size(14, 17))),
            onPressed: () {},
          )
              : Container()),
        ],
      );

  Widget _buildTour(Tour t) =>
      Container(
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
        child: Stack(
          children: [
            Row(
              children: [
                _pictureLeft(t, Size(31, size(28, 63)),
                    margin: EdgeInsets.only(
                        left: 10, right: 10, top: 15, bottom: 15)),
                _infoRight(t),
              ],
            ),
            Positioned(
              bottom: 22,
              right: -40,
              child: _buildBanner(t.ttl),
            ),
          ],
        ),
      );

  Widget _buildBanner(DateTime time) {
    if (time == null || time.isBefore(DateTime.now())) return Container();
    return Transform.rotate(
      angle: -pi / 4,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 2),
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.pink[300], Colors.pink],
              tileMode: TileMode.clamp,
              begin: Alignment.topRight,
              stops: [0.0, 1.0],
              end: Alignment.bottomLeft),
        ),
        child: _buildTime(time),
      ),
    );
  }

  Widget _buildTime(DateTime time) {
    var dur = time.difference(DateTime.now());
    var d = dur.inDays;
    var h = dur.inHours;
    String s = "noch\n" +
        (d != 0
            ? d.toString() + (d > 1 ? " Tage" : "Tag")
            : h.toString() + (h > 1 ? " Stunden" : " Stunde"));
    return Row(
      children: [
        Icon(
          Icons.date_range,
          color: Colors.white,
          size: size(22, 25),
        ),
        Container(
          margin: EdgeInsets.only(left: 6),
          width: 55,
          child: Text(
            s,
            textAlign: TextAlign.center,
            style:
            TextStyle(fontSize: size(12, 14), fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  void _showTour(Tour t) {
    SizeConfig().init(context);
    showGeneralDialog(
      barrierColor: Colors.grey.withOpacity(0.7),
      barrierDismissible: true,
      barrierLabel: '',
      transitionDuration: Duration(milliseconds: 270),
      context: context,
      transitionBuilder: (context, a1, a2, widget) =>
          Transform.scale(
            scale: a1.value,
            child: Opacity(
              opacity: a1.value,
              child: SimpleDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                backgroundColor: Colors.pinkAccent,
                contentPadding: EdgeInsets.all(16),
                children: [
                  // Picture
                  _pictureLeft(
                    t,
                    Size(85, size(30, 55)),
                    margin: EdgeInsets.only(bottom: 16),
                  ),
                  // Titel
                  _textBox(
                    t.name,
                    Size(85, size(10, 12.5)),
                    textColor: Colors.white,
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                  ),
                  // Autor
                  _textBox(
                    "von " + t.author,
                    Size(85, size(5, 7)),
                    textColor: Colors.white,
                    fontSize: 18.0,
                    fontStyle: FontStyle.italic,
                  ),
                  // Duration
                  // Stars
                  RatingBarIndicator(
                    rating: min(max(t.rating, 0), 5),
                    itemSize: horSize(7, 3.5),
                    itemBuilder: (BuildContext context, int index) =>
                        Icon(
                          Icons.star,
                          color: Colors.white,
                        ),
                    unratedColor: Colors.pink[300],
                  ),
                  // Description
                  _textBox(
                    t.description,
                    Size(85, size(15, 28)),
                    textAlign: TextAlign.justify,
                    fontSize: 18.0,
                    textColor: Colors.white,
                    margin: EdgeInsets.only(top: 5),
                  ),
                  // Buttons
                  ButtonBar(
                    alignment: MainAxisAlignment.center,
                    buttonPadding: EdgeInsets.all(12),
                    //buttonHeight: SizeConfig.safeBlockVertical * 12,
                    children: [
                      FlatButton(
                        splashColor: Colors.pink[100],
                        color: Colors.white,
                        shape: CircleBorder(
                            side: BorderSide(color: Colors.black)),
                        child: Icon(
                          Icons.play_arrow,
                          color: Colors.black,
                          size: 31,
                        ),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) => TourWalker(tour: t)));
                        },
                      ),
                      FlatButton(
                        splashColor: Colors.pink[100],
                        color: Colors.white,
                        shape: CircleBorder(
                            side: BorderSide(color: Colors.black)),
                        child: Icon(
                          Icons.remove_red_eye,
                          color: Colors.black,
                          size: 31,
                        ),
                        onPressed: () {},
                      ),
                      FlatButton(
                        splashColor: Colors.pink[100],
                        color: Colors.white,
                        shape: CircleBorder(
                            side: BorderSide(color: Colors.black)),
                        child: Icon(
                          Icons.share,
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
    User u = getUser();
    var list = u.tours
    // Filter Tours according to set TourType
        .where((t) =>
    (widget.tt == TourType.my
        ? t.author == u.username
        : (widget.tt == TourType.fav ? t.author != u.username : true)))
    // Build every Tour-Widget
        .map(_buildTour)
        .toList();

    return Column(
      children: list
+[
            Container(
                height: SizeConfig.safeBlockVertical *
                    (list.length < 2 ? size(11, 0) : 0))
          ],
    );
  }
}
