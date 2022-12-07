import 'package:flutter/material.dart';
import 'package:taesch/logic/theme_controller.dart';
import 'package:taesch/middleware/log/log_level.dart';
import 'package:taesch/middleware/log/logger_wrapper.dart';
import 'package:taesch/model/log_message.dart';
import 'package:taesch/view_model/screen/settings_screen_vm.dart';

/// shows the shopping list elements
class SettingsScreen extends StatefulWidget {
  final SettingsScreenVM _vm = SettingsScreenVM();

  SettingsScreen({super.key});

  @override
  State<StatefulWidget> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  LoggerWrapper logger = LoggerWrapper();

  @override
  Widget build(BuildContext context) {
    logger.log(
        level: LogLevel.info,
        logMessage: LogMessage(message: "entered settings screen"));
    return Scaffold(
      body: Column(
        children: [

          // ursprünglich war es nur "return SwitchListTile(...)"
          SwitchListTile(
              title: Text(widget._vm.switchTitle),
              value: ThemeController.of(context).darkTheme,
              onChanged: (bool value) {
                logger.log(
                    level: LogLevel.info,
                    logMessage: LogMessage(
                        message:
                        "switched ${widget._vm.switchTitle} button to $value"));
                setState(() {
                  ThemeController.of(context).darkTheme = value;
                });
              },
              secondary: const Icon(Icons.sunny),
          ),

          SwitchListTile(
            title: Text(widget._vm.permissionSwitchTitle),
            value: widget._vm.repository.geolocationTools.geoLocationPermissionGranted(),
            onChanged: (bool permitted) async{
              logger.log(
                  level: LogLevel.info,
                  logMessage: LogMessage(
                      message:
                      "switched ${widget._vm.permissionSwitchTitle} button to $permitted"));

              var gt = widget._vm.repository.geolocationTools;

              if (!permitted){
                /*
                IMPORTANT: this is not an actual denial of the service, as the OS would understand it.
                It is only a denial interpreted by the App, which ultimately achieves the same result of
                not using the GPS Location.
                 */
                gt.denyGeoLocationPermission();

              }else{
                // at this point I know the permission must be denied
                bool permDenial = gt.geoLocationPermissionIsPermanentlyDenied();
                if (!permDenial){
                  await gt.handleLocationPermission();
                  if (!gt.geoLocationPermissionGranted()){
                    // don't allow toggle
                  }
                }else{
                  // pop-up
                  // don't allow toggle
                }
              }
              setState((){}); // because the switch is set based on the .geoLocationPermGranted() property,
              // setState() ensures that the switch will be in the right position, after reloading the screen

            },
            secondary: const Icon(Icons.remove_from_queue_rounded),
          )

        ],
      ),
    );
  }
}
