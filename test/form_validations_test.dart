import 'package:cineandgo/services/form_validators.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  /// Testing form validations...
  ///
  /// Email validation
  test(
    'Validate email - Trying empty email',
    () {
      var actual = FormValidators.validateEmail('');
      expect(actual, 'empty_email');
    },
  );

  test(
    'Validate email - Trying non-empty email',
    () {
      var actual = FormValidators.validateEmail('email@email.com');
      expect(actual, null);
    },
  );

  /// Password validation
  test(
    'Validate password - Trying empty password',
    () {
      var actual = FormValidators.validatePassword('');
      expect(actual, 'empty_pass');
    },
  );

  test(
    'Validate password - Trying non-empty password',
    () {
      var actual = FormValidators.validatePassword('notverysecurepass');
      expect(actual, null);
    },
  );

  /// Password confirmation validation
  test(
    'Validate password confirmation - Trying empty password',
    () {
      var actual = FormValidators.validatePasswordConfirmation(
          null, 'notverysecurepass');
      expect(actual, 'pass_coincide');
    },
  );

  test(
    'Validate password - Trying non-empty password that do not coincide',
    () {
      var actual = FormValidators.validatePasswordConfirmation(
          'contraseñanomuysegura', 'notverysecurepass');
      expect(actual, 'pass_coincide');
    },
  );

  test(
    'Validate password - Trying non-empty password that coincide',
    () {
      var actual = FormValidators.validatePasswordConfirmation(
          'notverysecurepass', 'notverysecurepass');
      expect(actual, null);
    },
  );
}
