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

  ///Date validation
  test(
    'Validate date - Trying date before \'now\'',
    () {
      var actual =
          FormValidators.validateDate(DateTime.now().add(Duration(hours: -5)));
      expect(actual, false);
    },
  );

  test(
    'Validate date - Trying date after \'now\'',
    () {
      var actual =
          FormValidators.validateDate(DateTime.now().add(Duration(hours: 5)));
      expect(actual, true);
    },
  );

  /// Validating empty strings.
  test(
    'Validate string - Trying empty string',
    () {
      var actual = FormValidators.validateNotEmpty('');
      expect(actual, false);
    },
  );

  test(
    'Validate string - Trying non-empty string',
    () {
      var actual = FormValidators.validateNotEmpty('Not an empty string');
      expect(actual, true);
    },
  );

  /// Validating that a list of filds are not empty.
  test(
    'Validate list of strings - Trying empty strings',
    () {
      var actual = FormValidators.validateNotEmptyFields(
          ['Not an empty string', ' ', 'Not an empty string']);
      expect(actual, false);
    },
  );

  test(
    'Validate list of strings - Trying non-empty strings',
    () {
      var actual = FormValidators.validateNotEmptyFields([
        'Not an empty string',
        'Not an empty string',
        'Not an empty string'
      ]);
      expect(actual, true);
    },
  );
}
