import 'package:flutter_test/flutter_test.dart';
import 'package:taesch/model/error.dart';
import 'package:taesch/pages/view_model/login_page_vm.dart';
import 'package:taesch/pages/view_model/register_page_vm.dart';
import 'package:taesch/pages/view_model/starting_page_vm.dart';

void testValidateEMail() {
  group("testing email validation", () {
    StartingPageVM vm = LoginPageVM();

    test("testing null or empty values", () {
      var result = vm.validateEMail(null);
      expect(result, Error.noEmail);
      result = vm.validateEMail("");
      expect(result, Error.noEmail);
    });

    test("testing wrong content", () {
      var result = vm.validateEMail("value");
      expect(result, Error.invalidEmail);
    });

    test("testing valid value", () {
      var result = vm.validateEMail("johndoe@mail.com");
      expect(result, null);
    });
  });
}

void testValidatePassword() {
  group("testing password validation", () {
    LoginPageVM vm = LoginPageVM();

    test("testing no password", () {
      var result = vm.validatePassword(null);
      expect(result, Error.noPassword);
      result = vm.validatePassword("");
      expect(result, Error.noPassword);
    });

    test("testing password without number", () {
      var result = vm.validatePassword("abcABC!KK");
      expect(result, Error.noNumber);
    });

    test("testing password without lower case character", () {
      var result = vm.validatePassword("ABC123!!AAA");
      expect(result, Error.noLowerCaseLetter);
    });

    test("testing password without upper case character", () {
      var result = vm.validatePassword("abc123!!aaa");
      expect(result, Error.noUpperCaseLetter);
    });

    test("testing password without special characters", () {
      var result = vm.validatePassword("abc123ABCAAA");
      expect(result, Error.noSpecialCharacter);
    });

    test("testing too short or too long password", () {
      var result = vm.validatePassword("a!2B");
      expect(Error.tooLongOrTooShort, result);
    });

    test("testing valid value", () {
      var result = vm.validatePassword("abc!1ABCd");
      expect(result, null);
    });
  });
}

void testValidateUsername() {
  group("testing username validation", () {
    RegisterPageVM vm = RegisterPageVM();

    test("testing empty username input", () {
      var result = vm.validateUsername(null);
      expect(result, Error.noUsername);
      result = vm.validateUsername("");
      expect(result, Error.noUsername);
    });

    test("testing username with too less characters", () {
      var result = vm.validateUsername("a");
      expect(result, Error.invalidUsername);
    });

    test("testing valid username", () {
      var result = vm.validateUsername("Uwe");
      expect(result, null);
    });
  });
}

void testValidateSamePassword() {
  group("testing same password validation", () {
    RegisterPageVM vm = RegisterPageVM();
    test("testing comparison of same password", () {
      var result = vm.validateSamePassword("abc");
      expect(result, Error.notSamePassword);
    });
  });
}
