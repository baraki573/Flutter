import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:museum_app/constants.dart';
import 'package:museum_app/database/database.dart';
import 'package:museum_app/database/modelling.dart';
import 'package:museum_app/map/map_page.dart';
import 'package:museum_app/museum_tabs.dart';
import 'package:museum_app/tours_page/tours_widgets.dart';

import '../SizeConfig.dart';

class Tours extends StatefulWidget {
  Tours({Key key}) : super(key: key);

  @override
  _ToursState createState() => _ToursState();
}

enum TourType { all, my, fav }

class _ToursState extends State<Tours> {
  Widget _topInfo() {
    return Center(
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/product_tour.png')),
            ),
          ),
          Positioned(
            left: SizeConfig.blockSizeHorizontal * 2,
            top: SizeConfig.blockSizeVertical * 2,
            child: FlatButton(
              padding: EdgeInsets.all(3),
              shape: CircleBorder(),
              child: Icon(
                Icons.map,
                color: Colors.white,
                size: 40,
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MapPage()));
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _bottomInfo(funct) {
    return StreamBuilder(
        stream: MuseumDatabase.get().watchUser(),
        builder: (context, snapU) {
          var username =
              (snapU.data ?? User(username: "", imgPath: "")).username;
          return StreamBuilder(
              stream: MuseumDatabase.get().getTourStops(),
              builder: (context, snapTs) {
                var tours = snapTs.data ?? List<TourWithStops>();
                tours = tours.where(funct(username)).toList();
                return TourList(tours);
              });
        });
  }

  @override
  Widget build(BuildContext context) {
    return MuseumTabs(
        _topInfo(),
      {
        // All tours
        "Alle": _bottomInfo((_) => (tour) => true),
        // Only the created ones
        "Eigene": _bottomInfo((username) => (tour) => tour.tour.author == username),
        // The rest
        "Favoriten": _bottomInfo((username) => (tour) => tour.tour.author != username),
      },
        color: COLOR_TOUR,
    );
  }
}
