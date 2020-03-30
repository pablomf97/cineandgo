import 'package:cineandgo/models/film.dart';
import 'package:cineandgo/models/message.dart';
import 'package:cineandgo/models/user.dart';

import 'cinema.dart';

class Room {
  // Attributes
  String _id;
  Cinema _cinema;
  Film _film;
  String _roomTitle;
  String _dateTime;
  List<User> _users;
  List<Message> _messages;

  // Constructor
  Room(
    this._id,
    this._cinema,
    this._film,
    this._roomTitle,
    this._dateTime,
    this._users,
    this._messages,
  );

  // Getters
  String getId() => _id;
  Cinema getCinema() => _cinema;
  Film getFilm() => _film;
  String getRoomTitle() => _roomTitle;
  String getDateTime() => _dateTime;
  List<User> getUsers() => _users;
  List<Message> getMessages() => _messages;

  // Setters -- Will uncomment if necessary
  //  void setId(String value) => _id = value;
  //  void setCinema(Cinema value) => _cinema = value;
  //  void setFilm(Film value) => _film = value;
  //  void setRoomTitle(String value) => _roomTitle = value;
  //  void setDateTime(String value) => _dateTime = value;
  //  void setUsers(List<User> value) => _users = value;
  //  void setMessages(List<Message> value) => _messages = value;
}
