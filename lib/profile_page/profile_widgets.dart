import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:museum_app/Models.dart';
import 'package:museum_app/SizeConfig.dart';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';

class FavWidget extends StatefulWidget {
  FavWidget({Key key}) : super(key: key);

  @override
  _FavWidgetState createState() => _FavWidgetState();
}

class _FavWidgetState extends State<FavWidget> {
  Widget _buildAbteilung(Devision d) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // Headline
        Container(
          padding: EdgeInsets.only(left: 20),
          child: Text(
            d.name,
            style: TextStyle(
              color: d.color,
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
            itemCount: d.items.length,
            itemBuilder: (context, index) {
              // One "bubble"
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 5.0),
                child: Container(
                  //alignment: Alignment.center,
                  height: SizeConfig.safeBlockHorizontal * size(27, 16),
                  width: SizeConfig.safeBlockHorizontal * size(27, 16),
                  decoration: BoxDecoration(
                    border: Border.all(color: d.color, width: 3),
                    //color: Colors.white,
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: d.items[index].img,
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
                    splashColor: d.color.withOpacity(.1),
                    highlightColor: d.color.withOpacity(.05),
                    //padding: EdgeInsets.symmetric(vertical: 0.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(80.0),
                    ),
                    onPressed: () => dialog(d.items[index]),
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

  void dialog(Item i) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        contentPadding: const EdgeInsets.fromLTRB(16, 5, 16, 10),
        title: Text(i.name),
        content: Container(
          width: SizeConfig.safeBlockHorizontal * 70,
          height: SizeConfig.safeBlockHorizontal * 70,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: i.img,
              fit: BoxFit.fill,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    User u = getUser();
    return Column(
      children: List.generate(u.favDev.length, (index) {
        return _buildAbteilung(u.favDev[index]);
      }),
      /*[
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
      ],*/
    );
  }
}

class BadgeWidget extends StatefulWidget {
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
  Widget _buildBadge(Badge b) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(2.0),
        height: SizeConfig.safeBlockVertical /
            _perLine *
            (SizeConfig.orientationDevice == Orientation.portrait ? 51 : 130),
        child: _getBadge(b, false),
      ),
    );
  }

  void _badgePopUp(Badge b) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(b.name),
            contentPadding: EdgeInsets.only(bottom: 16),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _getBadge(b, true),
                Text(b.current.toString() + " / " + b.toGet.toString()),
              ],
            ),
          );
        });
  }

  Widget _getBadge(Badge b, popUp) {
    var perc = max(min(b.current / b.toGet * 100, 100), 0);
    return Stack(
      alignment: Alignment.center,
      children: [
        // Progress circle
        AnimatedCircularChart(
          key: popUp ? b.key2 : b.key,
          size: Size.square(SizeConfig.safeBlockVertical /
              _perLine *
              (SizeConfig.orientationDevice == Orientation.portrait
                  ? 54
                  : 135) *
              (popUp ? 1.3 : 1)),
          initialChartData: [
            CircularStackEntry(
              [
                CircularSegmentEntry(perc, b.color),
                CircularSegmentEntry(100 - perc, Colors.blueGrey[100]),
              ],
            ),
          ],
          percentageValues: true,
        ),
        // Picture/Badge
        Container(
          width: SizeConfig.safeBlockHorizontal /
              _perLine *
              (SizeConfig.orientationDevice == Orientation.portrait ? 63 : 50) *
              (popUp ? 1.3 : 1),
          height: SizeConfig.safeBlockHorizontal /
              _perLine *
              (SizeConfig.orientationDevice == Orientation.portrait ? 63 : 50) *
              (popUp ? 1.3 : 1),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: b.img,
              fit: BoxFit.fill,
            ),
          ),
          child: FlatButton(
            splashColor: b.color.withOpacity(.1),
            highlightColor: b.color.withOpacity(.05),
            onPressed: () => _badgePopUp(b),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(80.0),
            ),
            child: null,
          ),
        ),
      ],
    );
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
          Badge b = Badge(
              name: "Badge $index",
              current: index.roundToDouble(),
              toGet: 16,
              img: AssetImage('assets/images/profile_test.png'),
              color: Colors.primaries[index]);
          return _buildBadge(b);
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
