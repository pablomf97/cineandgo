import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:cineandgo/components/movies/custom_card.dart';

void main() {
  testWidgets(
    'Custom card - Called without photo',
    (WidgetTester tester) async {
      bool tapped = false;
      await tester.pumpWidget(MediaQuery(
          data: MediaQueryData(),
          child: MaterialApp(
              home: CustomCard(
                  title: 'Twelve Angry Men',
                  function: () {
                    tapped = true;
                  }))));

      final titleFinder = find.text('Twelve Angry Men');
      final assetFinder = find.byType(DecorationImage);

      await tester.tap(find.byType(GestureDetector));

      expect(titleFinder, findsOneWidget);
      expect(assetFinder, findsNothing);
      expect(tapped, true);
    },
  );

  testWidgets(
    'Custom card - Called without photo and ontap',
    (WidgetTester tester) async {
      bool tapped = false;
      await tester.pumpWidget(MediaQuery(
          data: MediaQueryData(),
          child: MaterialApp(
              home: CustomCard(title: 'Twelve Angry Men', function: null))));

      final titleFinder = find.text('Twelve Angry Men');
      final assetFinder = find.byType(DecorationImage);

      await tester.tap(find.byType(GestureDetector));

      expect(titleFinder, findsOneWidget);
      expect(assetFinder, findsNothing);
      expect(tapped, false);
    },
  );
}
