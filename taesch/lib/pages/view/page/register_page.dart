import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:taesch/model/error.dart';
import 'package:taesch/pages/view/page/home_page.dart';
import 'package:taesch/pages/view/page/starting_page.dart';
import 'package:taesch/pages/view_model/register_page_vm.dart';

class RegisterPage extends StartingPage {
  const RegisterPage({super.key});

  @override
  State<StatefulWidget> createState() => _RegisterPageState();
}

class _RegisterPageState extends StartingPageState {
  _RegisterPageState() {
    vm = RegisterPageVM();
  }

  @override
  List<Widget> bodyElements() {
    return [
      Text(
        (vm as RegisterPageVM).title,
        style: const TextStyle(
          fontSize: 40,
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        child: TextFormField(
          validator: (value) {
            return (vm as RegisterPageVM).validateUsername(value)?.message;
          },
          decoration: const InputDecoration(
            hintText: RegisterPageVM.usernameHint,
            border: OutlineInputBorder(),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        child: TextFormField(
          validator: (value) {
            return vm.validateEMail(value)?.message;
          },
          decoration: const InputDecoration(
            hintText: RegisterPageVM.emailHint,
            border: OutlineInputBorder(),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        child: TextFormField(
          obscureText: true,
          controller: (vm as RegisterPageVM).passwordController,
          validator: (value) {
            return vm.validatePassword(value)?.message;
          },
          decoration: const InputDecoration(
            hintText: RegisterPageVM.passwordHint,
            border: OutlineInputBorder(),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        child: TextFormField(
          obscureText: true,
          validator: (value) {
            return (vm as RegisterPageVM).validateSamePassword(value)?.message;
          },
          decoration: const InputDecoration(
            hintText: RegisterPageVM.passwordHint,
            border: OutlineInputBorder(),
          ),
        ),
      ),
      OutlinedButton(
        onPressed: () {
          if (formKey.currentState!.validate()) {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => HomePage()));
          }
        },
        child: Text((vm as RegisterPageVM).submitButtonText),
      ),
    ];
  }
}
