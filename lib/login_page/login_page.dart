import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:museum_app/SizeConfig.dart';
import 'package:museum_app/bottom_navigationbar/navigationbar_pattern.dart';
import 'package:museum_app/database/database.dart';

class LogIn extends StatefulWidget {
  LogIn({Key key}) : super(key: key);

  @override
  _LogInState createState() => _LogInState();
}

enum FormType { login, signup }

class _LogInState extends State<LogIn> {
  FormType _form;
  String _us, _pw, _pw2;
  final usCtrl = TextEditingController();
  final pwCtrl = TextEditingController();
  final pw2Ctrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    _form = FormType.login;
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
    usCtrl.dispose();
    pwCtrl.dispose();
    pw2Ctrl.dispose();
    super.dispose();
  }

  bool _getUS() {
    setState(() {
      _us = usCtrl.text;
      _pw = pwCtrl.text;
      _pw2 = pw2Ctrl.text;
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
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => BottomBarNavigationPatternExample()),
    );
    MuseumDatabase.get().updateOnboard(true);
  }

  Widget _customButtons(text, funct) {
    return FlatButton(
      //color: Colors.grey[300],
      textColor: Colors.black54,
      disabledColor: Colors.blue,
      disabledTextColor: Colors.white,
      splashColor: Colors.blueAccent,
      child: Text(text),
      onPressed: funct,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18.0),
        //side: BorderSide(color: Colors.red)
      ),
    );
  }

  Widget _topButtons() {
    String s1 = _form == FormType.login ? 'LOGIN' : 'LogIn';
    var funct1 = _form == FormType.login
        ? null
        : () => setState(() {
              _form = FormType.login;
            });
    String s2 = _form == FormType.signup ? 'SIGNUP' : 'SignUp';
    var funct2 = _form == FormType.signup
        ? null
        : () => setState(() {
              _form = FormType.signup;
            });
    return new Container(
      margin: EdgeInsets.only(right: size(88, 216), left: size(88, 216)),
      height: 35,
      decoration: new BoxDecoration(
        color: Colors.grey,
        borderRadius: new BorderRadius.circular(40.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          // LogIn-Button
          _customButtons(s1, funct1),
          // SignUp-Button
          _customButtons(s2, funct2),
        ],
      ),
    );
  }

  Widget _customTextField(ctrl, icon, text, obscure) {
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
            blurRadius: 1,
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
        children: <Widget>[
          // Username field
          _customTextField(
              usCtrl, Icons.account_circle, 'Username eingeben', false),
          // Password field
          _customTextField(pwCtrl, Icons.mail, 'Passwort eingeben', true),
          // Retype Password field [SignUp]
          _form == FormType.signup
              ? _customTextField(
                  pw2Ctrl, Icons.fiber_pin, 'Passwort bestätigen', true)
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
          actions: <Widget>[
            FlatButton(
              child: Text("Zurück"),
              onPressed: () {
                Navigator.of(context).pop();
              },
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

  void _submitDialog() {
    _getUS();
    if (_us == "" || _pw == "" || _pw2 == "" || _pw != _pw2)
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Hinweis"),
            content: Text(_pw != _pw2
                ? "Die eingegebenen Passwörter stimmen nicht überein."
                : "Bitte füllen Sie alle Felder aus."),
            actions: <Widget>[
              FlatButton(
                child: Text("Schließen"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    else
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Anmerkung"),
            content: RichText(
              text: TextSpan(
                style: new TextStyle(
                  fontSize: 18.0,
                  color: Colors.black,
                ),
                children: <TextSpan>[
                  TextSpan(
                      text: "Gehen Sie sicher, dass Sie für den Benutzernamen "
                          "keine persönlichen Informationen verwenden.\n"
                          "Eingegeben: "),
                  TextSpan(
                      text: "$_us",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text("Zurück"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
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
      //backgroundColor: Colors.amber,
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
            overflow: Overflow.visible,
            children: <Widget>[
              // LogIn-Box
              Container(
                height: SizeConfig.safeBlockVertical *
                    (_form == FormType.signup ? 50 : 38),
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
                child: Column(
                  children: <Widget>[
                    //Container(height: 10),
                    _topButtons(),
                    _textFields(),
                    //Container(height: 30),
                  ],
                ),
              ),
              // Submit-Button
              Positioned.fill(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  //(0, _form==FormType.login?1.35:0.65),
                  child: RaisedButton(
                    padding: EdgeInsets.only(
                        left: 25, right: 25, top: 10, bottom: 10),
                    textColor: Colors.white,
                    color: Colors.blue,
                    splashColor: Colors.blueAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      //side: BorderSide(color: Colors.red)
                    ),
                    child: Text(
                      "Submit",
                      textScaleFactor: 1.3,
                    ),
                    onPressed:
                        _form == FormType.signup ? _submitDialog : _nextScreen,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FlatButton(
        textColor: Colors.white,
        color: Colors.blue,
        splashColor: Colors.blueAccent,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text("Skip"),
            Icon(Icons.skip_next),
          ],
        ),
        onPressed: _skipDialog,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
        ),
      ),
    );
  }
}
