import 'package:flutter/material.dart';
import 'package:taesch/model/error_case.dart';
import 'package:taesch/view_model/page/starting_page_vm.dart';

class RegisterPageVM extends StartingPageVM {
  String title = "Register";
  static const usernameHint = "username";
  static const emailHint = "email";
  static const passwordHint = "password";
  String submitButtonText = "Submit";
  final passwordController = TextEditingController();

  ErrorCase? validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return ErrorCase.noUsername;
    } else if (!RegExp(r"^.{3,15}.*$").hasMatch(value)) {
      return ErrorCase.invalidUsername;
    }
    return null;
  }

  ErrorCase? validateSamePassword(String? value) {
    if (value != passwordController.text) {
      return ErrorCase.notSamePassword;
    }
    return null;
  }
}
