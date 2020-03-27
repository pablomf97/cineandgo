import 'package:flutter/material.dart';

class Fullscreen extends StatelessWidget {
  static String id = 'fullscreen';

  Fullscreen({@required this.photoUrl, @required this.index});

  final String photoUrl;
  final int index;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Scaffold(
        body: Center(
          child: Hero(
            tag: 'go_fullscreen_$index',
            child: Image.network(
              photoUrl,
            ),
          ),
        ),
      ),
    );
  }
}
