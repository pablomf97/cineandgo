import 'package:cineandgo/models/user.dart';

class Message {
  // Attributes
  User _user;
  String _text;

  // Constructor
  Message(this._user, this._text);

  // Getters
  User getUser() => _user;
  String getText() => _text;

  // Setters -- Will uncomment if necessary
  //  void setUser(User value) => _user = value;
  //  void setText(String value) => _text = value;
}
