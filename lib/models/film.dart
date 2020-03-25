import 'package:flutter/material.dart';

class Film {
  // Attributes
  String id;
  String popularity;
  String posterPath;
  String title;
  String originalTitle;
  List genreIds;
  String voteAverage;
  String overview;
  String releaseDate;

  // Constructor
  Film(
      {@required this.id,
      @required this.popularity,
      @required this.posterPath,
      @required this.title,
      @required this.originalTitle,
      @required this.genreIds,
      @required this.voteAverage,
      @required this.overview,
      @required this.releaseDate});

  // Getters
  //  String getId() => _id;
  //  double getPopularity() => _popularity;
  //  String getPosterPath() => _posterPath;
  //  String getTitle() => _title;
  //  String getOriginalTitle() => _originalTitle;
  //  List<int> getGenreIds() => _genreIds;
  //  double getVoteAverage() => _voteAverage;
  //  String getOverview() => _overview;
  //  String getReleaseDate() => _releaseDate;

  //  Setters -- Will uncomment if necessary
  //  void setId(String value) => _id = value;
  //  void setPopularity(double value) => _popularity = value;
  //  void setPosterPath(String value) => _posterPath = value;
  //  void setTitle(String value) => _title = value;
  //  void setOriginalTitle(String value) => _originalTitle = value;
  //  void setGenreIds(List<int> value) => _genreIds = value;
  //  void setVoteAverage(double value) => _voteAverage = value;
  //  void setOverview(String value) => _overview = value;
  //  void setReleaseDate(String value) => _releaseDate = value;
}
