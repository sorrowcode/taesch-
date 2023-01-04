import 'package:taesch/api/actions/actions.dart';

abstract class FirebaseActions implements Actions {
  Future<void> login({required String email, required String password});

  Future<void> register({required String email, required String password});

  //Future<void> addProductToShop();

  //Future<void> deleteProductFromShop();

  //Future<void> updateProductInShop();

  //Future<void> addProductInTemplate();

  //Future<void> deleteProductInTemplate();

  //Future<void> updateProductInTemplate();
}
