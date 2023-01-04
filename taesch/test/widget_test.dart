import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taesch/api/implementation/osm.dart';
import 'package:taesch/api/implementation/sql_database.dart';
import 'package:taesch/api/repositories/osm_repository.dart';
import 'package:taesch/api/repositories/repository_type.dart';
import 'package:taesch/api/repositories/sql_repository.dart';
import 'package:taesch/api/repository_holder.dart';
import 'package:taesch/app.dart';
import 'package:taesch/controller/theme_controller.dart';
import 'package:taesch/controller/theme_controller_provider.dart';
import 'package:taesch/model/error_case.dart';
import 'package:taesch/model/screen_state.dart';
import 'package:taesch/model/widget_key.dart';
import 'package:taesch/view/custom_widget/marker_long_tap_dialog.dart';
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
        expect(find.byType(ListTile), findsNWidgets(ScreenState.values.length));
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
      group("add element", () {
        testWidgets("testing cancel", (widgetTester) async {
          await widgetTester.pumpWidget(const MaterialApp(
            home: HomePage(),
          ));
          ((RepositoryHolder().getRepositoryByType(RepositoryType.sql)
          as SQLRepository)
              .sqlActions as SQLDatabase)
              .init()
              .then((value) async {
            await widgetTester.tap(find.byType(FloatingActionButton));
            await widgetTester.pumpAndSettle();
            await widgetTester.enterText(
                find.byType(TextFormField).first, "Test");
            await widgetTester.pump();
            await widgetTester.tap(find.widgetWithIcon(TextButton, Icons.close));
            await widgetTester.pumpAndSettle();
            expect(find.byType(Card), findsNothing);
            expect(find.text("Test"), findsNothing);
          });
        });

        testWidgets("with wrong values", (widgetTester) async {
          ((RepositoryHolder().getRepositoryByType(RepositoryType.sql) as SQLRepository).sqlActions as SQLDatabase).init().then((value) async {
            await widgetTester.pumpWidget(const MaterialApp(
              home: HomePage(),
            ));
            await widgetTester.tap(find.byType(FloatingActionButton));
            await widgetTester.pumpAndSettle();
            await widgetTester.enterText(
                find.byType(TextFormField).first, " ");
            await widgetTester.pump();
            await widgetTester.tap(find.widgetWithIcon(TextButton, Icons.check));
            await widgetTester.pumpAndSettle();
            testErrorCases(widgetTester, [ErrorCase.emptyField]);
          });
        });

        testWidgets("with correct values", (widgetTester) async {
          ((RepositoryHolder().getRepositoryByType(RepositoryType.sql) as SQLRepository).sqlActions as SQLDatabase).init().then((value) async {
            await widgetTester.pumpWidget(const MaterialApp(
              home: HomePage(),
            ));
            await widgetTester.tap(find.byType(FloatingActionButton));
            await widgetTester.pumpAndSettle();
            await widgetTester.enterText(
                find.byType(TextFormField).first, "Apple");
            await widgetTester.pump();
            await widgetTester.enterText(find.byType(TextFormField).last, "obst");
            await widgetTester.pump();
            await widgetTester.tap(find.widgetWithIcon(TextButton, Icons.check));
            await widgetTester.pumpAndSettle();
            expect(find.text("Apple"), findsOneWidget);
            expect(find.text("obst"), findsOneWidget);
            expect(find.byType(Card), findsOneWidget);
          });
        });

        testWidgets("with incorrect quantity", (widgetTester) async {
          // todo: has to be added as feature
        });

        testWidgets("with correct quantity", (widgetTester) async {
          // todo: has to be added as feature
        });
      });

      testWidgets("and deleting element", (widgetTester) async {
        ((RepositoryHolder().getRepositoryByType(RepositoryType.sql) as SQLRepository).sqlActions as SQLDatabase).init().then((value) async {
          await widgetTester.pumpWidget(const MaterialApp(
            home: HomePage(),
          ));
          await widgetTester.tap(find.byType(FloatingActionButton));
          await widgetTester.pumpAndSettle();
          await widgetTester.enterText(
              find.byType(TextFormField).first, "Apple");
          await widgetTester.pump();
          await widgetTester.enterText(find.byType(TextFormField).last, "obst");
          await widgetTester.pump();
          await widgetTester.tap(find.widgetWithIcon(TextButton, Icons.check));
          await widgetTester.pumpAndSettle();
          await widgetTester.longPress(find.byType(Card));
          await widgetTester.pumpAndSettle();
          expect(find.byType(Card), findsNothing);
        });
      });
    });

    group("near shops screen", () {
      testWidgets("find at least one list tile element", (widgetTester) async {
        HttpOverrides.global = null;
        OSMRepository repository = (RepositoryHolder().getRepositoryByType(RepositoryType.osm) as OSMRepository);
        await widgetTester.pump();
        (repository.osmActions as OSM).getNearShops(2000, repository.userPosition).then((value) async {
          repository.cache = value;
          await widgetTester.pump();
          await widgetTester.pumpWidget(const MaterialApp(
            home: HomePage(),
          ));
          expect(find.byType(ShoppingListScreen), findsOneWidget);
          await widgetTester.tap(find.byIcon(Icons.menu));
          await widgetTester.pumpAndSettle();
          await widgetTester.tap(find.widgetWithText(ListTile, ScreenState.nearShops.text));
          await widgetTester.pumpAndSettle();
          expect(find.byType(ListTile), findsAtLeastNWidgets(1));
        });
      });

      testWidgets("click on one shop to be navigated to the map", (widgetTester) async {
        HttpOverrides.global = null;
        OSMRepository repository = (RepositoryHolder().getRepositoryByType(RepositoryType.osm) as OSMRepository);
        await widgetTester.pump();
        (repository.osmActions as OSM).getNearShops(2000, repository.userPosition).then((value) async {
          repository.cache = value;
          await widgetTester.pump();
          await widgetTester.pumpWidget(const MaterialApp(
            home: HomePage(),
          ));
          expect(find.byType(ShoppingListScreen), findsOneWidget);
          await widgetTester.tap(find.byIcon(Icons.menu));
          await widgetTester.pumpAndSettle();
          await widgetTester.tap(
              find.widgetWithText(ListTile, ScreenState.nearShops.text));
          await widgetTester.pumpAndSettle();
          await widgetTester.tap(find.byType(ListTile).first);
          await widgetTester.pumpAndSettle();
          expect(find.text(ScreenState.shopsMap.text), findsOneWidget);
          expect(find.byType(Marker), findsOneWidget);
        });
      });
    });

    group("shops map screen", () {
      testWidgets("long press on marker", (widgetTester) async {
        HttpOverrides.global = null;
        OSMRepository repository = (RepositoryHolder().getRepositoryByType(RepositoryType.osm) as OSMRepository);
        await widgetTester.pump();
        (repository.osmActions as OSM).getNearShops(2000, repository.userPosition).then((value) async {
          repository.cache = value;
          await widgetTester.pump();
          await widgetTester.pumpWidget(const MaterialApp(
            home: HomePage(),
          ));
          expect(find.byType(ShoppingListScreen), findsOneWidget);
          await widgetTester.tap(find.byIcon(Icons.menu));
          await widgetTester.pumpAndSettle();
          await widgetTester.tap(
              find.widgetWithText(ListTile, ScreenState.shopsMap.text));
          await widgetTester.pumpAndSettle();
          expect(find.byType(Marker), findsAtLeastNWidgets(5));
          await widgetTester.tap(find
              .byType(Marker)
              .first);
          await widgetTester.pumpAndSettle();
          expect(find.byType(MarkerLongTapDialog), findsOneWidget);
        });
      });
    });
  });
}

void testErrorCases(WidgetTester widgetTester, List<ErrorCase> exceptCases) {
  for (ErrorCase errorCase in ErrorCase.values) {
    expect(find.text(errorCase.message), exceptCases.contains(errorCase) ? findsOneWidget : findsNothing);
  }
}
