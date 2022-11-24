import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:taesch/api/database/action_interfaces/i_product_action.dart';
import 'package:taesch/api/database/sql/dto/product_dto.dart';
import 'package:taesch/middleware/log/log_level.dart';
import 'package:taesch/middleware/log/logger_wrapper.dart';
import 'package:taesch/model/log_message.dart';
import 'package:taesch/model/product.dart';
import 'package:taesch/model/product_dto_map_data.dart';

class SQLDatabase implements IProductAction {
  late final Database _database;
  bool initialized = false;
  final String _generatedTable = "shopping_list_generated";
  final String _effectiveTable = "shopping_list_effective";
  LoggerWrapper logger = LoggerWrapper();

  Future<void> init() async {
    logger.log(
        level: LogLevel.info,
        logMessage: LogMessage(
          message: "sql database init called",
        ));
    WidgetsFlutterBinding.ensureInitialized();
    _database = await openDatabase(join(await getDatabasesPath(), "taesch.db"),
        version: 1, onCreate: (db, version) {
      var name = ProductDTOMapData.name.value();
      var imageURL = ProductDTOMapData.imageUrl.value();
      var quantity = ProductDTOMapData.quantity.value();
      var tags = ProductDTOMapData.tags.value();
      var positionValue = ProductDTOMapData.positionValue.value();
      var sumOfAllWeights = ProductDTOMapData.sumOfAllWeights.value();
      var timesBought = ProductDTOMapData.timesBought.value();
      var sql = "CREATE TABLE IF NOT EXISTS $_generatedTable("
          "$name TEXT PRIMARY KEY,"
          "$imageURL TEXT NOT NULL,"
          "$quantity INTEGER NOT NULL,"
          "$tags TEXT,"
          "$positionValue DOUBLE PRECISION NOT NULL,"
          "$sumOfAllWeights DOUBLE PRECISION NOT NULL,"
          "$timesBought INTEGER NOT NULL"
          ");"
          "CREATE TABLE IF NOT EXISTS $_effectiveTable("
          "$name TEXT PRIMARY KEY,"
          "$imageURL TEXT NOT NULL,"
          "$quantity INTEGER NOT NULL,"
          "$tags TEXT,"
          "$positionValue DOUBLE PRECISION NOT NULL,"
          "$sumOfAllWeights DOUBLE PRECISION NOT NULL,"
          "$timesBought INTEGER NOT NULL"
          ");";
      return db.execute(sql);
    });
    initialized = true;
  }

  @override
  Future<void> deleteProduct(bool generated, String productName) async {
    logger.log(
        level: LogLevel.info,
        logMessage: LogMessage(message: "sql database delete product called"));
    final db = _database;
    await db.delete(generated ? _generatedTable : _effectiveTable,
        where: "${ProductDTOMapData.name.value()} = ?;",
        whereArgs: [productName]);
  }

  @override
  Future<void> deleteProductList(bool generated) async {
    logger.log(
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
    logger.log(
        level: LogLevel.info,
        logMessage:
            LogMessage(message: "sql database get product list called"));
    final db = _database;
    final List<Map<String, dynamic>> products =
        await db.query(generated ? _generatedTable : _effectiveTable);
    return List.generate(products.length, (index) {
      var dto = ProductDTO.fromMap(map: products[index]);
      dto.toProduct();
      return dto.product;
    });
  }

  @override
  Future<void> insertProduct(bool generated, Product product) async {
    logger.log(
        level: LogLevel.info,
        logMessage: LogMessage(message: "sql database insert product called"));
    var db = _database;
    var dto = ProductDTO.fromProduct(product: product);
    dto.toMap();
    await db.insert(generated ? _generatedTable : _effectiveTable, dto.map);
  }
}
