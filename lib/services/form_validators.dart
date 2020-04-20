class FormValidators {
  /// Checks that the provided email is not empty
  static String validateEmail(String email) {
    return email == null || email.trim().isEmpty ? 'empty_email' : null;
  }

  /// Check that the provided password is not empty
  static String validatePassword(String pass) {
    return pass == null || pass.trim().isEmpty ? 'empty_pass' : null;
  }

  /// Checks that the two passwords coincide
  static String validatePasswordConfirmation(
      String pass, String passConfirmation) {
    return pass != passConfirmation ? 'pass_coincide' : null;
  }

  /// Checks that the provided date is after now
  static bool validateDate(DateTime date) {
    return date != null &&
        date.isAfter(DateTime.now().add(Duration(milliseconds: -1)));
  }

  /// Check that a field is not empty
  static bool validateNotEmpty(String value) {
    return value != null && value.trim().isNotEmpty;
  }

  /// Checks that all fields provided are not empty
  static bool validateNotEmptyFields(List<String> fields) {
    bool res = true;
    for (var field in fields)
      if (!validateNotEmpty(field)) {
        res = false;
        break;
      }
    return res;
  }
}
