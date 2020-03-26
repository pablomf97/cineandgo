import 'package:cineandgo/constants/constants.dart';
import 'package:cineandgo/services/tmdb.dart';
import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  CustomCard(
      {@required this.title,
      @required this.posterPath,
      @required this.function});

  final String posterPath;
  final String title;
  final Function function;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Card(
        elevation: 1.5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Container(
          width: 230.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: (posterPath == null || posterPath.isEmpty)
                  ? AssetImage('images/logo.png')
                  : NetworkImage(
                      TMDBModel.getPosterUrl(posterPath, true),
                    ),
            ),
          ),
          alignment: Alignment.bottomCenter,
          child: FractionallySizedBox(
            heightFactor: 0.25,
            child: Container(
              decoration: BoxDecoration(
                color: kPrimaryColor.withOpacity(0.9),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10.0),
                  bottomRight: Radius.circular(10.0),
                ),
              ),
              alignment: Alignment.center,
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'OpenSans',
                  fontWeight: FontWeight.bold,
                  fontSize: 15.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
