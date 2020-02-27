import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'SizeConfig.dart';
import 'constants.dart';
import 'database/database.dart';

class MuseumTabs extends StatefulWidget {
  final Widget top;
  final Color color;
  final List<String> names;
  final List<Widget> tabs;

  MuseumTabs(this.top, this.tabs, {this.names = const [], this.color, Key key})
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
    if (widget.names == null || widget.tabs == null)
      minLength = 0;
    else
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
    print(minLength);
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
          widget.names.length > 0
              ? ButtonBar(
                  buttonMinWidth: 100,
                  alignment: MainAxisAlignment.center,
                  children: _customButtons(),
                )
              : Container(),
          widget.tabs[_currentTab],
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return ListView(
      children: <Widget>[

        Stack(
            overflow: Overflow.visible,
            children: [
          Container(height: verSize(30, 45), child: widget.top),
          Positioned(
            top: verSize(41, 47),
            child: Container(
              color: Colors.white,
              width: horSize(100, 100),
              height: verSize(50, 30),
            ),
          ),
          Positioned(
            right: SizeConfig.blockSizeHorizontal * 2,
            top: SizeConfig.blockSizeVertical * 2,
            child: MuseumSettings(),
          ),
        ]),

        _bottomInfo(),
      ],
    );
  }
}

enum OptionType { editUs, editPw, editPp, about }

class MuseumSettings extends StatelessWidget {
  PopupMenuItem _myPopUpItem(String s, IconData i, OptionType t) {
    return PopupMenuItem(
      child: Row(children: [
        Container(padding: EdgeInsets.only(right: 4), child: Icon(i)),
        Text(s)
      ]),
      value: t,
    );
  }

  Widget _editUS(BuildContext context) {
    var ctrl = TextEditingController();
    return AlertDialog(
      title: Text("Username ändern"),
      content: TextFormField(
        autovalidate: true,
        controller: ctrl,
        validator: (input) {
          if (input.length < MIN_USERNAME) return "Username ist zu kurz";
          if (input.length > MAX_USERNAME) return "Username ist zu lang";
          return null;
        },
      ),
      actions: [
        FlatButton(
          child: Text("Zurück"),
          onPressed: () => Navigator.pop(context),
        ),
        FlatButton(
          child: Text("Bestätigen"),
          onPressed: () {
            MuseumDatabase.get().updateUsername(ctrl.text);
            ctrl.clear();
            Navigator.pop(context);
          },
        )
      ],
    );
  }

  void _select(val, BuildContext context) {
    switch (val) {
      // TODO build own about dialog in german. Maybe general dialog, val determines content
      case OptionType.about:
        showAboutDialog(context: context);
        break;
      case OptionType.editUs:
        showDialog(context: context, builder: _editUS);
        break;
      case OptionType.editPw:
        demo();
        break;
      case OptionType.editPp:
        MuseumDatabase.get().clear();
        //showDialog(context: context, builder: _editPp);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return PopupMenuButton(
      itemBuilder: (context) => [
        _myPopUpItem("Profilbild ändern", Icons.image, OptionType.editPp),
        _myPopUpItem("Username ändern", Icons.person, OptionType.editUs),
        _myPopUpItem("Passwort ändern", Icons.fiber_pin, OptionType.editPw),
        _myPopUpItem("Über diese App", Icons.info, OptionType.about),
      ],
      onSelected: (result) => _select(result, context),
      /*onPressed: () {
                print("Options");
              },
              iconSize: 35,*/
      icon: Icon(Icons.settings, size: 35, color: Colors.white,),
    );
  }
}
