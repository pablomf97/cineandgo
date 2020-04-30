import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Cine&Go! app test - Login -', () {
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
    final loginpage = find.byType('Login');
    final homepage = find.byType('Home');

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
  });
}
