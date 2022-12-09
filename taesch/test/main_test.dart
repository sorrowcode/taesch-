import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geolocator/geolocator.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:taesch/api/repository.dart';
import 'package:taesch/api/implementation/sql_database.dart';
import 'package:taesch/app.dart';
import 'package:taesch/logic/theme_controller.dart';
import 'package:taesch/model/error_case.dart';
import 'package:taesch/model/product.dart';
import 'package:taesch/model/query_location.dart';
import 'package:taesch/model/widget_key.dart';
import 'package:taesch/view/page/home_page.dart';
import 'package:taesch/view_model/page/login_page_vm.dart';
import 'package:taesch/view_model/page/register_page_vm.dart';
import 'package:taesch/view_model/page/starting_page_vm.dart';

void main() async {

  TestWidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();

  // create new theme controller, which will get the currently selected from shared preferences
  final themeController = ThemeController(prefs);

  // ui

  group("testing near shop page functionality", () {
    /*
    setUp(() {
      HttpOverrides.global = null;
    });
    */

    testWidgets("testing near shop screen", (widgetTester) async {
      await widgetTester.pumpWidget(const MaterialApp(
        home: HomePage(),
      ));

      expect(find.byIcon(Icons.menu), findsOneWidget);
      await widgetTester.tap(find.byIcon(Icons.menu));
      await widgetTester.pumpAndSettle();
      expect(find.text('Near Shops'), findsOneWidget);
      await widgetTester.tap(find.text("Near Shops"));
      await widgetTester.pumpAndSettle();
      expect(find.text('Search'), findsOneWidget);
      expect(find.byType(ListTile), findsOneWidget);
      await widgetTester.tap(find.byType(ListTile));
      await widgetTester.pumpAndSettle();
      expect(find.byKey(Key(WidgetKey.redMarkerKey.text)), findsOneWidget);
    });
  });

  group("testing login page functionality", () {
    testWidgets("testing with no input", (widgetTester) async {
      await widgetTester.pumpWidget(App(
        controller: themeController,
      ));
      expect(find.text("Login"), findsAtLeastNWidgets(2));
      await widgetTester.enterText(
          find.byKey(Key(WidgetKey.emailLoginKey.text)), "");
      await widgetTester.pump();
      await widgetTester.enterText(
          find.byKey(Key(WidgetKey.passwordLoginKey.text)), "");
      await widgetTester.pump();
      await widgetTester.tap(find.byKey(Key(WidgetKey.loginButtonKey.text)));
      await widgetTester.pump();
      expect(find.text(ErrorCase.noEmail.message), findsOneWidget);
      expect(find.text(ErrorCase.noPassword.message), findsOneWidget);
    });

    testWidgets("testing with invalid input", (widgetTester) async {
      await widgetTester.pumpWidget(App(
        controller: themeController,
      ));
      await widgetTester.enterText(
          find.byKey(Key(WidgetKey.emailLoginKey.text)), "johndoe");
      await widgetTester.pump();
      await widgetTester.enterText(
          find.byKey(Key(WidgetKey.passwordLoginKey.text)), "abc123ABC");
      await widgetTester.pump();
      await widgetTester.tap(find.byKey(Key(WidgetKey.loginButtonKey.text)));
      await widgetTester.pump();
      expect(find.text(ErrorCase.invalidEmail.message), findsOneWidget);
      expect(find.text(ErrorCase.noSpecialCharacter.message), findsOneWidget);
    });
  });

  group("testing register page functionality", () {
    testWidgets("testing with no values", (widgetTester) async {
      await widgetTester.pumpWidget(App(
        controller: themeController,
      ));
      await widgetTester
          .tap(find.byKey(Key(WidgetKey.registrationButtonKey.text)));
      await widgetTester.pumpAndSettle();

      await widgetTester.tap(find.byKey(Key(WidgetKey.submitButtonKey.text)));
      await widgetTester.pump();

      expect(find.text(ErrorCase.noUsername.message), findsOneWidget);
      expect(find.text(ErrorCase.noEmail.message), findsOneWidget);
      expect(find.text(ErrorCase.noPassword.message), findsOneWidget);
    });

    testWidgets("testing with invalid values", (widgetTester) async {
      await widgetTester.pumpWidget(App(
        controller: themeController,
      ));
      await widgetTester
          .tap(find.byKey(Key(WidgetKey.registrationButtonKey.text)));
      await widgetTester.pumpAndSettle();
      await widgetTester.enterText(
          find.byKey(Key(WidgetKey.usernameRegisterKey.text)), "a");
      await widgetTester.pump();
      await widgetTester.enterText(
          find.byKey(Key(WidgetKey.emailRegisterKey.text)), "a");
      await widgetTester.pump();
      await widgetTester.enterText(
          find.byKey(Key(WidgetKey.firstPasswordRegisterKey.text)), "a");
      await widgetTester.pump();
      await widgetTester.enterText(
          find.byKey(Key(WidgetKey.secondPasswordRegisterKey.text)), "b");
      await widgetTester.pump();
      await widgetTester.tap(find.byType(OutlinedButton));
      await widgetTester.pump();

      expect(find.text(ErrorCase.invalidUsername.message), findsOneWidget);
      expect(find.text(ErrorCase.invalidEmail.message), findsOneWidget);
      expect(find.text(ErrorCase.tooLongOrTooShort.message), findsOneWidget);
      expect(find.text(ErrorCase.notSamePassword.message), findsOneWidget);
    });
  });

  group("testing home page functionality", () {
    group("testing add shopping list item functionality", () {
      testWidgets("testing open editing pop up", (widgetTester) async {
        await widgetTester.pumpWidget(const MaterialApp(
          home: HomePage(),
        ));
        var floatingActionButton = find.byType(FloatingActionButton);
        expect(floatingActionButton, findsOneWidget);
        await widgetTester.tap(floatingActionButton);
        await widgetTester.pumpAndSettle();
        expect(find.byType(AlertDialog), findsOneWidget);
      });

      testWidgets("testing cancel", (widgetTester) async {
        Repository().sqlDatabase.init().then((value) async {
          await widgetTester.pumpWidget(const MaterialApp(
            home: HomePage(),
          ));
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

    testWidgets(("creating Tags"), (widgetTester) async{
      await widgetTester.pumpWidget(const MaterialApp(
        home: HomePage(),
      ));
      Repository().sqlDatabase.init().then((value) async{
        await widgetTester.tap(find.byType(FloatingActionButton));
        await widgetTester.pumpAndSettle();
        await widgetTester.enterText(find.byType(TextFormField).first, "Apfel");
        await widgetTester.pump();
        await widgetTester.enterText(find.byType(TextFormField).last, "4,");
        await widgetTester.pump();
        await widgetTester.tap(find.widgetWithIcon(TextButton, Icons.check));
        await widgetTester.pump();
        expect(find.byType(Card), findsOneWidget);
      });
    });

      testWidgets(("creating Tags and deleting Card"), (widgetTester) async{
        await widgetTester.pumpWidget(const MaterialApp(
          home: HomePage(),
        ));
        Repository().sqlDatabase.init().then((value) async{
          await widgetTester.tap(find.byType(FloatingActionButton));
          await widgetTester.pumpAndSettle();
          await widgetTester.enterText(find.byType(TextFormField).first, "Apfel");
          await widgetTester.pump();
          await widgetTester.enterText(find.byType(TextFormField).last, "4,");
          await widgetTester.pump();
          await widgetTester.tap(find.widgetWithIcon(TextButton, Icons.close));
          await widgetTester.pump();
          await widgetTester.longPress(find.byType(Card));
          expect(find.byType(Card), findsNothing);
        });
      });

      testWidgets(("creating Tags and dismiss"), (widgetTester) async{
        await widgetTester.pumpWidget(const MaterialApp(
          home: HomePage(),
        ));
        Repository().sqlDatabase.init().then((value) async{
          await widgetTester.tap(find.byType(FloatingActionButton));
          await widgetTester.pumpAndSettle();
          await widgetTester.enterText(find.byType(TextFormField).first, "Apfel");
          await widgetTester.pump();
          await widgetTester.enterText(find.byType(TextFormField).last, "4,");
          await widgetTester.pump();
          await widgetTester.tap(find.widgetWithIcon(TextButton, Icons.close));
          await widgetTester.pump();
          expect(find.byType(Card), findsNothing);
        });
      });



    testWidgets("testing no/invalid input", (widgetTester) async {
      await widgetTester.pumpWidget(const MaterialApp(
        home: HomePage(),
      ));
      await widgetTester.tap(find.byType(FloatingActionButton));
      await widgetTester.pumpAndSettle();
      await widgetTester.enterText(find.byType(TextFormField).first, "");
      await widgetTester.pump();
      await widgetTester.tap(find.widgetWithIcon(TextButton, Icons.check));
      await widgetTester.pump();
      expect(find.text(ErrorCase.emptyField.message), findsOneWidget);
    });

      testWidgets("testing with valid input", (widgetTester) async {
        await widgetTester.pumpWidget(const MaterialApp(
          home: HomePage(),
        ));
        Repository().sqlDatabase.init().then((value) async {
          await widgetTester.tap(find.byType(FloatingActionButton));
          await widgetTester.pumpAndSettle();
          await widgetTester.enterText(
              find.byType(TextFormField).first, "Test");
          await widgetTester.pump();
          await widgetTester.tap(find.widgetWithIcon(TextButton, Icons.check));
          await widgetTester.pumpAndSettle();
          expect(find.byType(Card), findsOneWidget);
          expect(find.text("Test"), findsOneWidget);
        });
      });
      testWidgets("testing with Tags", (widgetTester) async {
        await widgetTester.pumpWidget(const MaterialApp(
          home: HomePage(),
        ));
        Repository().sqlDatabase.init().then((value) async {
          await widgetTester.tap(find.byType(FloatingActionButton));
          await widgetTester.pumpAndSettle();
          await widgetTester.enterText(
              find.byType(TextFormField).first, "Test");
          await widgetTester.enterText(
              find.byType(TextFormField).last, "zB-Tag");
          await widgetTester.pump();
          await widgetTester.tap(find.widgetWithIcon(TextButton, Icons.check));
          await widgetTester.pumpAndSettle();
          expect(find.byType(Card), findsWidgets);
          expect(find.text("zB-Tag"), findsOneWidget);
        });
      });
    });

    testWidgets("deleting Product", (widgetTester) async {
      await widgetTester.pumpWidget(const MaterialApp(
        home: HomePage(),
      ));
      Repository().sqlDatabase.init().then((value) async {
        await widgetTester.tap(find.byType(FloatingActionButton));
        await widgetTester.pumpAndSettle();
        await widgetTester.enterText(find.byType(TextFormField), "Test");
        await widgetTester.pump();
        await widgetTester.tap(find.widgetWithIcon(TextButton, Icons.check));
        await widgetTester.pumpAndSettle();
        await widgetTester.longPress(find.byType(Card));
        expect(find.byType(Card), findsNothing);
      });
    });
  });

  // unit
  group("testing email validation", () {
    StartingPageVM vm = LoginPageVM();

    test("testing null or empty values", () {
      var result = vm.validateEMail(null);
      expect(result, ErrorCase.noEmail);
      result = vm.validateEMail("");
      expect(result, ErrorCase.noEmail);
    });

    test("testing wrong content", () {
      var result = vm.validateEMail("value");
      expect(result, ErrorCase.invalidEmail);
    });

    test("testing valid value", () {
      var result = vm.validateEMail("johndoe@mail.com");
      expect(result, null);
    });
  });

  group("testing password validation", () {
    LoginPageVM vm = LoginPageVM();

    test("testing no password", () {
      var result = vm.validatePassword(null);
      expect(result, ErrorCase.noPassword);
      result = vm.validatePassword("");
      expect(result, ErrorCase.noPassword);
    });

    test("testing password without number", () {
      var result = vm.validatePassword("abcABC!KK");
      expect(result, ErrorCase.noNumber);
    });

    test("testing password without lower case character", () {
      var result = vm.validatePassword("ABC123!!AAA");
      expect(result, ErrorCase.noLowerCaseLetter);
    });

    test("testing password without upper case character", () {
      var result = vm.validatePassword("abc123!!aaa");
      expect(result, ErrorCase.noUpperCaseLetter);
    });

    test("testing password without special characters", () {
      var result = vm.validatePassword("abc123ABCAAA");
      expect(result, ErrorCase.noSpecialCharacter);
    });

    test("testing too short or too long password", () {
      var result = vm.validatePassword("a!2B");
      expect(ErrorCase.tooLongOrTooShort, result);
    });

    test("testing valid value", () {
      var result = vm.validatePassword("abc!1ABCd");
      expect(result, null);
    });
  });

  group("testing username validation", () {
    RegisterPageVM vm = RegisterPageVM();

    test("testing empty username input", () {
      var result = vm.validateUsername(null);
      expect(result, ErrorCase.noUsername);
      result = vm.validateUsername("");
      expect(result, ErrorCase.noUsername);
    });

    test("testing username with too less characters", () {
      var result = vm.validateUsername("a");
      expect(result, ErrorCase.invalidUsername);
    });

    test("testing valid username", () {
      var result = vm.validateUsername("Uwe");
      expect(result, null);
    });
  });

  group("testing same password validation", () {
    RegisterPageVM vm = RegisterPageVM();
    test("testing comparison of same password", () {
      var result = vm.validateSamePassword("abc");
      expect(result, ErrorCase.notSamePassword);
    });
  });

  group("testing sqlite database", () {
    test("testing inserting and getting list", () async {
      sqfliteFfiInit(); // only for testing purposes
      databaseFactory = databaseFactoryFfi; // only for testing purposes
      databaseFactory
          .deleteDatabase(join(await getDatabasesPath(), "taesch.db"));
      var sqlDatabase = SQLDatabase();
      await sqlDatabase.init();
      Product testProduct = Product(name: "test product", imageUrl: "imageUrl");
      await sqlDatabase.insertProduct(false, testProduct);
      var products = await sqlDatabase.getProductList(false);
      Product product = products[0];
      expect(product.name, testProduct.name);
    });

    test("testing deletion", () async {
      sqfliteFfiInit(); // only for testing purposes
      databaseFactory = databaseFactoryFfi; // only for testing purposes
      databaseFactory
          .deleteDatabase(join(await getDatabasesPath(), "taesch.db"));
      var sqlDatabase = SQLDatabase();
      await sqlDatabase.init();
      Product testProduct1 =
          Product(name: "test product 1", imageUrl: "imageUrl");
      Product testProduct2 =
          Product(name: "test product 2", imageUrl: "imageUrl");
      Product testProduct3 =
          Product(name: "test product 3", imageUrl: "imageUrl");
      await sqlDatabase.insertProduct(false, testProduct1);
      await sqlDatabase.insertProduct(false, testProduct2);
      await sqlDatabase.insertProduct(false, testProduct3);
      var products = await sqlDatabase.getProductList(false);
      expect(products.length, 3);
      await sqlDatabase.deleteProduct(false, testProduct3.name);
      products = await sqlDatabase.getProductList(false);
      expect(products.length, 2);
      await sqlDatabase.deleteProductList(false);
      products = await sqlDatabase.getProductList(false);
      expect(products.length, 0);
    });
  });

  group('character conversion', () {
    test('character conversion', () {
      var inputString = utf8.encode(jsonEncode({"test-text": "äöüß"}));
      expect(
          jsonDecode(utf8.decode(inputString.toList())), {"test-text": "äöüß"});
    });
  });

  group("set dynamic query parameters", () {
    Repository repository = Repository();
    test('set search radius', () {
      int searchRadius = 4438;
      repository.queries.setSearchRadiusMeters(searchRadius);
      int radiusSetting = repository.queries.getSearchRadiusMeters();
      expect(radiusSetting, searchRadius);
    });
    test('set too high search radius', () {
      int searchRadius = 10000000; // too big
      repository.queries.setSearchRadiusMeters(searchRadius);
      int radiusSetting = repository.queries.getSearchRadiusMeters();
      expect(radiusSetting, repository.queries.maxSearchRadius);
    });
    test('set too low search radius', () {
      int searchRadius = -6; // too low
      repository.queries.setSearchRadiusMeters(searchRadius);
      int radiusSetting = repository.queries.getSearchRadiusMeters();
      expect(radiusSetting, repository.queries.minSearchRadius);
    });
    test('set position', () {
      double myLat = 49.1427;
      Position samplePosition = Position(
          latitude: myLat,
          longitude: 0.0,
          timestamp: null,
          accuracy: 0.0,
          altitude: 0.0,
          heading: 0.0,
          speed: 0.0,
          speedAccuracy: 0.0);
      repository.setPosition(samplePosition);
      expect(repository.queries.getCustomLocation().latitude, myLat);
    });
    test('set search area', () {
      QueryLocation myLocation = QueryLocation.neckarsulm;
      repository.queries.setQueryLocation(myLocation);
      expect(repository.queries.getQueryLocation(), myLocation);
    });
    // also attempt query
  });

  /* Integration Test - has plugin dependency

  group("testing geo-location fetch", () {
    GeolocationTools tools = GeolocationTools();
    test("testing fetch duration", () async {
      WidgetsFlutterBinding.ensureInitialized();
      DateTime time = DateTime.now();
      var millisBefore = time.millisecondsSinceEpoch;
      await tools.getCurrentPosition();
      var millisNow = time.millisecondsSinceEpoch;
      int maxSeconds = 30;
      var totalTime = ((millisNow - millisBefore) / 1000);
      expect(totalTime < maxSeconds, true);
    });
  });
  */
}
