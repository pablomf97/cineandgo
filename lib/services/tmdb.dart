import 'networking.dart';
import 'package:cineandgo/api_keys/api_keys.dart';

const String _tmdbApiKey = tmdbKey;
const requestUrl = 'https://api.themoviedb.org/3/';
const posterUrlOriginal = 'https://image.tmdb.org/t/p/original/';
const posterUrlSmall = 'https://image.tmdb.org/t/p/w500/';

class TMDBModel {
  static Future<dynamic> getNowPlaying(String languageCode, int page) async {
    NetworkHelper networkHelper = NetworkHelper('${requestUrl}movie/now_playing'
        '?api_key=$_tmdbApiKey'
        '&region=ES'
        '&page=$page'
        '&language=${languageCode == 'es' ? 'es-ES' : 'en-GB'}');

    var movieData = await networkHelper.getData();

    return movieData;
  }

  static Future<dynamic> getMovieDetails(
      String languageCode, String movieId) async {
    NetworkHelper networkHelper = NetworkHelper('${requestUrl}movie/$movieId'
        '?api_key=$_tmdbApiKey'
        '&language=${languageCode == 'es' ? 'es-ES' : 'en-GB'}');

    var movieData = await networkHelper.getData();

    return movieData;
  }

  static Future<dynamic> getCast(String movieId) async {
    NetworkHelper networkHelper =
        NetworkHelper('${requestUrl}movie/$movieId/credits'
            '?api_key=$_tmdbApiKey');

    var movieData = await networkHelper.getData();

    return movieData;
  }

  static String getPosterUrl(String posterPath, bool small) {
    return (small ? posterUrlSmall : posterUrlOriginal) + posterPath;
  }
}
