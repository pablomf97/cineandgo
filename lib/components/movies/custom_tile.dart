import 'package:cineandgo/constants/constants.dart';
import 'package:cineandgo/screens/others/fullscreen.dart';
import 'package:cineandgo/services/tmdb.dart';
import 'package:flutter/material.dart';

class CustomTile extends StatelessWidget {
  CustomTile(
      {Key key,
      @required this.photoPath,
      @required this.character,
      @required this.name,
      @required this.heroIndex})
      : super(key: key);

  final String photoPath;
  final String name;
  final String character;
  final int heroIndex;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: kPrimaryColor,
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 15.0),
        leading: GestureDetector(
          onTap: () {
            if (photoPath != null && photoPath.isNotEmpty) {
              Navigator.push(context, MaterialPageRoute(builder: (_) {
                return Fullscreen(
                  photoUrl: TMDBModel.getPosterUrl(photoPath, false),
                  index: heroIndex,
                );
              }));
            }
          },
          child: Hero(
            tag: 'go_fullscreen_$heroIndex',
            child: CircleAvatar(
              backgroundImage: (photoPath == null || photoPath.isEmpty)
                  ? AssetImage('images/logo.png')
                  : NetworkImage(
                      TMDBModel.getPosterUrl(photoPath, false),
                    ),
            ),
          ),
        ),
        title: Text(
          name,
          style: TextStyle(fontFamily: 'OpenSans', fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          'As ' + character,
          style: TextStyle(fontFamily: 'OpenSans', fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
