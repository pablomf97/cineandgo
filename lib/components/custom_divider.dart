import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  CustomDivider(
      {@required this.text,
      @required this.horizontalPadding,
      @required this.thickness});

  final String text;
  final double horizontalPadding;
  final double thickness;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding,
            ),
            child: Divider(
              thickness: thickness,
            ),
          ),
        ),
        Text(text),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding,
            ),
            child: Divider(
              thickness: thickness,
            ),
          ),
        ),
      ],
    );
  }
}
