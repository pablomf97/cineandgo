import 'dart:ui';
import 'package:cineandgo/components/custom_card.dart';
import 'package:cineandgo/constants/constants.dart';
import 'package:cineandgo/localization/app_localizations.dart';
import 'package:cineandgo/services/tmdb.dart';
import 'package:flutter/material.dart';
import 'movie_details.dart';

class AllMovieList extends StatefulWidget {
  AllMovieList({Key key}) : super(key: key);

  @override
  _AllMovieListState createState() => _AllMovieListState();
}

class _AllMovieListState extends State<AllMovieList> {
  final ScrollController _scrollController = ScrollController();

  /* 
  Used to know what the current page is
  and which one is the last page.
  */
  int _currentPage = 1;
  int _totalPages = 1;

  /* 
  This widget will be at the middle of the screen, showing 
  a spinner that will indicate that the app is loading
  all the movies.

  When the app finishes loading all the movies, this
  widget will change to a paginated grid of movies.
  */
  Widget _movies;

  /* 
  This method builds the grid.
  */
  void buildGrid() async {
    _movies =
        SliverFillRemaining(child: Center(child: CircularProgressIndicator()));

    var movieData =
        await TMDBModel.getNowPlaying(window.locale.countryCode, _currentPage);

    if (movieData != null) {
      Widget aux = SliverGrid(
          delegate: SliverChildBuilderDelegate(
            (context, index) => CustomCard(
              title: movieData['results'][index]['title'],
              posterPath: movieData['results'][index]['poster_path'],
              function: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) {
                      return MovieDetails(
                        movieId: movieData['results'][index]['id'].toString(),
                        title: movieData['results'][index]['title'],
                      );
                    },
                  ),
                );
              },
            ),
            childCount: movieData['results'].length,
          ),
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2));
      setState(() {
        _movies = aux;
        _totalPages = movieData['total_pages'];
      });
    } else {
      setState(() {
        _movies = Center(child: Text('Oops! Error...'));
      });
    }
  }

  @override
  void initState() {
    super.initState();
    buildGrid();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Material(
          color: kPrimaryColor,
          borderRadius: BorderRadius.circular(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              BottomBarButton(
                buttonText:
                    AppLocalizations.of(context).translate('previous_page'),
                onPressed: _currentPage == 1
                    ? null
                    : () {
                        setState(
                          () {
                            _currentPage--;
                            buildGrid();
                            _scrollController.animateTo(0.0,
                                duration: Duration(seconds: 1),
                                curve: Curves.ease);
                          },
                        );
                      },
              ),
              SizedBox(
                height: 40.0,
                width: 40.0,
                child: Material(
                  elevation: 1.0,
                  borderRadius: BorderRadius.circular(25.0),
                  child: Center(
                    child: Text(
                      _currentPage.toString(),
                      style: TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              BottomBarButton(
                buttonText: AppLocalizations.of(context).translate('next_page'),
                onPressed: _currentPage == _totalPages
                    ? null
                    : () {
                        setState(
                          () {
                            _currentPage++;
                            buildGrid();
                            _scrollController.animateTo(0.0,
                                duration: Duration(seconds: 1),
                                curve: Curves.ease);
                          },
                        );
                      },
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: CustomScrollView(
          controller: _scrollController,
          physics: BouncingScrollPhysics(),
          slivers: <Widget>[
            SliverAppBar(
              elevation: 0.0,
              primary: true,
              floating: true,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  AppLocalizations.of(context).translate('looking_for_rooms'),
                ),
              ),
            ),
            _movies
          ],
        ),
      ),
    );
  }
}

/* 
Bottom bar buttons.
*/
class BottomBarButton extends StatelessWidget {
  BottomBarButton({
    @required this.buttonText,
    @required this.onPressed,
  });

  final String buttonText;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.0,
      width: MediaQuery.of(context).size.width * 0.35,
      child: FlatButton(
        disabledColor: Colors.white38,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        color: kAccentColor,
        onPressed: onPressed,
        child: Center(
          child: Text(
            buttonText,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
