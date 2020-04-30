import 'package:cineandgo/components/others/custom_divider.dart';
import 'package:cineandgo/screens/others/loading_screen.dart';
import 'package:cineandgo/services/google_sign_in_out.dart';
import 'package:cineandgo/components/others/image_rounded_button.dart';
import 'package:cineandgo/components/others/rounded_button.dart';
import 'package:cineandgo/constants/constants.dart';
import 'package:cineandgo/localization/app_localizations.dart';
import 'package:cineandgo/services/form_validators.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:edge_alert/edge_alert.dart';

class Registration extends StatefulWidget {
  static const String id = 'registration';
  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration>
    with SingleTickerProviderStateMixin {
  // Firebase stuff & more Google stuff
  final _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  // Form key
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Animation-related
  AnimationController controller;
  RotationTransition transition;
  bool showSpinner = false;

  // TextFields values
  String email;
  String password;

  @override
  void initState() {
    super.initState();

    // Creating animations
    controller = AnimationController(
        duration: Duration(minutes: 2), vsync: this, upperBound: 20);

    // Starting animation
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
      /* 
      Shows a rotating spinner whenever the 
      boolean 'showSpinner' is equal to true.
      */
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
              AppLocalizations.of(context).translate('loading_screen'),
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
              /* 
              Input for the email address. It only checks if
              the input is filled because Firebase already
              checks if the text provided is an email.
              */
              Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      style: TextStyle().copyWith(color: Colors.black),
                      keyboardType: TextInputType.emailAddress,
                      textAlign: TextAlign.center,
                      validator: (value) {
                        final String message =
                            FormValidators.validateEmail(value);
                        if (message == null) return null;
                        return AppLocalizations.of(context).translate(message);
                      },
                      onChanged: (value) => email = value,
                      decoration: kTextFieldDecoration.copyWith(
                        hintText: AppLocalizations.of(context)
                            .translate('enter_an_email'),
                        hintStyle: TextStyle().copyWith(color: Colors.grey),
                      ),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    /* 
                    Password input. It checks if the text that 
                    the user inputs is more than 6 characters
                    long.
                    */
                    TextFormField(
                      style: TextStyle().copyWith(color: Colors.black),
                      obscureText: true,
                      textAlign: TextAlign.center,
                      validator: (value) {
                        final String message =
                            FormValidators.validatePassword(value);
                        if (message == null) return null;
                        return AppLocalizations.of(context).translate(message);
                      },
                      onChanged: (value) => password = value,
                      decoration: kTextFieldDecoration.copyWith(
                        hintText: AppLocalizations.of(context)
                            .translate('enter_a_pass'),
                        hintStyle: TextStyle().copyWith(color: Colors.grey),
                      ),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    /* 
                    Password confirmation input. Checks that the password
                    written in this input is the same as the other
                    password input.
                    */
                    TextFormField(
                      style: TextStyle().copyWith(color: Colors.black),
                      obscureText: true,
                      textAlign: TextAlign.center,
                      validator: (value) {
                        final String message =
                            FormValidators.validatePasswordConfirmation(
                                password, value);
                        if (message == null) return null;
                        return AppLocalizations.of(context).translate(message);
                      },
                      decoration: kTextFieldDecoration.copyWith(
                        hintText: AppLocalizations.of(context)
                            .translate('repeat_pass'),
                        hintStyle: TextStyle().copyWith(color: Colors.grey),
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                  ],
                ),
              ),
              /* 
              When the three booleans are equal to true means 
              that the user correctly filled the form an it is
              ready to validate.
              */
              RoundedButton(
                text: AppLocalizations.of(context).translate('register'),
                color: kAccentColor,
                /* 
                While the user is waiting, a spinner will show 
                in the middle of the screen so he/she knows that
                the app is working hard.

                If everything went correctly, there will be a new
                user in the database that will be able to log in
                in the app.
                */
                onPressed: () async {
                  if (!_formKey.currentState.validate()) return;
                  try {
                    setState(
                      () => showSpinner = true,
                    );
                    final newUser = await _auth.createUserWithEmailAndPassword(
                      email: email,
                      password: password,
                    );

                    if (newUser != null) {
                      Navigator.pushNamedAndRemoveUntil(
                          context, LoadingScreen.id, (route) => false);
                    }
                  } catch (oops) {
                    /* 
                    If Firebase returned some error, the app will 
                    show the user some information about it.
                    */
                    print(oops.code);
                    String message;
                    if (oops.code == 'ERROR_INVALID_EMAIL') {
                      message = AppLocalizations.of(context)
                          .translate('err_msg_firebase_invalid_email');
                    } else if (oops.code == 'ERROR_EMAIL_ALREADY_IN_USE') {
                      message = AppLocalizations.of(context)
                          .translate('err_msg_firebase_email_already_in_use');
                    } else {
                      message = AppLocalizations.of(context)
                          .translate('err_msg_firebase_generic');
                    }
                    setState(
                      () {
                        showSpinner = false;
                        EdgeAlert.show(context,
                            title:
                                AppLocalizations.of(context).translate('oops'),
                            description: message,
                            duration: EdgeAlert.LENGTH_VERY_LONG,
                            icon: Icons.error_outline,
                            backgroundColor: Colors.red);
                      },
                    );
                  }
                },
              ),
              /* 
              The user also has the option to register/login using Google
              */
              CustomDivider(
                thickness: 1.5,
                text: AppLocalizations.of(context).translate('or_use'),
                horizontalPadding: 12.0,
              ),
              ImageRoundedButton(
                title: 'Google',
                imagePath: 'images/google.png',
                onPressed: () async {
                  setState(
                    () => showSpinner = true,
                  );
                  try {
                    await GoogleSignInOut.signInWithGoogle(_auth, googleSignIn);
                    Navigator.pushNamedAndRemoveUntil(
                        context, LoadingScreen.id, (route) => false);
                  } catch (oops) {
                    setState(
                      () {
                        showSpinner = false;
                      },
                    );
                    EdgeAlert.show(context,
                        title: AppLocalizations.of(context).translate('oops'),
                        description: AppLocalizations.of(context)
                            .translate('err_msg_google_sign_in'),
                        duration: EdgeAlert.LENGTH_VERY_LONG,
                        icon: Icons.error_outline,
                        backgroundColor: Colors.red);
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
