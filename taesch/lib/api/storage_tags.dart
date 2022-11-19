
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:taesch/api/storage.dart';

import '../model/tag.dart';

class StorageTags implements PersistStorage<Tag>{
  late Database _db;
  static const tableName = 'tags';

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
      tableName,
      where: 'tag_name = ?',
      whereArgs: [deleteTag.tagName],
    );
  }

  @override
  void insert(Tag newTags) async {
    await _db.insert(
      tableName,
      newTags.toMap(),
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }
  void insertMany(List<Tag> newTags) async {
    var batch = _db.batch();
    for (var tag in newTags) {
      batch.insert(
          tableName,
          tag.toMap(),
          conflictAlgorithm: ConflictAlgorithm.ignore);
    }
    batch.commit(noResult: true, continueOnError: true);
  }

  @override
  Future<List<Tag>> read(Map filter) async {
    Future<List<Map<String, Object?>>> query;
    if (filter.isEmpty) {
      query = _db.query(tableName);
    } else {
      query = _db.query(tableName,
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
    _db.update(tableName, updateTag.toMap(),
        where: 'tag_name = ?', whereArgs: [updateTag.tagName]);
  }

  void updateMany(List<Tag> updateTags){
    var batch = _db.batch();
    for (var tag in updateTags) {
      batch.insert(
          tableName,
          tag.toMap(),
          conflictAlgorithm: ConflictAlgorithm.ignore);
    }
    batch.commit(noResult: true, continueOnError: true);
  }
  
}