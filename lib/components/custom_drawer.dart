import 'package:cineandgo/screens/fullscreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cineandgo/constants/constants.dart';
import 'package:cineandgo/localization/app_localizations.dart';
import 'package:cineandgo/screens/welcome.dart';

class CustomDrawer extends StatelessWidget {
  CustomDrawer(
      {@required this.photoUrl,
      @required this.name,
      @required this.email,
      @required this.auth});

  final String photoUrl;
  final String name;
  final String email;
  final FirebaseAuth auth;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: kPrimaryColor,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(bottom: 15.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) {
                        return Fullscreen(
                          photoUrl: photoUrl,
                          index: 0,
                        );
                      }));
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(
                        Radius.circular(30.0),
                      ),
                      child: Hero(
                        tag: 'go_fullscreen_0',
                        child: (photoUrl != null)
                            ? Image.network(
                                photoUrl,
                                height: 60.0,
                              )
                            : Image.asset(
                                'images/default_user.png',
                                height: 60.0,
                              ),
                      ),
                    ),
                  ),
                ),
                Text(
                  name != null ? name : '',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12.0,
                  ),
                ),
                Text(
                  email != null ? email : '',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12.0,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.movie,
              color: Colors.white,
            ),
            title: Text(
              AppLocalizations.of(context).translate('all_movies'),
            ),
          ),
          ListTile(
            leading: Image.asset('images/search_movies.png'),
            title: Text(
              AppLocalizations.of(context).translate('search_movies'),
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.airline_seat_legroom_extra,
              color: Colors.white,
            ),
            title: Text(
              AppLocalizations.of(context).translate('all_rooms'),
            ),
          ),
          ListTile(
            leading: Image.asset('images/search_rooms.png'),
            title: Text(
              AppLocalizations.of(context).translate('search_rooms'),
            ),
          ),
          Divider(
            indent: 5.0,
            endIndent: 5.0,
          ),
          ListTile(
            leading: Icon(
              Icons.exit_to_app,
              color: Colors.white,
            ),
            title: Text(
              AppLocalizations.of(context).translate('sign_out'),
            ),
            onTap: () {
              auth.signOut();
              Navigator.popAndPushNamed(context, Welcome.id);
            },
          )
        ],
      ),
    );
  }
}
