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

    test('Successful login', () async {
      await driver.tap(find.byValueKey('login_button'));
      await driver.runUnsynchronized(() async {
        await driver.tap(find.byValueKey('email_field'));
        await driver.enterText('pablomf@email.com');
        await driver.tap(find.byValueKey('password_field'));
        await driver.enterText('123456');
        await driver.tap(find.byValueKey('login_screen_button'));
        await driver.waitUntilNoTransientCallbacks();
        assert(find.byType('Login') == null);
      });
    });
  });
}
