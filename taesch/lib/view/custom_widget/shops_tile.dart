import 'package:flutter/material.dart';
import 'package:taesch/view_model/custom_widget/shops_tile_vm.dart';

class ShopsTile extends StatefulWidget {
  final ShopsTileVM _vm = ShopsTileVM();

  ShopsTile({super.key, required String title, required String address}) {
    _vm.title = title;
    _vm.address = address;
  }

  @override
  State<StatefulWidget> createState() => _ShopsTileState();
}

class _ShopsTileState extends State<ShopsTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.shopping_cart_rounded),
      title: Text(widget._vm.title),
      subtitle: Text(widget._vm.address),
    );
  }
}
