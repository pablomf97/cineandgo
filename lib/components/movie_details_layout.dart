import 'package:auto_size_text/auto_size_text.dart';
import 'package:cineandgo/components/room_list.dart';
import 'package:cineandgo/constants/constants.dart';
import 'package:cineandgo/localization/app_localizations.dart';
import 'package:cineandgo/screens/fullscreen.dart';
import 'package:cineandgo/services/tmdb.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'custom_tile.dart';
import 'genre_container.dart';
import 'movie_card.dart';

// TODO: Clean code and separate it in diferent components
// TODO: Add tab to see rooms

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
      length: 4,
      vsync: this,
      initialIndex: 0,
    );
    // getRooms();
    getCast();
    super.initState();
  }

  // TODO: Finish implementing room list

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
            child: MovieCard(
                posterPath: posterPath,
                title: title,
                originalTitle: originalTitle,
                voteAverage: voteAverage,
                evaluation: evaluation),
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
                        Text(
                          AppLocalizations.of(context).translate('rooms'),
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
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: RoomList(movieId: id),
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
