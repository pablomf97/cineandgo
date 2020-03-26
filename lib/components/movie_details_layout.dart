import 'package:cineandgo/constants/constants.dart';
import 'package:cineandgo/localization/app_localizations.dart';
import 'package:cineandgo/screens/fullscreen.dart';
import 'package:cineandgo/services/tmdb.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'genre_container.dart';

class MovieDetailsLayout extends StatefulWidget {
  MovieDetailsLayout(
      {@required this.posterPath,
      @required this.title,
      @required this.originalTitle,
      @required this.overview,
      @required this.voteAverage,
      @required this.evaluation,
      @required this.genres});

  final String posterPath;
  final String title;
  final String originalTitle;
  final String voteAverage;
  final String overview;
  final String evaluation;
  final List<GenreContainer> genres;

  @override
  _MovieDetailsLayoutState createState() => _MovieDetailsLayoutState(
        title: title,
        originalTitle: originalTitle,
        overview: overview,
        voteAverage: voteAverage,
        posterPath: posterPath,
        evaluation: evaluation,
        genres: genres,
      );
}

class _MovieDetailsLayoutState extends State<MovieDetailsLayout>
    with SingleTickerProviderStateMixin {
  _MovieDetailsLayoutState(
      {@required this.posterPath,
      @required this.title,
      @required this.originalTitle,
      @required this.overview,
      @required this.voteAverage,
      @required this.evaluation,
      @required this.genres});

  final String posterPath;
  final String title;
  final String originalTitle;
  final String voteAverage;
  final String overview;
  final String evaluation;
  final List<GenreContainer> genres;
  TabController controller;

  @override
  void initState() {
    controller = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height * 0.35,
          child: Material(
            elevation: 3.0,
            color: Colors.orange[50],
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
                          );
                        }));
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Hero(
                        tag: 'go_fullscreen',
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
                                  image:
                                      (posterPath == null || posterPath.isEmpty)
                                          ? AssetImage('images/logo.png')
                                          : NetworkImage(TMDBModel.getPosterUrl(
                                              posterPath, false)),
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
                              child: FittedBox(
                                fit: BoxFit.fitWidth,
                                child: Text(
                                  voteAverage,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: 'OpenSans',
                                    height: 1.05,
                                  ),
                                ),
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
          ),
        ),
        Expanded(
          flex: 1,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  alignment: Alignment.topCenter,
                  child: TabBar(
                    controller: controller,
                    labelColor: Colors.white,
                    unselectedLabelColor: kPrimaryColor,
                    labelPadding: EdgeInsets.all(2.0),
                    indicator: ShapeDecoration(
                      color: kPrimaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40.0),
                      ),
                    ),
                    tabs: <Widget>[
                      Text(
                        AppLocalizations.of(context).translate('overview'),
                        style: TextStyle(
                          fontFamily: 'OpenSans',
                          fontSize: 17.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        AppLocalizations.of(context).translate('genres'),
                        style: TextStyle(
                          fontFamily: 'OpenSans',
                          fontSize: 17.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        AppLocalizations.of(context).translate('cast'),
                        style: TextStyle(
                          fontFamily: 'OpenSans',
                          fontSize: 17.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: controller,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15.0, vertical: 10.0),
                      child: AutoSizeText(
                        overview,
                        textAlign: TextAlign.justify,
                        maxLines: 7,
                        style: TextStyle(
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15.0, vertical: 10.0),
                      child: Wrap(
                        alignment: WrapAlignment.center,
                        children: genres,
                      ),
                    ),
                    Text('data'),
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}

// TabBarView(
//                controller: tabController,
//                children: [
//                  Text('ceec'),
//                  Text('ceeceec'),
//                  Text('ceeceeceec'),
//                ],
//              )

// Column(
//            children: <Widget>[
//              ListTile(
//                title: Text(
//                  AppLocalizations.of(context).translate('overview'),
//                ),
//                onTap: () {
//                  showDialog(
//                      context: context,
//                      builder: (BuildContext context) {
//                        return AlertDialog(
//                          shape: RoundedRectangleBorder(
//                            borderRadius: BorderRadius.circular(20.0),
//                          ),
//                          content: Text(
//                            overview,
//                            style: TextStyle(
//                              fontSize: 15.0,
//                              fontFamily: 'OpenSans',
//                            ),
//                            textAlign: TextAlign.justify,
//                          ),
//                          actions: <Widget>[
//                            FlatButton(
//                              shape: RoundedRectangleBorder(
//                                borderRadius: BorderRadius.circular(40.0),
//                                side: BorderSide(
//                                  color: kPrimaryColor,
//                                  width: 1.0,
//                                ),
//                              ),
//                              textColor: kPrimaryColor,
//                              child: Text(
//                                AppLocalizations.of(context).translate('close'),
//                                style: TextStyle(
//                                  fontSize: 15.0,
//                                  fontFamily: 'OpenSans',
//                                ),
//                              ),
//                              onPressed: () {
//                                Navigator.of(context).pop();
//                              },
//                            ),
//                          ],
//                        );
//                      });
//                },
//              ),
//              ListTile(
//                title: Text(AppLocalizations.of(context).translate('genres')),
//                onTap: () {
//                  showDialog(
//                      context: context,
//                      builder: (BuildContext context) {
//                        return AlertDialog(
//                          shape: RoundedRectangleBorder(
//                            borderRadius: BorderRadius.circular(20.0),
//                          ),
//                          content: Padding(
//                            padding: EdgeInsets.symmetric(
//                              horizontal: 15.0,
//                              vertical: 5.0,
//                            ),
//                            child: Wrap(
//                              children: genres,
//                            ),
//                          ),
//                          actions: <Widget>[
//                            FlatButton(
//                              textColor: kPrimaryColor,
//                              child: Text(
//                                AppLocalizations.of(context).translate('close'),
//                                style: TextStyle(
//                                  fontSize: 15.0,
//                                  fontFamily: 'OpenSans',
//                                ),
//                              ),
//                              onPressed: () {
//                                Navigator.of(context).pop();
//                              },
//                            ),
//                          ],
//                        );
//                      });
//                },
//              ),
//            ],
//          )
