import 'package:flutter/material.dart';
import 'package:taesch/view_model/shops_tile_vm.dart';

class ShopsTile extends StatefulWidget {
  late ShopsTileVM _vm;

  ShopsTile({super.key, required String title, required String address}) {
    _vm = ShopsTileVM(title: title, address: address);
  }

  @override
  State<StatefulWidget> createState() => _ShopsTileState();
}

class _ShopsTileState extends State<ShopsTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget._vm.title),
      subtitle: Text(widget._vm.address),
    );
  }
}
