import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:museum_app/constants.dart';
import 'package:museum_app/database/database.dart';
import 'package:museum_app/graphql/query.dart';
import 'package:museum_app/login_page/login_page.dart';
import 'package:museum_app/museum_tabs.dart';
import 'package:museum_app/profile_page/profile_widgets.dart';
import 'package:museum_app/tours_page/tours_widgets.dart';

class Profile extends StatefulWidget {
  Profile({Key key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  /// Returns the widget to be displayed at the top.
  ///
  /// Uses the information provided by [user].
  Widget _topInfo(User user) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // profile picture

        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 2),
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          margin: EdgeInsets.symmetric(horizontal: 16),
          child: ClipOval(
            child: user.imgPath == ""
                ? Image.asset("assets/images/empty_profile.png")
                : QueryBackend.netWorkImage(
                    QueryBackend.imageURLProfile(user.imgPath),
                    height: 120,
                    width: 120,
                  ),
          ),
        ),
        /*Container(
          margin: EdgeInsets.symmetric(horizontal: 16),
          height: 120,
          width: 120,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 2),
            color: Colors.white,
            shape: BoxShape.circle,
            image: DecorationImage(
                image: AssetImage(user.imgPath), fit: BoxFit.fill),
          ),
        ),*/
        // username
        Text(
          user.username + "\nOnboardEnd: " + user.onboardEnd.toString(),
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: MuseumDatabase().watchUser(),
      builder: (context, snap) {
        User user = snap.data ??
            User(username: "...", imgPath: "assets/images/empty_profile.png");
        // if no user is currently logged in, show the login-screen
        if (user.accessToken?.trim() == "") return LogIn(skippable: false);
        // create the tab layout
        return MuseumTabs(
          _topInfo(user),
          {
            "Favoriten": FavWidget(),
            "Meine Touren":
                DownloadColumn(QueryBackend.created, color: COLOR_PROFILE),
            "Erfolge": BadgeWidget(),
            //"Statistik": StatWidget(),
          },
          color: COLOR_PROFILE,
        );
      },
    );
  }
}
