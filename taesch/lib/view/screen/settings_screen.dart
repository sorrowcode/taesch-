import 'package:flutter/material.dart';
import 'package:taesch/logic/theme_controller.dart';
import 'package:taesch/middleware/log/log_level.dart';
import 'package:taesch/middleware/log/logger_wrapper.dart';
import 'package:taesch/model/log_message.dart';
import 'package:taesch/view_model/custom_widget/permission_dialog_vm.dart';
import 'package:taesch/view_model/screen/settings_screen_vm.dart';

/// shows the shopping list elements
class SettingsScreen extends StatefulWidget {
  final SettingsScreenVM _vm = SettingsScreenVM();
  final PermissionDialogVM _dialogVM = PermissionDialogVM();

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
                  if (!gt.geolocationServicesEnabled()){
                    // pop-up
                    widget._dialogVM.showGeolocationPermissionDialog(
                        context,
                        "Location Services are disabled",
                        "Please go to your phone's settings and enable the Location Services.");
                  }
                }else{
                  // pop-up
                  widget._dialogVM.showGeolocationPermissionDialog(
                      context,
                      "Location Permanently Denied",
                      "You have permanently denied the usage of the GPS services.\n"
                          "In order to allow the app to use them, you have to manually go to your phone's \n"
                          "Settings -> Apps -> 'täsch' -> Permissions and allow the permission for "
                          "the usage of your location. Thanks ;)"
                  );

                  // don't allow toggle
                }

              }

              // because the switch is set based on the .geoLocationPermGranted() property,
              // setState() ensures that the switch will be in the right position, after reloading the screen
              setState((){
                if(gt.geoLocationPermissionIsPermanentlyDenied() && gt.geoLocationPermissionGranted()){
                  // should not be the case
                  gt.denyGeoLocationPermission();
                }
              });

            },
            secondary: const Icon(Icons.location_on),
          ),

          Container(
            padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
            child: Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                  onPressed: (){

                    widget._dialogVM.showGeolocationPermissionDialog(
                        context,
                        "Help on Location Service",
                        "If you can't toggle the ${widget._vm.permissionSwitchTitle} option, it might be because "
                            "you have permanently denied the usage of the GPS services.\n"
                            "In order to allow the app to use them, you need to manually go to your phone's \n"
                            "Settings -> Apps -> 'täsch' -> Permissions \nand allow the permission for "
                            "the usage of your location. Thanks ;)");

                  },
                  icon: const Icon(Icons.help_outline)

              ),
            ),
          )

        ],
      ),
    );
  }
}
