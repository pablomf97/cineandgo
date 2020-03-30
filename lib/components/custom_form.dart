import 'package:cineandgo/components/single_searchable_dropdown.dart';
import 'package:cineandgo/constants/constants.dart';
import 'package:cineandgo/localization/app_localizations.dart';
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

  void _selectCinema(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(
                  AppLocalizations.of(context).translate('select_theater')),
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
                      searchHint: AppLocalizations.of(context)
                          .translate('search_region'),
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
                        searchHint: AppLocalizations.of(context)
                            .translate('search_town'),
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
                                value: doc.documentID,
                              ));
                            });
                          });

                          setState(() {
                            _selectedLocalidad = value;
                            _dropdownTheaters = aux;
                          });
                        },
                        value: _selectedLocalidad),
                    SingleSearchableDropdown(
                      hint: AppLocalizations.of(context).translate('theater'),
                      searchHint: AppLocalizations.of(context)
                          .translate('search_theater'),
                      items: _dropdownTheaters,
                      onChangeValue: (value) {
                        _selectedTheater = value;
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
                      'Close',
                      style: TextStyle(color: kPrimaryColor),
                    ))
              ],
            ));
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              AppLocalizations.of(context).translate('create_room'),
              style: TextStyle(
                fontSize: 30,
              ),
            ),
          ),
          Card(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextFormField(
                    decoration: kTextFieldDecoration.copyWith(
                      hintText:
                          AppLocalizations.of(context).translate('room_name'),
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return AppLocalizations.of(context)
                            .translate('enter_room_name');
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextFormField(
                    decoration: kTextFieldDecoration,
                    enabled: false,
                    initialValue: widget.title,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        Card(
                          elevation: 5.0,
                          child: ListTile(
                            leading: Icon(
                              Icons.theaters,
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
                                  AppLocalizations.of(context)
                                      .translate('change'),
                                  style: TextStyle(color: Colors.black),
                                )),
                          ),
                        ),
                        Card(
                          elevation: 5.0,
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
                                  AppLocalizations.of(context)
                                      .translate('change'),
                                  style: TextStyle(color: Colors.black),
                                )),
                          ),
                        ),
                        Card(
                          elevation: 5.0,
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
                                  AppLocalizations.of(context)
                                      .translate('change'),
                                  style: TextStyle(color: Colors.black),
                                )),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RaisedButton(
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      Scaffold.of(context).showSnackBar(SnackBar(
                          content: Text(
                              '$_selectedRegion $_selectedLocalidad $_selectedTheater')));
                    }
                    print(
                        '$_selectedRegion $_selectedLocalidad $_selectedTheater');
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

/* 
Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            SingleSearchableDropdown(
                              items: _dropdownComunidades,
                              value: _selectedRegion,
                              hint: AppLocalizations.of(context)
                                  .translate('region'),
                              searchHint: AppLocalizations.of(context)
                                  .translate('search_region'),
                              onChangeValue: (value) {
                                List<DropdownMenuItem> aux = [];
                                if (_dropdownLocalidades != null &&
                                    _dropdownLocalidades.isNotEmpty)
                                  _dropdownLocalidades.clear();
                                if (_dropdownTheaters != null &&
                                    _dropdownTheaters.isNotEmpty)
                                  _dropdownTheaters.clear();
                                for (var town
                                    in kComunidades[value.toString()]) {
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
                                hint: AppLocalizations.of(context)
                                    .translate('town'),
                                searchHint: AppLocalizations.of(context)
                                    .translate('search_town'),
                                items: _dropdownLocalidades,
                                onChangeValue: (value) {
                                  List<DropdownMenuItem> aux = [];
                                  Firestore.instance
                                      .collection('theaters')
                                      .where('city', isEqualTo: _selectedRegion)
                                      .where('place',
                                          isEqualTo: value.toString())
                                      .snapshots()
                                      .listen((data) {
                                    data.documents.forEach((doc) {
                                      aux.add(DropdownMenuItem(
                                        child: Text(doc['name']),
                                        value: doc.documentID,
                                      ));
                                    });
                                  });

                                  setState(() {
                                    _selectedLocalidad = value;
                                    _dropdownTheaters = aux;
                                  });
                                },
                                value: _selectedLocalidad),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SingleSearchableDropdown(
                              hint: AppLocalizations.of(context)
                                  .translate('theater'),
                              searchHint: AppLocalizations.of(context)
                                  .translate('search_theater'),
                              items: _dropdownTheaters,
                              onChangeValue: (value) {
                                _selectedTheater = value;
                              },
                              value: _selectedTheater,
                              validator: (value) {
                                if (value == null) {
                                  return AppLocalizations.of(context)
                                      .translate('enter_theater');
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
*/
