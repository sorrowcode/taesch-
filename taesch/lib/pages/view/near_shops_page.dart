import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:taesch/pages/page_template.dart';

/// shows the shops which are near to the own location
class NearShopsPage extends PageTemplate {
  const NearShopsPage({super.key, required super.title});

  @override
  State<StatefulWidget> createState() => _NearShopsPageState();
}

class _NearShopsPageState extends PageTemplateState {
  @override
  Widget body() {
    return const Center(
      child: Text("Near Shops"),
    );
  }
}
