import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:museum_app/database/database.dart';
import 'package:museum_app/museum_tabs.dart';
import 'package:museum_app/profile_page/profile_widgets.dart';

class Profile extends StatefulWidget {
  Profile({Key key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

enum InfoType { fav, badge, stat }


class _ProfileState extends State<Profile> {
  InfoType _type = InfoType.fav;

  /* StreamBuilder<List<User>> _builder() {
    final db = MuseumDatabase.get();
    return StreamBuilder(
      stream: db.getUser(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        final list = snapshot.data ?? User(username: "HELP", imgPath: "KJ");
        print(list);
        return Text(
          list[0].username,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        );
      },
    );
  }*/

  Widget _topInfo() {
    return StreamBuilder(
        stream: MuseumDatabase.get().watchUser(),
        builder: (context, snap) {
          var user = snap.data ??
              User(username: "", imgPath: "assets/images/profile_test.png");
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
                    user.username,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  )
                ],
              ),
              // Option Button

            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return MuseumTabs(
      _topInfo(),
      {"Favoriten": FavWidget(), "Erfolge": BadgeWidget(), "Statistik": StatWidget()},
      staticScroll: [2],
      color: Colors.green,
    );
  }
}
