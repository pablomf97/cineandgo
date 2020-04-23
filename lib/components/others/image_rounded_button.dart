import 'package:flutter/material.dart';
import 'package:cineandgo/constants/constants.dart';

class ImageRoundedButton extends StatelessWidget {
  ImageRoundedButton(
      {@required this.imagePath,
      @required this.title,
      @required this.onPressed});

  final String imagePath;
  final String title;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 15.0),
      child: Center(
        child: Material(
          elevation: 5.0,
          color: kPrimaryColor,
          borderRadius: BorderRadius.circular(30.0),
          child: MaterialButton(
            onPressed: onPressed,
            height: 42.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(right: 5.0),
                  child: Image.asset(
                      imagePath == null || imagePath.trim().isEmpty
                          ? 'images/logo.png'
                          : imagePath),
                  height: 32.0,
                ),
                Text(
                  title == null ? '' : title,
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
