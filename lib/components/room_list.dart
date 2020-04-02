import 'package:cineandgo/components/room_list_tile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firestore_ui/firestore_ui.dart';

class RoomList extends StatefulWidget {
  RoomList({@required this.movieId});

  final String movieId;

  @override
  _RoomListState createState() => _RoomListState();
}

class _RoomListState extends State<RoomList> {
  // Instance of the database
  Firestore _db = Firestore.instance;

  // Query to perform to Firebase
  Stream<QuerySnapshot> get query => _db
      .collection('rooms')
      .where('movieId', isEqualTo: widget.movieId)
      .where('date', isGreaterThanOrEqualTo: DateTime.now())
      .orderBy('date', descending: false)
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return FirestoreAnimatedList(
      query: query,
      itemBuilder: (BuildContext context, DocumentSnapshot snapshot,
              Animation<double> animation, int index) =>
          FadeTransition(
        opacity: animation,
        child: RoomListTile(
          snapshot: snapshot,
        ),
      ),
    );
  }
}
