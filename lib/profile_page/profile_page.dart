import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:museum_app/constants.dart';
import 'package:museum_app/database/database.dart';
import 'package:museum_app/login_page/login_page.dart';
import 'package:museum_app/museum_tabs.dart';
import 'package:museum_app/profile_page/profile_widgets.dart';

class Profile extends StatefulWidget {
  Profile({Key key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Widget _topInfo(User user) {
    return Stack(
      alignment: Alignment.centerLeft,
      children: <Widget>[
        // Picture, Nickname
        Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              height: 120,
              width: 120,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 2),
                color: Colors.white,
                //borderRadius: BorderRadius.all(Radius.circular(80.0)),
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage(user.imgPath),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Text(
              user.username + "\nOnboardEnd: " + user.onboardEnd.toString(),
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            )
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: MuseumDatabase().watchUser(),
      builder: (context, snap) {
        var user = snap.data ??
            User(username: "...", imgPath: "assets/images/profile_test.png");
        if (user.username == "") return LogIn(skippable: false);
        return MuseumTabs(
          _topInfo(user),
          {
            "Favoriten": FavWidget(),
            "Erfolge": BadgeWidget(),
            "Statistik": StatWidget(),
          },
          color: COLOR_PROFILE,
        );
      },
    );
  }
}
