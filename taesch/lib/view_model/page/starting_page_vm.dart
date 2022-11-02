import 'package:taesch/model/error_case.dart';

abstract class StartingPageVM {
  ErrorCase? validateEMail(String? value) {
    if (value == null || value.isEmpty) {
      return ErrorCase.noEmail;
    }
    if (!RegExp(
            r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
        .hasMatch(value)) {
      return ErrorCase.invalidEmail;
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
  ErrorCase? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return ErrorCase.noPassword;
    } else if (!RegExp(r"^.{8,32}.*$").hasMatch(value)) {
      return ErrorCase.tooLongOrTooShort;
    } else if (!RegExp(r"^.*[0-9].*$").hasMatch(value)) {
      return ErrorCase.noNumber;
    } else if (!RegExp(r"^.*[a-z].*$").hasMatch(value)) {
      return ErrorCase.noLowerCaseLetter;
    } else if (!RegExp(r"^.*[A-Z].*$").hasMatch(value)) {
      return ErrorCase.noUpperCaseLetter;
    } else if (!RegExp(r"^.*\W.*$").hasMatch(value)) {
      return ErrorCase.noSpecialCharacter;
    }
    return null;
  }
}
