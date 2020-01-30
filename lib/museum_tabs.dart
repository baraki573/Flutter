import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'SizeConfig.dart';

class MuseumTabs extends StatefulWidget {
  final Widget top;
  final Color color;
  final List<String> names;
  final List<Widget> tabs;

  MuseumTabs(this.top, this.names, this.tabs, this.color, {Key key})
      : super(key: key);

  @override
  _MuseumTabsState createState() => _MuseumTabsState();
}

class _MuseumTabsState extends State<MuseumTabs> {
  int _currentTab = 0;
  int minLength;

  @override
  void initState() {
    super.initState();
    minLength = min(widget.names.length, widget.tabs.length);
  }

  List<Widget> _customButtons() {
    return List.generate(minLength, (index) {
      var selected = (index == _currentTab);
      return FlatButton(
        //textColor: Colors.black,
        //disabledTextColor: Colors.green,
        splashColor: widget.color.withOpacity(.4),
        child: Text(widget.names[index],
            style: TextStyle(
                color: (selected ? widget.color : Colors.black),
                fontSize: size(16, 19))),
        onPressed: () => setState(() {
          _currentTab = index;
        }),
      );
    });
  }

  Widget _bottomInfo() {
    //TODO extra view for empty list
    return Container(
      //height: SizeConfig.safeBlockVertical * 100,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.white, width: 2),
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
      ),
      child: Column(
        children: <Widget>[
          ButtonBar(
            buttonMinWidth: 100,
            alignment: MainAxisAlignment.center,
            children: _customButtons(),
          ),
          widget.tabs[_currentTab],
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Stack(children: [
        Positioned(
        bottom: 0,
        child: Container(
          color: Colors.white,
          width: horSize(100, 100),
          height: verSize(50, 30),
        ),
      ),
      ListView(
        children: <Widget>[
          Container(height: verSize(30, 45), child: widget.top),
          _bottomInfo(),
        ],
      )
    ]);
  }
}
