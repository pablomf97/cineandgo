import 'package:auto_size_text/auto_size_text.dart';
import 'package:cineandgo/components/movie_card.dart';
import 'package:cineandgo/constants/constants.dart';
import 'package:cineandgo/models/room.dart';
import 'package:cineandgo/services/tmdb.dart';
import 'package:flutter/material.dart';

class RoomDetails extends StatefulWidget {
  RoomDetails({@required this.room});

  final Map<String, dynamic> room;

  @override
  _RoomDetailsState createState() => _RoomDetailsState();
}

class _RoomDetailsState extends State<RoomDetails> {
  Room room;

  @override
  void initState() {
    room = Room.fromJson(widget.room);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF263238),
      appBar: AppBar(
        title: Text('Cine&Go!', style: TextStyle(color:Color(0xFF01D277)),),
        centerTitle: true,
        backgroundColor: Color(0xFF101213),
        elevation: 0.0,
      ),
      body: Column(
        children: <Widget>[
          // TODO: Room layout
          MovieCard(
              posterPath: room.film.posterPath,
              title: room.film.title,
              originalTitle: room.film.originalTitle,
              voteAverage: room.film.voteAverage.toString(),
              evaluation: ''),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InfoTile(
                title: '¿Cuando?', description: 'El 20 de marzo a las 20:00'),
          ),
        ],
      ),
    );
  }
}

class InfoTile extends StatelessWidget {
  final String title;
  final String description;

  InfoTile({this.title, this.description});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.0,
      width: 300.0,
      child: Material(
        color: kPrimaryColor,
        borderRadius: BorderRadius.circular(5.0),
        elevation: 1.0,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                  flex: 1,
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: AutoSizeText(
                      title,
                      style: TextStyle(
                          color: Colors.black45,
                          fontSize: 18.0,
                          fontStyle: FontStyle.italic),
                    ),
                  )),
              Expanded(
                  flex: 2,
                  child: Container(
                      alignment: Alignment.centerLeft,
                      child: AutoSizeText(
                        description,
                        style: TextStyle(fontSize: 25),
                      ))),
            ],
          ),
        ),
      ),
    );
  }
}
