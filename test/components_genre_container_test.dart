import 'package:cineandgo/components/movies/genre_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets(
    'Genre container - Non-empty name',
    (WidgetTester tester) async {
      await tester.pumpWidget(MediaQuery(
          data: MediaQueryData(),
          child: MaterialApp(home: GenreContainer(genre: 'Sci-fi'))));

      final genreFinder = find.text('Sci-fi');

      expect(genreFinder, findsOneWidget);
    },
  );
}
