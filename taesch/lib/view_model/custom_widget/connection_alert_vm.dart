import 'package:app_settings/app_settings.dart';

class ConnectionAlertVM {
  String settingButtonText = 'Settings';

  String get titleText {
    return 'No Connection to the Internet';
  }

  String get contentText {
    return '';
  }

  void openSettings() {
    emitWifiSettingScreen();
  }

  void emitWifiSettingScreen() {
    AppSettings.openWIFISettings();
  }

}