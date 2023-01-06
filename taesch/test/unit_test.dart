import 'package:flutter_test/flutter_test.dart';
import 'package:taesch/model/error_case.dart';
import 'package:taesch/view_model/page/login_page_vm.dart';
import 'package:taesch/view_model/page/register_page_vm.dart';
import 'package:taesch/view_model/page/starting_page_vm.dart';

void main() {
  /*
  setUpAll(() async {
    sqfliteFfiInit(); // only for testing purposes
    databaseFactory = databaseFactoryFfi; // only for testing purposes
    databaseFactory
        .deleteDatabase(join(await getDatabasesPath(), "taesch.db"));
    RepositoryHolder();
  });

   */

  group("validation", () {
    /* todo:
    - email validation
    - password validation
    - username validation ?
    - same password validation
    */

    group("email", () {
      StartingPageVM vm = LoginPageVM();

      test("null or empty values", () {
        var result = vm.validateEMail(null);
        expect(result, ErrorCase.noEmail);
        result = vm.validateEMail("");
        expect(result, ErrorCase.noEmail);
      });

      test("wrong content", () {
        var result = vm.validateEMail("value");
        expect(result, ErrorCase.invalidEmail);
      });

      test("valid value", () {
        var result = vm.validateEMail("johndoe@mail.com");
        expect(result, null);
      });
    });

    group("password", () {
      LoginPageVM vm = LoginPageVM();

      test("no password", () {
        var result = vm.validatePassword(null);
        expect(result, ErrorCase.noPassword);
        result = vm.validatePassword("");
        expect(result, ErrorCase.noPassword);
      });

      test("without number", () {
        var result = vm.validatePassword("abcABC!KK");
        expect(result, ErrorCase.noNumber);
      });

      test("without lower case character", () {
        var result = vm.validatePassword("ABC123!!AAA");
        expect(result, ErrorCase.noLowerCaseLetter);
      });

      test("without upper case character", () {
        var result = vm.validatePassword("abc123!!aaa");
        expect(result, ErrorCase.noUpperCaseLetter);
      });

      test("without special characters", () {
        var result = vm.validatePassword("abc123ABCAAA");
        expect(result, ErrorCase.noSpecialCharacter);
      });

      test("too short or too long", () {
        var result = vm.validatePassword("a!2B");
        expect(ErrorCase.tooLongOrTooShort, result);
      });

      test("valid value", () {
        var result = vm.validatePassword("abc!1ABCd");
        expect(result, null);
      });
    });

    group("username", () {
      test("empty input", () {
        RegisterPageVM vm = RegisterPageVM.empty();
        var result = vm.validateUsername(null);
        expect(result, ErrorCase.noUsername);
        result = vm.validateUsername("");
        expect(result, ErrorCase.noUsername);
      });

      test("with too less characters", () {
        RegisterPageVM vm = RegisterPageVM.empty();
        var result = vm.validateUsername("a");
        expect(result, ErrorCase.invalidUsername);
      });

      test("valid", () {
        RegisterPageVM vm = RegisterPageVM.empty();
        var result = vm.validateUsername("Uwe");
        expect(result, null);
      });
    });

    group("same password", () {
      RegisterPageVM vm = RegisterPageVM.empty();
      test("testing comparison of same password", () {
        var result = vm.validateSamePassword("abc");
        expect(result, ErrorCase.notSamePassword);
      });
    });
  });

  group("actions", () {
    /* todo:
      - sql actions
      - firebase actions
        - valid authentication via mocks
      - osm actions
     */

    group("sql", () {});

    group("firebase", () {});

    group("osm", () {});
  });
}
