import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

/// shows the shops which are near to the own location
class NearShopsScreen extends StatefulWidget {
  const NearShopsScreen({super.key});

  @override
  State<StatefulWidget> createState() => _NearShopsScreenState();
}

class _NearShopsScreenState extends State<NearShopsScreen> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("Near Shops"),
    );
  }
}
