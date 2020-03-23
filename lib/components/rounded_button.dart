import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  RoundedButton(
      {@required this.text,
      this.color,
      @required this.onPressed,
      this.enabled});

  final Color color;
  final String text;
  final bool enabled;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: (enabled == null || enabled) ? color : Colors.grey,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: (enabled == null || enabled) ? onPressed : null,
          minWidth: 200.0,
          height: 42.0,
          child: Text(
            text,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
