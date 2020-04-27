import 'package:cineandgo/components/rooms/custom_form.dart';
import 'package:cineandgo/localization/app_localizations.dart';
import 'package:cloud_firestore_mocks/cloud_firestore_mocks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';

Widget buildTesteableWidget({@required Widget child}) {
  return MediaQuery(
      data: MediaQueryData(),
      child: MaterialApp(localizationsDelegates: [
        AppLocalizationsDelegate(isTest: true),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ], home: child));
}

void main() {
  testWidgets(
    'Testing that custom form shows',
    (WidgetTester tester) async {
      await tester.pumpWidget(buildTesteableWidget(
          child: CustomForm(
        id: '598',
        title: 'Cidade de Deus',
        db: MockFirestoreInstance(),
      )));
      await tester.pumpAndSettle();

      final buttonFinder = find.byType(FlatButton);

      await tester.tap(buttonFinder.at(0));
      await tester.tap(buttonFinder.at(1));
      await tester.tap(buttonFinder.at(2));
      await tester.tap(buttonFinder.at(3));
    },
  );
}
