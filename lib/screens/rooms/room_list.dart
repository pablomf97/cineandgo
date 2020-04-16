import 'dart:ui';
import 'package:cineandgo/components/rooms/room_info_card.dart';
import 'package:cineandgo/constants/constants.dart';
import 'package:cineandgo/localization/app_localizations.dart';
import 'package:cineandgo/models/room.dart';
import 'package:cineandgo/services/tmdb.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';

final Firestore _db = Firestore.instance;
final DateTime now = DateTime.now();

class AllRooms extends StatefulWidget {
  AllRooms({Key key}) : super(key: key);

  @override
  _AllRoomsState createState() => _AllRoomsState();
}

class _AllRoomsState extends State<AllRooms> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  // Filtering things
  int _radioValue = 0;
  String _region;
  dynamic _movie;
  String _roomName;

  List<DropdownMenuItem> _movies;

  Future<QuerySnapshot> _selectedQuery = _db
      .collection('rooms')
      .where(
        'date',
        isGreaterThanOrEqualTo: now.subtract(
          Duration(
            hours: now.hour,
            minutes: now.minute,
            seconds: now.second,
          ),
        ),
      )
      .getDocuments();

  @override
  void initState() {
    super.initState();
    getMovies();
  }

  void getMovies() async {
    var movieData = await TMDBModel.getNowPlaying(window.locale.countryCode, 1);

    if (movieData != null) {
      List<DropdownMenuItem> aux = [];
      movieData['results'].forEach(
        (movie) {
          aux.add(
            DropdownMenuItem(
              child: Text(movie['title']),
              value: movie['id'],
            ),
          );
        },
      );
      setState(() => _movies = aux);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: Drawer(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(12.0),
                child: Text(
                  AppLocalizations.of(context).translate('filter'),
                  style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ListView(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.0),
                    child: RadioListTile(
                      value: 0,
                      groupValue: _radioValue,
                      onChanged: (selectedRadio) =>
                          setState(() => _radioValue = selectedRadio),
                      title: Text(
                        AppLocalizations.of(context).translate('all_rooms'),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.0),
                    child: RadioListTile(
                      value: 1,
                      groupValue: _radioValue,
                      onChanged: (selectedRadio) =>
                          setState(() => _radioValue = selectedRadio),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(AppLocalizations.of(context)
                              .translate('by_region')),
                          SearchableDropdown(
                            readOnly: _radioValue != 1,
                            value: _region,
                            items: kComunidades.keys
                                .map(
                                  (e) => DropdownMenuItem(
                                    child: Text(e),
                                    value: e,
                                  ),
                                )
                                .toList(),
                            onChanged: (value) =>
                                setState(() => _region = value),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.0),
                    child: RadioListTile(
                      value: 2,
                      groupValue: _radioValue,
                      onChanged: (selectedRadio) =>
                          setState(() => _radioValue = selectedRadio),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(AppLocalizations.of(context)
                              .translate('by_movie')),
                          SearchableDropdown(
                            readOnly: _radioValue != 2,
                            value: _movie,
                            items: _movies == null
                                ? [
                                    DropdownMenuItem(
                                      child: Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                    ),
                                  ]
                                : _movies,
                            onChanged: (value) =>
                                setState(() => _movie = value),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.0),
                    child: RadioListTile(
                      value: 3,
                      groupValue: _radioValue,
                      onChanged: (selectedRadio) =>
                          setState(() => _radioValue = selectedRadio),
                      title: TextField(
                        enabled: _radioValue == 3,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          labelText: AppLocalizations.of(context)
                              .translate('by_room_name'),
                        ),
                        onChanged: (value) => _roomName = value,
                      ),
                    ),
                  ),
                  Center(
                    child: RaisedButton(
                      color: kAccentColor,
                      onPressed: () {
                        setState(() {
                          switch (_radioValue) {
                            case 0:
                              _selectedQuery = _db
                                  .collection('rooms')
                                  .where(
                                    'date',
                                    isGreaterThanOrEqualTo: now.subtract(
                                      Duration(
                                        hours: now.hour,
                                        minutes: now.minute,
                                        seconds: now.second,
                                      ),
                                    ),
                                  )
                                  .getDocuments();
                              break;
                            case 1:
                              _selectedQuery = _db
                                  .collection('rooms')
                                  .where(
                                    'date',
                                    isGreaterThanOrEqualTo: now.subtract(
                                      Duration(
                                        hours: now.hour,
                                        minutes: now.minute,
                                        seconds: now.second,
                                      ),
                                    ),
                                  )
                                  .where('theater.city', isEqualTo: _region)
                                  .getDocuments();
                              break;
                            case 2:
                              _selectedQuery = _db
                                  .collection('rooms')
                                  .where(
                                    'date',
                                    isGreaterThanOrEqualTo: now.subtract(
                                      Duration(
                                        hours: now.hour,
                                        minutes: now.minute,
                                        seconds: now.second,
                                      ),
                                    ),
                                  )
                                  .where('movieId',
                                      isEqualTo: _movie.toString())
                                  .getDocuments();
                              break;
                            case 3:
                              _selectedQuery = _db
                                  .collection('rooms')
                                  .where(
                                    'date',
                                    isGreaterThanOrEqualTo: now.subtract(
                                      Duration(
                                        hours: now.hour,
                                        minutes: now.minute,
                                        seconds: now.second,
                                      ),
                                    ),
                                  )
                                  .where('roomName', isEqualTo: _roomName)
                                  .getDocuments();
                              break;
                          }
                        });
                        Navigator.pop(context);
                      },
                      child: Text(
                        AppLocalizations.of(context).translate('apply'),
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: <Widget>[
            SliverAppBar(
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.filter_list),
                  onPressed: () => _scaffoldKey.currentState.openEndDrawer(),
                ),
              ],
              elevation: 0.0,
              floating: true,
              pinned: false,
              snap: true,
              flexibleSpace: FlexibleSpaceBar(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      AppLocalizations.of(context)
                          .translate('looking_for_rooms'),
                    ),
                  ],
                ),
              ),
            ),
            FutureBuilder(
              future: _selectedQuery,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return SliverFillRemaining(
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
                if (snapshot.hasData) {
                  List<RoomInfo> rooms = [];
                  List<DocumentSnapshot> docs = snapshot.data.documents;

                  for (var doc in docs) {
                    Room room = Room.fromJson(doc.data);
                    rooms.add(
                      RoomInfo(
                        room: room,
                        id: doc.documentID,
                        padding:
                            EdgeInsets.only(top: 10.0, left: 12.0, right: 12.0),
                      ),
                    );
                  }
                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return rooms[index];
                      },
                      childCount: rooms.length,
                    ),
                  );
                }
                return SliverFillRemaining(
                  child: Center(
                    child: Text(
                      AppLocalizations.of(context).translate('nothing_to_show'),
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
