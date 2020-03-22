import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:museum_app/SizeConfig.dart';
import 'package:museum_app/database/database.dart';

class LogIn extends StatefulWidget {
  final bool skippable;

  LogIn({this.skippable = true, Key key}) : super(key: key);

  @override
  _LogInState createState() => _LogInState();
}

enum FormType { LOGIN, SIGNUP }

class _LogInState extends State<LogIn> {
  FormType _form = FormType.LOGIN;
  String _us, _pw, _pw2;
  final _usCtrl = TextEditingController();
  final _pwCtrl = TextEditingController();
  final _pw2Ctrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    _form = FormType.LOGIN;
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    _usCtrl.dispose();
    _pwCtrl.dispose();
    _pw2Ctrl.dispose();
    super.dispose();
  }

  bool _getUS() {
    setState(() {
      _us = _usCtrl.text.trim();
      _pw = _pwCtrl.text.trim();
      _pw2 = _pw2Ctrl.text.trim();
    });
    return _us != "" && _pw != "";
  }

  void _nextScreen() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    MuseumDatabase().updateUsername(_usCtrl.text);
    Navigator.popAndPushNamed(context, "/profile");
  }

  Widget _customButtons(String text, funct) {
    return FlatButton(
      //color: Colors.grey[300],
      textColor: Colors.black54,
      disabledColor: Colors.blue,
      disabledTextColor: Colors.white,
      splashColor: Colors.blueAccent,
      child: Text(funct == null ? text.toUpperCase() : text),
      onPressed: funct,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
    );
  }

  Widget _topButtons() {
    var funct1, funct2;

    switch (_form) {
      case FormType.LOGIN:
        funct2 = () => setState(() => _form = FormType.SIGNUP);
        break;
      case FormType.SIGNUP:
        funct1 = () => setState(() => _form = FormType.LOGIN);
        break;
    }
    return Container(
      margin: EdgeInsets.only(right: size(88, 216), left: size(88, 216)),
      height: 35,
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(40.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // LogIn-Button
          _customButtons("Login", funct1),
          // SignUp-Button
          _customButtons("SignUp", funct2),
        ],
      ),
    );
  }

  Widget _customTextField(ctrl, icon, String text, {obscure = false}) {
    return Container(
      margin: EdgeInsets.only(top: 16, left: 16, right: 16),
      padding: EdgeInsets.only(left: 10, right: 15),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(30.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.8),
            spreadRadius: 1,
            blurRadius: 2,
          ),
        ],
      ),
      child: TextFormField(
        controller: ctrl,
        obscureText: obscure,
        decoration: InputDecoration(
          border: InputBorder.none,
          icon: Icon(icon),
          labelText: text,
        ),
      ),
    );
  }

  Widget _textFields() {
    return Container(
      margin: const EdgeInsets.only(right: 15, left: 15),
      child: Column(
        children: [
          // Username field
          _customTextField(_usCtrl, Icons.account_circle, 'Username eingeben'),
          // Password field
          _customTextField(_pwCtrl, Icons.mail, 'Passwort eingeben',
              obscure: true),
          // Retype Password field [SignUp]
          _form == FormType.SIGNUP
              ? _customTextField(
                  _pw2Ctrl, Icons.fiber_pin, 'Passwort bestätigen',
                  obscure: true)
              : Container(),
        ],
      ),
    );
  }

  void _skipDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Hinweis"),
          content:
              Text("Möchten Sie wirklich ohne Accountverbindung fortfahen?\n"
                  "Sie verpassen so spannende Sammelaufgaben, blah blah"),
          actions: [
            FlatButton(
              child: Text("Zurück"),
              onPressed: () => Navigator.of(context).pop(),
            ),
            FlatButton(
              child: Text("Fortfahren"),
              onPressed: _nextScreen,
            ),
          ],
        );
      },
    );
  }

  void _signUpDialog() {
    _getUS();
    print(_us.length);
    if (_us == "" || _pw == "" || _pw2 == "" || _pw != _pw2)
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Hinweis"),
            content: Text(_pw != _pw2
                ? "Die eingegebenen Passwörter stimmen nicht überein."
                : "Bitte füllen Sie alle Felder aus."),
            actions: [
              FlatButton(
                child: Text("Schließen"),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          );
        },
      );
    else
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Anmerkung"),
            content: RichText(
              text: TextSpan(
                style: TextStyle(fontSize: 18.0, color: Colors.black),
                children: [
                  TextSpan(
                      text: "Gehen Sie sicher, dass Sie für den Benutzernamen "
                          "keine persönlichen Informationen verwenden.\n"
                          "Eingabe: "),
                  TextSpan(
                      text: "$_us",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            actions: [
              FlatButton(
                child: Text("Zurück"),
                onPressed: () => Navigator.of(context).pop(),
              ),
              FlatButton(
                child: Text("Weiter"),
                onPressed: _nextScreen,
              ),
            ],
          );
        },
      );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/haupthalle_hlm_blue.png'),
            fit: BoxFit.fill,
          ),
        ),
        padding: const EdgeInsets.only(right: 16, left: 16),
        child: Center(
          child: Stack(
            children: [
              // LogIn-Box
              Container(
                height: SizeConfig.safeBlockVertical *
                    (_form == FormType.SIGNUP ? 50 : 38),
                margin: const EdgeInsets.only(bottom: 27),
                padding: const EdgeInsets.only(top: 16),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(18.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.8),
                      spreadRadius: 1,
                      blurRadius: 2,
                    ),
                  ],
                ),
                child: Column(children: [_topButtons(), _textFields()]),
              ),
              // Submit-Button
              Positioned.fill(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: RaisedButton(
                    padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                    textColor: Colors.white,
                    color: Colors.blue,
                    splashColor: Colors.blue[200].withOpacity(.4),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                    child: Text("Bestätigen", textScaleFactor: 1.3),
                    onPressed:
                        _form == FormType.SIGNUP ? _signUpDialog : _nextScreen,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: widget.skippable
          ? FlatButton(
              textColor: Colors.white,
              color: Colors.blue,
              splashColor: Colors.blueAccent,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [Text("Skip"), Icon(Icons.skip_next)],
              ),
              onPressed: _skipDialog,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              ),
            )
          : null,
    );
  }
}
