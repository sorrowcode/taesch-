import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:taesch/api/implementation/sql_database.dart';
import 'package:taesch/model/error_case.dart';
import 'package:taesch/model/product.dart';
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

    group("sql", () {
      test("insert and get list", () async {
        await sqlSetup();
        var sqlDatabase = SQLDatabase();
        await sqlDatabase.init();
        Product testProduct = Product(name: "test product");
        await sqlDatabase.insertProduct(false, testProduct);
        var products = await sqlDatabase.getProductList(false);
        Product product = products[0];
        expect(product.name, testProduct.name);
      });

      test("deletion", () async {
        await sqlSetup();
        var sqlDatabase = SQLDatabase();
        await sqlDatabase.init();
        Product testProduct1 =
        Product(name: "test product 1");
        Product testProduct2 =
        Product(name: "test product 2");
        Product testProduct3 =
        Product(name: "test product 3");
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

    group("firebase", () {});

    group("osm", () {});
  });
}

Future<void> sqlSetup() async {
  sqfliteFfiInit(); // only for testing purposes
  databaseFactory = databaseFactoryFfi; // only for testing purposes
  databaseFactory
      .deleteDatabase(join(await getDatabasesPath(), "taesch.db"));
}