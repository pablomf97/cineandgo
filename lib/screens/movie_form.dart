import 'package:cineandgo/components/custom_form.dart';
import 'package:cineandgo/constants/constants.dart';
import 'package:flutter/material.dart';

class MovieForm extends StatefulWidget {
  MovieForm({@required this.id, this.title});

  final String id;
  final String title;

  @override
  _MovieFormState createState() => _MovieFormState(id: id, title: title);
}

class _MovieFormState extends State<MovieForm> {
  _MovieFormState({@required this.id, @required this.title});

  final String id;
  final String title;

  @override
  void initState() {
    getData();
    super.initState();
  }

  void getData() {
    print('$id $title');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cine&Go!'),
        centerTitle: true,
        backgroundColor: kPrimaryColor,
      ),
      body: CustomForm(
        id: id,
        title: title,
      ),
    );
  }
}

