import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

/// shows the shops which are near to the own location
class NearShopsPage extends StatefulWidget {
  const NearShopsPage({super.key});

  @override
  State<StatefulWidget> createState() => _NearShopsPageState();
}

class _NearShopsPageState extends State<NearShopsPage> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("Near Shops"),
    );
  }
}
