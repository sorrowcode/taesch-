class User {
  late String username;
  late String email;
  bool loggedIn = false;
  static final User _singleton = User._internal();

  factory User() {
    return _singleton;
  }

  User._internal();
}
