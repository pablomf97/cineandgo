import 'package:auto_size_text/auto_size_text.dart';
import 'package:cineandgo/components/rooms/room_info_card.dart';
import 'package:cineandgo/localization/app_localizations.dart';
import 'package:cineandgo/models/cinema.dart';
import 'package:cineandgo/models/film.dart';
import 'package:cineandgo/models/room.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final Room room = Room(
      movieId: '274',
      creator: 'Me',
      theater: Cinema(
          id: null,
          address: null,
          city: null,
          place: null,
          name: 'Metromar Cinemas 12',
          latitude: null,
          longitude: null,
          website: null),
      film: Film(
          title: 'El silencio de los corderos',
          originalTitle: 'The Silence of the Lambs',
          overview:
              'El FBI busca a "Buffalo Bill", un asesino en serie que mata a sus víctimas, todas adolescentes, después de prepararlas minuciosamente y arrancarles la piel.',
          voteAverage: 8.3,
          posterPath: null),
      roomName: 'Awesome room',
      date: DateTime.now(),
      time: 'perfect time',
      going: ['me', 'myself', 'I']);
  group(
    'Room info card',
    () {
      testWidgets(
        '- All data filled',
        (WidgetTester tester) async {
          await tester.pumpWidget(MediaQuery(
              data: MediaQueryData(),
              child: MaterialApp(
                  localizationsDelegates: [
                    AppLocalizationsDelegate(isTest: true),
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                  ],
                  home: RoomInfoCard(
                    room: room,
                    id: 'verylongid',
                    padding: EdgeInsets.all(15.0),
                  ))));
          await tester.pumpAndSettle();

          final sinder = find.byType(AutoSizeText);
          expect(sinder, findsWidgets);
        },
      );
    },
  );
}
