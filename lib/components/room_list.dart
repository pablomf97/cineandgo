import 'package:cineandgo/localization/app_localizations.dart';
import 'package:cineandgo/screens/room_details.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RoomList extends StatefulWidget {
  RoomList({@required this.movieId});

  final String movieId;

  @override
  _RoomListState createState() => _RoomListState();
}

class _RoomListState extends State<RoomList> {
  Firestore _db = Firestore.instance;

  Future<String> getTheaterName(String theaterId) async {
    return await _db
        .collection('theaters')
        .document(theaterId)
        .get()
        .then((doc) => doc.data['name']);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _db
          .collection('rooms')
          .where('movieId', isEqualTo: widget.movieId)
          .where('date', isGreaterThanOrEqualTo: DateTime.now())
          .orderBy('date', descending: false)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError)
          return Center(child: Text('Error: ${snapshot.error}'));
        if (!snapshot.hasData)
          return Center(
              child: Text(
            AppLocalizations.of(context).translate('nothing_to_show'),
            style: TextStyle(fontSize: 18.0, color: Colors.grey),
            textAlign: TextAlign.center,
          ));
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Center(
              child: Text(
                  AppLocalizations.of(context).translate('loading_screen'),
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18.0, color: Colors.grey)),
            );
          default:
            return ListView(
              children: snapshot.data.documents.map((DocumentSnapshot doc) {
                return Card(
                  elevation: 3.0,
                  child: ListTile(
                    isThreeLine: true,
                    title: Text(
                      doc['roomName'],
                      style: TextStyle(fontSize: 20.0),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(doc.data['theater']['name'].toString().trim()),
                          Text(
                              '${doc.data['theater']['place']}, ${doc.data['theater']['city']}'),
                          Text(
                              '${doc.data['going'].length} ${doc.data['going'].length > 1 ? AppLocalizations.of(context).translate('are_going_pl') : AppLocalizations.of(context).translate('are_going_si')}')
                        ],
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RoomDetails(),
                          ));
                    },
                  ),
                );
              }).toList(),
            );
        }
      },
    );
  }
}
