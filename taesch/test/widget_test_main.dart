import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taesch/controller/theme_controller.dart';

void main() async {

  TestWidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  //final themeController = ThemeController(prefs);

  group("login page", () {
    /* todo:
      - with wrong values
        - without values
        - with random values
        - with only email
        - with only password
        - with incorrect email + password
        - with correct email + wrong password
      - with correct values
        - transition to splash page
      - register button
        - transition to the register page
     */
  });

  group("registration page", () {
    /* todo:
      - with wrong values -> error cases
        - without values
        - with random values
        - with only username
        - with only email
        - with only password(s)
        - with not matching passwords
      - with correct values
        - transition to splash page
     */
  });

  group("splash page", () {
    // todo -> only existence of the page?
  });

  group("home page", () {
    group("drawer navigation", () {
      /* todo:
        - navigation
          - shopping list screen
          - near shops screen
          - settings screen
          - shops map screen
       */
    });

    group("shopping list screen", () {
      /* todo:
        - adding element
          - with wrong values
          - with correct values
          - with incorrect quantity
          - with correct quantity
        - deleting element
       */
    });

    group("near shops screen", () {
      /* todo:
        - filled with values
       */
    });

    group("settings screen", () {
      /* todo:
        - light- and dark mode
       */
    });

    group("shops map screen", () {
      /* todo:
        - short tap on marker -> red
        - long press on marker -> dialog
       */
    });
  });
}
