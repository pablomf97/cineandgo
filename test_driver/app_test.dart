import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Cine&Go! app test -', () {
    FlutterDriver driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() {
      if (driver != null) {
        driver.close();
      }
    });

    final emailField = find.byValueKey('email_field');
    final passwordField = find.byValueKey('password_field');
    final registrationEmailField = find.byValueKey('registration_email_field');
    final registrationPassField = find.byValueKey('registration_pass_field');
    final registrationConfirmField =
        find.byValueKey('registration_confirm_field');

    final registrationRegisterButton =
        find.byValueKey('registration_register_button');

    final loginpage = find.byType('Login');
    final homepage = find.byType('Home');
    final moviedetailspage = find.byType('MovieDetails');
    final movielistpage = find.byType('AllMovieList');
    final registrationpage = find.byType('Registration');

    test('Unsuccessful login', () async {
      await driver.tap(find.byValueKey('login_button'));
      await driver.runUnsynchronized(() async {
        await driver.tap(emailField);
        await driver.enterText('pablomfemail.com');
        await driver.tap(passwordField);
        await driver.enterText('123456789');
        await driver.tap(find.byValueKey('login_screen_button'));
        assert(loginpage != null);
      });
    });

    test('Successful login', () async {
      await driver.runUnsynchronized(() async {
        await driver.tap(emailField);
        await driver.enterText('pablomf@email.com');
        await driver.tap(passwordField);
        await driver.enterText('123456');
        await driver.tap(find.byValueKey('login_screen_button'));
        await driver.waitUntilNoTransientCallbacks();
        await driver.waitFor(homepage);
        assert(loginpage == null);
        assert(homepage != null);
      });
    });

    test('Checking a movie', () async {
      await driver.runUnsynchronized(() async {
        assert(homepage != null);
        await driver.tap(find.byValueKey('movie1'));
        await driver.waitUntilNoTransientCallbacks();
        await driver.waitFor(moviedetailspage);
        assert(moviedetailspage != null);
        await driver.tap(find.byValueKey('overview_tab'));
        await driver.tap(find.byValueKey('genres_tab'));
        await driver.tap(find.byValueKey('cast_tab'));
        await driver.scrollUntilVisible(
            find.byValueKey('cast_list'), find.byValueKey('cast_member6'));
        await driver.tap(find.byValueKey('rooms_tab'));
        await driver.waitUntilNoTransientCallbacks();
      });
    });

    test('Checking all movies', () async {
      await driver.runUnsynchronized(() async {
        await driver.tap(find.pageBack());
        await driver.waitUntilNoTransientCallbacks();
        assert(moviedetailspage == null);
        await driver.tap(find.byValueKey('button0'));
        await driver.waitUntilNoTransientCallbacks();
        await driver.waitFor(movielistpage);
        assert(movielistpage != null);
        await driver.scroll(
            find.byValueKey('movies_grid'), 0, -300, Duration(seconds: 1));
        await driver.tap(find.byValueKey('movie_list_next'));
        await driver.waitUntilNoTransientCallbacks();
        await driver.tap(find.byValueKey('movie_list_prev'));
        await driver.waitUntilNoTransientCallbacks();
      });
    });

    test('Logout from app', () async {
      await driver.runUnsynchronized(() async {
        await driver.tap(find.pageBack());
        assert(movielistpage == null);
        await driver.tap(find.byValueKey('popup_logout_button'));
        await driver.tap(find.byValueKey('logout_button'));
        await driver.waitUntilNoTransientCallbacks();
      });
    });

    test('Failing to register new user - Passwords do not coincide', () async {
      await driver.tap(find.byValueKey('register_button'));
      await driver.runUnsynchronized(() async {
        await driver.tap(registrationEmailField);
        await driver.enterText('pablomfemail.com');
        await driver.tap(registrationPassField);
        await driver.enterText('12345');
        await driver.tap(registrationConfirmField);
        await driver.enterText('123456');
        await driver.tap(registrationRegisterButton);
        assert(registrationpage != null);
        assert(find.text('Passwords must coincide') != null);
      });
    });

    test('Failing to register new user - Not a valid email', () async {
      await driver.runUnsynchronized(() async {
        await driver.tap(registrationPassField);
        await driver.enterText('123456');
        await driver.tap(registrationRegisterButton);
        await Future.delayed(Duration(seconds: 4));
        assert(registrationpage != null);
      });
    });

    test('Failing to register new user - Already used email', () async {
      await driver.runUnsynchronized(() async {
        await driver.tap(registrationEmailField);
        await driver.enterText('pablomf@email.com');
        await driver.tap(registrationRegisterButton);
        await Future.delayed(Duration(seconds: 4));
        assert(registrationpage != null);
      });
    });

    test('Success registering new user', () async {
      await driver.runUnsynchronized(() async {
        await driver.tap(registrationEmailField);
        await driver.enterText('pablofm@email.com');
        await driver.tap(registrationRegisterButton);
        await driver.waitUntilNoTransientCallbacks();
        assert(registrationpage == null);
        assert(homepage != null);
      });
    });
  });
}
