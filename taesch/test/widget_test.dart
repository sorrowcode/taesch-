import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taesch/app.dart';
import 'package:taesch/controller/theme_controller.dart';
import 'package:taesch/controller/theme_controller_provider.dart';
import 'package:taesch/model/error_case.dart';
import 'package:taesch/model/screen_state.dart';
import 'package:taesch/model/widget_key.dart';
import 'package:taesch/view/page/home_page.dart';
import 'package:taesch/view/page/login_page.dart';
import 'package:taesch/view/page/register_page.dart';
import 'package:taesch/view/screen/near_shops_screen.dart';
import 'package:taesch/view/screen/settings_screen.dart';
import 'package:taesch/view/screen/shopping_list_screen.dart';
import 'package:taesch/view/screen/shops_map_screen.dart';

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
    group("with wrong values:", () {
      testWidgets("without values", (widgetTester) async {
        await widgetTester.pumpWidget(App(
          controller: themeController,
        ));
        await widgetTester
            .tap(find.byKey(Key(WidgetKey.registrationButtonKey.text)));
        await widgetTester.pumpAndSettle();

        await widgetTester.tap(find.byKey(Key(WidgetKey.submitButtonKey.text)));
        await widgetTester.pump();

        testErrorCases(widgetTester, [ErrorCase.noUsername, ErrorCase.noEmail, ErrorCase.noPassword]);
      });

      testWidgets("with only username", (widgetTester) async {
        await widgetTester.pumpWidget(App(
          controller: themeController,
        ));
        await widgetTester
            .tap(find.byKey(Key(WidgetKey.registrationButtonKey.text)));
        await widgetTester.pumpAndSettle();
        await widgetTester.enterText(
            find.byKey(Key(WidgetKey.usernameRegisterKey.text)), "John");
        await widgetTester.pump();
        await widgetTester.tap(find.byType(TextButton));
        await widgetTester.pump();
        testErrorCases(widgetTester, [ErrorCase.noEmail, ErrorCase.noPassword]);
      });

      testWidgets("with only password", (widgetTester) async {
        await widgetTester.pumpWidget(App(
          controller: themeController,
        ));
        await widgetTester
            .tap(find.byKey(Key(WidgetKey.registrationButtonKey.text)));
        await widgetTester.pumpAndSettle();
        await widgetTester.enterText(
            find.byKey(Key(WidgetKey.firstPasswordRegisterKey.text)), "Test1234!");
        await widgetTester.pump();
        await widgetTester.enterText(
            find.byKey(Key(WidgetKey.secondPasswordRegisterKey.text)), "Test1234!");
        await widgetTester.pump();
        await widgetTester.tap(find.byType(TextButton));
        await widgetTester.pump();
        testErrorCases(widgetTester, [ErrorCase.noUsername, ErrorCase.noEmail]);
      });

      testWidgets("with not matching passwords", (widgetTester) async {
        await widgetTester.pumpWidget(App(
          controller: themeController,
        ));
        await widgetTester
            .tap(find.byKey(Key(WidgetKey.registrationButtonKey.text)));
        await widgetTester.pumpAndSettle();
        await widgetTester.enterText(
            find.byKey(Key(WidgetKey.usernameRegisterKey.text)), "John");
        await widgetTester.pump();
        await widgetTester.enterText(find.byKey(Key(WidgetKey.emailRegisterKey.text)), "test@test.de");
        await widgetTester.pump();
        await widgetTester.enterText(
            find.byKey(Key(WidgetKey.firstPasswordRegisterKey.text)), "Test1234!");
        await widgetTester.pump();
        await widgetTester.tap(find.byType(TextButton));
        await widgetTester.pump();
        testErrorCases(widgetTester, [ErrorCase.notSamePassword]);
      });
    });
  });

  group("splash page", () {
    // todo -> only existence of the page?
  });

  group("home page", () {
    group("drawer navigation:", () {
      testWidgets("click on shopping list list tile", (widgetTester) async {
        await widgetTester.pumpWidget(const MaterialApp(
          home: HomePage(),
        ));
        expect(find.text(ScreenState.shoppingList.text), findsOneWidget);
        await widgetTester.tap(find.byIcon(Icons.menu));
        await widgetTester.pump();
        expect(find.byType(ListTile), findsAtLeastNWidgets(ScreenState.values.length));
        await widgetTester.tap(find.widgetWithText(ListTile, ScreenState.shoppingList.text));
        await widgetTester.pumpAndSettle();
        expect(find.byType(ShoppingListScreen), findsOneWidget);
      });

      testWidgets("click on near shops list list tile", (widgetTester) async {
        await widgetTester.pumpWidget(const MaterialApp(
          home: HomePage(),
        ));
        await widgetTester.tap(find.byIcon(Icons.menu));
        await widgetTester.pumpAndSettle();
        await widgetTester.tap(find.widgetWithText(ListTile, ScreenState.nearShops.text));
        await widgetTester.pumpAndSettle();
        expect(find.byType(NearShopsScreen), findsOneWidget);
      });

      testWidgets("click on settings list list tile", (widgetTester) async {
        await widgetTester.pumpWidget(AnimatedBuilder(
            animation: themeController,
            builder: (context, _) => ThemeControllerProvider(
                controller: themeController,
                child: const MaterialApp(
                  home: HomePage()),
                )));
        await widgetTester.tap(find.byIcon(Icons.menu));
        await widgetTester.pumpAndSettle();
        await widgetTester.tap(find.widgetWithText(ListTile, ScreenState.settings.text));
        await widgetTester.pumpAndSettle();
        expect(find.byType(SettingsScreen), findsOneWidget);
      });

      testWidgets("click on shops map list list tile", (widgetTester) async {
        await widgetTester.pumpWidget(const MaterialApp(
          home: HomePage(),
        ));
        await widgetTester.tap(find.byIcon(Icons.menu));
        await widgetTester.pumpAndSettle();
        await widgetTester.tap(find.widgetWithText(ListTile, ScreenState.shopsMap.text));
        await widgetTester.pumpAndSettle();
        expect(find.byType(ShopsMapScreen), findsOneWidget);
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
