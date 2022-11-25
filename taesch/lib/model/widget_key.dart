enum WidgetKey {
  emailLoginKey,
  passwordLoginKey,
  registrationButtonKey,
  loginButtonKey,
  usernameRegisterKey,
  emailRegisterKey,
  firstPasswordRegisterKey,
  secondPasswordRegisterKey,
  submitButtonKey,
  shoppingListScreenListTile,
}

extension KeyText on WidgetKey {
  String get text {
    return toString();
  }
}
