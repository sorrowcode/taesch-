import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:taesch/controller/theme_controller.dart';
import 'package:taesch/middleware/log/log_level.dart';
import 'package:taesch/middleware/log/logger_wrapper.dart';
import 'package:taesch/model/log_message.dart';
import 'package:taesch/view/custom_widget/permission_dialog.dart';
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
  var formatter = NumberFormat.decimalPattern();

  @override
  Widget build(BuildContext context) {
    logger.log(
        level: LogLevel.info,
        logMessage: LogMessage(message: "entered settings screen"));
    return ListView(
      children: [
        SwitchListTile(
          title: Text(widget._vm.switchTitle),
          value: ThemeController.of(context).darkTheme,
          activeColor: Theme.of(context).secondaryHeaderColor,
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
          secondary: Icon(
            Icons.sunny,
            color: Theme.of(context).iconTheme.color,
          ),
        ),

        SwitchListTile(
          title: Text(widget._vm.permissionSwitchTitle),
          value: widget._vm.repo.osmActions.geoLocationPermissionGranted(),
          onChanged: (bool permitted) async{
            logger.log(
                level: LogLevel.info,
                logMessage: LogMessage(
                    message:
                    "switched ${widget._vm.permissionSwitchTitle} button to $permitted"));

            var actions = widget._vm.repo.osmActions;

            if (!permitted){
              /*
                IMPORTANT: this is not an actual denial of the service, as the OS would understand it.
                It is only a denial interpreted by the App, which ultimately achieves the same result of
                not using the GPS Location.
                 */
              actions.denyGeoLocationPermission();

            }else{
              // at this point I know the permission must be denied
              bool permDenial = actions.geoLocationPermissionIsPermanentlyDenied();
              if (!permDenial){
                await actions.handleLocationPermission();
                if (!actions.geoLocationPermissionGranted()){
                  // don't allow toggle
                }
                if (!actions.geolocationServicesEnabled()){
                  // pop-up
                  PermissionDialog().showGeolocationPermissionDialog(
                      context,
                      "Location Services are disabled",
                      "Please go to your phone's settings and enable the Location Services.");
                }
              }else{
                // pop-up
                PermissionDialog().showGeolocationPermissionDialog(
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
              if(actions.geoLocationPermissionIsPermanentlyDenied() && actions.geoLocationPermissionGranted()){
                // should not be the case
                actions.denyGeoLocationPermission();
              }
            });

          },
          secondary: const Icon(Icons.location_on),
        ),

        ListTile(
          title: Text(widget._vm.radTitle),
          trailing: DropdownButton(
            value: widget._vm.repo.searchRadius,
            items: (widget._vm.radValues
                .map((int e) => DropdownMenuItem(
                    value: e, child: Text(formatter.format(e))))
                .toList()),
            onChanged: (int? value) {
              logger.log(
                  level: LogLevel.info,
                  logMessage: LogMessage(
                      message:
                          "switched ${widget._vm.switchTitle} button to $value"));

              setState(() {
                widget._vm.repo.searchRadius = value!;
              });

              widget._vm.repo.osmActions
                  .getNearShops(widget._vm.repo.searchRadius,
                      widget._vm.repo.userPosition)
                  .then((value) {
                widget._vm.repo.cache = value;
              });
            },
          ),
        )
      ],
    );
  }
}
