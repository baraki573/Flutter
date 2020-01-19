import 'package:flutter/material.dart';

var pageList = [
  PageModel(
      imageUrl: "assets/images/art_museum.png",
      title: "Herzlich Wilkommen!",
      body: "Geschichte vernetzt im Hessichen Landesmuseum Darmstadt",
      number: 1,
      titleGradient: gradients[0]),
  PageModel(
      imageUrl: "assets/images/Mobile_app_p3ts.png",
      title: "App ins Museum!",
      body: "Mobil unterwegs im Landesmuseum:",
      number: 2,
      titleGradient: gradients[1]),
  PageModel(
      imageUrl: "assets/images/authentication.png",
      title: "Erstelle Dein Profil!",
      body: "Dein eigenes Profil im Landesmuseum:",
      number: "3",
      titleGradient: gradients[2]),
];

List<List<Color>> gradients = [
  [Color(0xFF9708CC), Color(0xFF43CBFF)],
  [Color(0xFFE2859F), Color(0xFFFCCF31)],
  [Color(0xFF736EFE), Color(0xFF5EFCE8)],
];

class PageModel {
  var imageUrl;
  var title;
  var body;
  var number;
  List<Color> titleGradient = [];
  PageModel({this.imageUrl, this.title, this.body, this.number, this.titleGradient});
}