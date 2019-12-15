import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:museum_app/SizeConfig.dart';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';

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
                margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 5.0),
                child: Container(
                  //alignment: Alignment.center,
                  height: SizeConfig.safeBlockHorizontal *
                      (SizeConfig.orientationDevice == Orientation.portrait
                          ? 27
                          : 16),
                  width: SizeConfig.safeBlockHorizontal *
                      (SizeConfig.orientationDevice == Orientation.portrait
                          ? 27
                          : 16),
                  decoration: BoxDecoration(
                    border: Border.all(color: color, width: 3),
                    //color: Colors.white,
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: content[index],
                      fit: BoxFit.fill,
                    ),
                    /*boxShadow: [
                        BoxShadow(
                          color: color.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 1,
                          offset: Offset.fromDirection(pi / 4, 4.0),
                        ),
                      ],*/
                  ),
                  child: FlatButton(
                    splashColor: color.withOpacity(.1),
                    highlightColor: color.withOpacity(.05),
                    //padding: EdgeInsets.symmetric(vertical: 0.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(80.0),
                    ),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              contentPadding:
                              const EdgeInsets.fromLTRB(16, 5, 16, 10),
                              title: Text("$name: $index"),
                              content: Container(
                                width: SizeConfig.safeBlockHorizontal * 70,
                                height: SizeConfig.safeBlockHorizontal * 70,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: content[index],
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            );
                          });
                      print("$name: $index");
                    },
                    child: null,
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
        _getAbteilung("Bonus", Colors.deepPurple,
            [AssetImage('assets/images/haupthalle_hlm_blue.png')])
      ],
    );
  }
}

class BadgeWidget extends StatefulWidget{
  BadgeWidget({Key key}) : super(key: key);

  @override
  _BadgeWidgetState createState() => _BadgeWidgetState(3);
}

class _BadgeWidgetState extends State<BadgeWidget> {
  final _perLine;
  var context;

  _BadgeWidgetState(this._perLine);

  Widget _getGrid(int perLine, List<Widget> content) {
    int rowC = (content.length / perLine).ceil();
    List<Widget> rows = List<Widget>(rowC);
    for (int i = 0; i < rowC; i++) {
      var sub = content.sublist(
          i * perLine, min(i * perLine + perLine, content.length));
      while (sub.length < perLine) sub.add(Expanded(child: Container()));
      rows[i] = Row(children: sub);
    }
    return Column(children: rows);
  }

  /// comlP represents percentages in the form "42.42" for "42.42%"
  Widget _getBadge(
      Color color, double current, double toget, ImageProvider img) {
    var perc = max(min(current / toget * 100, 100), 0);
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(2.0),
        height: SizeConfig.safeBlockVertical /
            _perLine *
            (SizeConfig.orientationDevice == Orientation.portrait ? 51 : 130),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Progress circle
            AnimatedCircularChart(
              size: Size.square(SizeConfig.safeBlockVertical /
                  _perLine *
                  (SizeConfig.orientationDevice == Orientation.portrait
                      ? 54
                      : 135)),
              initialChartData: [
                CircularStackEntry(
                  [
                    CircularSegmentEntry(perc, color),
                    CircularSegmentEntry(100 - perc, Colors.blueGrey[200]),
                  ],
                ),
              ],
              percentageValues: true,
            ),
            // Picture/Badge
            Container(
              width: SizeConfig.safeBlockHorizontal /
                  _perLine *
                  (SizeConfig.orientationDevice == Orientation.portrait
                      ? 63
                      : 50),
              height: SizeConfig.safeBlockHorizontal /
                  _perLine *
                  (SizeConfig.orientationDevice == Orientation.portrait
                      ? 63
                      : 50),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: img,
                  fit: BoxFit.fill,
                ),
              ),
              child: FlatButton(
                splashColor: color.withOpacity(.1),
                highlightColor: color.withOpacity(.05),
                onPressed: ()=>_badgePopUp(color, current, toget, img),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(80.0),
                ),
                child: null,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _badgePopUp(
      Color color, double current, double toget, ImageProvider img) {
    var perc = max(min(current / toget * 100, 100), 0);
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Badge $current"),
            contentPadding: EdgeInsets.only(bottom: 16),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    // Progress circle
                    AnimatedCircularChart(
                      size: Size.square(SizeConfig.safeBlockVertical *
                          (SizeConfig.orientationDevice == Orientation.portrait
                              ? 27
                              : 52)),
                      initialChartData: [
                        CircularStackEntry(
                          [
                            CircularSegmentEntry(perc, color),
                            CircularSegmentEntry(
                                100 - perc, Colors.blueGrey[200]),
                          ],
                        ),
                      ],
                      percentageValues: true,
                    ),
                    // Picture/Badge
                    Container(
                      width: SizeConfig.safeBlockHorizontal *
                          (SizeConfig.orientationDevice == Orientation.portrait
                              ? 32
                              : 19),
                      height: SizeConfig.safeBlockHorizontal *
                          (SizeConfig.orientationDevice == Orientation.portrait
                              ? 32
                              : 19),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: img,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ],
                ),
                Text("$current / $toget"),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      alignment: Alignment.center,
      child: _getGrid(
        _perLine,
        List.generate(16, (index) {
          return _getBadge(Colors.primaries[index], index.roundToDouble(), 16,
              AssetImage('assets/images/profile_test.png'));
        }),
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
          "Not yet implemented",
          style: TextStyle(fontSize: 20),
        ),
      ],
    );
  }
}