import 'package:flutter/cupertino.dart';
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
  var connection = ConnectivityProvider();

  showAlertDialog(BuildContext context){
    showDialog(context: context, builder: (BuildContext context)=>ConnectionAlert());
  }
}
