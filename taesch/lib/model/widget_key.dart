enum WidgetKey {
  emailLoginKey,
  passwordLoginKey,
  registrationButtonKey,
  loginButtonKey,
  usernameRegisterKey,
  emailRegisterKey,
  firstPasswordRegisterKey,
  secondPasswordRegisterKey,
}

extension KeyText on WidgetKey {
  String get text {
    return toString();
  }
}
