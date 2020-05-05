import 'package:http/http.dart' as http;
import 'networking.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';

const _requestUrl = 'https://api.themoviedb.org/3/';
const _posterUrlOriginal = 'https://image.tmdb.org/t/p/original/';
const _posterUrlSmall = 'https://image.tmdb.org/t/p/w500/';

/* 
TMDBModel is the class that contains all the requests to TMDB.
*/
class TMDBModel {
  static Future<String> getTmdbKey() async {
    RemoteConfig remoteConfig = await RemoteConfig.instance;
    await remoteConfig.fetch(expiration: Duration(minutes: 2));
    await remoteConfig.activateFetched();

    return remoteConfig.getValue('TMDB_KEY').asString();
  }

  /*
  This method gets the movies that are currently being displayed in thaters.
  */
  static Future<dynamic> getNowPlaying(
      String languageCode, int page, http.Client client,
      {bool test = false}) async {
    final key = test ? 'key' : await getTmdbKey();
    NetworkHelper networkHelper =
        NetworkHelper('${_requestUrl}movie/now_playing'
            '?api_key=$key'
            '&region=ES'
            '&page=$page'
            '&language=${languageCode == 'es' ? 'es-ES' : 'en-GB'}');

    var movieData = await networkHelper.getData(client);

    return movieData;
  }

  /*
  This method get the details of one movie by its ID.
  */
  static Future<dynamic> getMovieDetails(
      String languageCode, String movieId, http.Client client,
      {bool test = false}) async {
    final key = test ? 'key' : await getTmdbKey();
    NetworkHelper networkHelper = NetworkHelper('${_requestUrl}movie/$movieId'
        '?api_key=$key'
        '&language=${languageCode == 'es' ? 'es-ES' : 'en-GB'}');

    var movieData = await networkHelper.getData(client);

    return movieData;
  }

  /*
  This method gets the cast of a certain movie by its ID.
  */
  static Future<dynamic> getCast(String movieId, http.Client client,
      {bool test = false}) async {
    final key = test ? 'key' : await getTmdbKey();
    NetworkHelper networkHelper =
        NetworkHelper('${_requestUrl}movie/$movieId/credits'
            '?api_key=$key');

    var movieData = await networkHelper.getData(client);

    return movieData;
  }

  /*
  This method returns the full URL of a movie poster. If the bool
  'small' is equal to true, then poster will have a reduced size of
  500px of width (resolution).
  */
  static String getPosterUrl(String posterPath, bool small) {
    return (small ? _posterUrlSmall : _posterUrlOriginal) + posterPath;
  }

  /*
  This method returns a simple evaluation based on the score of one movie.  
  */
  static String getEvaluation(double voteAverage) {
    String ev = 'of_the_worst';
    if (voteAverage >= 2 && voteAverage <= 4.9) {
      ev = 'bad';
    } else if (voteAverage >= 5 && voteAverage <= 6.9) {
      ev = 'okay';
    } else if (voteAverage >= 7 && voteAverage <= 8.5) {
      ev = 'good';
    } else if (voteAverage >= 8.6 && voteAverage <= 9.5) {
      ev = 'verrrrry_good';
    } else if (voteAverage > 9.5) {
      ev = 'mastapiece';
    }
    return ev;
  }
}
