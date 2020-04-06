import 'package:cineandgo/models/film.dart';
import 'package:cineandgo/models/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'cinema.dart';

import 'package:meta/meta.dart';

class Room {
  // Attributes
  String movieId;
  Cinema theater;
  Film film;
  String roomName;
  DateTime date;
  String time;
  List<dynamic> going;

  // Constructor
  Room({
    @required this.movieId,
    @required this.theater,
    @required this.film,
    @required this.roomName,
    @required this.date,
    @required this.time,
    @required this.going,
  });

  // ToJSON
  Map<String, dynamic> toJson() => {
        'movieId': movieId,
        'theater': theater.toJson(),
        'film': film.toJson(),
        'roomName': roomName,
        'date': date,
        'time': time,
        'going': going,
      };

  // FromJSON
  static Room fromJson(Map<String, dynamic> data) => Room(
      movieId: data['movieId'],
      theater: Cinema.fromJSON(data['theater']),
      film: Film.fromJSON(data['film']),
      roomName: data['roomName'],
      date: data['date'].toDate(),
      time: data['time'],
      going: data['going']);
}
