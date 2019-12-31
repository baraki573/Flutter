import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:museum_app/Models.dart';
import 'package:museum_app/SizeConfig.dart';
import 'package:museum_app/tours_page/tours_page.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class TourList extends StatelessWidget {
  final TourType tt;

  TourList(this.tt);

  Widget _pictureLeft(Tour t) => Container(
        margin: EdgeInsets.only(left: 11, right: 7, top: 15, bottom: 15),
        width: SizeConfig.safeBlockHorizontal * 31,
        height: SizeConfig.safeBlockVertical * size(28, 63),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          image: DecorationImage(image: t.img, fit: BoxFit.cover),
        ),
      );

  Widget _infoRight(Tour t) => Container(
        width: SizeConfig.safeBlockHorizontal * size(51, 55),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _tourName(t),
            // TODO better modelling -> the current one implies that every
            // user has acces to the full profile of authors (maybe store
            // the username instead of th whole user?)
            _tourAuthor(t),
            _tourRating(t),
            _tourDescr(t),
            _tourButtons(t),
          ],
        ),
      );

  Widget _tourName(Tour t) => Container(
        margin: EdgeInsets.only(bottom: 3),
        //color: Colors.red,
        height: SizeConfig.safeBlockVertical * size(6, 11),
        child: Text(
          t.name,
          textAlign: TextAlign.justify,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
          overflow: TextOverflow.fade,
        ),
      );

  Widget _tourAuthor(Tour t) => Text(
        "von " + t.author.username,
        style: TextStyle(
          fontStyle: FontStyle.italic,
          fontSize: size(14, 15),
        ),
      );

  Widget _tourRating(Tour t) => Container(
        margin: EdgeInsets.symmetric(vertical: 3.5),
        child: Row(
          children: [
            RatingBarIndicator(
              rating: min(max(t.rating, 0), 5),
              itemSize: SizeConfig.safeBlockHorizontal * size(4.5, 3.5),
              itemBuilder: (BuildContext context, int index) => Icon(
                Icons.star,
                color: Colors.red,
              ),
              unratedColor: Colors.grey.withAlpha(50),
            ),
          ],
        ),
      );

  Widget _tourDescr(Tour t) => Container(
        height: SizeConfig.safeBlockVertical * size(7, 17),
        child: Text(
          t.description,
          textAlign: TextAlign.justify,
          style: TextStyle(fontSize: size(13, 15)),
          overflow: TextOverflow.fade,
        ),
      );

  Widget _tourButtons(Tour t) => ButtonBar(
        buttonPadding: EdgeInsets.symmetric(horizontal: size(5, 9)),
        alignment: MainAxisAlignment.start,
        buttonMinWidth: SizeConfig.safeBlockHorizontal * size(22, 19),
        buttonHeight: SizeConfig.safeBlockVertical * size(6, 10),
        children: [
          FlatButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            color: Colors.red,
            child: Text("Anzeigen", style: TextStyle(fontSize: size(14, 17))),
            onPressed: () {},
          ),
          (t.author.username == getUser().username
              ? FlatButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  color: Colors.red,
                  child: Text("Bearbeiten", style: TextStyle(fontSize: size(14, 17))),
                  onPressed: () {},
                )
              : Container()),
        ],
      );

  Widget _buildTour(Tour t) => Container(
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
                _pictureLeft(t),
                _infoRight(t),
              ],
            ),
            Positioned(
              bottom: 20,
              right: -38,
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
        color: Colors.green,
        child: _buildTime(time),
      ),
    );
  }

  Widget _buildTime(DateTime time) {
    var dur = time.difference(DateTime.now());
    print(DateTime.now().toString());
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
          color: Colors.red,
          size: size(22, 25),
        ),
        Container(
          margin: EdgeInsets.only(left: 6),
          width: 48,
          child: Text(
            s,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: size(13, 15), fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    User u = getUser();
    var list = u.tours
        // Filter Tours according to set TourType
        .where((t) => (tt == TourType.my
            ? t.author == u
            : (tt == TourType.fav ? t.author != u : true)))
        // Build every Tour-Widget
        .map(_buildTour)
        .toList();

    return Column(
      children: list +
          [
            Container(
                height: SizeConfig.safeBlockVertical *
                    (list.length < 2 &&
                            SizeConfig.orientationDevice == Orientation.portrait
                        ? 12.5
                        : 0)),
          ],
    );
  }
}
