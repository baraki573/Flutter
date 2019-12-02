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
  String _us, _pw;
  final usCtrl = TextEditingController();
  final pwCtrl = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    usCtrl.dispose();
    pwCtrl.dispose();
    super.dispose();
  }

  bool _getUS() {
    setState(() {
      _us = usCtrl.text;
      _pw = pwCtrl.text;
    });
    return _us!="" && _pw!="";
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
      MaterialPageRoute(builder: (context) => BottomBarNavigationPatternExample()),
    );
  }

  Widget _topButtons() {
    String s1 = _form==FormType.login ? 'LOGIN' : 'LogIn';
    var funct1 = _form==FormType.login ? null : () => setState(() {_form = FormType.login;});
    String s2 = _form==FormType.register ? 'SIGNUP' : 'SignUp';
    var funct2 = _form==FormType.register ? null : () => setState(() {_form = FormType.register;});
    return new Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          // LogIn-Button
          FlatButton(
            color: Colors.grey[300],
            textColor: Colors.black54,
            disabledColor: Colors.blue,
            disabledTextColor: Colors.white,
            splashColor: Colors.blueAccent,
            child: new Text(s1),
            onPressed: funct1,
          ),
          // SignUp-Button
          FlatButton(
            color: Colors.grey[300],
            textColor: Colors.black54,
            disabledColor: Colors.blue,
            disabledTextColor: Colors.white,
            splashColor: Colors.blueAccent,
            child: new Text(s2),
            onPressed: funct2,
          ),
        ],
      ),
    );
  }

  Widget _textFields() {
    return Column(
      children: <Widget>[
        // Username field
        Container(
          margin: const EdgeInsets.only(right: 10, left: 10),
          child: TextFormField(
            controller: usCtrl,
            decoration: InputDecoration(icon: Icon(Icons.account_circle), labelText: 'Username eingeben'),
          ),
        ),
        // Password field
        Container(
          margin: const EdgeInsets.only(right: 10, left: 10),
          child: TextFormField(
            controller: pwCtrl,
            decoration: InputDecoration(icon: Icon(Icons.mail), labelText: 'Passwort eingeben'),
            obscureText: true,
          ),
        ),
      ],
    );
  }

  Widget _bottomButtons() {
    if (_form == FormType.login) {
      return new Container(
        child: new Column(
          children: <Widget>[
            new RaisedButton(
              child: new Text('Login'),
              onPressed: () {if (_getUS()) _nextScreen();},
            ),
            new FlatButton(
              child: new Text('Passwort vergessen?'),
              onPressed: null,
            ),
          ],
        ),
      );
    } else {
      return new Container(
        child: new Column(
          children: <Widget>[
            new RaisedButton(
              child: new Text('Accounterstellung'),
              onPressed: () {if (_getUS()) _nextScreen();},
            ),
          ],
        ),
      );
    }
  }

  Widget _introText() {
    return Container(
      margin: const EdgeInsets.only(right: 10, left: 10, top: 10),
      child: Text(
        'Bitte melden Sie sich unten mit Ihren Accountdaten an. Sollten Sie noch keinen Account besitzen, können Sie über \"Signup\" einen anfordern.',
        textAlign: TextAlign.left,
        style: TextStyle(
          fontSize: 18,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text("Account einrichten"),
      ),
      body: ListView(
          children: <Widget>[
            _introText(),
            _topButtons(),
            // Debug only
            Container(
              margin: const EdgeInsets.only(right: 10, left: 10),
              child: Text('Username: $_us; Password: $_pw'),
            ),
            _textFields(),
            _bottomButtons(),
            Text(
              (_form==FormType.register ? "Verwenden Sie für den Benutzernamen keine persönlichen Informationen." : ""),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontStyle: FontStyle.italic,
                fontSize: 18,
              ),
            ),
          ],
        ),
      floatingActionButton: FloatingActionButton(
        onPressed: _nextScreen,
        tooltip: "Überspringen",
        child: Icon(Icons.skip_next),
      ),
    );
  }
}