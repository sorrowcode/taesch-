import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:taesch/api/actions/sql_actions.dart';
import 'package:taesch/api/mapper/product_dto_map_data.dart';
import 'package:taesch/middleware/log/log_level.dart';
import 'package:taesch/middleware/log/logger_wrapper.dart';
import 'package:taesch/model/log_message.dart';
import 'package:taesch/model/product.dart';

class SQLDatabase implements SQLActions {
  late final Database _database;
  bool initialized = false;
  final String _generatedTable = "shopping_list_generated";
  final String _effectiveTable = "shopping_list_effective";
  final LoggerWrapper _logger = LoggerWrapper();

  @override
  Future<void> init() async {
    _logger.log(
        level: LogLevel.info,
        logMessage: LogMessage(
          message: "sql database init called",
        ));
    WidgetsFlutterBinding.ensureInitialized();
    _database = await openDatabase(join(await getDatabasesPath(), "taesch.db"),
        version: 1, onCreate: (db, version) {
      var name = ProductDTOMapData.name.value();
      var quantity = ProductDTOMapData.quantity.value();
      var tags = ProductDTOMapData.tags.value();
      var positionValue = ProductDTOMapData.positionValue.value();
      var sumOfAllWeights = ProductDTOMapData.sumOfAllWeights.value();
      var timesBought = ProductDTOMapData.timesBought.value();
      var sql = "CREATE TABLE IF NOT EXISTS $_generatedTable("
          "$name TEXT PRIMARY KEY,"
          "$quantity INTEGER NOT NULL,"
          "$tags TEXT,"
          "$positionValue DOUBLE PRECISION NOT NULL,"
          "$sumOfAllWeights DOUBLE PRECISION NOT NULL,"
          "$timesBought INTEGER NOT NULL"
          ");"
          "CREATE TABLE IF NOT EXISTS $_effectiveTable("
          "$name TEXT PRIMARY KEY,"
          "$quantity INTEGER NOT NULL,"
          "$tags TEXT,"
          "$positionValue DOUBLE PRECISION NOT NULL,"
          "$sumOfAllWeights DOUBLE PRECISION NOT NULL,"
          "$timesBought INTEGER NOT NULL"
          ");";
      initialized = true;
      return db.execute(sql);
    });
  }

  @override
  Future<void> deleteProduct(bool generated, String productName) async {
    _logger.log(
        level: LogLevel.info,
        logMessage: LogMessage(message: "sql database delete product called"));
    final db = _database;
    await db.delete(generated ? _generatedTable : _effectiveTable,
        where: "${ProductDTOMapData.name.value()} = ?;",
        whereArgs: [productName]);
  }

  @override
  Future<void> deleteProductList(bool generated) async {
    _logger.log(
        level: LogLevel.info,
        logMessage:
            LogMessage(message: "sql database delete product list called"));
    final db = _database;
    await db.delete(
      generated ? _generatedTable : _effectiveTable,
    );
  }

  @override
  Future<List<Product>> getProductList(bool generated) async {
    _logger.log(
        level: LogLevel.info,
        logMessage:
            LogMessage(message: "sql database get product list called"));
    final db = _database;
    final List<Map<String, dynamic>> products =
        await db.query(generated ? _generatedTable : _effectiveTable);
    return List.generate(products.length, (index) {
      return Product.fromMap(products[index]);
    });
  }

  @override
  Future<void> insertProduct(bool generated, Product product) async {
    _logger.log(
        level: LogLevel.info,
        logMessage: LogMessage(message: "sql database insert product called"));
    var db = _database;
    await db.insert(generated ? _generatedTable : _effectiveTable, product.toMap());
  }
}
