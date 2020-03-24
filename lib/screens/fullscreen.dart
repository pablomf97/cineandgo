import 'package:flutter/material.dart';

class Fullscreen extends StatelessWidget {
  static String id = 'fullscreen';

  Fullscreen({@required this.photoUrl});

  final String photoUrl;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Scaffold(
        body: Center(
          child: Hero(
            tag: 'go_fullscreen',
            child: Image.network(
              photoUrl,
            ),
          ),
        ),
      ),
    );
  }
}
