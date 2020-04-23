import 'package:cineandgo/components/others/custom_divider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

void main() {
  testWidgets(
    'Just a custom divider, not that much to test',
    (WidgetTester tester) async {
      await tester.pumpWidget(MediaQuery(
          data: MediaQueryData(),
          child: MaterialApp(
              home: CustomDivider(
                  text: 'Dividiendo...',
                  horizontalPadding: 0.0,
                  thickness: 1.0))));

      final dividerFinder = find.byType(Divider);
      final textFinder = find.text('Dividiendo...');

      expect(dividerFinder, findsNWidgets(2));
      expect(textFinder, findsOneWidget);
    },
  );

  testWidgets(
    'Just a custom divider, not that much to test',
    (WidgetTester tester) async {
      await tester.pumpWidget(MediaQuery(
          data: MediaQueryData(),
          child: MaterialApp(
              home: CustomDivider(
                  text: 'Dividiendo...',
                  horizontalPadding: null,
                  thickness: null))));

      final dividerFinder = find.byType(Divider);
      final textFinder = find.text('Dividiendo...');

      expect(dividerFinder, findsNWidgets(2));
      expect(textFinder, findsOneWidget);
    },
  );
}
