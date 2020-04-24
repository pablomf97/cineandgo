import 'package:cineandgo/models/film.dart';
import 'cinema.dart';

import 'package:meta/meta.dart';

class Room {
  // Attributes
  String creator;
  String movieId;
  Cinema theater;
  Film film;
  String roomName;
  DateTime date;
  String time;
  List<dynamic> going;

  // Constructors
  Room({
    this.movieId,
    this.creator,
    this.theater,
    this.film,
    this.roomName,
    this.date,
    this.time,
    this.going,
  });

  // ToJSON
  Map<String, dynamic> toJson() => {
        'movieId': movieId,
        'creator': creator,
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
      creator: data['creator'],
      theater: Cinema.fromJSON(data['theater']),
      film: Film.fromJSON(data['film']),
      roomName: data['roomName'],
      date: data['date'].runtimeType == DateTime
          ? data['date']
          : data['date'].toDate(),
      time: data['time'],
      going: data['going']);
}
