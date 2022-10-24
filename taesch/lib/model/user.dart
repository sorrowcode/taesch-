class User {
  late String username;
  late String email;
  static final User _singleton = User._internal();

  factory User() {
    return _singleton;
  }

  User._internal();
}
