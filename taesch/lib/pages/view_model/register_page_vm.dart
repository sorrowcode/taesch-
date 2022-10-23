import 'package:flutter/cupertino.dart';
import 'package:taesch/pages/view_model/starting_page_vm.dart';

class RegisterPageVM extends StartingPageVM {
  String title = "Register";
  static const usernameHint = "username";
  static const emailHint = "maxmustermann@mail.com";
  static const passwordHint = "Pa55w0rd";
  String submitButtonText = "Submit";
  final passwordController = TextEditingController();

  Error? validateUsername(String? value) {
    return null;
  }

  Error? validateSamePassword(String? value) {
    return null;
  }
}
