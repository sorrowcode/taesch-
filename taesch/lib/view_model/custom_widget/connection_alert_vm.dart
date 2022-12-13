import 'package:app_settings/app_settings.dart';
import 'package:taesch/api/connectivity_provider.dart';


class ConnectionAlertVM {
  late ConnectivityProvider _connection;
  String settingButtonText = 'Settings';

  ConnectionAlertVM(){
    _connection = ConnectivityProvider();
  }

  String get titleText {
    return 'No Connection to ${!_connection.isOnline ? ' the Internet' : ' GPS'}';
  }

  String get contentText {
    return '';
  }

  void openSettings() {
    if (!_connection.isOnline) {
      emitWifiSettingScreen();
    } else if (!_connection.isGpsOnline){
      emitGeoSettingScreen();
    }
  }

  void emitWifiSettingScreen() {
    AppSettings.openWIFISettings();
  }

  void emitGeoSettingScreen() {
    AppSettings.openLocationSettings();
  }

}