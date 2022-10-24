import 'package:taesch/model/error.dart';

abstract class StartingPageVM {
  Error? validateEMail(String? value) {
    if (value == null || value.isEmpty) {
      return Error.noEmail;
    }
    if (!RegExp(
            r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
        .hasMatch(value)) {
      return Error.invalidEmail;
    }
    return null;
  }

  /// validates the password with the following criteria:
  ///
  /// - lower case letter
  /// - upper case letter
  /// - number
  /// - special character
  /// - length between 8 and 32 characters
  Error? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return Error.noPassword;
    } else if (!RegExp(r"^.{8,32}.*$").hasMatch(value)) {
      return Error.tooLongOrTooShort;
    } else if (!RegExp(r"^.*[0-9].*$").hasMatch(value)) {
      return Error.noNumber;
    } else if (!RegExp(r"^.*[a-z].*$").hasMatch(value)) {
      return Error.noLowerCaseLetter;
    } else if (!RegExp(r"^.*[A-Z].*$").hasMatch(value)) {
      return Error.noUpperCaseLetter;
    } else if (!RegExp(r"^.*\W.*$").hasMatch(value)) {
      return Error.noSpecialCharacter;
    }
    return null;
  }
}
