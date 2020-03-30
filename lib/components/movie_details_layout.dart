import 'package:auto_size_text/auto_size_text.dart';
import 'package:cineandgo/constants/constants.dart';
import 'package:cineandgo/localization/app_localizations.dart';
import 'package:cineandgo/screens/fullscreen.dart';
import 'package:cineandgo/services/tmdb.dart';
import 'package:flutter/material.dart';
import 'custom_tile.dart';
import 'genre_container.dart';

// TODO: Clean code and separate it in diferent components

class MovieDetailsLayout extends StatefulWidget {
  MovieDetailsLayout(
      {@required this.id,
      @required this.posterPath,
      @required this.title,
      @required this.originalTitle,
      @required this.overview,
      @required this.voteAverage,
      @required this.evaluation,
      @required this.genres});

  final String id;
  final String posterPath;
  final String title;
  final String originalTitle;
  final String voteAverage;
  final String overview;
  final String evaluation;
  final List<GenreContainer> genres;

  @override
  _MovieDetailsLayoutState createState() => _MovieDetailsLayoutState(
        id: id,
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
      {@required this.id,
      @required this.posterPath,
      @required this.title,
      @required this.originalTitle,
      @required this.overview,
      @required this.voteAverage,
      @required this.evaluation,
      @required this.genres});

  final String id;
  final String posterPath;
  final String title;
  final String originalTitle;
  final String voteAverage;
  final String overview;
  final String evaluation;
  final List<GenreContainer> genres;

  List<CustomTile> cast = [];
  TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(
      length: 3,
      vsync: this,
    );
    getCast();
    super.initState();
  }

  void getCast() async {
    var movieCast = await TMDBModel.getCast(id);

    if (movieCast != null) {
      List<CustomTile> aux = [];
      int i = 1;
      for (var actor in movieCast['cast']) {
        aux.add(CustomTile(
          photoPath: actor['profile_path'],
          name: actor['name'],
          character: actor['character'],
          heroIndex: i++,
        ));
      }
      setState(() {
        cast = aux;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        TweenAnimationBuilder(
          tween: Tween<Offset>(
            begin: Offset(0, -1.0),
            end: Offset(0, 0),
          ),
          duration: Duration(milliseconds: 350),
          curve: Curves.decelerate,
          builder: (context, offset, child) {
            return FractionalTranslation(
              translation: offset,
              child: Container(
                width: double.infinity,
                child: Center(
                  child: child,
                ),
              ),
            );
          },
          child: Container(
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
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) {
                            return Fullscreen(
                              photoUrl:
                                  TMDBModel.getPosterUrl(posterPath, false),
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
                                    image: (posterPath == null ||
                                            posterPath.isEmpty)
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
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 15.0),
                                      width: MediaQuery.of(context).size.width *
                                          0.25,
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
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: TweenAnimationBuilder(
            tween: Tween<Offset>(
              begin: Offset(0, -1.0),
              end: Offset(0, 0.0),
            ),
            duration: Duration(milliseconds: 350),
            curve: Curves.decelerate,
            builder: (context, offset, child) {
              return FractionalTranslation(
                translation: offset,
                child: Container(
                  width: double.infinity,
                  child: Center(
                    child: child,
                  ),
                ),
              );
            },
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    alignment: Alignment.topCenter,
                    child: TabBar(
                      controller: _tabController,
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
                    controller: _tabController,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 10.0),
                        child: AutoSizeText(
                          overview,
                          textAlign: TextAlign.justify,
                          maxLines: 10,
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
                      ListView(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 10.0),
                        children: cast,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
