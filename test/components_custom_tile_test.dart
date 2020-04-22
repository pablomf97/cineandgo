import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:cineandgo/components/movies/custom_tile.dart';

void main() {
  testWidgets(
    'Custom tile - Called without photo',
    (WidgetTester tester) async {
      await tester.pumpWidget(MediaQuery(
          data: MediaQueryData(),
          child: MaterialApp(
            home: CustomTile(
                photoPath: null,
                name: 'George MacKay',
                character: 'Lance Corporal William "Will" Schofield',
                heroIndex: 0),
          )));

      final nameFinder = find.text('George MacKay');
      final characterFinder =
          find.text('As Lance Corporal William "Will" Schofield');
      final assetFinder = find.byType(DecorationImage);

      expect(nameFinder, findsOneWidget);
      expect(characterFinder, findsOneWidget);
      expect(assetFinder, findsNothing);
    },
  );

  testWidgets(
    'Custom tile - Called with no data',
    (WidgetTester tester) async {
      await tester.pumpWidget(MediaQuery(
          data: MediaQueryData(),
          child: MaterialApp(
            home: CustomTile(
                photoPath: null, name: '', character: '', heroIndex: 0),
          )));

      final nameFinder = find.text('George MacKay');
      final characterFinder =
          find.text('As Lance Corporal William "Will" Schofield');
      final assetFinder = find.byType(DecorationImage);

      expect(nameFinder, findsNothing);
      expect(characterFinder, findsNothing);
      expect(assetFinder, findsNothing);
    },
  );
}
