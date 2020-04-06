import 'package:cineandgo/api_keys/api_keys.dart';
import 'package:cineandgo/components/info_tile.dart';
import 'package:cineandgo/components/movie_card.dart';
import 'package:cineandgo/components/simple_box.dart';
import 'package:cineandgo/constants/constants.dart';
import 'package:cineandgo/localization/app_localizations.dart';
import 'package:cineandgo/models/room.dart';
import 'package:cineandgo/screens/chat_room.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edge_alert/edge_alert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

class RoomDetails extends StatefulWidget {
  RoomDetails({@required this.room, @required this.id});

  final Map<String, dynamic> room;
  final String id;

  @override
  _RoomDetailsState createState() => _RoomDetailsState();
}

class _RoomDetailsState extends State<RoomDetails> {
  Room room;
  bool going = false;
  String email;
  String name;

  @override
  void initState() {
    room = Room.fromJson(widget.room);
    setState(() {
      name = room.roomName;
    });
    checkIfGoing();
    super.initState();
  }

  void checkIfGoing() async =>
      await FirebaseAuth.instance.currentUser().then((user) => setState(() {
            email = user.email;
            going = room.going.contains(email);
          }));

  showBottomSheet(List<Widget> children) => showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50.0),
                topRight: Radius.circular(50.0))),
        backgroundColor: kLightPrimaryColor,
        builder: (BuildContext context) {
          return Container(
              alignment: Alignment.center,
              height: MediaQuery.of(context).size.height * 0.65,
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: children,
              ));
        },
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        heroTag: 'fabroom',
        elevation: 1.0,
        onPressed: going
            ? () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChatRoom(
                      roomId: widget.id,
                    ),
                  ),
                );
              }
            : () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    title: Text(AppLocalizations.of(context)
                        .translate('register_to_room')),
                    actionsPadding: EdgeInsets.symmetric(horizontal: 15.0),
                    actions: <Widget>[
                      FlatButton(
                        color: Colors.red,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('No',
                            style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                      ),
                      FlatButton(
                        color: kAccentColor,
                        onPressed: () async {
                          // Register
                          String user = await FirebaseAuth.instance
                              .currentUser()
                              .then((value) => value.email);

                          Firestore.instance
                              .collection('rooms')
                              .document(widget.id)
                              .updateData({
                            'going': FieldValue.arrayUnion([user])
                          }).then((value) {
                            EdgeAlert.show(context,
                                title: AppLocalizations.of(context)
                                    .translate('joined_room'),
                                backgroundColor: Colors.green);
                            Navigator.pop(context);

                            setState(() {
                              going = true;
                            });
                          });
                        },
                        child: Text(
                            AppLocalizations.of(context).translate('yes'),
                            style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                      )
                    ],
                  ),
                );
              },
        child: Icon(going ? Icons.forum : Icons.add),
      ),
      appBar: AppBar(
        title: Text(
          'Cine&Go!',
        ),
        centerTitle: true,
        actions: going
            ? <Widget>[
                PopupMenuButton(
                  onSelected: (value) async {
                    switch (value) {
                      case 0:
                        await showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            content: TextField(
                              decoration: InputDecoration(
                                hintText: name,
                              ),
                              onChanged: (value) => name = value,
                            ),
                            actions: <Widget>[
                              FlatButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text(
                                  AppLocalizations.of(context)
                                      .translate('close'),
                                ),
                              ),
                              FlatButton(
                                onPressed: () {
                                  if (name != null &&
                                      name.trim().isNotEmpty &&
                                      name != room.roomName) {
                                    Firestore.instance
                                        .collection('rooms')
                                        .document(widget.id)
                                        .updateData({'roomName': name}).then(
                                            (value) {
                                      Navigator.pop(context);
                                      EdgeAlert.show(context,
                                          backgroundColor: Colors.green,
                                          title: 'Name updated');
                                      setState(() {
                                        name = name;
                                      });
                                    });
                                  }
                                },
                                child: Text(
                                  AppLocalizations.of(context)
                                      .translate('accept'),
                                ),
                              ),
                            ],
                          ),
                        );
                        break;
                      case 1:
                        await showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text(
                                'You are about to leave the room. Are you sure?'),
                            actions: <Widget>[
                              FlatButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text(
                                  AppLocalizations.of(context)
                                      .translate('close'),
                                ),
                              ),
                              FlatButton(
                                onPressed: () {
                                  Firestore.instance
                                      .collection('rooms')
                                      .document(widget.id)
                                      .updateData({
                                    'going': FieldValue.arrayRemove([email])
                                  }).then((value) {
                                    int i = 0;
                                    Navigator.popUntil(
                                        context, (route) => i++ == 2);
                                    EdgeAlert.show(context,
                                        backgroundColor: Colors.green,
                                        title: 'Succesfully left room');
                                  });
                                },
                                child: Text(
                                  AppLocalizations.of(context)
                                      .translate('accept'),
                                ),
                              ),
                            ],
                          ),
                        );
                        break;
                    }
                  },
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      enabled: email == room.creator,
                      value: 0,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text('Change name'),
                          Icon(Icons.edit),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      enabled: email != room.creator,
                      value: 1,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text('Leave room'),
                          Icon(Icons.exit_to_app),
                        ],
                      ),
                    ),
                  ],
                )
              ]
            : null,
      ),
      body: Column(
        children: <Widget>[
          Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.all(10.0),
              child: Text(name != null ? name : room.roomName,
                  style: TextStyle(fontSize: 30.0))),
          Padding(
            padding: const EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
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
                  '${AppLocalizations.of(context).translate('on_the')} ${room.date.day < 10 ? 0.toString() + room.date.day.toString() : room.date.day}/${room.date.month < 10 ? 0.toString() + room.date.month.toString() : room.date.month} ${AppLocalizations.of(context).translate('at')} ${room.time}',
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: InfoTile(
              title: AppLocalizations.of(context).translate('where'),
              description:
                  '${AppLocalizations.of(context).translate('in')} ${room.theater.name.trim()}',
              button: IconButton(
                icon: Icon(Icons.arrow_forward),
                onPressed: () {
                  showBottomSheet([
                    SimpleBox(
                      color: kAccentColor,
                    ),
                    InfoTile(
                      title: room.theater.name,
                      description: room.theater.address,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(40.0),
                          child: FlutterMap(
                            options: MapOptions(
                              center: LatLng(room.theater.latitude,
                                  room.theater.longitude),
                              zoom: 13.0,
                            ),
                            layers: [
                              TileLayerOptions(
                                urlTemplate: "https://api.tiles.mapbox.com/v4/"
                                    "{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}",
                                additionalOptions: {
                                  'accessToken': '$mapboxKey',
                                  'id': 'mapbox.streets',
                                },
                              ),
                              MarkerLayerOptions(
                                markers: [
                                  Marker(
                                    width: 80.0,
                                    height: 80.0,
                                    point: new LatLng(room.theater.latitude,
                                        room.theater.longitude),
                                    builder: (context) => new Container(
                                      child: Icon(
                                        Icons.location_on,
                                        color: kAccentColor,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ]);
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: InfoTile(
              title: AppLocalizations.of(context).translate('who'),
              description:
                  '${room.going.length} ${room.going.length > 1 ? AppLocalizations.of(context).translate('are_going_pl') : AppLocalizations.of(context).translate('are_going_si')}',
              button: IconButton(
                  icon: Icon(Icons.arrow_forward),
                  onPressed: () {
                    showBottomSheet([
                      SimpleBox(
                        color: kAccentColor,
                      ),
                      Expanded(
                        child: StreamBuilder(
                          stream: Firestore.instance
                              .collection('rooms')
                              .document(widget.id)
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return ListView.builder(
                                itemCount: snapshot.data['going'].length,
                                itemBuilder: (context, index) => Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  child: Card(
                                    color: kPrimaryColor,
                                    child: ListTile(
                                      title:
                                          Text(snapshot.data['going'][index]),
                                    ),
                                  ),
                                ),
                              );
                            }
                            return Text(
                                AppLocalizations.of(context).translate('oops'));
                          },
                        ),
                      )
                    ]);
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
