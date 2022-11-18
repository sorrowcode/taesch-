
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:taesch/api/storage.dart';

import '../model/tag.dart';

class StorageTags implements PersistStorage<Tag>{
  late Database _db;

  StorageTags._create() {
    return;
  }

  /// Public factory
  static Future<StorageTags> create() async {
    // Call the private constructor
    var component = StorageTags._create();

    component._db = await openDatabase(
      // Set the path to the database. Note: Using the `join` function from the
      // `path` package is best practice to ensure the path is correctly
      // constructed for each platform.
      join(await getDatabasesPath(), 'shoppinglist_database.db'),
      // When the database is first created, create a table to store dogs.
      onCreate: (db, version) {
        // Run the CREATE TABLE statement on the database.
        return db.execute(
          'CREATE TABLE tags(id INTEGER PRIMARY KEY, tag_name TEXT, priority DOUBLE)',
        );
      },
      // Set the version. This executes the onCreate function and provides a
      // path to perform database upgrades and downgrades.
      version: 1,
    );
    return component;
  }

  @override
  void delete(Tag deleteTag) {
    _db.delete(
      'tags',
      where: 'tag_name = ?',
      whereArgs: [deleteTag.tagName],
    );
  }

  @override
  void insert(Tag newTag) async {
    await _db.insert(
      'shopping_items',
      newTag.toMap(),
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }

  @override
  Future<List<Tag>> read(Map filter) async {
    Future<List<Map<String, Object?>>> query;
    if (filter.isEmpty) {
      query = _db.query('shopping_items');
    } else {
      query = _db.query('shopping_items',
          where: filter.keys.join('=?,'),
          whereArgs: filter.values.toList(growable: false));
    }

    // Query the table for all The ShoppingItems
    final List<Map<String, dynamic>> maps = await query;
    // Convert the List<Map<String, dynamic> into a List<ShoppingItem>.
    return List.generate(maps.length, (i) {
      return Tag.db(
        tagName: maps[i]['tag_name'],
        priorityValue: maps[i]['priority'],
      );
    });
  }

  @override
  void update(Tag updateTag) {
    _db.update('shopping_items', updateTag.toMap(),
        where: 'tag_name = ?', whereArgs: [updateTag.tagName]);
  }
  
}