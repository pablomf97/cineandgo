import 'package:cineandgo/components/others/simple_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets(
    'It\'s a simple box',
    (WidgetTester tester) async {
      await tester.pumpWidget(MediaQuery(
          data: MediaQueryData(), child: MaterialApp(home: SimpleBox())));

      final containerFinder = find.byType(Container);

      expect(containerFinder, findsOneWidget);
    },
  );
}
