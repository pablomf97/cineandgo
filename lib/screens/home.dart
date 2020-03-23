import 'package:cineandgo/constants/constants.dart';
import 'package:cineandgo/screens/welcome.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Home extends StatefulWidget {
  static String id = 'home';

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Firebase stuff
  final _auth = FirebaseAuth.instance;
  FirebaseUser loggedUser;

  // This method gets the user
  // that is currently logged in
  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser();

      if (user != null) {
        loggedUser = user;
      }
    } catch (oops) {
      print(oops);
    }
  }

  @override
  void initState() {
    super.initState();

    getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Cine&Go!'),
        centerTitle: true,
        backgroundColor: kPrimaryColor,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              _auth.signOut();
              Navigator.popAndPushNamed(context, Welcome.id);
            },
          )
        ],
      ),
    );
  }
}
