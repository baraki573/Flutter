import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:museum_app/graphql/mutations.dart';

import 'SizeConfig.dart';
import 'constants.dart';
import 'database/database.dart';
import 'graphql/graphqlConf.dart';
import 'image_dialog.dart';

class MuseumTabs extends StatefulWidget {
  final Widget top;
  final Color color;
  final Map<String, Widget> tabs;
  final bool showSetting;

  MuseumTabs(this.top, this.tabs,
      {this.color = Colors.black, this.showSetting = true, Key key})
      : super(key: key);

  MuseumTabs.single(this.top, widget,
      {this.color = Colors.black, this.showSetting = true, Key key})
      : tabs = {"Single": widget},
        super(key: key);

  @override
  _MuseumTabsState createState() => _MuseumTabsState();
}

class _MuseumTabsState extends State<MuseumTabs> with TickerProviderStateMixin {
  String _currentTab;

  void initState() {
    super.initState();
    if (widget.tabs.length >= 1) _currentTab = widget.tabs.keys.toList()[0];
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
          widget.showSetting
              ? Positioned(
                  right: horSize(2, 2, right: true),
                  top: verSize(1, 1),
                  child: MuseumSettings(),
                )
              : Container(),
        ]),
        _bottomInfo(),
      ],
    );
  }
}

