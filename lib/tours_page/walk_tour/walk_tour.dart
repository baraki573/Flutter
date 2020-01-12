import 'package:expandable_bottom_bar/expandable_bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:museum_app/Models.dart';
import 'package:museum_app/SizeConfig.dart';
import 'package:museum_app/map/map_page.dart';
import 'package:museum_app/tours_page/walk_tour/walk_tour_content.dart';
import 'package:museum_app/tours_page/walk_tour/walk_tour_tasks.dart';

class TourWalker extends StatefulWidget {
  final Tour tour;

  TourWalker({Key key, this.tour}) : super(key: key);

  @override
  _TourWalkerState createState() => _TourWalkerState();
}

class _TourWalkerState extends State<TourWalker>
    with SingleTickerProviderStateMixin {
  int _currentItem = 0;
  BottomBarController bbc;
  final double dragLength = 420.0;

  @override
  void initState() {
    super.initState();
    bbc = BottomBarController(vsync: this, dragLength: dragLength);
  }

  @override
  void dispose() {
    bbc.dispose();
    super.dispose();
  }

  Widget _navigator() {
    int length = widget.tour.stops.length;
    Color colorNav = Colors.white;
    return Container(
      padding: EdgeInsets.only(top: 30, left: 15, right: 15, bottom: 9),
      height: verSize(17, 31),
      decoration: BoxDecoration(
        color: Colors.pink,
        border: Border(bottom: BorderSide(color: Colors.black, width: 1.5)),
      ),
      child: Row(
        //mainAxisAlignment: MainAxisAlignment.center,
        //mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            //color: Colors.orange,
            alignment: Alignment.centerLeft,
            width: horSize(17, 27),
            child: (widget.tour.stops[_currentItem] is Exhibit
                ? Text(
                    "Station\n" + (_currentItem + 1).toString() + " / $length",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 17, color: colorNav),
                  )
                : Icon(
                    Icons.info_outline,
                    size: 32,
                    color: colorNav,
                  )),
          ),
          Spacer(),
          Container(
            //color: Colors.red,
            width: horSize(50, 30),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  widget.tour.name,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  style: TextStyle(
                      fontSize: 18,
                      color: colorNav,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  "von " + widget.tour.author,
                  style: TextStyle(
                      fontSize: 15,
                      fontStyle: FontStyle.italic,
                      color: colorNav),
                ),
              ],
            ),
          ),
          Spacer(),
          Container(
            //color: Colors.orange,
            alignment: Alignment.centerRight,
            width: horSize(15, 27),
            child: FlatButton(
                shape: CircleBorder(),
                padding: EdgeInsets.all(12),
                child: Icon(Icons.map, size: 30, color: colorNav),
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MapPage()))),
          ),
        ],
      ),
    );
  }

  List<Widget> _previewStops(List<Stop> stops) {
    var length = widget.tour.stops.length;
    return List.generate(
      length,
      (index) => Container(
        margin: EdgeInsets.symmetric(vertical: 7),
        decoration: BoxDecoration(
          color: Colors.pinkAccent,
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        child: FlatButton(
          onPressed: () => setState(() {
            //_currentImage = 0;
            _currentItem = index;
            bbc.swap();
          }),
          padding: EdgeInsets.all(0),
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  width: horSize(35, 20),
                  height: verSize(18, 20),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: stops[index].imgs[0], fit: BoxFit.cover),
                    border: Border(right: BorderSide(color: Colors.black)),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  width: horSize(45, 47),
                  padding: EdgeInsets.symmetric(horizontal: 2),
                  child: Text(
                    (index + 1).toString() + " / $length\n" + stops[index].name,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    int length = widget.tour.stops.length;
    return Scaffold(
      extendBody: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: GestureDetector(
        onVerticalDragUpdate: bbc.onDrag,
        onVerticalDragEnd: bbc.onDragEnd,
        child: FloatingActionButton.extended(
          label:
              Text("Zieh mich", style: TextStyle(fontWeight: FontWeight.bold)),
          elevation: 1,
          // here: buttonColor
          backgroundColor: Colors.pink,
          // here: textColor
          foregroundColor: Colors.white,
          onPressed: () => bbc.swap(),
        ),
      ),
      bottomNavigationBar: BottomExpandableAppBar(
        controller: bbc,
        expandedHeight: dragLength,
        shape: AutomaticNotchedShape(
            RoundedRectangleBorder(), StadiumBorder(side: BorderSide())),
        //expandedBackColor: Colors.red,
        expandedDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.grey[100],
            border: Border.all(color: Colors.black, width: 1.5)),
        expandedBody: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: ListView(
              padding:
                  EdgeInsets.only(left: 16, right: 16, top: 20, bottom: 50),
              children: _previewStops(widget.tour
                  .stops) //List.generate(100, (i) => Text("Hier ist Nummer $i")),
              ),
        ),
        bottomAppBarBody: Container(
          decoration: BoxDecoration(
            color: Colors.pink,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15), topRight: Radius.circular(15)),
            border: Border.all(color: Colors.black, width: 1.5),
          ),
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              FlatButton(
                onPressed: () => Navigator.pop(context),
                child: Row(children: [
                  Icon(Icons.flag, color: Colors.white),
                  Text(
                    "Beenden",
                    style: TextStyle(color: Colors.white),
                  )
                ]),
              ),
              Spacer(flex: 2),
              FlatButton(
                onPressed: _currentItem == length - 1
                    ? null
                    : () => setState(() {
                          _currentItem++;
                          //_currentImage = 0;
                        }),
                child: Row(children: [
                  Text("Weiter", style: TextStyle(color: Colors.white)),
                  Icon(Icons.arrow_forward, color: Colors.white)
                ]),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          _navigator(),
          Container(
            alignment: Alignment.topCenter,
            padding: EdgeInsets.all(0),
            height: verSize(83, 100),
            child: ListView(
              padding: EdgeInsets.all(0),
              children: [
                TourWalkerContent(widget.tour.stops[_currentItem]),
                TourWalkerTasks(widget.tour.tasks[widget.tour.stops[_currentItem].name]),
                Container(height: verSize(11, 7)),
                //_content(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
