import 'package:auto_size_text/auto_size_text.dart';
import 'package:cineandgo/constants/constants.dart';
import 'package:flutter/material.dart';

class InfoTile extends StatelessWidget {
  final String title;
  final String description;
  final IconButton button;

  InfoTile({this.title, this.description, this.button});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.0,
      width: MediaQuery.of(context).size.width * 0.95,
      child: Material(
        color: kPrimaryColor,
        borderRadius: BorderRadius.circular(5.0),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                      flex: 1,
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: AutoSizeText(
                          title,
                          style: TextStyle(
                              fontSize: 18.0, fontStyle: FontStyle.italic),
                        ),
                      )),
                  Expanded(
                      flex: 2,
                      child: Container(
                          width: MediaQuery.of(context).size.width * 0.75,
                          alignment: Alignment.centerLeft,
                          child: AutoSizeText(
                            description,
                            style: TextStyle(fontSize: 23),
                            maxLines: 2,
                          ))),
                ],
              ),
              button != null ? Padding(
                padding: const EdgeInsets.all(5.0),
                child: button,
              ) : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
