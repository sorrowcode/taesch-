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
}

extension ErrorMessage on Error {
  String get message {
    switch (this) {
      case Error.noEmail:
        return "Please enter an E-Mail address";
      case Error.invalidEmail:
        return "Please enter a valid email address";
      case Error.noPassword:
        return "Please enter a password";
      case Error.noLowerCaseLetter:
        return "The password should have at least on lower case letter";
      case Error.noUpperCaseLetter:
        return "The password should contain at least one upper case letter";
      case Error.noNumber:
        return "The password should contain at least one number";
      case Error.noSpecialCharacter:
        return "The password should contain at least one special character";
      case Error.tooLongOrTooShort:
        return "The length of the password should be between 8 and 32 characters";
      case Error.noUsername:
        return "The length of the username should be between 5 and 20 characters";
      case Error.invalidUsername:
        return "Please enter a valid username";
    }
  }
}
