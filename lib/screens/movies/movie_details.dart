import 'dart:ui';
import 'package:cineandgo/components/movies/genre_container.dart';
import 'package:cineandgo/components/movies/movie_details_layout.dart';
import 'package:cineandgo/constants/constants.dart';
import 'package:cineandgo/screens/rooms/room_form.dart';
import 'package:cineandgo/services/tmdb.dart';
import 'package:flutter/material.dart';

class MovieDetails extends StatefulWidget {
  MovieDetails({
    @required this.movieId,
    @required this.title,
  });

  final String movieId;
  final String title;

  @override
  _MovieDetailsState createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails> {
  // Page layout
  Widget pageLayout = Center(
    child: CircularProgressIndicator(),
  );

  void getMovieData() async {
    var movieDetails = await TMDBModel.getMovieDetails(
        window.locale.languageCode, widget.movieId);

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
          id: movieDetails['id'].toString(),
          title: movieDetails['title'],
          originalTitle: movieDetails['original_title'],
          overview: movieDetails['overview'],
          voteAverage: movieDetails['vote_average'].toString(),
          posterPath: movieDetails['poster_path'],
          evaluation:
              TMDBModel.getEvaluation(movieDetails['vote_average'], context),
          genres: genres,
        );
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getMovieData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cine&Go!'),
        centerTitle: true,
      ),
      body: pageLayout,
      floatingActionButton: FloatingActionButton(
        heroTag: 'fabroom',
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return MovieForm(
                  id: widget.movieId,
                  title: widget.title,
                );
              },
            ),
          );
        },
        child: Icon(Icons.add),
        backgroundColor: kAccentColor,
      ),
    );
  }
}
