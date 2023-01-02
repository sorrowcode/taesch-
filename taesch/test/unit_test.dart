import 'package:flutter_test/flutter_test.dart';
import 'package:taesch/model/error_case.dart';
import 'package:taesch/view_model/page/login_page_vm.dart';
import 'package:taesch/view_model/page/starting_page_vm.dart';

void main() async {
  group("validation", () {
    /* todo:
    - email validation
    - password validation
    - username validation ?
    - same password validation
    */

    group("email", () {
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

    group("password", () {

    });

    group("username", () {

    });

    group("same password", () {

    });
  });

  group("actions", () {
    /* todo:
      - sql actions
      - firebase actions
        - valid authentication via mocks
      - osm actions
     */

    group("sql", () {

    });

    group("firebase", () {

    });

    group("osm", () {

    });
  });
}