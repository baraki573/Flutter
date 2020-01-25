import 'package:flutter/material.dart';
import 'package:museum_app/route_generator.dart';

//void main() => runApp(MyApp());
void main() => runApp(MyApp());


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    precacheImage(AssetImage('assets/images/haupthalle_hlm_blue.png'), context);
    precacheImage(AssetImage("assets/images/orientierungsplan_high.png"), context);
    return MaterialApp(
      debugShowCheckedModeBanner: true,
      title: 'Museum App',
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
      ),
      //home: Onboarding(),
      //home: Home(),
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}