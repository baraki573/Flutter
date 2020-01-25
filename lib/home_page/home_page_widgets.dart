import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:museum_app/SizeConfig.dart';
import 'dart:math';
import 'package:museum_app/route_generator.dart';



class HomeFunctionalities extends StatefulWidget {
  HomeFunctionalities({Key key}) : super(key: key);

  @override
  _HomeFunctionalitiesState createState() => _HomeFunctionalitiesState();
}
var funcSizeHeightPortrait = 29;
var funcSizeWidthPortrait = 42;
var funcSizeHeightLandscape = 30;
var funcSizeWidthLandscape = 10;


var imageSizeHeightPortrait = 20;
var imageSizeWidthPortrait = 38;
var imageSizeHeightLandscape = 10;
var imageSizeWidthLandscape = 30;

class _HomeFunctionalitiesState extends State<HomeFunctionalities> {
  
  Widget _createFunctionality(){
    return Container(
        child: Stack(
          children: [
            Column(
              children:[
                _firstRow(),
                _secondRow(),
                _thirdRow(),
              ] //next row should be here
            ),
        ])
    );
  }
  

  Widget _firstRow(){
    return Row( 
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[ 
      InkWell(
      child: Container(
        width: SizeConfig.orientationDevice == Orientation.portrait ? SizeConfig.safeBlockHorizontal * funcSizeWidthPortrait : SizeConfig.safeBlockHorizontal * funcSizeWidthLandscape, 
        height: SizeConfig.orientationDevice == Orientation.portrait ? SizeConfig.safeBlockVertical * funcSizeHeightPortrait : SizeConfig.safeBlockVertical * funcSizeHeightLandscape,
        margin: EdgeInsets.only(left:16.0, top:16.0,bottom:16, right:5),
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
                  margin: EdgeInsets.only(right:5.0, left:5.0, top:10),
                  child:
                  Image.asset('assets/images/undraw_wall_post_83ul.png',
                  width: SizeConfig.orientationDevice == Orientation.portrait ? SizeConfig.safeBlockHorizontal * imageSizeWidthPortrait : SizeConfig.safeBlockHorizontal * imageSizeWidthLandscape, 
                  height: SizeConfig.orientationDevice == Orientation.portrait ? SizeConfig.safeBlockVertical * imageSizeHeightPortrait : SizeConfig.safeBlockVertical * imageSizeHeightLandscape)),
                Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(bottom:10.0, top:5.0),
                    child: SafeArea(
                    bottom: false,
                    child: Text(
                    "Mein Profil",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                    fontSize: SizeConfig.orientationDevice == Orientation.portrait ? SizeConfig.safeBlockHorizontal * 5 : SizeConfig.safeBlockHorizontal * 2,
                    fontFamily: "Nunito",
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1A1A1A)),
                    )
                      )
              )
              ],
            )
          )
        ),
        onTap: () { Navigator.of(context).pushNamed('/profile');}
      ),
        Container(
        width: SizeConfig.orientationDevice == Orientation.portrait ? SizeConfig.safeBlockHorizontal * funcSizeWidthPortrait : SizeConfig.safeBlockHorizontal * funcSizeWidthLandscape, 
        height: SizeConfig.orientationDevice == Orientation.portrait ? SizeConfig.safeBlockVertical * funcSizeHeightPortrait : SizeConfig.safeBlockVertical * funcSizeHeightLandscape,
        margin: EdgeInsets.only(right:16.0, top:16.0,bottom:16, left:5),
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
                  margin: EdgeInsets.only(right:5.0, left:5.0, top:10),
                  child:
                  Image.asset('assets/images/undraw_art_lover_yjfr.png',
                  width: SizeConfig.orientationDevice == Orientation.portrait ? SizeConfig.safeBlockHorizontal * imageSizeWidthPortrait : SizeConfig.safeBlockHorizontal * imageSizeWidthLandscape, 
                  height: SizeConfig.orientationDevice == Orientation.portrait ? SizeConfig.safeBlockVertical * imageSizeHeightPortrait : SizeConfig.safeBlockVertical * imageSizeHeightLandscape)),
                Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(bottom:10.0, top:5.0),
                    child: SafeArea(
                    bottom: false,
                    child: Text(
                    "Tour gehen",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                    fontSize: SizeConfig.orientationDevice == Orientation.portrait ? SizeConfig.safeBlockHorizontal * 5 : SizeConfig.safeBlockHorizontal * 2,
                    fontFamily: "Nunito",
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1A1A1A)),
                    )
                      )
              )
              ],
            )
          )
        ),
      ],
    );
  }
  
  Widget _secondRow(){
    return Row( 
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[ 
                  InkWell( child:  
                  Container(
                    width: SizeConfig.orientationDevice == Orientation.portrait ? SizeConfig.safeBlockHorizontal * funcSizeWidthPortrait : SizeConfig.safeBlockHorizontal * funcSizeWidthLandscape, 
                    height: SizeConfig.orientationDevice == Orientation.portrait ? SizeConfig.safeBlockVertical * funcSizeHeightPortrait : SizeConfig.safeBlockVertical * funcSizeHeightLandscape,
                    margin: EdgeInsets.only(left:16.0, bottom:16, right:5),
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
                              margin: EdgeInsets.only(right:5.0, left:5.0, top:10),
                              child:
                              Image.asset('assets/images/undraw_detailed_analysis_xn7y.png',
                              width: SizeConfig.orientationDevice == Orientation.portrait ? SizeConfig.safeBlockHorizontal * imageSizeWidthPortrait : SizeConfig.safeBlockHorizontal * imageSizeWidthLandscape, 
                              height: SizeConfig.orientationDevice == Orientation.portrait ? SizeConfig.safeBlockVertical * imageSizeHeightPortrait : SizeConfig.safeBlockVertical * imageSizeHeightLandscape)),
                            Container(
                                alignment: Alignment.center,
                                margin: EdgeInsets.only(bottom:10.0, top:5.0),
                                child: SafeArea(
                                bottom: false,
                                child: Text(
                                "Tour erstellen",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                fontSize: SizeConfig.orientationDevice == Orientation.portrait ? SizeConfig.safeBlockHorizontal * 5 : SizeConfig.safeBlockHorizontal * 2,
                                fontFamily: "Nunito",
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF1A1A1A)),
                                )
                                  )
                          )
                          ],
                        )
                      )
                    ),
                    //onTap: () { Navigator.of(context).pushNamed('/tutorials');}
                    ),
                    InkWell(child:
                    Container(
                    width: SizeConfig.orientationDevice == Orientation.portrait ? SizeConfig.safeBlockHorizontal * funcSizeWidthPortrait : SizeConfig.safeBlockHorizontal * funcSizeWidthLandscape, 
                    height: SizeConfig.orientationDevice == Orientation.portrait ? SizeConfig.safeBlockVertical * funcSizeHeightPortrait : SizeConfig.safeBlockVertical * funcSizeHeightLandscape,
                    margin: EdgeInsets.only(right:16.0, bottom:16, left:5),
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
                              margin: EdgeInsets.only(right:5.0, left:5.0, top:10),
                              child:
                              Image.asset('assets/images/undraw_collecting_fjjl.png',
                              width: SizeConfig.orientationDevice == Orientation.portrait ? SizeConfig.safeBlockHorizontal * imageSizeWidthPortrait : SizeConfig.safeBlockHorizontal * imageSizeWidthLandscape, 
                              height: SizeConfig.orientationDevice == Orientation.portrait ? SizeConfig.safeBlockVertical * imageSizeHeightPortrait : SizeConfig.safeBlockVertical * imageSizeHeightLandscape)),
                            Container(
                                alignment: Alignment.center,
                                margin: EdgeInsets.only(bottom:10.0, top:5.0),
                                child: SafeArea(
                                bottom: false,
                                child: Text(
                                "Tutorials",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                fontSize: SizeConfig.orientationDevice == Orientation.portrait ? SizeConfig.safeBlockHorizontal * 5 : SizeConfig.safeBlockHorizontal * 2,
                                fontFamily: "Nunito",
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF1A1A1A)),
                                )
                                  )
                          )
                          ],
                        )
                      )
                    ),
                    onTap: () { Navigator.of(context).pushNamed('/tutorials');}
                    )
                  ],
                );
  }
  
  Widget _thirdRow(){
    return Row( 
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[ 
      Container(
        width: SizeConfig.orientationDevice == Orientation.portrait ? SizeConfig.safeBlockHorizontal * funcSizeWidthPortrait : SizeConfig.safeBlockHorizontal * funcSizeWidthLandscape, 
        height: SizeConfig.orientationDevice == Orientation.portrait ? SizeConfig.safeBlockVertical * funcSizeHeightPortrait : SizeConfig.safeBlockVertical * funcSizeHeightLandscape,
        margin: EdgeInsets.only(left:16.0, bottom:16, right:5),
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
                  margin: EdgeInsets.only(right:5.0, left:5.0, top:10),
                  child:
                  Icon(
                    Icons.info,
                    color: Colors.blue,
                    size:100,
                  )),
                Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(bottom:10.0, top:15.0),
                    child: SafeArea(
                    bottom: false,
                    child: Text(
                    "Über das Landesmuseum",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                    fontSize: SizeConfig.orientationDevice == Orientation.portrait ? SizeConfig.safeBlockHorizontal * 5 : SizeConfig.safeBlockHorizontal * 2,
                    fontFamily: "Nunito",
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1A1A1A)),
                    )
                      )
              )
              ],
            )
          )
        ),
        Container(
        width: SizeConfig.orientationDevice == Orientation.portrait ? SizeConfig.safeBlockHorizontal * funcSizeWidthPortrait : SizeConfig.safeBlockHorizontal * funcSizeWidthLandscape, 
        height: SizeConfig.orientationDevice == Orientation.portrait ? SizeConfig.safeBlockVertical * funcSizeHeightPortrait : SizeConfig.safeBlockVertical * funcSizeHeightLandscape,
        margin: EdgeInsets.only(right:16.0, bottom:16, left:5),
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
                  margin: EdgeInsets.only(right:5.0, left:5.0, top:10),
                  child:
                  Image.asset('assets/images/undraw_new_ideas_jdea.png',
                  width: SizeConfig.orientationDevice == Orientation.portrait ? SizeConfig.safeBlockHorizontal * 35 : SizeConfig.safeBlockHorizontal * imageSizeWidthLandscape, 
                  height: SizeConfig.orientationDevice == Orientation.portrait ? SizeConfig.safeBlockVertical * 15 : SizeConfig.safeBlockVertical * imageSizeHeightLandscape)),
                Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(bottom:10.0, top:5.0, right:5.0, left:5.0,),
                    child: SafeArea(
                    bottom: false,
                    child: Text(
                    "Über das Projekt geschichte vernetzt",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                    fontSize: SizeConfig.orientationDevice == Orientation.portrait ? SizeConfig.safeBlockHorizontal * 5 : SizeConfig.safeBlockHorizontal * 2,
                    fontFamily: "Nunito",
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1A1A1A)),
                    )
                      )
              )
              ],
            )
          )
        ),
      ],
    );
  }
  

  @override
  Widget build(BuildContext context) {
    return _createFunctionality();
  }
}