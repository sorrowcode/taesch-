import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:taesch/api/repository.dart';
import 'package:taesch/api/storage.dart';
import 'package:taesch/model/shopping_list_item.dart';

class StorageShopItems implements PersistStorage<ShoppingListItem> {
  late Database _db;
  late Repository repository;

  StorageShopItems._create() {
    repository = Repository();
    listenerSetup();
    return;
  }
  listenerSetup() {
    repository.shoppingListSize.addListener(() {
      replace(repository.shoppingListItems);
    });
  }

  /// Public factory
  static Future<StorageShopItems> create() async {
    // Call the private constructor
    var component = StorageShopItems._create();

    component._db = await openDatabase(
      // Set the path to the database. Note: Using the `join` function from the
      // `path` package is best practice to ensure the path is correctly
      // constructed for each platform.
      join(await getDatabasesPath(), 'shoppinglist_database.db'),
      // When the database is first created, create a table to store dogs.
      onCreate: (db, version) {
        // Run the CREATE TABLE statement on the database.
        return db.execute(
          'CREATE TABLE shopping_items(id INTEGER PRIMARY KEY, item_title TEXT, image TEXT, bought BOOLEAN)',
        );
      },
      // Set the version. This executes the onCreate function and provides a
      // path to perform database upgrades and downgrades.
      version: 1,
    );
    return component;
  }

  @override
  Future<void> delete(ShoppingListItem shopItem) async {
    await _db.delete(
      'shopping_items',
      where: 'item_title = ?',
      whereArgs: [shopItem.title],
    );
  }

  @override
  Future<List<ShoppingListItem>> read(Map filter) async {
    // Query the table for all The ShoppingItems
    final List<Map<String, dynamic>> maps = await _db.query('shopping_items',where: filter.keys.join('=?,'), whereArgs: filter.values.toList(growable: false));
    // Convert the List<Map<String, dynamic> into a List<ShoppingItem>.
    return List.generate(maps.length, (i) {
      return ShoppingListItem.db(
        title: maps[i]['item_title'],
        image: maps[i]['image'],
        weight: maps[i]['weight'],
      );
    });
  }

  @override

  ///item Title is identifier => don't change
  Future<void> update(ShoppingListItem shopItem) async {
    await _db.update('shopping_items', shopItem.toMap(),
        where: 'item_title = ?', whereArgs: [shopItem.title]);
  }
  Future<void> replace(List<ShoppingListItem> shoppinglist) async {
    await _db.transaction((txn) async  {
      await txn.delete('shopping_items');
          Batch batch = txn.batch();
      for (var item in shoppinglist) {
        batch.insert('shopping_items', item.toMap());
      }
      batch.commit();
    });

  }

  @override
  Future<void> insert(ShoppingListItem shopItem) async {
    await _db.insert(
      'shopping_items',
      shopItem.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}
