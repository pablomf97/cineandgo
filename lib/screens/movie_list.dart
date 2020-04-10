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

  int _currentPage = 1;
  int _totalPages = 1;

  Widget _movies =
      SliverFillRemaining(child: Center(child: CircularProgressIndicator()));

  void buildGrid() async {
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
    buildGrid();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Material(
          color: kPrimaryColor,
          elevation: 20.0,
          borderRadius: BorderRadius.circular(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              SizedBox(
                height: 50.0,
                width: MediaQuery.of(context).size.width * 0.35,
                child: FlatButton(
                  disabledColor: Colors.white38,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  color: kAccentColor,
                  onPressed: _currentPage == 1
                      ? null
                      : () {
                          setState(() {
                            _currentPage--;
                            buildGrid();
                            _scrollController.animateTo(0.0,
                                duration: Duration(seconds: 1),
                                curve: Curves.ease);
                          });
                        },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.arrow_back_ios,
                        color: Colors.black,
                        size: 15.0,
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      Text(
                        'Previous page',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 40.0,
                width: 40.0,
                child: Material(
                  elevation: 3.0,
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
              SizedBox(
                height: 50.0,
                width: MediaQuery.of(context).size.width * 0.35,
                child: FlatButton(
                  disabledColor: Colors.white38,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  color: kAccentColor,
                  onPressed: _currentPage == _totalPages
                      ? null
                      : () {
                          setState(() {
                            _currentPage++;
                            buildGrid();
                            _scrollController.animateTo(0.0,
                                duration: Duration(seconds: 1),
                                curve: Curves.ease);
                          });
                        },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Next page',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.black,
                        size: 15.0,
                      ),
                    ],
                  ),
                ),
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
