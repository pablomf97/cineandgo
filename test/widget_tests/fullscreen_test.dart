import 'package:cineandgo/screens/others/fullscreen.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

class MockClient extends Mock implements http.Client {}

void main() {
  /* testWidgets(
    'This widget has an image as big as the screen allows.',
    (WidgetTester tester) async {
      setUp(() {
        final client = MockClient();
      });

      await tester.pumpWidget(MaterialApp(
          home: Fullscreen(
              photoUrl:
                  'https://image.tmdb.org/t/p/w600_and_h900_bestv2/yMeyZHAlakxTRGJT0hp96Zz2Xfw.jpg',
              index: 0)));

      final imageFinder = find.byType(Image);

      expect(imageFinder, findsOneWidget);
    },
  ); */
}
