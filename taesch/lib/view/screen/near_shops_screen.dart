import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:taesch/view/custom_widget/shops_tile.dart';
import 'package:taesch/view_model/screen/near_shops_screen_vm.dart';

/// shows the shops which are near to the own location
class NearShopsScreen extends StatefulWidget {
  final _vm = NearShopsScreenVM();

  NearShopsScreen({super.key});

  @override
  State<StatefulWidget> createState() => _NearShopsScreenState();
}

class _NearShopsScreenState extends State<NearShopsScreen> {
  List<Widget> _getShopList() {
    var shopsList = <Widget>[];
    setState(() {
      for (int i = 0; i < widget._vm.repository.shopsCache.length; i++) {
        shopsList.add(ShopsTile(
            title: widget._vm.repository.shopsCache[i].name,
            address: widget._vm.repository.shopsCache[i].address));
      }
    });
    return shopsList;
  }

  @override
  Widget build(BuildContext context) {
    //widget._vm.getShops();
    return Scaffold(
        body: Column(
      children: [
        Center(
          child: SizedBox(
            height: 100,
            child: Column(
              children: [
                Text("Area: Heilbronn", style: TextStyle(fontSize: 25)),
                TextButton(
                  child: Text("Search"),
                  onPressed: () {
                    setState(() {
                      widget._vm.getShops();
                    });
                  },
                )
              ],
            ),
          ),
        ),
        Expanded(
            child: SingleChildScrollView(
          child: Column(
            children: _getShopList(),
          ),
        ))
      ],
    ));
  }
}
