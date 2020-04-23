import 'package:cineandgo/components/others/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group(
    'Rounded button',
    () {
      testWidgets(
        '- Returns the button',
        (WidgetTester tester) async {
          bool tapped = false;
          await tester.pumpWidget(MediaQuery(
              data: MediaQueryData(),
              child: MaterialApp(
                  home: RoundedButton(
                      text: 'Press me!', onPressed: () => tapped = true))));

          await tester.tap(find.byType(MaterialButton));
          final textFinder = find.text('Press me!');

          expect(tapped, true);
          expect(textFinder, findsOneWidget);
        },
      );

      testWidgets(
        '- Returns the button with no title',
        (WidgetTester tester) async {
          bool tapped = false;
          await tester.pumpWidget(MediaQuery(
              data: MediaQueryData(),
              child: MaterialApp(
                  home: RoundedButton(
                      text: null, onPressed: () => tapped = true))));

          await tester.tap(find.byType(MaterialButton));
          final textFinder = find.text('');

          expect(tapped, true);
          expect(textFinder, findsOneWidget);
        },
      );

      testWidgets(
        '- Returns the button with no title',
        (WidgetTester tester) async {
          bool tapped = false;
          await tester.pumpWidget(MediaQuery(
              data: MediaQueryData(),
              child: MaterialApp(
                  home: RoundedButton(
                text: 'Press me!',
                onPressed: () => tapped = true,
                enabled: false,
              ))));

          await tester.tap(find.byType(MaterialButton));
          final textFinder = find.text('Press me!');

          expect(tapped, false);
          expect(textFinder, findsOneWidget);
        },
      );
    },
  );
}
