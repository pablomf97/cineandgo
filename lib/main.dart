import 'package:cineandgo/constants/constants.dart';
import 'package:cineandgo/screens/home.dart';
import 'package:cineandgo/screens/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:cineandgo/screens/welcome.dart';
import 'package:cineandgo/screens/login.dart';
import 'package:cineandgo/screens/registration.dart';

void main() => runApp(CineGo());

class CineGo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
