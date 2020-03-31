import 'package:cineandgo/components/dropdown_cinema.dart';
import 'package:cineandgo/components/single_searchable_dropdown.dart';
import 'package:cineandgo/constants/constants.dart';
import 'package:cineandgo/localization/app_localizations.dart';
import 'package:edge_alert/edge_alert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class CustomForm extends StatefulWidget {
  CustomForm({
    @required this.id,
    @required this.title,
  });

  final String id;
  final String title;

  @override
  _CustomFormState createState() => _CustomFormState();
}

class _CustomFormState extends State<CustomForm> {
  final _formKey = GlobalKey<FormState>();

  String _zero = "00";

  List<DropdownMenuItem> _dropdownComunidades = [];
  List<DropdownMenuItem> _dropdownLocalidades = [];
  List<DropdownMenuItem> _dropdownTheaters = [];

  String _selectedRegion;
  String _selectedLocalidad;
  String _selectedTheater;
  String _selectedName;
  DateTime _selectedDate;
  TimeOfDay _selectedTime;

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now().add(Duration(milliseconds: -1)),
        lastDate: DateTime.now().add(Duration(days: 7)));

    if (picked != null && picked != _selectedDate)
      setState(() {
        _selectedDate = picked;
      });
  }

  Future<Null> _selectTime(BuildContext context) async {
    final TimeOfDay picked =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  void _selectName(BuildContext context) async {
    String aux = _selectedName;
    await showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (BuildContext context, setState) {
          return AlertDialog(
            title: Text(AppLocalizations.of(context).translate('select_name')),
            content: Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                initialValue: aux != null && aux.isNotEmpty ? aux : '',
                decoration: kTextFieldDecoration.copyWith(
                  hintText: AppLocalizations.of(context).translate('room_name'),
                ),
                onChanged: (value) => aux = value,
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text(AppLocalizations.of(context).translate('accept')),
                textColor: kPrimaryColor,
                onPressed: () => Navigator.pop(context),
              )
            ],
          );
        },
      ),
    );
    setState(() {
      if (aux != null && aux.isNotEmpty) {
        if (aux != _selectedName) _selectedName = aux;
      } else {
        _selectedName = null;
      }
    });
  }

  void _selectCinema(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (BuildContext context, setState) {
          return AlertDialog(
            title:
                Text(AppLocalizations.of(context).translate('select_theater')),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            content: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SingleSearchableDropdown(
                    items: _dropdownComunidades,
                    value: _selectedRegion,
                    hint: AppLocalizations.of(context).translate('region'),
                    searchHint:
                        AppLocalizations.of(context).translate('search_region'),
                    onChangeValue: (value) {
                      List<DropdownMenuItem> aux = [];
                      if (_dropdownLocalidades != null &&
                          _dropdownLocalidades.isNotEmpty)
                        _dropdownLocalidades.clear();
                      if (_dropdownTheaters != null &&
                          _dropdownTheaters.isNotEmpty)
                        _dropdownTheaters.clear();
                      for (var town in kComunidades[value.toString()]) {
                        aux.add(DropdownMenuItem(
                          child: Text(town),
                          value: town,
                        ));
                      }
                      setState(() {
                        _selectedRegion = value;
                        _dropdownLocalidades = aux;
                      });
                    },
                  ),
                  SingleSearchableDropdown(
                      hint: AppLocalizations.of(context).translate('town'),
                      searchHint:
                          AppLocalizations.of(context).translate('search_town'),
                      items: _dropdownLocalidades,
                      onChangeValue: (value) {
                        List<DropdownMenuItem> aux = [];
                        Firestore.instance
                            .collection('theaters')
                            .where('city', isEqualTo: _selectedRegion)
                            .where('place', isEqualTo: value.toString())
                            .snapshots()
                            .listen((data) {
                          data.documents.forEach((doc) {
                            aux.add(DropdownMenuItem(
                              child: Text(doc['name']),
                              value: '${doc['name']} (${doc.documentID})',
                            ));
                          });
                          setState(() {
                            _selectedLocalidad = value;
                            _dropdownTheaters = aux;
                          });
                        });
                      },
                      value: _selectedLocalidad),
                  SingleSearchableDropdown(
                    hint: AppLocalizations.of(context).translate('theater'),
                    searchHint: AppLocalizations.of(context)
                        .translate('search_theater'),
                    items: _dropdownTheaters,
                    onChangeValue: (value) {
                      setState(() {
                        _selectedTheater = value;
                      });
                    },
                    value: _selectedTheater,
                    validator: (value) {
                      if (value == null) {
                        return AppLocalizations.of(context)
                            .translate('enter_theater');
                      }
                      return null;
                    },
                  )
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    AppLocalizations.of(context).translate('accept'),
                    style: TextStyle(color: kPrimaryColor),
                  ))
            ],
          );
        },
      ),
    );
    setState(() {
      _selectedTheater = _selectedTheater;
    });
  }

  @override
  void initState() {
    super.initState();
    getSelectables();
  }

  void getSelectables() {
    for (var comunidad in kComunidades.keys) {
      _dropdownComunidades.add(DropdownMenuItem(
        child: Text(comunidad),
        value: comunidad,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              alignment: Alignment.centerLeft,
              child: Text(
                AppLocalizations.of(context).translate('create_room'),
                style: TextStyle(
                  fontSize: 40,
                  color: kPrimaryColor,
                ),
              ),
            ),
          ),
          Card(
            color: kVeryLightPrimaryColor,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 15.0),
              child: Container(
                child: Column(
                  children: <Widget>[
                    Card(
                      elevation: 5.0,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          leading: Icon(
                            Icons.theaters,
                            color: Colors.black,
                          ),
                          title: Text(
                            widget.title,
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Card(
                      elevation: 5.0,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          leading: Icon(
                            Icons.border_color,
                            color: Colors.black,
                          ),
                          title: _selectedName == null
                              ? Text(AppLocalizations.of(context)
                                  .translate('select_name'))
                              : Text(
                                  '$_selectedName',
                                ),
                          trailing: FlatButton(
                            onPressed: () => _selectName(context),
                            child: Text(
                              AppLocalizations.of(context).translate('change'),
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            color: kPrimaryColor,
                          ),
                        ),
                      ),
                    ),
                    Card(
                      elevation: 5.0,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          leading: Icon(
                            Icons.event_seat,
                            color: Colors.black,
                          ),
                          title: _selectedTheater == null
                              ? Text(AppLocalizations.of(context)
                                  .translate('select_theater'))
                              : Text(
                                  '$_selectedTheater',
                                ),
                          trailing: FlatButton(
                            onPressed: () => _selectCinema(context),
                            child: Text(
                              AppLocalizations.of(context).translate('change'),
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            color: kPrimaryColor,
                          ),
                        ),
                      ),
                    ),
                    Card(
                      elevation: 5.0,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          leading: Icon(
                            Icons.calendar_today,
                            color: Colors.black,
                          ),
                          title: _selectedDate == null
                              ? Text(AppLocalizations.of(context)
                                  .translate('pick_date'))
                              : Text(
                                  '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
                                ),
                          trailing: FlatButton(
                            onPressed: () => _selectDate(context),
                            child: Text(
                              AppLocalizations.of(context).translate('change'),
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            color: kPrimaryColor,
                          ),
                        ),
                      ),
                    ),
                    Card(
                      elevation: 5.0,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          leading: Icon(
                            Icons.access_time,
                            color: Colors.black,
                          ),
                          title: _selectedTime == null
                              ? Text(AppLocalizations.of(context)
                                  .translate('pick_time'))
                              : Text(
                                  '${_selectedTime.hour} : ${_selectedTime.minute == 0 ? _zero : _selectedTime.minute}'),
                          trailing: FlatButton(
                            onPressed: () => _selectTime(context),
                            child: Text(
                              AppLocalizations.of(context).translate('change'),
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            color: kPrimaryColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RaisedButton(
                  elevation: 5.0,
                  onPressed: () async {
                    if (_selectedDate == null ||
                        _selectedTheater == null ||
                        _selectedName == null ||
                        _selectedTime == null) {
                      EdgeAlert.show(
                        context,
                        duration: EdgeAlert.LENGTH_VERY_LONG,
                        backgroundColor: Colors.red,
                        icon: Icons.error_outline,
                        title: AppLocalizations.of(context)
                            .translate('form_not_filled'),
                      );
                    } else {
                      String theaterId =
                          _selectedTheater.split('(')[1].replaceFirst(')', '');

                      Future<DocumentReference> docRef =
                          Firestore.instance.collection('rooms').add({
                        'movieId': widget.id,
                        'theaterId': theaterId,
                        'roomName': _selectedName,
                        'date':
                            '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
                        'time': '${_selectedTime.hour}:${_selectedTime.minute}',
                        'going': [await FirebaseAuth.instance.currentUser().then((value) => value.email)]
                      });

                      docRef.then((value) {
                        EdgeAlert.show(context,
                            backgroundColor: Colors.green,
                            icon: Icons.check_circle_outline,
                            duration: EdgeAlert.LENGTH_VERY_LONG,
                            title: AppLocalizations.of(context)
                                .translate('room_created'));

                        Navigator.pop(context);
                      }, onError: (error) {
                        EdgeAlert.show(context,
                            backgroundColor: Colors.red,
                            icon: Icons.check_circle_outline,
                            duration: EdgeAlert.LENGTH_VERY_LONG,
                            title:
                                AppLocalizations.of(context).translate('oops'));
                      });
                    }
                  },
                  child: Text(
                    AppLocalizations.of(context).translate('create'),
                    style: TextStyle(fontSize: 20),
                  ),
                  textColor: Colors.white,
                  color: kPrimaryColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0)),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