enum _OptionType {
  EDIT_US,
  EDIT_PW,
  EDIT_IMG,
  LOGIN,
  LOGOUT,
  ABOUT,
  clear,
  demo
}

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
        maxLength: MAX_USERNAME,
        validator: (input) {
          if (input.length < MIN_USERNAME) return "Username ist zu kurz";
          return null;
        },
        decoration: InputDecoration(hintText: "Username"),
      ),
      actions: [
        FlatButton(
          child: Text("Zurück", style: TextStyle(color: COLOR_PROFILE)),
          onPressed: () => Navigator.pop(context),
        ),
        FlatButton(
          child: Text("Bestätigen", style: TextStyle(color: COLOR_PROFILE)),
          onPressed: () {
            MuseumDatabase().updateUsername(ctrl.text);
            Navigator.pop(context);
          },
        )
      ],
    );
  }

  Future<void> _editPW(BuildContext context) async {
    var ctrl = TextEditingController();
    var ctrl2 = TextEditingController();
    final key = GlobalKey<FormFieldState>();
    String accesToken = await MuseumDatabase().accessToken();

    var dialog = AlertDialog(
      title: Text("Passwort ändern"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            controller: ctrl,
            obscureText: true,
            decoration: InputDecoration(hintText: "Passwort"),
          ),
          TextFormField(
            key: key,
            controller: ctrl2,
            obscureText: true,
            decoration: InputDecoration(hintText: "Passwort wiederholen"),
            validator: (s) {
              if (s != ctrl.text)
                return "Passwörter stimmen nicht überein";
              return null;
            },
          ),
        ],
      ),
      actions: [
        FlatButton(
          child: Text("Zurück", style: TextStyle(color: COLOR_PROFILE)),
          onPressed: () => Navigator.pop(context),
        ),
        FlatButton(
          child: Text("Bestätigen", style: TextStyle(color: COLOR_PROFILE)),
          onPressed: () async {
            if (!key.currentState.validate()) return;
            GraphQLClient _client = GraphQLConfiguration().clientToQuery();
            print(ctrl.text);
            await _client.mutate(MutationOptions(
              documentNode: gql(
                  MutationBackend.changePassword(accesToken, ctrl.text.trim())),
              update: (cache, result) => cache,
              onCompleted: (result) => Navigator.pop(context),
              onError: (e) => print("ERROR"),
            ));
          },
        ),
      ],
    );

    showDialog(context: context, builder: (context) => dialog);
  }

  Widget _logout(BuildContext context) {
    return AlertDialog(
      title: Text("Warnung"),
      content: Text("Möchten Sie sich wirklich ausloggen?\n"
          "Zum Wiederanmelden benötigen Sie Ihre Anmeldedaten."),
      actions: [
        FlatButton(
          child: Text("Zurück", style: TextStyle(color: COLOR_PROFILE)),
          onPressed: () => Navigator.pop(context),
        ),
        FlatButton(
          child: Text("Abmelden", style: TextStyle(color: COLOR_PROFILE)),
          onPressed: () async {
            await MuseumDatabase().logOut();
            Navigator.pop(context);
            Navigator.popAndPushNamed(context, "/profile");
          },
        )
      ],
    );
  }

  void _select(val, BuildContext context) {
    switch (val) {
      // TODO build own about dialog in german. Maybe general dialog, val determines content
      case _OptionType.EDIT_IMG:
        showDialog(context: context, builder: (_) => ImageDialog());
        break;
      case _OptionType.EDIT_US:
        showDialog(context: context, builder: _editUS);
        break;
      case _OptionType.EDIT_PW:
        _editPW(context);
        break;
      case _OptionType.ABOUT:
        showDialog(context: context, builder: _about);
        break;
      case _OptionType.LOGOUT:
        showDialog(context: context, builder: _logout);
        break;
      case _OptionType.LOGIN:
        Navigator.popAndPushNamed(context, "/profile");
        break;
      case _OptionType.clear:
        MuseumDatabase().clear();
        break;
      case _OptionType.demo:
        demo();
        break;
      default:
    }
  }

  Widget _about(context) {
    return AlertDialog(
      title: Text("Geschichte Vernetzt"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Teil des Projekts MINTplus²: Systematischer und vernetzter Kompetenzaufbau in der Lehrerbildung im Umgang mit Digitalisierung und Heterogenität",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: horSize(4, 2),
                fontFamily: "Nunito",
                fontWeight: FontWeight.w300,
                fontStyle: FontStyle.italic,
                color: Color(0xFF1A1A1A)),
          ),
          Image.asset('assets/images/photo_2020-01-19.jpeg',
              width: horSize(35, 30), height: verSize(15, 10)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(left: 7, right: 7),
                alignment: Alignment.center,
                child: Image.asset('assets/images/Logo_MINTplus_182x0.jpg',
                    width: horSize(28, 30), height: verSize(10, 20)),
              ),
              Container(
                margin: EdgeInsets.only(left: 7, right: 7),
                alignment: Alignment.center,
                child: Image.asset('assets/images/serveimage.png',
                    width: horSize(28, 30), height: verSize(10, 20)),
              ),
            ],
          ),
        ],
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 16),
      actions: [
        FlatButton(
          child: Text("Schließen"),
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: MuseumDatabase().watchUser(),
      builder: (context, snap) {
        bool logged = snap.hasData && snap.data.username != "";
        return PopupMenuButton(
          itemBuilder: (context) => _popUpList(logged),
          onSelected: (result) => _select(result, context),
          icon: Icon(
            Icons.settings,
            size: 35,
            color: Colors.white,
          ),
        );
      },
    );
  }

  _popUpList(bool logged) {
    List<PopupMenuItem> base = [
      _myPopUpItem("Einloggen", Icons.redo, _OptionType.LOGIN),
      _myPopUpItem("Über diese App", Icons.info, _OptionType.ABOUT),
      _myPopUpItem("DEBUG clear", Icons.clear, _OptionType.clear),
      _myPopUpItem("DEBUG demo", Icons.play_arrow, _OptionType.demo),
    ];

    if (logged) {
      base.removeAt(0);
      base.insert(0, _myPopUpItem("Ausloggen", Icons.undo, _OptionType.LOGOUT));
      base.insert(
          0,
          _myPopUpItem(
              "Passwort ändern", Icons.fiber_pin, _OptionType.EDIT_PW));
      base.insert(0,
          _myPopUpItem("Username ändern", Icons.person, _OptionType.EDIT_US));
      base.insert(0,
          _myPopUpItem("Profilbild ändern", Icons.image, _OptionType.EDIT_IMG));
    }

    return base;
  }
}
