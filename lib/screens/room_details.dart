import 'package:cineandgo/components/info_tile.dart';
import 'package:cineandgo/components/movie_card.dart';
import 'package:cineandgo/localization/app_localizations.dart';
import 'package:cineandgo/models/room.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RoomDetails extends StatefulWidget {
  RoomDetails({@required this.room});

  final Map<String, dynamic> room;

  @override
  _RoomDetailsState createState() => _RoomDetailsState();
}

class _RoomDetailsState extends State<RoomDetails> {
  Room room;
  bool going;

  @override
  void initState() {
    room = Room.fromJson(widget.room);
    checkIfGoing();
    super.initState();
  }

  void checkIfGoing() async =>
      await FirebaseAuth.instance.currentUser().then((user) => setState(() {
            going = room.going.contains(user.email);
          }));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: going
          ? FloatingActionButton(
              onPressed: () {},
              child: Icon(Icons.forum),
            )
          : FloatingActionButton(
              onPressed: () {},
              child: Icon(Icons.add),
            ),
      appBar: AppBar(
        title: Text(
          'Cine&Go!',
        ),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 5.0),
            child: MovieCard(
              posterPath: room.film.posterPath,
              title: room.film.title,
              originalTitle: room.film.originalTitle,
              voteAverage: room.film.voteAverage.toString(),
              evaluation: '',
              roundAll: true,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: InfoTile(
                title: AppLocalizations.of(context).translate('when'),
                description:
                    '${AppLocalizations.of(context).translate('on_the')} ${room.date.day < 10 ? 0.toString() + room.date.day.toString() : room.date.day}/${room.date.month < 10 ? 0.toString() + room.date.month.toString() : room.date.month} ${AppLocalizations.of(context).translate('at')} ${room.time}'),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: InfoTile(
              title: AppLocalizations.of(context).translate('where'),
              description:
                  '${AppLocalizations.of(context).translate('in')} ${room.theater.name.trim()}',
              button:
                  IconButton(icon: Icon(Icons.arrow_forward), onPressed: () {}),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: InfoTile(
              title: AppLocalizations.of(context).translate('who'),
              description:
                  '${room.going.length} ${room.going.length > 1 ? AppLocalizations.of(context).translate('are_going_pl') : AppLocalizations.of(context).translate('are_going_si')}',
              button:
                  IconButton(icon: Icon(Icons.arrow_forward), onPressed: () {}),
            ),
          ),
        ],
      ),
    );
  }
}
