import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:museum_app/SizeConfig.dart';
import 'dart:math';
import 'package:museum_app/museum_tabs.dart';
import '../constants.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

var funcSizeHeightPortrait = 29;
var funcSizeWidthPortrait = 42;
var funcSizeHeightLandscape = 30;
var funcSizeWidthLandscape = 10;

var imageSizeHeightPortrait = 20;
var imageSizeWidthPortrait = 38;
var imageSizeHeightLandscape = 10;
var imageSizeWidthLandscape = 30;

enum InfoType { HOME, USAGE, TUTORIALS, ABOUT_MUSEUM, ABOUT_PROJECT }

class _HomeState extends State<Home> {
  InfoType _type = InfoType.HOME;
  void goBack() => setState(() => _type = InfoType.HOME);

  Widget _topInfo1() {
    return Container(
      height: verSize(30, 45),
      child: Center(
        child: Stack(
          children: [
            Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                child: Column(children: <Widget>[
                  Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(bottom: 5.0, top: 15.0),
                      child: SafeArea(
                          bottom: false,
                          child: Text(
                            "Geschichte",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: SizeConfig.orientationDevice ==
                                        Orientation.portrait
                                    ? SizeConfig.safeBlockHorizontal * 13
                                    : SizeConfig.safeBlockHorizontal * 2,
                                fontFamily: "Nunito",
                                // fontWeight: FontWeight.w700,
                                color: Colors.white),
                          ))),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                      children: <Widget>[
                        Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(bottom: 5.0, top: 2.0),
                            child: SafeArea(
                                bottom: false,
                                child: Text(
                                  "Vernetzt",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: SizeConfig.orientationDevice ==
                                              Orientation.portrait
                                          ? SizeConfig.safeBlockHorizontal * 13
                                          : SizeConfig.safeBlockHorizontal * 2,
                                      fontFamily: "Chiller",
                                      // fontWeight: FontWeight.w700,
                                      color: Colors.white),
                                )))
                      ],
                    ),
                  )
                ]))
          ],
        ),
      ),
    );
  }

  Widget _topInfo() {
    return Container(
      height: verSize(30, 45),
      child: Center(
        child: Container(
            margin: EdgeInsets.only(right: 5.0, left: 5.0),
            child: Image.asset('assets/images/HomePage.png',
                width: SizeConfig.orientationDevice == Orientation.portrait
                    ? SizeConfig.safeBlockHorizontal * 80
                    : SizeConfig.safeBlockHorizontal * 50,
                height: SizeConfig.orientationDevice == Orientation.portrait
                    ? SizeConfig.safeBlockVertical * 25
                    : SizeConfig.safeBlockVertical * 50)),
      ),
    );
  }

  Widget _bottomInfo() {
    return Container(
      //height: SizeConfig.safeBlockVertical * 100,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.white, width: 2),
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
      ),
      child: Container(
          child: Stack(children: [
        Column(children: [
          _firstRow(),
          _secondRow(),
        ] //next row should be here
            ),
      ])),
    );
  }

  Widget _firstRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        InkWell(
            child: Container(
                width: SizeConfig.orientationDevice == Orientation.portrait
                    ? SizeConfig.safeBlockHorizontal * funcSizeWidthPortrait
                    : SizeConfig.safeBlockHorizontal * funcSizeWidthLandscape,
                height: SizeConfig.orientationDevice == Orientation.portrait
                    ? SizeConfig.safeBlockVertical * funcSizeHeightPortrait
                    : SizeConfig.safeBlockVertical * funcSizeHeightLandscape,
                margin: EdgeInsets.only(
                    left: 16.0, top: 16.0, bottom: 16, right: 5),
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
                alignment: Alignment.center,
                child: SafeArea(
                    bottom: false,
                    child: Column(
                      children: <Widget>[
                        Container(
                            margin:
                                EdgeInsets.only(right: 5.0, left: 5.0, top: 10),
                            child: Image.asset(
                                'assets/images/Group_2304@3x.png',
                                width: SizeConfig.orientationDevice ==
                                        Orientation.portrait
                                    ? SizeConfig.safeBlockHorizontal * 35
                                    : SizeConfig.safeBlockHorizontal *
                                        imageSizeWidthLandscape,
                                height: SizeConfig.orientationDevice ==
                                        Orientation.portrait
                                    ? SizeConfig.safeBlockVertical * 17
                                    : SizeConfig.safeBlockVertical *
                                        imageSizeHeightLandscape)),
                        Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(bottom: 10.0, top: 5.0),
                            child: SafeArea(
                                bottom: false,
                                child: Text(
                                  "Einführung zur App-Nutzung",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: SizeConfig.orientationDevice ==
                                              Orientation.portrait
                                          ? SizeConfig.safeBlockHorizontal * 5
                                          : SizeConfig.safeBlockHorizontal * 2,
                                      fontFamily: "Nunito",
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xFF1A1A1A)),
                                )))
                      ],
                    ))),
            onTap: () {
              setState(() => _type = InfoType.USAGE);
            }),
        Container(
            width: SizeConfig.orientationDevice == Orientation.portrait
                ? SizeConfig.safeBlockHorizontal * funcSizeWidthPortrait
                : SizeConfig.safeBlockHorizontal * funcSizeWidthLandscape,
            height: SizeConfig.orientationDevice == Orientation.portrait
                ? SizeConfig.safeBlockVertical * funcSizeHeightPortrait
                : SizeConfig.safeBlockVertical * funcSizeHeightLandscape,
            margin:
                EdgeInsets.only(right: 16.0, top: 16.0, bottom: 16, left: 5),
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
            alignment: Alignment.center,
            child: SafeArea(
                bottom: false,
                child: Column(
                  children: <Widget>[
                    Container(
                        margin: EdgeInsets.only(right: 5.0, left: 5.0, top: 10),
                        child: Image.asset('assets/images/Group_2265@3x.png',
                            width: SizeConfig.orientationDevice ==
                                    Orientation.portrait
                                ? SizeConfig.safeBlockHorizontal * 35
                                : SizeConfig.safeBlockHorizontal *
                                    imageSizeWidthLandscape,
                            height: SizeConfig.orientationDevice ==
                                    Orientation.portrait
                                ? SizeConfig.safeBlockVertical * 17
                                : SizeConfig.safeBlockVertical *
                                    imageSizeHeightLandscape)),
                    Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(bottom: 10.0, top: 5.0),
                        child: SafeArea(
                            bottom: false,
                            child: Text(
                              "Methoden und Tutorials",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: SizeConfig.orientationDevice ==
                                          Orientation.portrait
                                      ? SizeConfig.safeBlockHorizontal * 5
                                      : SizeConfig.safeBlockHorizontal * 2,
                                  fontFamily: "Nunito",
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF1A1A1A)),
                            )))
                  ],
                ))),
      ],
    );
  }

  Widget _secondRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
            width: SizeConfig.orientationDevice == Orientation.portrait
                ? SizeConfig.safeBlockHorizontal * funcSizeWidthPortrait
                : SizeConfig.safeBlockHorizontal * funcSizeWidthLandscape,
            height: SizeConfig.orientationDevice == Orientation.portrait
                ? SizeConfig.safeBlockVertical * funcSizeHeightPortrait
                : SizeConfig.safeBlockVertical * funcSizeHeightLandscape,
            margin: EdgeInsets.only(left: 16.0, bottom: 16, right: 5),
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
            alignment: Alignment.center,
            child: SafeArea(
                bottom: false,
                child: Column(
                  children: <Widget>[
                    Container(
                        margin: EdgeInsets.only(right: 5.0, left: 5.0, top: 10),
                        child: Icon(
                          Icons.info,
                          color: Colors.blue,
                          size: 100,
                        )),
                    Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(bottom: 10.0, top: 15.0),
                        child: SafeArea(
                            bottom: false,
                            child: Text(
                              "Über das Landesmuseum",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: SizeConfig.orientationDevice ==
                                          Orientation.portrait
                                      ? SizeConfig.safeBlockHorizontal * 5
                                      : SizeConfig.safeBlockHorizontal * 2,
                                  fontFamily: "Nunito",
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF1A1A1A)),
                            )))
                  ],
                ))),
        Container(
            width: SizeConfig.orientationDevice == Orientation.portrait
                ? SizeConfig.safeBlockHorizontal * funcSizeWidthPortrait
                : SizeConfig.safeBlockHorizontal * funcSizeWidthLandscape,
            height: SizeConfig.orientationDevice == Orientation.portrait
                ? SizeConfig.safeBlockVertical * funcSizeHeightPortrait
                : SizeConfig.safeBlockVertical * funcSizeHeightLandscape,
            margin: EdgeInsets.only(right: 16.0, bottom: 16, left: 5),
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
            alignment: Alignment.center,
            child: SafeArea(
                bottom: false,
                child: Column(
                  children: <Widget>[
                    Container(
                        margin: EdgeInsets.only(right: 5.0, left: 5.0, top: 10),
                        child: Image.asset(
                            'assets/images/undraw_new_ideas_jdea@3x.png',
                            width: SizeConfig.orientationDevice ==
                                    Orientation.portrait
                                ? SizeConfig.safeBlockHorizontal * 35
                                : SizeConfig.safeBlockHorizontal *
                                    imageSizeWidthLandscape,
                            height: SizeConfig.orientationDevice ==
                                    Orientation.portrait
                                ? SizeConfig.safeBlockVertical * 15
                                : SizeConfig.safeBlockVertical *
                                    imageSizeHeightLandscape)),
                    Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(
                          bottom: 10.0,
                          top: 5.0,
                          right: 5.0,
                          left: 5.0,
                        ),
                        child: SafeArea(
                            bottom: false,
                            child: Text(
                              "Über das Projekt geschichte vernetzt",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: SizeConfig.orientationDevice ==
                                          Orientation.portrait
                                      ? SizeConfig.safeBlockHorizontal * 5
                                      : SizeConfig.safeBlockHorizontal * 2,
                                  fontFamily: "Nunito",
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF1A1A1A)),
                            )))
                  ],
                ))),
      ],
    );
  }

  Widget _homePage() {
    return ListView(
      children: <Widget>[
        _topInfo(),
        _bottomInfo(),
      ],
    );
  }

  Widget _usage() {
    return MuseumTabs.single(
        Stack(children: [
          Container(
            height: verSize(30, 45),
            child: Center(
              child: Container(
                  margin: EdgeInsets.only(right: 5.0, left: 5.0),
                  child: Image.asset('assets/images/HomePage.png',
                      width:
                          SizeConfig.orientationDevice == Orientation.portrait
                              ? SizeConfig.safeBlockHorizontal * 80
                              : SizeConfig.safeBlockHorizontal * 50,
                      height:
                          SizeConfig.orientationDevice == Orientation.portrait
                              ? SizeConfig.safeBlockVertical * 25
                              : SizeConfig.safeBlockVertical * 50)),
            ),
          ),
          Positioned(
              left: horSize(2, 2, left: true),
              top: verSize(1, 1),
              child: Container(
                width: horSize(25, 4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: () => setState(() => _type = InfoType.HOME),
                      icon: Icon(Icons.arrow_back),
                      iconSize: 30,
                      color: Colors.white,
                    ),
                  ],
                ),
              )),
        ]),
        Column(
          children: <Widget>[
            _usageRow1(),
            _usageRow2(),
            _usageRow3(),
            _usageRow4(),
            border(
                GestureDetector(
                  onTap: () => print("Video Erklär Tour"),
                  child: Row(
                    //mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: horSize(23, 23),
                        child: Icon(Icons.video_library,
                            color: Colors.red, size: size(60, 74)),
                      ),
                      Container(
                        width: horSize(57, 60),
                        child: Text(
                          "Noch Fragen?\nSchau Dir ein Erklärvideo zur App-Bedienung an!",
                          style: TextStyle(
                            fontSize: SizeConfig.orientationDevice ==
                                    Orientation.portrait
                                ? SizeConfig.safeBlockHorizontal * 5
                                : SizeConfig.safeBlockHorizontal * 2,
                            fontFamily: "Nunito",
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                margin: EdgeInsets.only(left: 16.0, right: 16),
                padding: EdgeInsets.all(15))
          ],
        ),
        showSetting: false);
  }

  Widget _usageRow1() {
    return Container(
        width: SizeConfig.orientationDevice == Orientation.portrait
            ? SizeConfig.safeBlockHorizontal * 100
            : SizeConfig.safeBlockHorizontal * 15,
        height: SizeConfig.orientationDevice == Orientation.portrait
            ? SizeConfig.safeBlockVertical * 26
            : SizeConfig.safeBlockVertical * 13,
        margin: EdgeInsets.only(left: 16.0, right: 16),
        alignment: Alignment.center,
        child: SafeArea(
            bottom: false,
            child: Row(
              children: <Widget>[
                Container(
                  height: verSize(20, 4),
                  width: horSize(25, 4),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/Group_2363@3x.png"),
                    ),
                  ),
                ),
                Container(
                    alignment: Alignment.center,
                    height: verSize(28, 4),
                    width: horSize(50, 4),
                    margin: EdgeInsets.only(left: 5, right: 5),
                    child: SafeArea(
                        bottom: false,
                        child: Text(
                          "Im Home-Bereich gibt es Informationen zur App-Bedienung, dem Museum und dem Projekt \"Geschichte vernetzt\". Methoden und Tutorials für den Museumsbesuch stehen auch bereit.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: SizeConfig.orientationDevice ==
                                      Orientation.portrait
                                  ? SizeConfig.safeBlockHorizontal * 4
                                  : SizeConfig.safeBlockHorizontal * 2,
                              fontFamily: "Nunito",
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF1A1A1A)),
                        ))),
                Container(
                    alignment: Alignment.center,
                    height: verSize(10, 4),
                    width: horSize(10, 4),
                    margin: EdgeInsets.only(left: 5),
                    child: SafeArea(
                        bottom: false,
                        child: Icon(
                          Icons.home,
                          color: COLOR_HOME,
                          size: 30,
                        ))),
              ],
            )));
  }

  Widget _usageRow2() {
    return Container(
        width: SizeConfig.orientationDevice == Orientation.portrait
            ? SizeConfig.safeBlockHorizontal * 100
            : SizeConfig.safeBlockHorizontal * 15,
        height: SizeConfig.orientationDevice == Orientation.portrait
            ? SizeConfig.safeBlockVertical * 26
            : SizeConfig.safeBlockVertical * 13,
        margin: EdgeInsets.only(left: 16.0, right: 16),
        alignment: Alignment.center,
        child: SafeArea(
            bottom: false,
            child: Row(
              children: <Widget>[
                Container(
                  height: verSize(20, 4),
                  width: horSize(25, 4),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/Group_2319@3x.png"),
                    ),
                  ),
                ),
                Container(
                    alignment: Alignment.center,
                    height: verSize(28, 4),
                    width: horSize(50, 4),
                    margin: EdgeInsets.only(left: 5, right: 5),
                    child: SafeArea(
                        bottom: false,
                        child: Text(
                          "Unter Tour gehen kannst Du viele verschiedene Touren durch das Museum abrufen und herunterladen.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: SizeConfig.orientationDevice ==
                                      Orientation.portrait
                                  ? SizeConfig.safeBlockHorizontal * 4
                                  : SizeConfig.safeBlockHorizontal * 2,
                              fontFamily: "Nunito",
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF1A1A1A)),
                        ))),
                Container(
                    alignment: Alignment.center,
                    height: verSize(10, 4),
                    width: horSize(10, 4),
                    margin: EdgeInsets.only(left: 5),
                    child: SafeArea(
                        bottom: false,
                        child: Icon(
                          Icons.flag,
                          color: COLOR_TOUR,
                          size: 30,
                        ))),
              ],
            )));
  }

  Widget _usageRow3() {
    return Container(
        width: SizeConfig.orientationDevice == Orientation.portrait
            ? SizeConfig.safeBlockHorizontal * 100
            : SizeConfig.safeBlockHorizontal * 15,
        height: SizeConfig.orientationDevice == Orientation.portrait
            ? SizeConfig.safeBlockVertical * 26
            : SizeConfig.safeBlockVertical * 13,
        margin: EdgeInsets.only(left: 16.0, right: 16),
        alignment: Alignment.center,
        child: SafeArea(
            bottom: false,
            child: Row(
              children: <Widget>[
                Container(
                  height: verSize(20, 4),
                  width: horSize(25, 4),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/Group_2366@3x.png"),
                    ),
                  ),
                ),
                Container(
                    alignment: Alignment.center,
                    height: verSize(28, 4),
                    width: horSize(50, 4),
                    margin: EdgeInsets.only(left: 5, right: 5),
                    child: SafeArea(
                        bottom: false,
                        child: Text(
                          "Unter Neues Projekt kannst Du eigene Touren erstellen und auf gespeicherte Museumsobjekte zugreifen.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: SizeConfig.orientationDevice ==
                                      Orientation.portrait
                                  ? SizeConfig.safeBlockHorizontal * 4
                                  : SizeConfig.safeBlockHorizontal * 2,
                              fontFamily: "Nunito",
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF1A1A1A)),
                        ))),
                Container(
                    alignment: Alignment.center,
                    height: verSize(10, 4),
                    width: horSize(10, 4),
                    margin: EdgeInsets.only(left: 5),
                    child: SafeArea(
                        bottom: false,
                        child: Icon(
                          Icons.add,
                          color: COLOR_ADD,
                          size: 30,
                        ))),
              ],
            )));
  }

  Widget _usageRow4() {
    return Container(
        width: SizeConfig.orientationDevice == Orientation.portrait
            ? SizeConfig.safeBlockHorizontal * 100
            : SizeConfig.safeBlockHorizontal * 15,
        height: SizeConfig.orientationDevice == Orientation.portrait
            ? SizeConfig.safeBlockVertical * 26
            : SizeConfig.safeBlockVertical * 13,
        margin: EdgeInsets.only(left: 16.0, right: 16),
        alignment: Alignment.center,
        child: SafeArea(
            bottom: false,
            child: Row(
              children: <Widget>[
                Container(
                  height: verSize(20, 4),
                  width: horSize(25, 4),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/Group_2317@3x.png"),
                    ),
                  ),
                ),
                Container(
                    alignment: Alignment.center,
                    height: verSize(28, 4),
                    width: horSize(50, 4),
                    margin: EdgeInsets.only(left: 5, right: 5),
                    child: SafeArea(
                        bottom: false,
                        child: Text(
                          "Unter Deinem Profil kannst Du Favoriten speichern, Statistiken abrufen und Erfolge einsehen.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: SizeConfig.orientationDevice ==
                                      Orientation.portrait
                                  ? SizeConfig.safeBlockHorizontal * 4
                                  : SizeConfig.safeBlockHorizontal * 2,
                              fontFamily: "Nunito",
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF1A1A1A)),
                        ))),
                Container(
                    alignment: Alignment.center,
                    height: verSize(10, 4),
                    width: horSize(10, 4),
                    margin: EdgeInsets.only(left: 5),
                    child: SafeArea(
                        bottom: false,
                        child: Icon(
                          Icons.person_outline,
                          color: COLOR_PROFILE,
                          size: 30,
                        ))),
              ],
            )));
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    switch (_type) {
      case InfoType.USAGE:
        debugPrint("changed");
        return _usage();
      case InfoType.TUTORIALS:
        return Container();
      case InfoType.ABOUT_MUSEUM:
        return Container();
      case InfoType.ABOUT_PROJECT:
        return Container();
      default:
        debugPrint("init");
        return _homePage();
    }
  }
}

Widget border(Widget w,
    {width,
    borderColor = COLOR_HOME,
    height,
    margin,
    padding = const EdgeInsets.all(8)}) {
  return Container(
    width: width,
    height: height,
    padding: padding,
    margin: margin,
    decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: borderColor, width: 1.5),
        borderRadius: BorderRadius.all(Radius.circular(18.0)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.8),
            spreadRadius: 1,
            blurRadius: 2,
            offset: Offset.fromDirection(pi / 2),
          )
        ]),
    child: w,
  );
}
