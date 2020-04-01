import 'package:auto_size_text/auto_size_text.dart';
import 'package:cineandgo/constants/constants.dart';
import 'package:cineandgo/screens/fullscreen.dart';
import 'package:cineandgo/services/tmdb.dart';
import 'package:flutter/material.dart';

class MovieCard extends StatelessWidget {
  const MovieCard({
    Key key,
    @required this.posterPath,
    @required this.title,
    @required this.originalTitle,
    @required this.voteAverage,
    @required this.evaluation,
  }) : super(key: key);

  final String posterPath;
  final String title;
  final String originalTitle;
  final String voteAverage;
  final String evaluation;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 3.0,
      color: kVeryLightPrimaryColor,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
        bottomRight: Radius.circular(20.0),
        bottomLeft: Radius.circular(20.0),
      )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: GestureDetector(
              onTap: () {
                if (posterPath != null && posterPath.isNotEmpty) {
                  Navigator.push(context, MaterialPageRoute(builder: (_) {
                    return Fullscreen(
                      photoUrl: TMDBModel.getPosterUrl(posterPath, false),
                      index: 0,
                    );
                  }));
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Hero(
                  tag: 'go_fullscreen_0',
                  child: FractionallySizedBox(
                    heightFactor: 1.0,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: (posterPath == null || posterPath.isEmpty)
                                ? AssetImage('images/logo.png')
                                : NetworkImage(
                                    TMDBModel.getPosterUrl(posterPath, false)),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Expanded(
                        flex: 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              child: AutoSizeText(
                                title,
                                maxLines: 2,
                                style: TextStyle(
                                  fontFamily: 'OpenSans',
                                  fontSize: 30.0,
                                ),
                              ),
                            ),
                            Expanded(
                              child: AutoSizeText(
                                originalTitle,
                                maxLines: 2,
                                style: TextStyle(
                                  fontFamily: 'OpenSans',
                                  color: Colors.black45,
                                  fontSize: 20.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 15.0),
                              width: MediaQuery.of(context).size.width * 0.25,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: kPrimaryColor,
                              ),
                              child: AutoSizeText(
                                voteAverage,
                                textAlign: TextAlign.center,
                                maxLines: 1,
                                style: TextStyle(
                                  fontFamily: 'OpenSans',
                                  height: 1.25,
                                  color: Colors.white,
                                  fontSize: 150,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          evaluation,
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            fontSize: 15.0,
                            fontFamily: 'OpenSans',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
