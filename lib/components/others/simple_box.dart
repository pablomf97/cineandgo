import 'package:flutter/material.dart';

class SimpleBox extends StatelessWidget {
  SimpleBox({this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width * 0.15,
        height: 10.0,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(50.0),
        ),
      ),
    );
  }
}