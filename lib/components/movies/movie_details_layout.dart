import 'package:auto_size_text/auto_size_text.dart';
import 'package:cineandgo/components/rooms/room_list.dart';
import 'package:cineandgo/constants/constants.dart';
import 'package:cineandgo/localization/app_localizations.dart';
import 'package:cineandgo/services/tmdb.dart';
import 'package:flutter/material.dart';
import 'custom_tile.dart';
import 'genre_container.dart';
import 'movie_card.dart';

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
  _MovieDetailsLayoutState createState() => _MovieDetailsLayoutState();
}

class _MovieDetailsLayoutState extends State<MovieDetailsLayout>
    with SingleTickerProviderStateMixin {
  // Cast
  List<Widget> _cast = [
    Center(
      child: CircularProgressIndicator(),
    )
  ];
  // Tab stuff
  TabController _tabController;
  // The text style of the tab bar
  final TextStyle _tabBarTextStyle = TextStyle(
    fontFamily: 'OpenSans',
    fontSize: 17.0,
    fontWeight: FontWeight.bold,
  );

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 4,
      vsync: this,
      initialIndex: 0,
    );
    buildCastList();
  }

  /* 
  Builds the list of 'CustomTiles' that contains all
  the cast of the movie that is being displayed.
  */
  void buildCastList() async {
    var movieCast = await TMDBModel.getCast(widget.id);

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
        _cast = aux;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        /* 
        Animation that makes the movie card appear from offscreen.
        */
        SlideInAnimation(
          child: MovieCard(
              posterPath: widget.posterPath,
              title: widget.title,
              originalTitle: widget.originalTitle,
              voteAverage: widget.voteAverage,
              evaluation: widget.evaluation),
          durationInMillis: 350,
        ),
        Expanded(
          child: SlideInAnimation(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    alignment: Alignment.topCenter,
                    child: TabBar(
                      controller: _tabController,
                      labelColor: Colors.black,
                      unselectedLabelColor: Colors.white,
                      labelPadding: EdgeInsets.all(2.0),
                      indicator: ShapeDecoration(
                        color: kAccentColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40.0),
                        ),
                      ),
                      tabs: <Widget>[
                        Text(
                          AppLocalizations.of(context).translate('overview'),
                          style: _tabBarTextStyle,
                        ),
                        Text(
                          AppLocalizations.of(context).translate('genres'),
                          style: _tabBarTextStyle,
                        ),
                        Text(
                          AppLocalizations.of(context).translate('cast'),
                          style: _tabBarTextStyle,
                        ),
                        Text(
                          AppLocalizations.of(context).translate('rooms'),
                          style: _tabBarTextStyle,
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
                          widget.overview,
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
                          children: widget.genres,
                        ),
                      ),
                      ListView(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5.0, vertical: 5.0),
                        children: _cast,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 0.0),
                        child: RoomList(movieId: widget.id),
                      ),
                    ],
                  ),
                )
              ],
            ),
            durationInMillis: 450,
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

class SlideInAnimation extends StatelessWidget {
  SlideInAnimation({
    @required this.child,
    @required this.durationInMillis,
  });

  final Widget child;
  final int durationInMillis;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween<Offset>(
        begin: Offset(0, -1.0),
        end: Offset(0, 0),
      ),
      duration: Duration(milliseconds: durationInMillis),
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
      child: child,
    );
  }
}
