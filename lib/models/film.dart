class Film {
  // Attributes
  String posterPath;
  String title;
  String originalTitle;
  double voteAverage;
  String overview;

  // Constructor
  Film(
      {this.title,
      this.originalTitle,
      this.overview,
      this.voteAverage,
      this.posterPath});

  // ToJSON
  Map<String, dynamic> toJson() => {
        'voteAverage': voteAverage,
        'title': title,
        'originalTitle': originalTitle,
        'overview': overview,
        'posterPath': posterPath
      };

  static Film fromJSON(Map<String, dynamic> data) => Film(
      title: data['title'],
      originalTitle: data['originalTitle'],
      overview: data['overview'],
      voteAverage: data['voteAverage'],
      posterPath: data['posterPath']);
}
