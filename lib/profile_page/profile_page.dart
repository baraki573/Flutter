import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:museum_app/SizeConfig.dart';

class Profile extends StatefulWidget {
  Profile({Key key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

enum InfoType { fav, badge, stat }

class _ProfileState extends State<Profile> {
  InfoType _type = InfoType.fav;

  Widget _topInfo() {
    var username = "Maria123_HD";
    var profileImg = AssetImage('assets/images/profile_test.png');
    return Container(
      height: SizeConfig.safeBlockVertical *
          (SizeConfig.orientationDevice == Orientation.portrait ? 30 : 45),
      child: Stack(
        alignment: Alignment.centerLeft,
        children: <Widget>[
          // Picture, Nickname
          Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16),
                height: 120,
                width: 120,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 2),
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(80.0)),
                  image: DecorationImage(
                    image: profileImg,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Container(
                //alignment: Alignment.center,
                //padding: EdgeInsets.only(left: 50),
                child: Text(
                  username,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
              ),
            ],
          ),
          // Option Button
          Positioned(
            right: SizeConfig.blockSizeHorizontal * 2,
            top: SizeConfig.blockSizeVertical * 2,
            child: IconButton(
              //padding: EdgeInsets.all(1.0),
              onPressed: () {
                print("Options");
              },
              iconSize: 35,
              icon: Icon(Icons.settings),
            ),
          ),
        ],
      ),
    );
  }

  Widget _customButtons(String text, InfoType type) {
    var selected = _type == type;
    return FlatButton(
      textColor: Colors.black,
      disabledTextColor: Colors.green,
      splashColor: Colors.greenAccent,
      child: Text(text),
      onPressed: (selected
          ? null
          : () => setState(() {
                _type = type;
              })),
    );
  }

  Widget _bottomInfo() {
    return Container(
      //height: SizeConfig.safeBlockVertical * 100,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
      ),
      child: Column(
        children: <Widget>[
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: <Widget>[
              _customButtons("Favoriten", InfoType.fav),
              _customButtons("Erfolge", InfoType.badge),
              _customButtons("Statistik", InfoType.stat),
            ],
          ),
          (_type == InfoType.fav
              ? FavWidget()
              : (_type == InfoType.badge ? BadgeWidget() : StatWidget())),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return ListView(
      children: <Widget>[
        _topInfo(),
        _bottomInfo(),
      ],
    );
  }
}

class FavWidget extends StatelessWidget {
  Widget _getAbteilung(String name, Color color, List<ImageProvider> content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // Headline
        Container(
          padding: EdgeInsets.only(left: 20),
          child: Text(
            name,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 17,
            ),
          ),
        ),
        // Horizontal Scrollable
        Container(
          padding: EdgeInsets.only(bottom: 20.0, top: 2.0),
          height: SizeConfig.safeBlockVertical *
              (SizeConfig.orientationDevice == Orientation.portrait ? 21 : 40),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: content.length,
            itemBuilder: (context, index) {
              // One "bubble"
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 5.0),
                child: FlatButton(
                  padding: EdgeInsets.symmetric(vertical: 0.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(80.0),
                    //side: BorderSide(color: Colors.red)
                  ),
                  onPressed: () {
                    print("$name: $index");
                  },
                  child: Container(
                    //padding: EdgeInsets.symmetric(vertical: 5.0),
                    alignment: Alignment.center,
                    width: SizeConfig.safeBlockHorizontal *
                        (SizeConfig.orientationDevice == Orientation.portrait
                            ? 27
                            : 15),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(80.0)),
                      image: DecorationImage(
                        image: content[index],
                        fit: BoxFit.fill,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: color.withOpacity(0.8),
                          spreadRadius: 1,
                          blurRadius: 1,
                          offset: Offset.fromDirection(pi / 4, 4.0),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _getAbteilung("Zoologisch", Colors.red, [
          AssetImage('assets/images/profile_test.png'),
          AssetImage('assets/images/profile_test2.png'),
          AssetImage('assets/images/profile_test2.png'),
          AssetImage('assets/images/profile_test.png')
        ]),
        _getAbteilung("Skulpturen", Colors.blue, [
          AssetImage('assets/images/profile_test.png'),
          AssetImage('assets/images/profile_test.png')
        ]),
        _getAbteilung("Bilder", Colors.amber, [
          AssetImage('assets/images/profile_test.png'),
          AssetImage('assets/images/profile_test2.png'),
          AssetImage('assets/images/profile_test.png'),
          AssetImage('assets/images/profile_test.png'),
          AssetImage('assets/images/profile_test2.png'),
          AssetImage('assets/images/profile_test.png'),
          AssetImage('assets/images/profile_test.png'),
          AssetImage('assets/images/profile_test2.png'),
          AssetImage('assets/images/profile_test.png'),
          AssetImage('assets/images/profile_test2.png')
        ]),
        _getAbteilung("Bonus", Colors.deepPurple, [AssetImage('assets/images/haupthalle_hlm_blue.png')])
      ],
    );
  }
}

class BadgeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: SizeConfig.safeBlockVertical*(SizeConfig.orientationDevice==Orientation.portrait? 50:65),
        child: GridView.count(
          crossAxisCount: 2,
          children: List.generate(
            100,
            (index) {
              return Container(
                margin: EdgeInsets.all(2.0),
                color: Colors.red,
                width: 2,
                child: Text("llj"),
              );
            },
          ),
        ),
    );
  }
}

class StatWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Text(
          "Rundgänge: 5",
          style: TextStyle(fontSize: 20),
        ),
        Text(
          "Rundgänge: 5",
          style: TextStyle(fontSize: 20),
        ),
        Text(
          "Rundgänge: 5",
          style: TextStyle(fontSize: 20),
        ),
        Text(
          "Rundgänge: 5",
          style: TextStyle(fontSize: 20),
        ),
        Text(
          "Rundgänge: 5",
          style: TextStyle(fontSize: 20),
        ),
        Text(
          "Rundgänge: 5",
          style: TextStyle(fontSize: 20),
        ),
      ],
    );
  }
}
