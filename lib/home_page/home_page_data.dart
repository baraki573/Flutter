import 'package:flutter/material.dart';

var pageList = [
  HomeFunc(
      imageUrl: "assets/images/art_museum.png",
      title: "Mein Profil",
      goTo: "Profile()",),
  HomeFunc(
      imageUrl: "assets/images/Mobile_app_p3ts.png",
      title: "App ins Museum!",
      goTo: 2,),
  HomeFunc(
      imageUrl: "assets/images/authentication.png",
      title: "Erstelle Dein Profil!",
      goTo: 3,),
      
];


class HomeFunc {
  var imageUrl;
  var title;
  var goTo;
  List<Color> titleGradient = [];
  HomeFunc({this.imageUrl, this.title, this.goTo, this.titleGradient});
}