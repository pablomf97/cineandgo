import 'package:cineandgo/components/rounded_button.dart';
import 'package:cineandgo/constants/constants.dart';
import 'package:edge_alert/edge_alert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:progress_indicators/progress_indicators.dart';

import 'home.dart';

class Login extends StatefulWidget {
  static const String id = 'login';

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> with SingleTickerProviderStateMixin {
  // Firebase stuff
  final _auth = FirebaseAuth.instance;

  // Animation-related
  AnimationController controller;
  RotationTransition transition;
  bool showSpinner = false;

  // TextFields values
  String email;
  String password;

  // Enabling/Disabling button
  bool isEmailFieldFilled = false;
  bool isPasswordFieldFilled = false;

  @override
  void initState() {
    super.initState();

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        opacity: 0.9,
        progressIndicator: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RotationTransition(
              turns: controller,
              child: Container(
                height: 60.0,
                child: Image.asset('images/logo.png'),
              ),
            ),
            ScalingText(
              'Cargando películas y salas...',
              style: TextStyle(fontSize: 15.0),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Hero(
                tag: 'logo',
                child: RotationTransition(
                  turns: controller,
                  child: Container(
                    height: 200.0,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  if (value.length > 0) {
                    setState(() {
                      isEmailFieldFilled = true;
                    });
                  } else {
                    setState(() {
                      isEmailFieldFilled = false;
                    });
                  }
                  email = value;
                },
                decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Introduce tu email',
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                obscureText: true,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  if (value.length > 0) {
                    setState(() {
                      isPasswordFieldFilled = true;
                    });
                  } else {
                    setState(() {
                      isPasswordFieldFilled = false;
                    });
                  }
                  password = value;
                },
                decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Introduce tu contraseña',
                ),
              ),
              SizedBox(
                height: 24.0,
              ),
              RoundedButton(
                enabled: isEmailFieldFilled && isPasswordFieldFilled,
                text: 'Entrar',
                color: kAccentColor,
                onPressed: () async {
                  try {
                    setState(() {
                      showSpinner = true;
                    });
                    final user = await _auth.signInWithEmailAndPassword(
                      email: email,
                      password: password,
                    );

                    if (user != null) {
                      int i = 0;
                      Navigator.pushNamedAndRemoveUntil(context, Home.id,
                          (route) {
                        return i++ == 2;
                      });
                    }
                  } catch (oops) {
                    setState(() {
                      showSpinner = false;
                      EdgeAlert.show(context,
                          title: '¡Oops, error!',
                          description: 'Ha ocurrido algún error relacionado'
                              ' con la base de datos. Vuelve a'
                              ' intentarlo en unos momentos',
                          duration: EdgeAlert.LENGTH_VERY_LONG,
                          icon: Icons.error_outline,
                          backgroundColor: Colors.red);
                    });
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
