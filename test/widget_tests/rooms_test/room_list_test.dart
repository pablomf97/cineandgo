import 'package:cineandgo/components/rooms/room_list.dart';
import 'package:cineandgo/models/cinema.dart';
import 'package:cineandgo/models/film.dart';
import 'package:cineandgo/models/room.dart';
import 'package:cloud_firestore_mocks/cloud_firestore_mocks.dart';
import 'package:firestore_ui/firestore_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

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
    date: DateTime.now().add(Duration(days: 1)),
    time: 'Alguna hora',
    going: ['me', 'myself', 'i']);

void main() {
  db.collection('rooms').add(room.toJson());
  testWidgets(
    'Testing that the list works',
    (WidgetTester tester) async {
      await tester.pumpWidget(MediaQuery(
          data: MediaQueryData(),
          child: MaterialApp(
              home: RoomList(
            movieId: '278',
            db: db,
          ))));
      await tester.pumpAndSettle();

      expect(find.byType(FirestoreAnimatedList), findsOneWidget);
    },
  );
}
