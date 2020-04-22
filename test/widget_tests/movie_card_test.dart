import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:cineandgo/components/movies/movie_card.dart';

void main() {
  testWidgets(
    'Movie card - Full',
    (WidgetTester tester) async {
      await tester.pumpWidget(MediaQuery(
          data: MediaQueryData(),
          child: MaterialApp(
              home: MovieCard(
                  posterPath: null,
                  title: 'El Señor de los Anillos: El retorno del Rey',
                  originalTitle:
                      'The Lord of the Rings: The Return of the King',
                  voteAverage: '9.5',
                  evaluation: 'mastapiece'))));

      final assetFinder = find.byType(AssetImage);
      final titleFinder =
          find.text('El Señor de los Anillos: El retorno del Rey');
      final originalTitleFinder =
          find.text('The Lord of the Rings: The Return of the King');
      final voteFinder = find.text('9.5');
      final evaluationFinder = find.text('mastapiece');

      expect(assetFinder, findsNothing);
      expect(titleFinder, findsOneWidget);
      expect(originalTitleFinder, findsOneWidget);
      expect(voteFinder, findsOneWidget);
      expect(evaluationFinder, findsOneWidget);
    },
  );

  testWidgets(
    'Movie card - Round corners',
    (WidgetTester tester) async {
      await tester.pumpWidget(MediaQuery(
          data: MediaQueryData(),
          child: MaterialApp(
              home: MovieCard(
                  posterPath: null,
                  title: 'El Señor de los Anillos: El retorno del Rey',
                  originalTitle:
                      'The Lord of the Rings: The Return of the King',
                  voteAverage: '9.5',
                  evaluation: 'mastapiece',
                  roundAll: true))));

      final assetFinder = find.byType(AssetImage);
      final titleFinder =
          find.text('El Señor de los Anillos: El retorno del Rey');
      final originalTitleFinder =
          find.text('The Lord of the Rings: The Return of the King');
      final voteFinder = find.text('9.5');
      final evaluationFinder = find.text('mastapiece');

      expect(assetFinder, findsNothing);
      expect(titleFinder, findsOneWidget);
      expect(originalTitleFinder, findsOneWidget);
      expect(voteFinder, findsOneWidget);
      expect(evaluationFinder, findsOneWidget);
    },
  );
}
