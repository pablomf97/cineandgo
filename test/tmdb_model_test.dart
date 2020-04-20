import 'package:cineandgo/services/tmdb.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:cineandgo/api_keys/api_keys.dart';
import 'package:flutter_test/flutter_test.dart';

class MockClient extends Mock implements http.Client {}

main() {
  const _requestUrl = 'https://api.themoviedb.org/3/';
  const _tmdbApiKey = tmdbKey;

  /// Testing 'getNowPlaying' request.
  group(
    'Get now playing',
    () {
      test(
        'Get now playing - Returns a GET if the http call completes successfully',
        () async {
          final client = MockClient();

          when(client.get('${_requestUrl}movie/now_playing'
                  '?api_key=$_tmdbApiKey'
                  '&region=ES'
                  '&page=1'
                  '&language=es-ES'))
              .thenAnswer((_) async =>
                  http.Response('{"test":1,"title": "Success!"}', 200));

          expect(await TMDBModel.getNowPlaying('es', 1, client),
              {"test": 1, "title": "Success!"});
        },
      );

      test(
        'Get now playing - Returns an exception if the http call did not complete successfully',
        () {
          final client = MockClient();

          when(client.get('${_requestUrl}movie/now_playing'
                  '?api_key=$_tmdbApiKey'
                  '&region=ES'
                  '&page=1'
                  '&language=es-ES'))
              .thenAnswer((_) async => http.Response('Oops! Not found', 400));

          expect(TMDBModel.getNowPlaying('es', 1, client), throwsException);
        },
      );
    },
  );

  group(
    'Get movie details',
    () {
      test(
        'Get movie details - Returns a GET if the http call completes successfully',
        () async {
          final client = MockClient();

          when(client.get('${_requestUrl}movie/115'
                  '?api_key=$_tmdbApiKey'
                  '&language=es-ES'))
              .thenAnswer((_) async =>
                  http.Response('{"test":3,"title": "El gran Lebowski"}', 200));

          expect(await TMDBModel.getMovieDetails('es', '115', client),
              {"test": 3, "title": "El gran Lebowski"});
        },
      );

      test(
        'Get movie details - Returns an exception if the http call did not complete successfully',
        () {
          final client = MockClient();

          when(client.get('${_requestUrl}movie/115'
                  '?api_key=$_tmdbApiKey'
                  '&language=es-ES'))
              .thenAnswer((_) async => http.Response('Oops! Not found', 400));

          expect(
              TMDBModel.getMovieDetails('es', '115', client), throwsException);
        },
      );
    },
  );

  group(
    'Get cast',
    () {
      test(
        'Get cast - Returns a GET if the http call completes successfully',
        () async {
          final client = MockClient();

          when(client.get('${_requestUrl}movie/115/credits'
                  '?api_key=$_tmdbApiKey'))
              .thenAnswer((_) async =>
                  http.Response('{"test":5,"title": "Jeff Bridges"}', 200));

          expect(await TMDBModel.getCast('115', client),
              {"test": 5, "title": "Jeff Bridges"});
        },
      );

      test(
        'Get cast - Returns an exception if the http call did not complete successfully',
        () {
          final client = MockClient();

          when(client.get('${_requestUrl}movie/115/credits'
                  '?api_key=$_tmdbApiKey'))
              .thenAnswer((_) async => http.Response('Oops! Not found', 400));

          expect(TMDBModel.getCast('115', client), throwsException);
        },
      );
    },
  );
}
