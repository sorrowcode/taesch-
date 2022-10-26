enum Error {
  noEmail,
  invalidEmail,
  noPassword,
  noLowerCaseLetter,
  noUpperCaseLetter,
  noNumber,
  noSpecialCharacter,
  tooLongOrTooShort,
  noUsername,
  invalidUsername,
  notSamePassword,
  emptyField,
}

extension ErrorMessage on Error {
  String get message {
    switch (this) {
      case Error.noEmail:
        return "no email";
      case Error.invalidEmail:
        return "invalid email";
      case Error.noPassword:
        return "no password";
      case Error.noLowerCaseLetter:
        return "missing lower case letter";
      case Error.noUpperCaseLetter:
        return "missing upper case letter";
      case Error.noNumber:
        return "missing number";
      case Error.noSpecialCharacter:
        return "missing special character";
      case Error.tooLongOrTooShort:
        return "too long or too short";
      case Error.noUsername:
        return "no username";
      case Error.invalidUsername:
        return "invalid username";
      case Error.notSamePassword:
        return "passwords don't match";
      case Error.emptyField:
        return "Field is empty";
    }
  }
}
