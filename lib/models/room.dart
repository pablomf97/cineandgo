import 'package:cineandgo/models/message.dart';
import 'package:cineandgo/models/user.dart';

class Room {
  // Attributes
  String _id;
  String _cinemaId;
  String _filmId;
  String _roomTitle;
  String _dateTime;
  List<User> _users;
  List<Message> _messages;

  // Constructor
  Room(
    this._id,
    this._cinemaId,
    this._filmId,
    this._roomTitle,
    this._dateTime,
    this._users,
    this._messages,
  );

  // Getters
  String getId() => _id;
  String getCinemaId() => _cinemaId;
  String getFilmId() => _filmId;
  String getRoomTitle() => _roomTitle;
  String getDateTime() => _dateTime;
  List<User> getUsers() => _users;
  List<Message> getMessages() => _messages;

  // Setters -- Will uncomment if necessary
  //  void setId(String value) => _id = value;
  //  void setCinemaId(String value) => _cinemaId = value;
  //  void setFilmId(String value) => _filmId = value;
  //  void setRoomTitle(String value) => _roomTitle = value;
  //  void setDateTime(String value) => _dateTime = value;
  //  void setUsers(List<User> value) => _users = value;
  //  void setMessages(List<Message> value) => _messages = value;
}
