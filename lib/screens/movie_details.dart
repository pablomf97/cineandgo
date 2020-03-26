import 'package:cineandgo/components/genre_container.dart';
import 'package:cineandgo/components/movie_details_layout.dart';
import 'package:cineandgo/constants/constants.dart';
import 'package:cineandgo/localization/app_localizations.dart';
import 'package:cineandgo/services/tmdb.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'fullscreen.dart';

class MovieDetails extends StatefulWidget {
  MovieDetails({@required this.movieId});

  final String movieId;

  @override
  _MovieDetailsState createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails>
    with SingleTickerProviderStateMixin {
  // Page layout
  Widget pageLayout = Column(
    children: <Widget>[],
  );

  String getEvaluation(double voteAverage) {
    String ev = AppLocalizations.of(context).translate('of_the_worst');
    if (voteAverage >= 2 && voteAverage <= 4.9) {
      ev = AppLocalizations.of(context).translate('bad');
    } else if (voteAverage >= 5 && voteAverage <= 6.9) {
      ev = AppLocalizations.of(context).translate('okay');
    } else if (voteAverage >= 7 && voteAverage <= 8.5) {
      ev = AppLocalizations.of(context).translate('good');
    } else if (voteAverage >= 8.6 && voteAverage <= 9.5) {
      ev = AppLocalizations.of(context).translate('verrrrry_good');
    } else if (voteAverage > 9.5) {
      ev = AppLocalizations.of(context).translate('mastapiece');
    }
    return ev;
  }

  @override
  void initState() {
    super.initState();
    getMovieData();
  }

  void getMovieData() async {
    var movieDetails = await TMDBModel.getMovieDetails('es', widget.movieId);

    if (movieDetails != null) {
      List<GenreContainer> genres = [];
      for (var genre in movieDetails['genres']) {
        genres.add(
          GenreContainer(
            genre: genre['name'],
          ),
        );
      }
      setState(() {
        pageLayout = MovieDetailsLayout(
          title: movieDetails['title'],
          originalTitle: movieDetails['original_title'],
          overview: movieDetails['overview'],
          voteAverage: movieDetails['vote_average'].toString(),
          posterPath: movieDetails['poster_path'],
          evaluation: getEvaluation(movieDetails['vote_average']),
          genres: genres,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Cine&Go!'),
        centerTitle: true,
        backgroundColor: kPrimaryColor,
      ),
      body: pageLayout,
    );
  }
}
