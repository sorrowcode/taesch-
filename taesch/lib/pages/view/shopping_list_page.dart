import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:taesch/pages/page_template.dart';

/// shows the shopping list elements
class ShoppingListPage extends PageTemplate {
  const ShoppingListPage({super.key, required super.title});

  @override
  State<StatefulWidget> createState() => _ShoppingListPageState();
}

class _ShoppingListPageState extends PageTemplateState {
  @override
  Widget body() {
    return const Center(
      child: Text("Shopping List"),
    );
  }
}
