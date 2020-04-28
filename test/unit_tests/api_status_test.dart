import 'package:http/http.dart' as http;

void main() async {
  final _tmdbRequestUrl =
      'https://api.themoviedb.org/3/configuration?api_key=notavalidkey';
  final _mbRequest = 'https://api.tiles.mapbox.com/v4/';

  http.Response tmdbResponse = await http.get(_tmdbRequestUrl);
  http.Response mbResponse = await http.get(_mbRequest);

  var badReqCodes = [
    300,
    301,
    302,
    303,
    304,
    305,
    306,
    307,
    308,
    410,
    500,
    501,
    502,
    503,
    504,
    505,
    506,
    507,
    508,
    510,
    511
  ];
  if (badReqCodes.contains(tmdbResponse.statusCode))
    throw ('La API de TMDB no ha funcionado como debería...');
  if (badReqCodes.contains(mbResponse.statusCode))
    throw ('La API de MapBox no ha funcionado como debería...');
}
