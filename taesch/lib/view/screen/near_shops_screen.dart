import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:taesch/api/map_api_logic/api_querier.dart';

import '../../model/map_spot.dart';

/// shows the shops which are near to the own location
class NearShopsScreen extends StatefulWidget {
  const NearShopsScreen({super.key});

  @override
  State<StatefulWidget> createState() => _NearShopsScreenState();
}

class _NearShopsScreenState extends State<NearShopsScreen> {

    APIQuerier apiQuerier = APIQuerier();
    bool _toggler = false;

    List<Widget> createSpotWidgets(List<MapSpot> list){
        var elements = <Widget>[];
        for (int i=0; i<list.length; i++){
            var entry = list[i];
            var cont = Container(
                child: Column(
                    children: [
                        Text(entry.name,
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                        Text(entry.address),
                        Text("   ")
                    ],
                ),
            );
            elements.add(cont);
        }
        return elements;
    }

  @override
  Widget build(BuildContext context){
    //return const Center();
      apiQuerier.makeHTTPRequest();
      var mapdata = apiQuerier.extractJSONData();
      var scrollWidgetList = createSpotWidgets(mapdata);
      print("SUCCESS");

    return Scaffold(
      body: Column(
          children: [
              Container(
                  height: 100,
                  //color: _toggleColor? Colors.purple : Colors.blue,
                  child: Column(
                      children: [
                          Text("Area: Heilbronn",
                              style: TextStyle(fontSize: 25)),
                          TextButton(
                              child: Text("Search"),
                              onPressed: (){setState(() {
                                  _toggler = !_toggler;
                              });},
                          )
                      ],
                  ),
              ),
              Expanded(
                  child: SingleChildScrollView(
                      child: Column(
                          children: _toggler? scrollWidgetList : scrollWidgetList,
                      ),
                  )
              )
          ],
      )
    );
  }
}
