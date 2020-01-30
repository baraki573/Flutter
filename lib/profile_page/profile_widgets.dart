import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';
import 'package:museum_app/SizeConfig.dart';
import 'package:museum_app/database/database.dart';

class FavWidget extends StatefulWidget {
  FavWidget({Key key}) : super(key: key);

  @override
  _FavWidgetState createState() => _FavWidgetState();
}

class _FavWidgetState extends State<FavWidget> {
  Widget _buildAbteilung(Devision d, List<Stop> list) {
    if (list.isEmpty) return Container();
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Headline
          Container(
              padding: EdgeInsets.only(left: 20),
              child: Text(d.name,
                  style: TextStyle(
                    color: d.color,
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ))),
          // Horizontal Scrollable
          Container(
              padding: EdgeInsets.only(bottom: 20.0, top: 2.0),
              height: verSize(21, 40),
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    // One "bubble"
                    return Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 5.0),
                        height: horSize(27, 16),
                        width: horSize(27, 16),
                        decoration: BoxDecoration(
                            border: Border.all(color: d.color, width: 3),
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: AssetImage(list[index].images[0]),
                              fit: BoxFit.fill,
                            )),
                        child: FlatButton(
                          splashColor: d.color.withOpacity(.1),
                          highlightColor: d.color.withOpacity(.05),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(80.0),
                          ),
                          onPressed: () => dialog(list[index]),
                          child: null,
                        ));
                  }))
        ]);
  }

  void dialog(Stop s) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        contentPadding: const EdgeInsets.fromLTRB(16, 5, 16, 10),
        title: Text(s.name),
        content: Container(
          width: SizeConfig.safeBlockHorizontal * 70,
          height: SizeConfig.safeBlockHorizontal * 70,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(s.images[0]),
              fit: BoxFit.fill,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: MuseumDatabase.get().getDevisions(),
        builder: (context, snapDev) {
          var devisions = snapDev.data ?? List<Devision>();
          //print(devisions);
          return StreamBuilder(
              stream: MuseumDatabase.get().getStops(),
              builder: (context, snapStop) {
                var stops = snapStop.data ?? List<Stop>();
                return Column(
                  children: List.generate(devisions.length, (index) {
                    return _buildAbteilung(
                        devisions[index],
                        stops
                            .where((e) => e.devision == devisions[index].name)
                            .toList());
                  }),
                );
              });
        });
  }
}

class BadgeWidget extends StatefulWidget {
  BadgeWidget({Key key}) : super(key: key);

  @override
  _BadgeWidgetState createState() => _BadgeWidgetState(3);
}

class _BadgeWidgetState extends State<BadgeWidget> {
  final _perLine;

  _BadgeWidgetState(this._perLine);

  Widget _getGrid(List<Widget> content) {
    int rowC = (content.length / _perLine).ceil();
    List<Widget> rows = List<Widget>(rowC);
    for (int i = 0; i < rowC; i++) {
      var sub = content.sublist(
          i * _perLine, min(i * _perLine + _perLine, content.length));
      while (sub.length < _perLine) sub.add(Expanded(child: Container()));
      rows[i] = Row(children: sub);
    }
    return Column(children: rows);
  }

  /// comlP represents percentages in the form "42.42" for "42.42%"
  Widget _buildBadge(Badge b) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(2.0),
        height: verSize(51, 130) / _perLine,
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
            contentPadding: EdgeInsets.only(bottom: 10),
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
    final key = GlobalKey<AnimatedCircularChartState>();
    final key2 = GlobalKey<AnimatedCircularChartState>();
    var perc = max(min(b.current / b.toGet * 100, 100), 0);
    return Stack(
      alignment: Alignment.center,
      children: [
        // Progress circle
        AnimatedCircularChart(
          key: popUp ? key2 : key,
          size: Size.square(verSize(54, 135) * (popUp ? 1.3 : 1) / _perLine),
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
          width: horSize(63, 50) * (popUp ? 1.3 : 1) / _perLine,
          height: horSize(63, 50) * (popUp ? 1.3 : 1) / _perLine,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: AssetImage(b.imgPath),
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
    //UserClass u = getUser();
    return StreamBuilder(
        stream: MuseumDatabase.get().getBadges(),
        builder: (context, snapBad) {
          List<Badge> badges = snapBad.data ?? List<Badge>();
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 16),
            alignment: Alignment.center,
            child: _getGrid(badges.map((b) => _buildBadge(b)).toList()),
          );
        });
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
          style: TextStyle(fontSize: 25),
        ),
      ],
    );
  }
}
