import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:taesch/api/database/action_interfaces/i_product_action.dart';
import 'package:taesch/api/database/sql/dto/product_dto.dart';
import 'package:taesch/model/product.dart';
import 'package:taesch/model/product_dto_map_data.dart';

class SQLDatabase implements IProductAction {
  late final Database _database;
  final String _generatedTable = "shopping_list_generated";
  final String _effectiveTable = "shopping_list_effective";

  Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    _database = await openDatabase(join(await getDatabasesPath(), "taesch.db"),
        version: 1,
        onCreate: (db, version) {
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
      return db.execute(
        sql
      );
    });
  }

  @override
  void deleteEffectiveProduct() {
    // TODO: implement deleteEffectiveProduct
  }

  @override
  void deleteEffectiveProductList() {
    // TODO: implement deleteEffectiveProductList
  }

  @override
  void deleteGeneratedProduct() {
    // TODO: implement deleteGeneratedProduct
  }

  @override
  void deleteGeneratedProductList() {
    // TODO: implement deleteGeneratedProductList
  }

  @override
  Product getEffectiveProduct() {
    // TODO: implement getEffectiveProduct
    throw UnimplementedError();
  }

  @override
  Future<List<Product>> getEffectiveProductList() async {
    final db = _database;
    final List<Map<String, dynamic>> products = await db.query(_effectiveTable);
    return List.generate(products.length, (index) {
      var dto = ProductDTO.fromMap(map: products[index]);
      dto.toProduct();
      return dto.product;
    });
  }

  @override
  Product getGeneratedProduct() {
    // TODO: implement getGeneratedProduct
    throw UnimplementedError();
  }

  @override
  List<Product> getGeneratedProductList() {
    // TODO: implement getGeneratedProductList
    throw UnimplementedError();
  }

  @override
  Future<void> insertEffectiveProduct(Product product) async {
    var db = _database;
    var dto = ProductDTO.fromProduct(product: product);
    dto.toMap();
    await db.insert(
        _effectiveTable,
        dto.map);
  }

  @override
  void insertGeneratedProductList(List<Product> products) {
    // TODO: implement insertGeneratedProductList
  }
}
