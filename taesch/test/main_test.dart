import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:taesch/api/storage.dart';
import 'package:taesch/api/storage_shop_items.dart';
import 'package:taesch/app.dart';
import 'package:taesch/model/error_case.dart';
import 'package:taesch/model/screen_state.dart';
import 'package:taesch/model/shopping_list_item.dart';
import 'package:taesch/model/widget_key.dart';
import 'package:taesch/view/page/home_page.dart';
import 'package:taesch/view/screen/near_shops_screen.dart';
import 'package:taesch/view/screen/shopping_list_screen.dart';
import 'package:taesch/view_model/page/login_page_vm.dart';
import 'package:taesch/view_model/page/register_page_vm.dart';
import 'package:taesch/view_model/page/starting_page_vm.dart';

void main() {
  // ui
  group("testing login page functionality", () {
    LoginPageVM vm = LoginPageVM();
    testWidgets("testing with no input", (widgetTester) async {
      await widgetTester.pumpWidget(App());
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
      await widgetTester.pumpWidget(App());
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
    //RegisterPageVM vm = RegisterPageVM();
    testWidgets("testing with no values", (widgetTester) async {
      await widgetTester.pumpWidget(App());
      await widgetTester
          .tap(find.byKey(Key(WidgetKey.registrationButtonKey.text)));
      await widgetTester.pumpAndSettle();

      //expect(find.byType(RegisterPage), findsOneWidget); <- tester

      await widgetTester.tap(find.byKey(Key(WidgetKey.submitButtonKey.text)));
      await widgetTester.pump();

      expect(find.text(ErrorCase.noUsername.message), findsOneWidget);
      expect(find.text(ErrorCase.noEmail.message), findsOneWidget);
      expect(find.text(ErrorCase.noPassword.message), findsOneWidget);
    });

    testWidgets("testing with invalid values", (widgetTester) async {
      await widgetTester.pumpWidget(App());
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
    testWidgets('testing navigation of the side bar', (widgetTester) async {
      var key = GlobalKey<ScaffoldState>();
      // building the root of the application
      await widgetTester.pumpWidget(MaterialApp(
        home: HomePage(
          key: key,
        ),
      ));
      // checking in which page we are
      expect(find.byType(ShoppingListScreen), findsOneWidget);
      expect(find.byType(NearShopsScreen), findsNothing);
      // finding the button for the drawer

      var findMenuButton = find.byIcon(Icons.menu);
      expect(findMenuButton, findsOneWidget);

      // tapping the button which should make the drawer visible
      await widgetTester.ensureVisible(findMenuButton);
      await widgetTester.tap(findMenuButton);
      await widgetTester.pumpAndSettle();
      // checking if drawer made list tiles visible
      expect(find.byType(ListTile), findsAtLeastNWidgets(3));

      var findNearShopsListTile = find.text(ScreenState.nearShops.text);
      expect(findNearShopsListTile, findsAtLeastNWidgets(1));

      // tapping on list tile to switch page
      await widgetTester.tap(findNearShopsListTile);
      await widgetTester.pumpAndSettle(const Duration(seconds: 1));
      // checking if page was switched
      expect(find.byType(NearShopsScreen), findsOneWidget);
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

  group('String', () {
    late PersistStorage itemList;
    // Setup sqflite_common_ffi for flutter test
    setUpAll(() async {
      // Initialize FFI
      sqfliteFfiInit();
      // Change the default factory
      databaseFactory = databaseFactoryFfi;

      itemList = await StorageShopItems.create();
    });
    WidgetsFlutterBinding.ensureInitialized();
    ShoppingListItem testItem = ShoppingListItem('TestItem', '');

    test('Store ShoppingItem', () async {
      itemList.insert(testItem);
      expect((await itemList.read('*')).toString(), [testItem].toString());
    });
    test('Update ShoppingItem', () async {
      testItem = ShoppingListItem('TestItem', 'abcd');
      itemList.update(testItem);
      expect((await itemList.read('*')).toString(), [testItem].toString());
    });
    test('Update ShoppingItem wrong', () async {
      ShoppingListItem wrong = ShoppingListItem('Wrong', '');
      itemList.update(wrong);
      expect((await itemList.read('*')).toString(), [testItem].toString());
    }); //nothing happens
    test('Delete ShoppingItem', () async {
      itemList.delete(testItem);
      expect((await itemList.read('*')).toString(), [].toString());
    });
    tearDownAll(() async {
      await databaseFactory.deleteDatabase(
          join(await getDatabasesPath(), 'shoppinglist_database.db'));
    });
  });
}
