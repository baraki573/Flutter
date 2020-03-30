import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:museum_app/database/database.dart';
import 'package:museum_app/graphql/graphqlConf.dart';
import 'package:museum_app/route_generator.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MuseumDatabase().init();
  final User user = await MuseumDatabase().getUser();
  final bool onboardEnd = user.onboardEnd;

  runApp(GraphQLProvider(
    client: GraphQLConfiguration().client,
    child: CacheProvider(
      child: MyApp(onboardEnd ? "/" : "/onboard"),
    ),
  ));
}

class MyApp extends StatelessWidget {
  final String start;

  const MyApp(this.start, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    precacheImage(AssetImage('assets/images/haupthalle_hlm_blue.png'), context);
    precacheImage(
        AssetImage("assets/images/orientierungsplan_high.png"), context);

    return MaterialApp(
      debugShowCheckedModeBanner: true,
      locale: Locale('de'),
      title: 'Geschichte Vernetzt',
      theme: ThemeData(
        buttonTheme: ButtonThemeData(minWidth: 5),
        primarySwatch: Colors.lightBlue,
      ),
      initialRoute: start,
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
