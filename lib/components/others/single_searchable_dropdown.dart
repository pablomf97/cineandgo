import 'package:flutter/material.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';

class SingleSearchableDropdown extends StatelessWidget {
  SingleSearchableDropdown({
    @required this.hint,
    @required this.searchHint,
    this.items,
    @required this.onChangeValue,
    this.validator,
    this.value,
  });

  final List items;
  final Function onChangeValue;
  final String hint;
  final String searchHint;
  final Function validator;
  final value;

  @override
  Widget build(BuildContext context) {
    return SearchableDropdown(
      items: items,
      onChanged: onChangeValue,
      hint: hint,
      displayClearIcon: false,
      closeButton: null,
      searchHint: searchHint,
      validator: validator,
      value: value,
    );
  }
}
