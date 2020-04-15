import 'package:cineandgo/screens/registration_login/welcome.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'home.dart';

class LoadingScreen extends StatefulWidget {
  static String id = 'loading_screen';

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen>
    with SingleTickerProviderStateMixin {
  // Firebase stuff
  final _auth = FirebaseAuth.instance;

  // Animation-related
  AnimationController controller;
  RotationTransition transition;

  @override
  void initState() {
    super.initState();

    // Checking if there is any logged user
    getCurrentUser();

    // Creating animations
    controller = AnimationController(
        duration: Duration(minutes: 2), vsync: this, upperBound: 20);

    //Starting animations
    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser();

      user != null
          ? Navigator.pushReplacementNamed(context, Home.id)
          : Navigator.pushReplacementNamed(context, Welcome.id);
    } catch (oops) {
      print(oops);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: RotationTransition(
          turns: controller,
          child: Container(
            height: 60.0,
            child: Image.asset('images/logo.png'),
          ),
        ),
      ),
    );
  }
}
