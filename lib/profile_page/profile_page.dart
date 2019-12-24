import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:museum_app/Models.dart';
import 'package:museum_app/SizeConfig.dart';
import 'package:museum_app/profile_page/profile_widgets.dart';

class Profile extends StatefulWidget {
  Profile({Key key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

enum InfoType { fav, badge, stat }
enum OptionType { editUs, editPw, editPp, about }

class _ProfileState extends State<Profile> {
  InfoType _type = InfoType.fav;

  Widget _topInfo() {
    User u = getUser();
    return Container(
      height: SizeConfig.safeBlockVertical *
          (SizeConfig.orientationDevice == Orientation.portrait ? 30 : 45),
      child: Stack(
        alignment: Alignment.centerLeft,
        children: <Widget>[
          // Picture, Nickname
          Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16),
                height: 120,
                width: 120,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 2),
                  color: Colors.white,
                  //borderRadius: BorderRadius.all(Radius.circular(80.0)),
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: u.img,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Container(
                //alignment: Alignment.center,
                //padding: EdgeInsets.only(left: 50),
                child: Text(
                  u.username,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
              ),
            ],
          ),
          // Option Button
          Positioned(
            right: SizeConfig.blockSizeHorizontal * 2,
            top: SizeConfig.blockSizeVertical * 2,
            child: PopupMenuButton(
              itemBuilder: (context) => [
                _myPopUpItem(
                    "Profilbild ändern", Icons.image, OptionType.editPp),
                _myPopUpItem(
                    "Username ändern", Icons.person, OptionType.editUs),
                _myPopUpItem(
                    "Passwort ändern", Icons.fiber_pin, OptionType.editPw),
                _myPopUpItem("Über diese App", Icons.info, OptionType.about),
              ],
              onSelected: (result) => _select(result),
              /*onPressed: () {
                print("Options");
              },
              iconSize: 35,*/
              icon: Icon(Icons.settings, size: 35)))]));}

  PopupMenuItem _myPopUpItem(String s, IconData i, OptionType t) {
    return PopupMenuItem(
      child: Row(children: [
        Container(padding: EdgeInsets.only(right: 4), child: Icon(i)),
        Text(s)
      ]),
      value: t,
    );
  }

  void _select(val) {
    switch (val) {
      // TODO build own about dialog in german. Maybe general dialog, val determines content
      case OptionType.about:
        showAboutDialog(context: context);
        break;
    }
  }

  Widget _customButtons(String text, InfoType type) {
    var selected = _type == type;
    return FlatButton(
      //textColor: Colors.black,
      //disabledTextColor: Colors.green,
      splashColor: Colors.greenAccent,
      child: Text(text,
          style: TextStyle(
              color: (selected ? Colors.green : Colors.black),
              fontSize: (SizeConfig.orientationDevice == Orientation.portrait
                  ? 16
                  : 19))),
      onPressed: () => setState(() {
        _type = type;
      }),
    );
  }

  Widget _bottomInfo() {
    return Container(
      //height: SizeConfig.safeBlockVertical * 100,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
      ),
      child: Column(
        children: <Widget>[
          ButtonBar(
            buttonMinWidth: 100,
            alignment: MainAxisAlignment.center,
            children: <Widget>[
              _customButtons("Favoriten", InfoType.fav),
              _customButtons("Erfolge", InfoType.badge),
              _customButtons("Statistik", InfoType.stat),
            ],
          ),
          (_type == InfoType.fav
              ? FavWidget()
              : (_type == InfoType.badge ? BadgeWidget() : StatWidget())),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return ListView(
      children: <Widget>[
        _topInfo(),
        _bottomInfo(),
      ],
    );
  }
}
