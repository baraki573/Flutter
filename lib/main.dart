import 'package:flutter/material.dart';
import 'package:museum_app/database/database.dart';
import 'package:museum_app/route_generator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MuseumDatabase().initUser();
  final bool onboardEnd = await MuseumDatabase().onboardEnd();
  runApp(MyApp(onboardEnd ? "/" : "/onboard"));
}

class MyApp extends StatelessWidget {
  final String start;

  const MyApp(this.start, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    precacheImage(AssetImage('assets/images/haupthalle_hlm_blue.png'), context);
    precacheImage(
        AssetImage("assets/images/orientierungsplan_high.png"), context);

    /*return FutureBuilder(
        future: MuseumDatabase().onboardEnd(),
        builder: (context, snap) {
          if (!snap.hasData) {
            MuseumDatabase().initUser();
            //return Center(child: CircularProgressIndicator());
          }

          var onboardEnd = snap.data;
          String start =
              onboardEnd == null ? "/loading" : (onboardEnd ? "/" : "/onboard");

          print("ON " + (onboardEnd?.toString() ?? "null"));
          print("START " + start);
*/
    return MaterialApp(
      debugShowCheckedModeBanner: true,
      locale: Locale('de'),
      title: 'Museum App',
      theme: ThemeData(
        buttonTheme: ButtonThemeData(minWidth: 5),
        primarySwatch: Colors.lightBlue,
      ),
      initialRoute: start,
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
