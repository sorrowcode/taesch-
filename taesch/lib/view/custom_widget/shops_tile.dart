import 'package:flutter/material.dart';
import 'package:taesch/middleware/log/logger_wrapper.dart';
import 'package:taesch/view_model/custom_widget/shops_tile_vm.dart';

class ShopsTile extends StatefulWidget {

  late final String _title;
  late final String _address;

  ShopsTile({super.key, required String title, required String address}){
    _title = title;
    _address = address;
  }

  @override
  State<StatefulWidget> createState() => _ShopsTileState();
}

class _ShopsTileState extends State<ShopsTile> {
  LoggerWrapper logger = LoggerWrapper();
  late final ShopsTileVM _vm;

  _ShopsTileState() {
    _vm = ShopsTileVM.withData(title: widget._title, address: widget._address);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0)),
            tileColor: Theme.of(context).listTileTheme.tileColor,
            leading: const Icon(Icons.shopping_cart),
            title: Text(_vm.title),
            subtitle: Text(_vm.address)));
  }
}
