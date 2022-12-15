import 'package:flutter/material.dart';
import 'package:taesch/view/custom_widget/connection_alert.dart';
import 'package:taesch/view_model/page/starting_page_vm.dart';

import '../../api/connectivity_provider.dart';

class LoginPageVM extends StartingPageVM {
  String title = "Login";
  static const String emailHint = "email";
  static const String passwordHint = "password";
  String registrationButtonText = "Register";
  String loginButtonText = "Login";
  String notOnlineString = 'enable Network connection to use this app';
  var connection = ConnectivityProvider();
  bool isOnline = false;

  showAlertDialog(BuildContext context){
    showDialog(context: context, builder: (BuildContext context)=>ConnectionAlert());
  }
}
