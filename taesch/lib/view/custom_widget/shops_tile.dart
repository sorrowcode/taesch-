import 'package:flutter/material.dart';
import 'package:taesch/middleware/log/logger_wrapper.dart';
import 'package:taesch/view_model/custom_widget/shops_tile_vm.dart';

class ShopsTile extends StatefulWidget {
  final ShopsTileVM _vm = ShopsTileVM();
  final void Function() callBack;

  ShopsTile(
      {super.key,
      required String title,
      required String address,
      required this.callBack}) {
    _vm.title = title;
    _vm.address = address;
  }

  @override
  State<StatefulWidget> createState() => _ShopsTileState();
}

class _ShopsTileState extends State<ShopsTile> {
  LoggerWrapper logger = LoggerWrapper();

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0)),
            tileColor: Theme.of(context).listTileTheme.tileColor,
            leading: const Icon(Icons.shopping_cart),
            title: Text(widget._vm.title),
            subtitle: Text(widget._vm.address),
            onTap: widget.callBack));
  }
}
