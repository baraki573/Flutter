import 'package:flutter/material.dart';

var pageList = [
  PageModel(
      imageUrl: "assets/images/art_museum.png",
      title: "Landesmuseum Darmstadt ",
      body: "Let's Discover",
      titleGradient: gradients[0]),
  PageModel(
      imageUrl: "assets/images/new_ideas.png",
      title: "New Way",
      body: "FEEL THE MAGIC OF WELLNESS",
      titleGradient: gradients[1]),
  PageModel(
      imageUrl: "assets/images/authentication.png",
      title: "Login",
      body: "LET'S HIKE UP",
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
  List<Color> titleGradient = [];
  PageModel({this.imageUrl, this.title, this.body, this.titleGradient});
}