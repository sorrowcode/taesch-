import 'package:http/http.dart';
import 'package:taesch/api/actions/ping_actions.dart';

class Ping implements PingActions {
  final String _apiUrl = "https://google.com";
  bool isOnline = true;

  @override
  Future<void> init() async {
    get(Uri.parse(_apiUrl)).then((result) {
      isOnline = (result.statusCode ~/ 100) == 2 ? true : false;
    }) // 200 range
        .catchError((err) {
      isOnline = false;
    });
    /*
    get(Uri.parse(_apiUrl))
        .then((result) => (result.statusCode ~/ 100) == 2 ? true : false) // 200 range
        .catchError((err)=> false);

     */
  }
}
