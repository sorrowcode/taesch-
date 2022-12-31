enum ErrorCase {
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

extension ErrorMessage on ErrorCase {
  String get message {
    switch (this) {
      case ErrorCase.noEmail:
        return "no email";
      case ErrorCase.invalidEmail:
        return "invalid email";
      case ErrorCase.noPassword:
        return "no password";
      case ErrorCase.noLowerCaseLetter:
        return "missing lower case letter";
      case ErrorCase.noUpperCaseLetter:
        return "missing upper case letter";
      case ErrorCase.noNumber:
        return "missing number";
      case ErrorCase.noSpecialCharacter:
        return "missing special character";
      case ErrorCase.tooLongOrTooShort:
        return "too long or too short";
      case ErrorCase.noUsername:
        return "no username";
      case ErrorCase.invalidUsername:
        return "invalid username";
      case ErrorCase.notSamePassword:
        return "passwords don't match";
      case ErrorCase.emptyField:
        return "field is empty";
    }
  }
}
