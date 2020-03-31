import 'package:cineandgo/constants/constants.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:cineandgo/screens/home.dart';
import 'package:cineandgo/screens/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:cineandgo/screens/welcome.dart';
import 'package:cineandgo/screens/login.dart';
import 'package:cineandgo/screens/registration.dart';
import 'package:cineandgo/localization/app_localizations.dart';

// TODO: Clean imports of project

void main() => runApp(CineGo());

class CineGo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: Theme.of(context).copyWith(
        primaryColor: kPrimaryColor,
        accentColor: kAccentColor,
      ),
      supportedLocales: [
        Locale('en', 'GB'),
        Locale('en', 'US'),
        Locale('es', 'ES'),
        Locale('es', 'AR'),
      ],
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      localeResolutionCallback: (locale, supportedLocales) {
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale.languageCode &&
              supportedLocale.countryCode == locale.countryCode) {
            return supportedLocale;
          }
        }
        return supportedLocales.first;
      },
      debugShowCheckedModeBanner: false,
      initialRoute: LoadingScreen.id,
      routes: {
        Welcome.id: (context) => Welcome(),
        Registration.id: (context) => Registration(),
        Login.id: (context) => Login(),
        Home.id: (context) => Home(),
        LoadingScreen.id: (context) => LoadingScreen(),
      },
    );
  }
}
