import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:museum_app/Models.dart';
import 'package:museum_app/SizeConfig.dart';
import 'package:museum_app/map/map_page.dart';
import 'package:photo_view/photo_view.dart';

class TourWalker extends StatefulWidget {
  final Tour tour;

  TourWalker({Key key, this.tour}) : super(key: key);

  @override
  _TourWalkerState createState() => _TourWalkerState();
}

class _TourWalkerState extends State<TourWalker> {
  int _currentItem = 0;
  int _currentImage = 0;

  Widget _navigator() {
    int length = widget.tour.stops.length;
    double base = 1.5;
    Color colorNav = Colors.white;
    return Container(
      decoration: BoxDecoration(
        color: Colors.pink,
        border: Border.all(color: Colors.black),
      ),
      padding: EdgeInsets.only(top: 21),
      width: SizeConfig.safeBlockHorizontal * 100,
      height: SizeConfig.safeBlockVertical * size(17, 32.5),
      child: Stack(
        children: [
          // Back Arrow
          Positioned(
            top: base,
            left: 2,
            child: FlatButton(
                onPressed: _currentItem == 0
                    ? null
                    : () => setState(()  {_currentItem--; _currentImage=0;}),
                child: Icon(Icons.arrow_back, size: 30, color: colorNav)),
          ),
          // Index Display
          Positioned(
            top: base + 13,
            left: SizeConfig.safeBlockHorizontal * 25,
            right: SizeConfig.safeBlockHorizontal * 25,
            child: Container(
              //width: SizeConfig.safeBlockHorizontal * 40,
              //color: Colors.red,
              child: Text(
                (_currentItem + 1).toString() + " / " + length.toString(),
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, color: colorNav),
              ),
            ),
          ),
          // Forward Arrow
          Positioned(
            top: base,
            right: 2,
            child: FlatButton(
                onPressed: _currentItem == length - 1
                    ? null
                    : () => setState(() {_currentItem++; _currentImage=0;}),
                child: Icon(Icons.arrow_forward, size: 30, color: colorNav)),
          ),
          // Tour Name
          Positioned(
            top: base + 42,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              width: SizeConfig.safeBlockHorizontal * 100,
              height: SizeConfig.safeBlockVertical * size(3, 5),
              child: Text(
                widget.tour.name,
                style: TextStyle(
                    fontSize: 16, fontWeight: FontWeight.bold, color: colorNav),
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          // Author Name
          Positioned(
            top: base + 60,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              width: SizeConfig.safeBlockHorizontal * 100,
              height: SizeConfig.safeBlockVertical * size(3, 5),
              child: Text(
                "von " + widget.tour.author,
                style: TextStyle(
                    fontSize: 14, fontStyle: FontStyle.italic, color: colorNav),
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _content() {
    Item item = widget.tour.stops[_currentItem];
    return Container(
      height: SizeConfig.safeBlockVertical * size(87.1, 75),
      //padding: EdgeInsets.all(0),
      //color: Colors.red,
      child: ListView(
        //shrinkWrap: true,
        padding: EdgeInsets.all(0),
        children: [
          // Images
          CarouselSlider(
            //enlargeCenterPage: true,
            onPageChanged: (index) => setState(() => _currentImage = index),
            viewportFraction: 1.0,
            height: SizeConfig.safeBlockVertical * 52,
            enableInfiniteScroll: false,
            items: item.imgs
                .map(
                  (img) => Stack(
                    children: [
                      Container(
                        //margin: EdgeInsets.symmetric(horizontal: 16),
                        //height: SizeConfig.safeBlockVertical * 40,
                        //width: SizeConfig.safeBlockHorizontal * 100,
                        decoration: BoxDecoration(
                          //borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          border: Border.all(color: Colors.black),
                          image: DecorationImage(image: img, fit: BoxFit.cover),
                        ),
                      ),
                      Positioned(
                        top: 7,
                        right: 23,
                        height: SizeConfig.safeBlockVertical * 6,
                        width: SizeConfig.safeBlockVertical * 6,
                        child: FlatButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          padding: EdgeInsets.all(0),
                          color: Colors.black.withOpacity(0.3),
                          child: Icon(Icons.zoom_out_map,
                              color: Colors.white, size: 30),
                          onPressed: () {
                            _imagePopup(context, item.imgs[_currentImage]);
                          },
                        ),
                      ),
                    ],
                  ),
                )
                .toList(),
          ),
          // Dot Indicator
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              item.imgs.length,
              (index) => Container(
                width: 8.0,
                height: 8.0,
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _currentImage == index
                      ? Colors.black
                      : Colors.grey.withOpacity(0.75),
                ),
              ),
            ),
          ),
          _information(item),
        ],
      ),
    );
  }

  Widget _information(Item item) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            item.name,
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.pink),//Color(0xfff7bc3d)),
          ),
          ExpandablePanel(
            collapsed: Text(item.descr,
                maxLines: 5,
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 18),
                overflow: TextOverflow.ellipsis),
            expanded: Text(
              item.descr,
              textAlign: TextAlign.justify,
              style: TextStyle(fontSize: 18),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10, bottom: 5),
            child: Text(
              "Weitere Informationen",
              style: TextStyle(fontSize: 22, color: Colors.pinkAccent),
            ),
          ),
          _informationTable(item),
        ],
      ),
    );
  }

  Widget _informationTable(Item item) {
    var info = item.getInformation();
    return Container(
      margin: EdgeInsets.only(right: 23, bottom: 25),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
        border: Border.all(color: Colors.black),
        boxShadow: [BoxShadow(offset: Offset.fromDirection(pi/4))]
      ),
      child: Table(
        columnWidths: {
          0: FixedColumnWidth(SizeConfig.safeBlockHorizontal * 30),
          1: FixedColumnWidth(SizeConfig.safeBlockHorizontal * 47)
        },
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        border: TableBorder.symmetric(inside: BorderSide(color: Colors.black)),
        children: List.generate(
          info.length,
          (index) => TableRow(
            children: [
              Container(
                //padding: EdgeInsets.all(3),
                child: Text(
                  info.keys.elementAt(index),
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                child: Text(
                  info.putIfAbsent(info.keys.elementAt(index), null),
                  style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _imagePopup(BuildContext context, final ImageProvider img) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Stack(
          children: [
            PhotoView(
              imageProvider: img,
              maxScale: 3.0,
              minScale: PhotoViewComputedScale.contained,
              backgroundDecoration: const BoxDecoration(
                color: Colors.black,
              ),
              //initialIndex: index,
              //scrollDirection: verticalGallery ? Axis.vertical : Axis.horizontal,
            ),
            Positioned(
              top: 35,
              left: 7,
              height: SizeConfig.safeBlockVertical * 6,
              width: SizeConfig.safeBlockVertical * 6,
              child: FlatButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                padding: EdgeInsets.all(0),
                color: Colors.black.withOpacity(0.3),
                child: Icon(Icons.arrow_back, color: Colors.white, size: 32),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          _navigator(),
          _content(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.pink,
        child: Icon(Icons.map, color: Colors.white),
        onPressed: () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => MapPage())),
      ),
    );
  }
}
