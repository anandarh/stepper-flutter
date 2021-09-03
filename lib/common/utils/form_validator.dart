import 'string_validator.dart';

class FormValidator {
  static String? validateEmail(String? value) {
    if (value!.isEmpty) {
      return 'Email is required!';
    }

    // Regex for email validation
    String p = "[a-zA-Z0-9\+\.\_\%\-\+]{1,256}" +
        "\\@" +
        "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}" +
        "(" +
        "\\." +
        "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25}" +
        ")+";
    RegExp regExp = new RegExp(p);

    if (regExp.hasMatch(value)) {
      return null;
    }

    return 'Invalid email format';
  }

  static String? validatePassword(String? value) {
    if (value!.isEmpty) {
      return 'Please enter your password!';
    }

    if (value.strengthLevel == 'Weak') {
      return 'Your password security is too weak!';
    }

    return null;
  }

  static String? validateEmpty(String? value) {
    if (value == null) {
      return 'Please enter your choice!';
    }

    if (value.isEmpty) {
      return 'Please enter your choice!';
    }
  }
}