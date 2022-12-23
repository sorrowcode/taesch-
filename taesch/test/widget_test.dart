import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taesch/app.dart';
import 'package:taesch/controller/theme_controller.dart';
import 'package:taesch/model/error_case.dart';
import 'package:taesch/model/widget_key.dart';
import 'package:taesch/view/page/login_page.dart';
import 'package:taesch/view/page/register_page.dart';

void main() async {

  TestWidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final themeController = ThemeController(prefs);

  group("login page", () {
      group("wrong values:", () {
      testWidgets("without values", (widgetTester) async {
        await widgetTester.pumpWidget(App(
          controller: themeController,
        ));
        expect(find.byType(LoginPage), findsOneWidget);
        await widgetTester.enterText(
            find.byKey(Key(WidgetKey.emailLoginKey.text)), "");
        await widgetTester.pump();
        await widgetTester.enterText(
            find.byKey(Key(WidgetKey.passwordLoginKey.text)), "");
        await widgetTester.pump();
        await widgetTester.tap(find.byKey(Key(WidgetKey.loginButtonKey.text)));
        await widgetTester.pump();
        testErrorCases(widgetTester, [ErrorCase.noEmail, ErrorCase.noPassword]);
      });

      testWidgets("with only email", (widgetTester) async {
        await widgetTester.pumpWidget(App(
          controller: themeController,
        ));
        expect(find.byType(LoginPage), findsOneWidget);
        await widgetTester.enterText(
            find.byKey(Key(WidgetKey.emailLoginKey.text)), "test@test.de");
        await widgetTester.pump();
        await widgetTester.enterText(
            find.byKey(Key(WidgetKey.passwordLoginKey.text)), "");
        await widgetTester.pump();
        await widgetTester.tap(find.byKey(Key(WidgetKey.loginButtonKey.text)));
        await widgetTester.pump();
        testErrorCases(widgetTester, [ErrorCase.noPassword]);
      });

      testWidgets("with only password", (widgetTester) async {
        await widgetTester.pumpWidget(App(
          controller: themeController,
        ));
        expect(find.byType(LoginPage), findsOneWidget);
        await widgetTester.enterText(
            find.byKey(Key(WidgetKey.emailLoginKey.text)), "");
        await widgetTester.pump();
        await widgetTester.enterText(
            find.byKey(Key(WidgetKey.passwordLoginKey.text)), "Test1234!");
        await widgetTester.pump();
        await widgetTester.tap(find.byKey(Key(WidgetKey.loginButtonKey.text)));
        await widgetTester.pump();
        testErrorCases(widgetTester, [ErrorCase.noEmail]);
      });

      testWidgets("incorrect email and password", (widgetTester) async {
        // todo: after exception handling, maybe covered partially in unit testing
      });

      testWidgets("with correct email and wrong password", (widgetTester) async {
        // todo: after exception handling, maybe covered partially in unit testing
      });
    });

    testWidgets("click on register button", (widgetTester) async {
      await widgetTester.pumpWidget(App(
        controller: themeController,
      ));
      expect(find.byType(LoginPage), findsOneWidget);
      await widgetTester.tap(find.byKey(Key(WidgetKey.registrationButtonKey.text)));
      await widgetTester.pumpAndSettle();
      expect(find.byType(RegisterPage), findsOneWidget);
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

void testErrorCases(WidgetTester widgetTester, List<ErrorCase> exceptCases) {
  for (ErrorCase errorCase in ErrorCase.values) {
    expect(find.text(errorCase.message), exceptCases.contains(errorCase) ? findsOneWidget : findsNothing);
  }
}
