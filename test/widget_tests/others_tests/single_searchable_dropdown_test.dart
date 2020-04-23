import 'package:cineandgo/components/others/single_searchable_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group(
    'Single searchable dropdown',
    () {
      testWidgets(
        '- Returns the dropdown list',
        (WidgetTester tester) async {
          await tester.pumpWidget(MediaQuery(
              data: MediaQueryData(),
              child: MaterialApp(
                  home: Scaffold(
                body: SingleSearchableDropdown(
                    items: <DropdownMenuItem>[],
                    hint: 'Very useful hint',
                    searchHint: 'Another very useful hint',
                    onChangeValue: () {}),
              ))));
        },
      );
    },
  );
}
