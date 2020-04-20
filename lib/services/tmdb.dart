import 'package:cineandgo/localization/app_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'networking.dart';
import 'package:cineandgo/api_keys/api_keys.dart';

const String _tmdbApiKey = tmdbKey;
const _requestUrl = 'https://api.themoviedb.org/3/';
const _posterUrlOriginal = 'https://image.tmdb.org/t/p/original/';
const _posterUrlSmall = 'https://image.tmdb.org/t/p/w500/';

/* 
TMDBModel is the class that contains all the requests to TMDB.
*/
class TMDBModel {
  /*
  This method gets the movies that are currently being displayed in thaters.
  */
  static Future<dynamic> getNowPlaying(
      String languageCode, int page, http.Client client) async {
    NetworkHelper networkHelper =
        NetworkHelper('${_requestUrl}movie/now_playing'
            '?api_key=$_tmdbApiKey'
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
      String languageCode, String movieId, http.Client client) async {
    NetworkHelper networkHelper = NetworkHelper('${_requestUrl}movie/$movieId'
        '?api_key=$_tmdbApiKey'
        '&language=${languageCode == 'es' ? 'es-ES' : 'en-GB'}');

    var movieData = await networkHelper.getData(client);

    return movieData;
  }

  /*
  This method gets the cast of a certain movie by its ID.
  */
  static Future<dynamic> getCast(String movieId, http.Client client) async {
    NetworkHelper networkHelper =
        NetworkHelper('${_requestUrl}movie/$movieId/credits'
            '?api_key=$_tmdbApiKey');

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
  static String getEvaluation(double voteAverage, BuildContext context) {
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
}
