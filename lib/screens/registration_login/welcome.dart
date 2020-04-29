import 'package:cineandgo/components/others/rounded_button.dart';
import 'package:cineandgo/localization/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:cineandgo/constants/constants.dart';
import 'login.dart';
import 'registration.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class Welcome extends StatelessWidget {
  static const String id = 'welcome';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: Container(
                    child: Image.asset('images/logo.png'),
                    height: 100.0,
                  ),
                ),
                SizedBox(
                  width: 15.0,
                ),
                TyperAnimatedTextKit(
                  text: ['Cine&Go!'],
                  speed: Duration(milliseconds: 100),
                  isRepeatingAnimation: false,
                  textStyle: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 45.0,
                    fontWeight: FontWeight.w800,
                    color: kPrimaryTextColor,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            RoundedButton(
              key: Key('login_button'),
              text: AppLocalizations.of(context).translate('login'),
              color: kAccentColor,
              onPressed: () => Navigator.pushNamed(context, Login.id),
            ),
            RoundedButton(
              key: Key('register_button'),
              text: AppLocalizations.of(context).translate('register'),
              color: kPrimaryColor,
              onPressed: () => Navigator.pushNamed(context, Registration.id),
            ),
          ],
        ),
      ),
    );
  }
}
