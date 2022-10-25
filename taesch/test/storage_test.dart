import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:taesch/pages/model/api/storage.dart';
import 'package:taesch/pages/model/api/storage_shop_items.dart';
import 'package:taesch/pages/model/shoppingitem.dart';
import 'package:test/test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite/sqflite.dart';

void main() {
  late PersistStorage itemList;
  // Setup sqflite_common_ffi for flutter test
  setUpAll(() async {
    // Initialize FFI
    sqfliteFfiInit();
    // Change the default factory
    databaseFactory = databaseFactoryFfi;

    itemList = await StorageShopItems.create();

  });
  group('String', () {
    WidgetsFlutterBinding.ensureInitialized();
    ShoppingItem testItem = ShoppingItem('TestItem', '');

    test('Store ShoppingItem',() async {
      itemList.insert(testItem);
      expect((await itemList.read('*')).toString(), [testItem].toString());
    });
    test('Update ShoppingItem',() async {
      testItem = ShoppingItem('TestItem', 'abcd');
      itemList.update(testItem);
      expect((await itemList.read('*')).toString(), [testItem].toString());
    });
    test('Update ShoppingItem wrong',() async {
      ShoppingItem wrong = ShoppingItem('Wrong', '');
      itemList.update(wrong);
      expect((await itemList.read('*')).toString(), [testItem].toString());
    });//nothing happens
    test('Delete ShoppingItem',() async {
      itemList.delete(testItem);
      expect((await itemList.read('*')).toString(), [].toString());
    });
  });

  tearDownAll(() async {
    await databaseFactory.deleteDatabase(join(await getDatabasesPath(), 'shoppinglist_database.db'));
  });
}