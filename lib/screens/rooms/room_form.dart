import 'package:cineandgo/components/rooms/custom_form.dart';
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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Cine&Go!',
        ),
        centerTitle: true,
      ),
      body: CustomForm(
        id: id,
        title: title,
      ),
    );
  }
}
