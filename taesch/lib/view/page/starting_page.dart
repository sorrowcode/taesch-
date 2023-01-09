import 'package:flutter/material.dart';
import 'package:taesch/api/actions/ping_actions.dart';
import 'package:taesch/api/implementation/ping.dart';
import 'package:taesch/api/repositories/ping_repository.dart';
import 'package:taesch/api/repositories/repository_type.dart';
import 'package:taesch/api/repository_holder.dart';
import 'package:taesch/middleware/log/logger_wrapper.dart';
import 'package:taesch/view/custom_widget/connection_alert.dart';
import 'package:taesch/view_model/page/starting_page_vm.dart';

abstract class StartingPage extends StatefulWidget {
  const StartingPage({super.key});
}

abstract class StartingPageState extends State<StartingPage> {
  late StartingPageVM vm;
  final formKey = GlobalKey<FormState>();
  LoggerWrapper logger = LoggerWrapper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      margin: const EdgeInsets.only(
        left: 40,
        right: 40,
      ),
      child: Form(
        key: formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 4),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: bodyElements(),
          ),
        ),
      ),
    ));
  }

  List<Widget> bodyElements();
}
