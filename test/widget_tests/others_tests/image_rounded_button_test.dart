import 'package:cineandgo/components/others/image_rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group(
    'Rounded button with image',
    () {
      testWidgets(
        '- Returns the button',
        (WidgetTester tester) async {
          bool tapped = false;
          await tester.pumpWidget(MediaQuery(
              data: MediaQueryData(),
              child: MaterialApp(
                  home: ImageRoundedButton(
                      imagePath: 'images/google.png',
                      title: 'Google',
                      onPressed: () => tapped = true))));

          await tester.tap(find.byType(MaterialButton));
          final imageFinder = find.byType(Image);
          final titleFinder = find.text('Google');

          expect(tapped, true);
          expect(imageFinder, findsOneWidget);
          expect(titleFinder, findsOneWidget);
        },
      );

      testWidgets(
        '- Returns the button with no image',
        (WidgetTester tester) async {
          bool tapped = false;
          await tester.pumpWidget(MediaQuery(
              data: MediaQueryData(),
              child: MaterialApp(
                  home: ImageRoundedButton(
                      imagePath: null,
                      title: 'Google',
                      onPressed: () => tapped = true))));

          await tester.tap(find.byType(MaterialButton));
          final imageFinder = find.byType(Image);
          final titleFinder = find.text('Google');

          expect(tapped, true);
          expect(imageFinder, findsOneWidget);
          expect(titleFinder, findsOneWidget);
        },
      );

      testWidgets(
        '- Returns the button with no title',
        (WidgetTester tester) async {
          bool tapped = false;
          await tester.pumpWidget(MediaQuery(
              data: MediaQueryData(),
              child: MaterialApp(
                  home: ImageRoundedButton(
                      imagePath: 'images/google.png',
                      title: null,
                      onPressed: () => tapped = true))));

          await tester.tap(find.byType(MaterialButton));
          final imageFinder = find.byType(Image);
          final titleFinder = find.text('');

          expect(tapped, true);
          expect(imageFinder, findsOneWidget);
          expect(titleFinder, findsOneWidget);
        },
      );

      testWidgets(
        '- Returns the button (disabled)',
        (WidgetTester tester) async {
          await tester.pumpWidget(MediaQuery(
              data: MediaQueryData(),
              child: MaterialApp(
                  home: ImageRoundedButton(
                      imagePath: 'images/google.png',
                      title: 'Google',
                      onPressed: null))));

          final imageFinder = find.byType(Image);
          final titleFinder = find.text('Google');

          expect(imageFinder, findsOneWidget);
          expect(titleFinder, findsOneWidget);
        },
      );
    },
  );
}
