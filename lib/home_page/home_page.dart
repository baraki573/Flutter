import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:museum_app/SizeConfig.dart';

import 'package:museum_app/home_page/home_page_widgets.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {


  Widget _topInfo1() {
    return Container(
      height: verSize(30, 45),
      child: Center(
        child: Stack(
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              child:
              Column(children: <Widget>[
                Container( 
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(bottom:5.0, top:15.0),
                  child: SafeArea(
                  bottom: false,
                  child: Text(
                  "Geschichte",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                  fontSize: SizeConfig.orientationDevice == Orientation.portrait ? SizeConfig.safeBlockHorizontal * 13 : SizeConfig.safeBlockHorizontal * 2,
                  fontFamily: "Nunito",
                  // fontWeight: FontWeight.w700,
                  color: Colors.white),
                  )
                  )
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child:
                  Column(children: <Widget>[
                    Container( 
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(bottom:5.0, top:2.0),
                      child: SafeArea(
                      bottom: false,
                      child: Text(
                      "Vernetzt",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                      fontSize: SizeConfig.orientationDevice == Orientation.portrait ? SizeConfig.safeBlockHorizontal * 13 : SizeConfig.safeBlockHorizontal * 2,
                      fontFamily: "Chiller",
                      // fontWeight: FontWeight.w700,
                      color: Colors.white),
                      )
                      )
                    )],
                    ),)
              ])
            )  
          ],
        ),
      ),
    );
  }


  Widget _topInfo() {
    return Container(
      height: verSize(30, 45),
      child: Center(
          child:
            Container(
                  margin: EdgeInsets.only(right:5.0, left:5.0),
                  child: 
                  Image.asset('assets/images/HomePage.png',
                  width: SizeConfig.orientationDevice == Orientation.portrait ? SizeConfig.safeBlockHorizontal * 80 : SizeConfig.safeBlockHorizontal * 50, 
                  height: SizeConfig.orientationDevice == Orientation.portrait ? SizeConfig.safeBlockVertical * 25 : SizeConfig.safeBlockVertical * 50)
                  ),
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
      child: HomeFunctionalities(),
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
