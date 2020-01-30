import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:museum_app/SizeConfig.dart';
import 'package:museum_app/constants.dart';
import 'package:museum_app/database/database.dart';
import 'package:museum_app/museum_tabs.dart';
import 'package:museum_app/profile_page/profile_widgets.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  Profile({Key key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

enum InfoType { fav, badge, stat }
enum OptionType { editUs, editPw, editPp, about }

class _ProfileState extends State<Profile> {
  InfoType _type = InfoType.fav;

  /* StreamBuilder<List<User>> _builder() {
    final db = MuseumDatabase.get();
    return StreamBuilder(
      stream: db.getUser(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        final list = snapshot.data ?? User(username: "HELP", imgPath: "KJ");
        print(list);
        return Text(
          list[0].username,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        );
      },
    );
  }*/

  Widget _topInfo() {
    return StreamBuilder(
        stream: MuseumDatabase.get().getUser(),
        builder: (context, snap) {
          var user = snap.data ??
              User(username: "", imgPath: "assets/images/profile_test.png");
          return Stack(
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
                        image: AssetImage(user.imgPath),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Text(
                    user.username,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  )
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
                    _myPopUpItem(
                        "Über diese App", Icons.info, OptionType.about),
                  ],
                  onSelected: (result) => _select(result),
                  /*onPressed: () {
                print("Options");
              },
              iconSize: 35,*/
                  icon: Icon(Icons.settings, size: 35),
                ),
              ),
            ],
          );
        });
  }

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

  Widget _editPp(BuildContext context) {
    //TODO implement
    return AlertDialog();
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

  @override
  Widget build(BuildContext context) {
    return MuseumTabs(
      _topInfo(),
      ["Favoriten", "Erfolge", "Statistik"],
      [FavWidget(), BadgeWidget(), StatWidget()],
      Colors.green,
    );
  }
}
