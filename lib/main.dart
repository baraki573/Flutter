import 'package:flutter/material.dart';
import 'package:museum_app/database/database.dart';
import 'package:museum_app/route_generator.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    precacheImage(AssetImage('assets/images/haupthalle_hlm_blue.png'), context);
    precacheImage(
        AssetImage("assets/images/orientierungsplan_high.png"), context);

    return StreamBuilder(
      stream: MuseumDatabase.get().watchUser(),
      builder: (context, snap) {
        bool onboardEnd = (snap.data)?.onboardEnd;
        if (onboardEnd == null) return Container();
        print(onboardEnd);
        return MaterialApp(
          debugShowCheckedModeBanner: true,
          locale: Locale('de'),
          title: 'Museum App',
          theme: ThemeData(
            buttonTheme: ButtonThemeData(minWidth: 5),
            primarySwatch: Colors.lightBlue,
          ),
          //home: Onboarding(),
          //home: Home(),
          initialRoute: onboardEnd ? '/' : '/onboard',
          onGenerateRoute: RouteGenerator.generateRoute,
        );
      },
    );
  }
}
