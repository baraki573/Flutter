import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:expandable/expandable.dart';
import 'package:expandable_bottom_bar/expandable_bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:museum_app/Models.dart';
import 'package:museum_app/SizeConfig.dart';
import 'package:museum_app/map/map_page.dart';
import 'package:museum_app/tours_page/walk_tour/walk_tour_tasks.dart';
import 'package:photo_view/photo_view.dart';

class TourWalkerContent extends StatefulWidget {
  final Stop stop;

  TourWalkerContent(this.stop, {Key key}) : super(key: key);

  @override
  _TourWalkerContentState createState() => _TourWalkerContentState();
}

class _TourWalkerContentState extends State<TourWalkerContent> {
  int _currentImage = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      //shrinkWrap: true,
      //padding: EdgeInsets.all(0),
      children: [
        // Images
        CarouselSlider(
          //enlargeCenterPage: true,
          onPageChanged: (index) => setState(() => _currentImage = index),
          viewportFraction: 1.0,
          height: verSize(52, 68.5),
          enableInfiniteScroll: false,
          items: widget.stop.imgs
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
                          _imagePopup(widget.stop.imgs[_currentImage]);
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
            widget.stop.imgs.length,
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
        _information(),
        //TourWalkerTasks(widget.),
      ],
    );
  }

  void _imagePopup(final ImageProvider img) {
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

  Widget _information() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.stop.name,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.pink,
            ),
          ),
          ExpandablePanel(
            collapsed: Text(widget.stop.descr,
                maxLines: 5,
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 18),
                overflow: TextOverflow.ellipsis),
            expanded: Text(
              widget.stop.descr,
              textAlign: TextAlign.justify,
              style: TextStyle(fontSize: 18),
            ),
          ),
          _informationTable(widget.stop),
        ],
      ),
    );
  }

  Widget _informationTable(item) {
    if (!(item is Exhibit)) return Container();
    var info = item.getInformation();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(top: 10, bottom: 5),
          child: Text(
            "Weitere Informationen",
            style: TextStyle(fontSize: 22, color: Colors.pinkAccent),
          ),
        ),
        Container(
          margin: EdgeInsets.only(right: 23),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10)),
              border: Border.all(color: Colors.black),
              boxShadow: [BoxShadow(offset: Offset.fromDirection(pi / 4))]),
          child: Table(
            columnWidths: {
              0: FixedColumnWidth(horSize(30, 25)),
              1: FixedColumnWidth(horSize(47, 62))
            },
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            border:
                TableBorder.symmetric(inside: BorderSide(color: Colors.black)),
            children: List.generate(
              info.length,
              (index) => TableRow(
                children: [
                  Container(
                    //padding: EdgeInsets.all(3),
                    child: Text(
                      info.keys.elementAt(index),
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                    child: Text(
                      info.putIfAbsent(info.keys.elementAt(index), null),
                      style:
                          TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}