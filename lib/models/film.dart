class Film {
  // Attributes
  String _id;
  double _popularity;
  String _posterPath;
  String _title;
  String _originalTitle;
  List<int> _genreIds;
  double _voteAverage;
  String _overview;
  String _releaseDate;

  // Constructor
  Film(
    this._id,
    this._popularity,
    this._posterPath,
    this._title,
    this._originalTitle,
    this._genreIds,
    this._voteAverage,
    this._overview,
    this._releaseDate,
  );

  // Getters
  String getId() => _id;
  double getPopularity() => _popularity;
  String getPosterPath() => _posterPath;
  String getTitle() => _title;
  String getOriginalTitle() => _originalTitle;
  List<int> getGenreIds() => _genreIds;
  double getVoteAverage() => _voteAverage;
  String getOverview() => _overview;
  String getReleaseDate() => _releaseDate;

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
