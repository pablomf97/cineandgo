import 'package:cineandgo/components/movies/custom_tile.dart';
import 'package:cineandgo/services/tmdb.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Builders {
  static Future<List> buildCast(String id, http.Client client,
      {bool test = false}) async {
    var res;
    try {
      var movieCast = await TMDBModel.getCast(id, client, test: test);

      if (movieCast != null) {
        List<CustomTile> aux = [];
        int i = 1;
        for (var actor in movieCast['cast']) {
          aux.add(CustomTile(
              photoPath: actor['profile_path'],
              name: actor['name'],
              character: actor['character'],
              heroIndex: i++,
              key: Key('cast_member$i')));
        }
        res = aux;
      }
    } catch (error) {
      res = null;
    }
    return res;
  }
}
