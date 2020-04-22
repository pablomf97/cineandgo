import 'package:cineandgo/components/rooms/info_tile.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

void main() {
  testWidgets(
    'Info tile - This widget has a title and a description but no button.',
    (WidgetTester tester) async {
      await tester.pumpWidget(MediaQuery(
          data: MediaQueryData(),
          child: MaterialApp(
              home: InfoTile(
                  title: 'Testing...', description: 'This is an info tile'))));

      final titleFinder = find.text('Testing...');
      final descriptionFinder = find.text('This is an info tile');
      final buttonFinder = find.byType(IconButton);

      expect(titleFinder, findsOneWidget);
      expect(descriptionFinder, findsOneWidget);
      expect(buttonFinder, findsNothing);
    },
  );

  testWidgets(
    'Info tile - This widget has no title and no description but has a button.',
    (WidgetTester tester) async {
      await tester.pumpWidget(MediaQuery(
          data: MediaQueryData(),
          child: MaterialApp(
              home: InfoTile(
                  button: IconButton(
                      icon: Icon(Icons.healing), onPressed: null)))));

      final titleFinder = find.text('Testing...');
      final descriptionFinder = find.text('This is an info tile');
      final buttonFinder = find.byType(IconButton);

      expect(titleFinder, findsNothing);
      expect(descriptionFinder, findsNothing);
      expect(buttonFinder, findsOneWidget);
    },
  );

  testWidgets(
    'Info tile - This widget has a title, a description and a button.',
    (WidgetTester tester) async {
      await tester.pumpWidget(MediaQuery(
          data: MediaQueryData(),
          child: MaterialApp(
              home: InfoTile(
                  title: 'Testing...',
                  description: 'This is an info tile',
                  button: IconButton(
                      icon: Icon(Icons.healing), onPressed: null)))));

      final titleFinder = find.text('Testing...');
      final descriptionFinder = find.text('This is an info tile');
      final buttonFinder = find.byType(IconButton);

      expect(titleFinder, findsOneWidget);
      expect(descriptionFinder, findsOneWidget);
      expect(buttonFinder, findsOneWidget);
    },
  );
}
