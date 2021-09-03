extension StringValidators on String {
  /// Check if the string contains lowercase characters.
  bool get isLowercase {
    RegExp regEx = RegExp(r".*[a-z].*");
    return regEx.hasMatch(this);
  }

  /// Check if the string contains uppercase characters.
  bool get isUppercase {
    RegExp regEx = RegExp(r".*[A-Z].*");
    return regEx.hasMatch(this);
  }

  /// Check if the string contains numeric characters.
  bool get isNumber {
    RegExp regEx = RegExp(r".*[0-9].*");
    return regEx.hasMatch(this);
  }

  /// Check if the string contains special characters.
  bool get isCharacter {
    RegExp regEx = RegExp(r".*(?!\w+$)^.+$.*");
    return regEx.hasMatch(this);
  }

  /// Check the complexity of a string.
  String get strengthLevel {
    RegExp strongRegExp = RegExp(
        r"^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#\$%\^&\*])(?=.{8,})");
    RegExp mediumRegExp = RegExp(
        r"^(((?=.*[a-z])(?=.*[A-Z]))|((?=.*[a-z])(?=.*[0-9]))|((?=.*[A-Z])(?=.*[0-9])))(?=.{6,})");

    if (strongRegExp.hasMatch(this)) {
      return 'Strong';
    } else if (mediumRegExp.hasMatch(this)) {
      return 'Medium';
    } else {
      return 'Weak';
    }
  }
}
