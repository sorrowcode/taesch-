import 'package:flutter/material.dart';
import 'package:taesch/model/error.dart';
import 'package:taesch/pages/view_model/starting_page_vm.dart';

class RegisterPageVM extends StartingPageVM {
  String title = "Register";
  static const usernameHint = "username";
  static const emailHint = "maxmustermann@mail.com";
  static const passwordHint = "Pa55w0rd";
  String submitButtonText = "Submit";
  final passwordController = TextEditingController();

  Error? validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return Error.noUsername;
    } else if (!RegExp(r"^.{3,15}.*$").hasMatch(value)) {
      return Error.invalidUsername;
    }
    return null;
  }

  Error? validateSamePassword(String? value) {
    if (value != passwordController.text) {
      return Error.notSamePassword;
    }
    return null;
  }
}
