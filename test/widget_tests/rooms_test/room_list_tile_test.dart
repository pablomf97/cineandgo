import 'package:cineandgo/components/rooms/room_list_tile.dart';
import 'package:cineandgo/localization/app_localizations.dart';
import 'package:cineandgo/models/cinema.dart';
import 'package:cineandgo/models/film.dart';
import 'package:cineandgo/models/room.dart';
import 'package:cloud_firestore_mocks/cloud_firestore_mocks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';

const RoomsCollection = 'rooms';
final db = MockFirestoreInstance();
final Room room = Room(
    movieId: '278',
    creator: 'Me',
    theater: Cinema(
        id: 'SEV001',
        address: 'Alguna calle de Mairena',
        city: 'Sevilla',
        place: 'Mairena',
        name: 'Metromar Cinemas 12',
        latitude: 37.349737,
        longitude: -6.051168,
        website: 'https://www.cineciudad.com/Cine2/10/Metromar/Total'),
    film: Film(
        title: 'Cadena perpetua',
        originalTitle: 'The Shawshank Redemption',
        overview:
            'Acusado del asesinato de su mujer, Andrew Dufresne, tras ser condenado a cadena perpetua, es enviado a la prisión de Shawshank.',
        voteAverage: 8.7,
        posterPath: null),
    roomName: 'Una de las mejores películas jamás rodadas',
    date: DateTime.now(),
    time: 'Alguna hora',
    going: ['me', 'myself', 'i']);
final Room emptyRoom = Room(
    creator: '',
    date: DateTime.now(),
    film: Film(),
    going: [],
    movieId: '',
    roomName: '',
    theater: Cinema(),
    time: '');

Widget buildTesteableWidget({@required Widget child}) {
  return MediaQuery(
      data: MediaQueryData(),
      child: MaterialApp(localizationsDelegates: [
        AppLocalizationsDelegate(isTest: true),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ], home: child));
}

void main() {
  group(
    'Room list tile',
    () {
      testWidgets(
        '- All data filled',
        (WidgetTester tester) async {
          await db
              .collection(RoomsCollection)
              .document('room1')
              .setData(room.toJson());
          final snapshot =
              await db.collection(RoomsCollection).document('room1').get();

          await tester.pumpWidget(
              buildTesteableWidget(child: RoomListTile(snapshot: snapshot)));
          await tester.pumpAndSettle();

          final roomNameFinder = find.text(snapshot.data['roomName']);
          final theaterNameFinder = find.text(snapshot.data['theater']['name']);
          final addressFinder = find.text(
              '${snapshot.data['theater']['place']}, ${snapshot.data['theater']['city']}');

          expect(roomNameFinder, findsOneWidget);
          expect(theaterNameFinder, findsOneWidget);
          expect(addressFinder, findsOneWidget);
          expect(find.byType(Text), findsNWidgets(4));
        },
      );

      testWidgets(
        '- No data filled',
        (WidgetTester tester) async {
          await db
              .collection(RoomsCollection)
              .document('room1')
              .setData(emptyRoom.toJson());
          final snapshot =
              await db.collection(RoomsCollection).document('room1').get();

          await tester.pumpWidget(
              buildTesteableWidget(child: RoomListTile(snapshot: snapshot)));
          await tester.pumpAndSettle();

          final roomNameFinder = find.text(snapshot.data['roomName']);
          final theaterNameFinder = find.text(snapshot.data['theater']['name']);
          final addressFinder = find.text(
              '${snapshot.data['theater']['place']}, ${snapshot.data['theater']['city']}');

          expect(roomNameFinder, findsNothing);
          expect(theaterNameFinder, findsNothing);
          expect(addressFinder, findsNothing);
          expect(find.byType(Text), findsNWidgets(4));
        },
      );
    },
  );
}
