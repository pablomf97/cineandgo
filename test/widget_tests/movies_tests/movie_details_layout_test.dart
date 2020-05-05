import 'package:cineandgo/components/movies/movie_card.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:cineandgo/components/movies/movie_details_layout.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

class MockClient extends Mock implements http.Client {}

void main() {
  testWidgets(
    'Movie details layout',
    (WidgetTester tester) async {
      final client = MockClient();

      when(client.get(any)).thenAnswer((_) async => http.Response('OK', 200));

      await tester.pumpWidget(MaterialApp(
          home: Scaffold(
        body: MovieDetailsLayout(
          id: '324857',
          posterPath: '',
          title: 'Spider-man: Un nuevo universo',
          originalTitle: 'Spider-man: Into the Spider-verse',
          overview:
              'En un universo paralelo donde Peter Parker ha muerto, un joven de secundaria llamado Miles Morales es el nuevo Spider-Man. Sin embargo, cuando el líder mafioso Wilson Fisk (a.k.a Kingpin) construye el "Super Colisionador" trae a una versión alternativa de Peter Parker que tratará de enseñarle a Miles como ser un mejor Spider-Man.',
          voteAverage: '8.4',
          evaluation: 'Verrrry good',
          genres: [],
          client: client,
        ),
      )));

      final movieFinder = find.byType(MovieCard);
      final tabbarviewFinder = find.byType(TabBarView);
      final tabbarFinder = find.byType(TabBar);

      expect(movieFinder, findsOneWidget);
      expect(tabbarviewFinder, findsOneWidget);
      expect(tabbarFinder, findsOneWidget);
    },
  );
}
