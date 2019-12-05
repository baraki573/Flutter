import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:museum_app/bottom_navigationbar/navigationbar_pattern.dart';

class LogIn extends StatefulWidget {
  LogIn({Key key}) : super(key: key);

  @override
  _LogInState createState() => _LogInState();
}

enum FormType { login, register }

class _LogInState extends State<LogIn> {
  FormType _form = FormType.login;
  String _us, _pw, _pw2;
  final usCtrl = TextEditingController();
  final pwCtrl = TextEditingController();
  final pw2Ctrl = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
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

  /*
  void _formChange() async {
    setState(() {
      if (_form == FormType.register) {
        _form = FormType.login;
      } else {
        _form = FormType.register;
      }
    });
  }*/

  void _nextScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => BottomBarNavigationPatternExample()),
    );
  }

  Widget _getMyButton(text, funct){
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

  Widget _topButtons(bool portrait) {
    String s1 = _form == FormType.login ? 'LOGIN' : 'LogIn';
    var funct1 = _form == FormType.login
        ? null
        : () => setState(() {
              _form = FormType.login;
            });
    String s2 = _form == FormType.register ? 'SIGNUP' : 'SignUp';
    var funct2 = _form == FormType.register
        ? null
        : () => setState(() {
              _form = FormType.register;
            });
    return new Container(
      margin: EdgeInsets.only(
          right: (portrait ? 82 : 222), left: (portrait ? 82 : 222)),
      height: 35,
      decoration: new BoxDecoration(
        color: Colors.grey,
        borderRadius: new BorderRadius.circular(40.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          // LogIn-Button
          _getMyButton(s1, funct1),
          // SignUp-Button
          _getMyButton(s2, funct2),
        ],
      ),
    );
  }


  Widget _getMyTextField(ctrl, icon, text, obscure){
    return Container(
      margin: EdgeInsets.only(top: 15),
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
          _getMyTextField(usCtrl, Icons.account_circle, 'Username eingeben', false),
          // Password field
          _getMyTextField(pwCtrl, Icons.mail, 'Passwort eingeben', true),
          // Retype Password field [SignUp]
          _form == FormType.register
              ? _getMyTextField(pw2Ctrl, Icons.fiber_pin, 'Passwort bestätigen', true)
              : Container(),
        ],
      ),
    );
  }

  Widget _bottomButtons() {
    if (_form == FormType.login) {
      return FlatButton(
        child: new Text('Passwort vergessen?'),
        onPressed: _getUS,
      );
    } else {
      return Text(
          "Verwenden Sie für den Benutzernamen keine persönlichen Informationen.\n",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontStyle: FontStyle.italic,
            fontSize: 18,
          ));
      /*child: new Column(
          children: <Widget>[
            new RaisedButton(
              child: new Text('Accounterstellung'),
              onPressed: () {
                if (_getUS()) _nextScreen();
              },
            ),
          ],
        ),
      ;*/
    }
  }

  Widget _introText() {
    return Container(
      child: Text(
        'Bitte melden Sie sich unten mit Ihren Accountdaten an. Sollten Sie noch keinen Account besitzen, können Sie über \"Signup\" einen anfordern.',
        textAlign: TextAlign.left,
        style: TextStyle(
          fontSize: 18,
        ),
      ),
    );
  }

  void _showDialog() {
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
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    return Scaffold(
      /*appBar: AppBar(
        title: Text("Account einrichten"),
      ),*/
      backgroundColor: Colors.amber,
      body: Center(
        child: ListView(
          padding: const EdgeInsets.only(right: 10, left: 10),
          shrinkWrap: true,
          children: <Widget>[
            //Container(
            //decoration: BoxDecoration,
            //margin: const EdgeInsets.only(right: 10, left: 10),
            //_introText(),
            //Container(height: screenHeight / 5),
            // Debug only
            //Text('Username: $_us; Password: $_pw; Password2: $_pw2'),
            //child:
            Stack(
              overflow: Overflow.visible,
              children: <Widget>[
                // LogIn-Box
                Container(
                  //height: screenHeight * (_form == FormType.register ? 0.4 : 0.3),
                  margin: const EdgeInsets.only(bottom: 27),
                  padding: const EdgeInsets.only(top: 10, bottom: 35),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(18.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.8),
                        spreadRadius: 1,
                        blurRadius: 2,
                        //offset: Offset(0, 7), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Column(
                    children: <Widget>[
                      //Container(height: 10),
                      _topButtons(isPortrait),
                      _textFields(),
                      //Container(height: 30),
                    ],
                  ),
                ),
                // Submit-Button
                Positioned.fill(
                  //top: _form == FormType.register ? 230 : 165,
                  //top: screenHeight * 0.1,
                  //bottom: screenHeight * 0.7,
                  //left: screenWidth * 0.3,
                  //right: screenWidth * 0.3,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    //(0, _form==FormType.login?1.35:0.65),
                    child: RaisedButton(
                      textColor: Colors.white,
                      color: Colors.blue,
                      splashColor: Colors.blueAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(18.0),
                        //side: BorderSide(color: Colors.red)
                      ),
                      child: Text(
                        "Submit",
                        textScaleFactor: 1.5,
                      ),
                      onPressed: _form == FormType.register
                          ? _showDialog
                          : _nextScreen,
                    ),
                  ),
                ),
              ],
            ),
            //_bottomButtons()
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _nextScreen,
        tooltip: "Überspringen",
        child: Icon(Icons.skip_next),
      ),
    );
  }
}
