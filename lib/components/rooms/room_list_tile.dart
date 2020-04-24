import 'package:cineandgo/constants/constants.dart';
import 'package:cineandgo/localization/app_localizations.dart';
import 'package:cineandgo/screens/rooms/room_details.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RoomListTile extends StatelessWidget {
  RoomListTile({@required this.snapshot});

  final DocumentSnapshot snapshot;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5.0),
      child: Material(
        color: kPrimaryColor,
        elevation: 3.0,
        borderRadius: BorderRadius.circular(5.0),
        child: ListTile(
          isThreeLine: true,
          title: Text(
            snapshot.data['roomName'] == null ||
                    snapshot.data['roomName'].trim().isEmpty
                ? '...'
                : snapshot.data['roomName'],
            style: TextStyle(fontSize: 20.0),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(snapshot.data['theater']['name'] == null ||
                        snapshot.data['theater']['name'].trim().isEmpty
                    ? '...'
                    : snapshot.data['theater']['name'].toString().trim()),
                Text(snapshot.data['theater']['place'] == null ||
                        snapshot.data['theater']['city'] == null
                    ? '...'
                    : '${snapshot.data['theater']['place']}, ${snapshot.data['theater']['city']}'),
                Text(snapshot.data['going'] == null ||
                        snapshot.data['going'].isEmpty
                    ? '...'
                    : '${snapshot.data['going'].length} ${snapshot.data['going'].length > 1 ? AppLocalizations.of(context).translate('are_going_pl') : AppLocalizations.of(context).translate('are_going_si')}')
              ],
            ),
          ),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              IconButton(
                  icon: Icon(Icons.arrow_forward),
                  alignment: Alignment.bottomCenter,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RoomDetails(
                              room: snapshot.data, id: snapshot.documentID),
                        ));
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
