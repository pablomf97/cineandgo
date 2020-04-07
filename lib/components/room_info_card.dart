import 'package:auto_size_text/auto_size_text.dart';
import 'package:cineandgo/constants/constants.dart';
import 'package:cineandgo/localization/app_localizations.dart';
import 'package:cineandgo/models/room.dart';
import 'package:cineandgo/screens/room_details.dart';
import 'package:cineandgo/services/tmdb.dart';
import 'package:flutter/material.dart';

class RoomInfo extends StatelessWidget {
  RoomInfo({@required this.room, @required this.id});

  final Room room;
  final String id;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.22,
        child: Material(
          color: kPrimaryColor,
          borderRadius: BorderRadius.circular(10.0),
          elevation: 1.0,
          child: InkWell(
            borderRadius: BorderRadius.circular(10.0),
            enableFeedback: true,
            excludeFromSemantics: true,
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RoomDetails(
                      room: room.toJson(),
                      id: id,
                    ),
                  ));
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          flex: 2,
                          child: Container(
                            alignment: Alignment.centerLeft,
                            child: AutoSizeText(
                              room.film.title,
                              maxLines: 2,
                              style: TextStyle(
                                fontSize: 35,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: AutoSizeText(
                            room.theater.name,
                            maxLines: 2,
                            style: TextStyle(
                              fontSize: 20,
                              fontStyle: FontStyle.italic,
                              color: Colors.white70,
                            ),
                          ),
                        ),
                        Expanded(
                          child: AutoSizeText(
                            '${AppLocalizations.of(context).translate('on_the')} ${room.date.day < 10 ? 0.toString() + room.date.day.toString() : room.date.day}/${room.date.month < 10 ? 0.toString() + room.date.month.toString() : room.date.month} ${AppLocalizations.of(context).translate('at')} ${room.time}',
                            maxLines: 2,
                            style: TextStyle(
                              fontSize: 20,
                              fontStyle: FontStyle.italic,
                              color: Colors.white70,
                            ),
                          ),
                        ),
                        Expanded(
                          child: AutoSizeText(
                            '${room.going.length} ${room.going.length > 1 ? AppLocalizations.of(context).translate('are_going_pl') : AppLocalizations.of(context).translate('are_going_si')}',
                            maxLines: 2,
                            style: TextStyle(
                              fontSize: 20,
                              fontStyle: FontStyle.italic,
                              color: Colors.white70,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Flexible(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(0.0, 15.0, 15.0, 15.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        image: DecorationImage(
                            image: room.film.posterPath != null &&
                                    room.film.posterPath.isNotEmpty
                                ? NetworkImage(TMDBModel.getPosterUrl(
                                    room.film.posterPath, true))
                                : AssetImage('images/logo.png'),
                            fit: BoxFit.cover),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}