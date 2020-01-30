import 'package:flutter/material.dart';
import 'package:moor/moor.dart';
import 'package:museum_app/database/database.dart';
import 'package:museum_app/onboarding/onboarding.dart';
import 'package:provider/provider.dart';

//void main() => runApp(MyApp());
void main() => runApp(MyApp());


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    precacheImage(AssetImage('assets/images/haupthalle_hlm_blue.png'), context);
    precacheImage(AssetImage("assets/images/orientierungsplan_high.png"), context);
    return MaterialApp(
      debugShowCheckedModeBanner: true,
      locale: Locale('de'),
      title: 'Museum App',
      theme: ThemeData(
        buttonTheme:ButtonThemeData(minWidth: 5),
        primarySwatch: Colors.lightBlue,
      ),
      home: Onboarding(),
    );
  }
}