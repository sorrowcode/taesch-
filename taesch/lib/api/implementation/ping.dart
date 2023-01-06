

import 'package:http/http.dart';

import '../actions/ping_actions.dart';

class Ping implements PingActions {
  final String _apiUrl = "https://google.com";
  @override
  void init() {

  }

  @override
  Future<bool> isOnline() {
    return get(Uri.parse(_apiUrl))
        .then((result) => (result.statusCode ~/ 100) == 2 ? true : false) // 200 range
        .catchError((err)=> false);
  }

}