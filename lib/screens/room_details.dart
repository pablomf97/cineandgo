import 'package:cineandgo/constants/constants.dart';
import 'package:flutter/material.dart';

class RoomDetails extends StatefulWidget {
  RoomDetails({Key key}) : super(key: key);

  @override
  _RoomDetailsState createState() => _RoomDetailsState();
}

class _RoomDetailsState extends State<RoomDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Cine&Go!'),
        centerTitle: true,
        backgroundColor: kPrimaryColor,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          // TODO: Room layout 
        ],
      ),
    );
  }
}
