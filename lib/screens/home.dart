import 'package:cineandgo/components/custom_drawer.dart';
import 'package:cineandgo/constants/constants.dart';
import 'package:cineandgo/localization/app_localizations.dart';
import 'package:cineandgo/screens/welcome.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  static String id = 'home';

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Firebase stuff
  final _auth = FirebaseAuth.instance;
  FirebaseUser loggedUser;

  // User info
  String photoUrl;
  String name;
  String email;

  // This method gets the user
  // that is currently logged in
  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser();

      if (user != null) {
        loggedUser = user;
        getUserInfo();
      }
    } catch (oops) {
      print(oops);
    }
  }

  void getUserInfo() {
    setState(() {
      photoUrl = loggedUser.photoUrl;
      name = loggedUser.displayName;
      email = loggedUser.email;
    });
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(
        photoUrl: photoUrl,
        name: name,
        email: email,
        auth: _auth,
      ),
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Cine&Go!'),
        centerTitle: true,
        backgroundColor: kPrimaryColor,
      ),
    );
  }
}
