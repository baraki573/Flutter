import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'SizeConfig.dart';
import 'constants.dart';
import 'database/database.dart';

class MuseumTabs extends StatefulWidget {
  final Widget top;
  final Color color;
  final Map<String, Widget> tabs;
  final bool showSetting;

  //final List<String> names;
  //final List<Widget> tabs;

  MuseumTabs(this.top, this.tabs,
      {this.color = Colors.black, this.showSetting=true, Key key})
      : super(key: key);

  MuseumTabs.single(this.top, widget,
      {this.color = Colors.black, this.showSetting=true, Key key})
      : tabs = {"Single": widget},
        super(key: key);

  @override
  _MuseumTabsState createState() => _MuseumTabsState();
}

class _MuseumTabsState extends State<MuseumTabs> with TickerProviderStateMixin {
  String _currentTab;

  void initState() {
    super.initState();
    if (widget.tabs.length >= 1)
      _currentTab = widget.tabs.keys.toList()[0];
  }

  List<Widget> _customButtons() {
    return widget.tabs.entries.map((entry) {
      var selected = (_currentTab == entry.key);
      return FlatButton(
        //textColor: Colors.black,
        //disabledTextColor: Colors.green,
        splashColor: widget.color.withOpacity(.4),
        child: Text(entry.key,
            style: TextStyle(
                color: (selected ? widget.color : Colors.black),
                fontSize: size(16, 19))),
        onPressed: () => setState(() => _currentTab = entry.key),
      );
    }).toList();
  }

  Widget _bottomInfo() {
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
          widget.tabs.length > 1
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
        Stack(overflow: Overflow.visible, children: [
          Container(height: verSize(30, 45), child: widget.top),
          Positioned(
            top: verSize(28.5, 47, top: true),
            child: Container(
              color: Colors.white,
              width: horSize(100, 100),
              height: verSize(80, 30),
            ),
          ),
          widget.showSetting ? Positioned(
            right: horSize(2, 2, right: true),
            top: verSize(1, 1),
            child: MuseumSettings(),
          ) : Container(),
        ]),
        _bottomInfo(),
      ],
    );
  }
}

enum _OptionType { editUs, editPw, editPp, about }

class MuseumSettings extends StatelessWidget {
  PopupMenuItem _myPopUpItem(String s, IconData i, _OptionType t) {
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
      case _OptionType.about:
        showAboutDialog(context: context);
        break;
      case _OptionType.editUs:
        showDialog(context: context, builder: _editUS);
        break;
      case _OptionType.editPw:
        demo();
        break;
      case _OptionType.editPp:
        MuseumDatabase.get().clear();
        //showDialog(context: context, builder: _editPp);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: (context) => [
        _myPopUpItem("Profilbild ändern", Icons.image, _OptionType.editPp),
        _myPopUpItem("Username ändern", Icons.person, _OptionType.editUs),
        _myPopUpItem("Passwort ändern", Icons.fiber_pin, _OptionType.editPw),
        _myPopUpItem("Über diese App", Icons.info, _OptionType.about),
      ],
      onSelected: (result) => _select(result, context),
      /*onPressed: () {
                print("Options");
              },
              iconSize: 35,*/
      icon: Icon(
        Icons.settings,
        size: 35,
        color: Colors.white,
      ),
    );
  }
}
