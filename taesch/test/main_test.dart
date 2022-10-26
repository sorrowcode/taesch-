import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:taesch/app.dart';
import 'package:taesch/model/error_case.dart';
import 'package:taesch/model/screen_state.dart';
import 'package:taesch/model/widget_key.dart';
import 'package:taesch/view/page/home_page.dart';
import 'package:taesch/view/page/register_page.dart';
import 'package:taesch/view/screen/near_shops_screen.dart';
import 'package:taesch/view/screen/shopping_list_screen.dart';
import 'package:taesch/view_model/login_page_vm.dart';
import 'package:taesch/view_model/register_page_vm.dart';
import 'package:taesch/view_model/starting_page_vm.dart';

void main() {
  // ui
  group("testing login page functionality", () {
    LoginPageVM vm = LoginPageVM();
    testWidgets("testing with no input", (widgetTester) async {
      await widgetTester.pumpWidget(App());
      expect(find.text("Login"), findsOneWidget);
      await widgetTester.tap(find.text(vm.submitButtonText));
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
      await widgetTester.tap(find.text(vm.submitButtonText));
      await widgetTester.pump();
      expect(find.text(ErrorCase.invalidEmail.message), findsOneWidget);
      expect(find.text(ErrorCase.noSpecialCharacter.message), findsOneWidget);
    });

    testWidgets("testing with valid input", (widgetTester) async {
      await widgetTester.pumpWidget(App());
      await widgetTester.enterText(
          find.byKey(Key(WidgetKey.emailLoginKey.text)), "johndoe@mail.com");
      await widgetTester.pump();
      expect(find.text("johndoe@mail.com"), findsOneWidget);
      await widgetTester.enterText(
          find.byKey(Key(WidgetKey.passwordLoginKey.text)), "abc!123ABC");
      await widgetTester.pump();
      expect(find.text(vm.submitButtonText), findsOneWidget);
      await widgetTester.tap(find.byKey(Key(WidgetKey.loginButtonKey.text)));
      await widgetTester.pump();
      for (ErrorCase element in ErrorCase.values) {
        expect(find.text(element.message), findsNothing);
      }
    });
  });

  group("testing register page functionality", () {
    RegisterPageVM vm = RegisterPageVM();
    testWidgets("testing with no values", (widgetTester) async {
      await widgetTester.pumpWidget(const MaterialApp(
        home: RegisterPage(),
      ));

      await widgetTester.tap(find.text(vm.submitButtonText));
      await widgetTester.pump();

      expect(find.text(ErrorCase.noUsername.message), findsOneWidget);
      expect(find.text(ErrorCase.noEmail.message), findsOneWidget);
      expect(find.text(ErrorCase.noPassword.message), findsOneWidget);
    });

    testWidgets("testing with invalid values", (widgetTester) async {
      await widgetTester.pumpWidget(const MaterialApp(
        home: RegisterPage(),
      ));
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
      expect(find.byType(ListTile), findsAtLeastNWidgets(2));
      var findNearShopsListTile = find.text(ScreenState.nearShops.text);
      expect(findNearShopsListTile, findsOneWidget);

      // tapping on list tile to switch page
      await widgetTester.tap(findNearShopsListTile);
      await widgetTester.pumpAndSettle(const Duration(seconds: 1));
      // checking if page was switched
      expect(find.text(ScreenState.nearShops.text), findsAtLeastNWidgets(2));
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
}
