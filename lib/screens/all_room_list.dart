import 'package:cineandgo/components/room_info_card.dart';
import 'package:cineandgo/models/room.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AllRooms extends StatefulWidget {
  AllRooms({Key key}) : super(key: key);

  @override
  _AllRoomsState createState() => _AllRoomsState();
}

class _AllRoomsState extends State<AllRooms> {
  final Firestore _db = Firestore.instance;
  final DateTime now = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              elevation: 0.0,
              floating: true,
              pinned: false,
              snap: true,
              flexibleSpace: FlexibleSpaceBar(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Look for rooms'),
                  ],
                ),
              ),
            ),
            FutureBuilder(
              future: _db
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
                  .getDocuments(),
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
                    child: Text('No Content'),
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
