import 'package:flutter_test/flutter_test.dart';

void main() async {

  TestWidgetsFlutterBinding.ensureInitialized();
  //final prefs = await SharedPreferences.getInstance();
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
    group("wrong values:", () {
      testWidgets("without values", (widgetTester) async {

      });

      testWidgets("with random values", (widgetTester) async {

      });

      testWidgets("with only email", (widgetTester) async {

      });

      testWidgets("with only password", (widgetTester) async {

      });

      testWidgets("incorrect email and password", (widgetTester) async {

      });

      testWidgets("with correct email and wrong password", (widgetTester) async {

      });
    });

    testWidgets("with correct values", (widgetTester) async {

    });

    testWidgets("click on register button", (widgetTester) async {

    });
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
    group("with wrong values:", () {
      testWidgets("without values", (widgetTester) async {

      });

      testWidgets("with random values", (widgetTester) async {

      });

      testWidgets("with only username", (widgetTester) async {

      });

      testWidgets("with only password", (widgetTester) async {

      });

      testWidgets("with not matching passwords", (widgetTester) async {

      });
    });

    testWidgets("with correct values", (widgetTester) async {

    });
  });

  group("splash page", () {
    // todo -> only existence of the page?
  });

  group("home page", () {
    group("drawer navigation:", () {
      /* todo:
        - navigation
          - shopping list screen
          - near shops screen
          - settings screen
          - shops map screen
       */
      testWidgets("click on shopping list list tile", (widgetTester) async {

      });

      testWidgets("click on near shops list list tile", (widgetTester) async {

      });

      testWidgets("click on settings list list tile", (widgetTester) async {

      });

      testWidgets("click on shops map list list tile", (widgetTester) async {

      });
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

      group("add element", () {
        testWidgets("with wrong values", (widgetTester) async {

        });

        testWidgets("with correct values", (widgetTester) async {

        });

        testWidgets("with incorrect quantity", (widgetTester) async {

        });

        testWidgets("with correct quantity", (widgetTester) async {

        });
      });

      testWidgets("with deleting element", (widgetTester) async {

      });
    });

    group("near shops screen", () {
      /* todo:
        - filled with values
       */

      testWidgets("find at least one list tile element", (widgetTester) async {

      });
    });

    group("settings screen", () {
      /* todo:
        - light- and dark mode
       */

      testWidgets("change mode", (widgetTester) async {

      });
    });

    group("shops map screen", () {
      /* todo:
        - short tap on marker -> red
        - long press on marker -> dialog
       */

      testWidgets("tap on marker", (widgetTester) async {

      });

      testWidgets("long press on marker", (widgetTester) async {

      });
    });
  });
}
