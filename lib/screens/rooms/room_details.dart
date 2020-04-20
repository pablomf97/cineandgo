import 'package:flutter_config/flutter_config.dart';
import 'package:cineandgo/components/movies/movie_card.dart';
import 'package:cineandgo/components/others/simple_box.dart';
import 'package:cineandgo/components/rooms/info_tile.dart';
import 'package:cineandgo/constants/constants.dart';
import 'package:cineandgo/localization/app_localizations.dart';
import 'package:cineandgo/models/room.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edge_alert/edge_alert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

import 'chat_room.dart';

class RoomDetails extends StatefulWidget {
  RoomDetails({@required this.room, @required this.id});

  final Map<String, dynamic> room;
  final String id;

  @override
  _RoomDetailsState createState() => _RoomDetailsState();
}

class _RoomDetailsState extends State<RoomDetails> {
  FirebaseUser _currentUser;

  Room room;
  bool going = false;
  String email;
  String name;

  List<Widget> popupMenuButton = [];

  @override
  void initState() {
    room = Room.fromJson(widget.room);
    setState(() {
      name = room.roomName;
    });
    getCurrentUser();
    super.initState();
  }

  void getCurrentUser() async {
    _currentUser = await FirebaseAuth.instance.currentUser();
    setState(
      () {
        email = _currentUser.email;
        going = room.going.contains(email);
        buildPopupMenu();
      },
    );
  }

  /* 
  This method determines what buttons should be shown to the user,
  based on the type of user that looking at the room.
  */
  void buildPopupMenu() {
    if (going) {
      List<PopupMenuButton> aux;
      if (email == room.creator) {
        aux = [
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
                            AppLocalizations.of(context).translate('close'),
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
                                  .updateData({'roomName': name}).then((value) {
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
                            AppLocalizations.of(context).translate('accept'),
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
                    Text(
                      AppLocalizations.of(context).translate('change_name'),
                    ),
                    Icon(Icons.edit),
                  ],
                ),
              ),
            ],
          )
        ];
      } else {
        aux = [
          PopupMenuButton(
            onSelected: (value) async {
              switch (value) {
                case 0:
                  await showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text(AppLocalizations.of(context)
                          .translate('leave_room_q')),
                      actions: <Widget>[
                        FlatButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text(
                            'No',
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
                              Navigator.popUntil(context, (route) => i++ == 2);
                              EdgeAlert.show(context,
                                  backgroundColor: Colors.green,
                                  title: AppLocalizations.of(context)
                                      .translate('successfully_left'));
                            });
                          },
                          child: Text(
                            AppLocalizations.of(context).translate('yes'),
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
                enabled: email != room.creator,
                value: 0,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      AppLocalizations.of(context).translate('leave_room'),
                    ),
                    Icon(Icons.exit_to_app),
                  ],
                ),
              ),
            ],
          )
        ];
      }
      setState(() => popupMenuButton = aux);
    }
  }

  /*
  This method shows a bottom sheet that displays widgets.
  */
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
        actions: popupMenuButton,
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
                  '${AppLocalizations.of(context).translate('on_the')} ${room.date.day < 10 ? 0.toString() + room.date.day.toString() : room.date.day}/${room.date.month < 10 ? 0.toString() + room.date.month.toString() : room.date.month} ${AppLocalizations.of(context).translate('at')} ${room.time.endsWith('0') ? room.time + 0.toString() : room.time}',
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
                    /*
                    Map.
                    */
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
                                  'accessToken':
                                      '${FlutterConfig.get('MAP_BOX_KEY')}',
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
