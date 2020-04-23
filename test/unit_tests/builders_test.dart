import 'package:cineandgo/components/movies/custom_tile.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cineandgo/services/builders.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

class MockClient extends Mock implements http.Client {}

main() {
  /// Mocking .env variable
  FlutterConfig.loadValueForTesting({'TMDB_KEY': 'key'});
  group(
    'Build cast',
    () {
      test(
        'returns a list of custom tiles',
        () async {
          final client = MockClient();

          when(client.get(any)).thenAnswer((_) async => http.Response(
              '{"test": 1,"cast": [{"profile_path": "profilePath", "name": "Shameik Moore", "character": "Miles Morales"}]}',
              200));

          var actual = await Builders.buildCast('324857', client);
          expect(actual is List<CustomTile>, true);
        },
      );

      test(
        'returns null',
        () async {
          final client = MockClient();

          when(client.get(any))
              .thenAnswer((_) async => http.Response('Oops! Not found', 400));

          expect(await Builders.buildCast('324857', client), null);
        },
      );
    },
  );
}
