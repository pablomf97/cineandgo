import 'package:flutter/material.dart';

class GenreContainer extends StatelessWidget {
  GenreContainer({@required this.genre});

  final String genre;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3.0, vertical: 5.0),
      child: Container(
        padding: EdgeInsets.all(4.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(
            color: Colors.grey[600],
            style: BorderStyle.solid,
          ),
        ),
        child: Text(
          genre,
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.black, fontSize: 17.0),
        ),
      ),
    );
  }
}
