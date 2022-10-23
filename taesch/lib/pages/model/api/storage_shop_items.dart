import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:taesch/pages/model/api/storage.dart';
import 'package:taesch/pages/model/shoppingitem.dart';

class StorageShopItems implements PersistStorage<ShoppingItem>{
  late Database db;
  StorageShopItems(){
    getDb();
  }
  void getDb() async {
    db = await openDatabase(
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
  }

  @override
  Future<void> delete(ShoppingItem shopItem) async {
    // Remove the Dog from the database.
    await db.delete(
      'shopping_items',
      // Use a `where` clause to delete a specific dog.
      where: 'shop_item = ?',
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [shopItem.title],
    );
  }

  @override
  Future<List<ShoppingItem>> read(String filter) async {
    // Query the table for all The ShoppingItems
    final List<Map<String, dynamic>> maps = await db.query('shopping_items');

    // Convert the List<Map<String, dynamic> into a List<Dog>.
    return List.generate(maps.length, (i) {
      return ShoppingItem.db(
        title: maps[i]['item_title'],
        image: maps[i]['image'],
        bought: maps[i]['bought'],
      );
    });
  }

  @override
  Future<void> update(ShoppingItem shopItem) async {
    // Update the given Dog.
    await db.update(
      'shopping_items',
      shopItem.toMap(),
      // Ensure that the Dog has a matching id.
      where: 'item_title = ?',
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [shopItem.title],
    );
  }

  @override
  Future<void> insert(ShoppingItem shopItem) async {
    await db.insert(
      'shopping_items',
      shopItem.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

}