import 'package:flutter/material.dart';
import 'package:taesch/model/error_case.dart';
import 'package:taesch/model/widget_key.dart';
import 'package:taesch/view/page/register_page.dart';
import 'package:taesch/view/page/splash_page.dart';
import 'package:taesch/view/page/starting_page.dart';
import 'package:taesch/view_model/page/login_page_vm.dart';

class LoginPage extends StartingPage {
  const LoginPage({super.key});

  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends StartingPageState {
  _LoginPageState() {
    vm = LoginPageVM();
  }

  @override
  List<Widget> bodyElements() {
    return [
      Text(
        (vm as LoginPageVM).title,
        style: const TextStyle(
          fontSize: 40,
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        child: TextFormField(
          initialValue: "test@test.de",
          key: Key(WidgetKey.emailLoginKey.text),
          validator: (value) {
            return vm.validateEMail(value)?.message;
          },
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        child: TextFormField(
          initialValue: "123TesT§",
          key: Key(WidgetKey.passwordLoginKey.text),
          obscureText: true,
          validator: (value) {
            return vm.validatePassword(value)?.message;
          },
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
          ),
        ),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          TextButton(
            style: OutlinedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.primary,
            ),
            key: Key(WidgetKey.registrationButtonKey.text),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const RegisterPage()),
              );
            },
            child: Text(
              (vm as LoginPageVM).registrationButtonText,
              style: Theme.of(context).textTheme.button,
            ),
          ),
          TextButton(
            style: OutlinedButton.styleFrom(
              backgroundColor:
                  Theme.of(context).buttonTheme.colorScheme?.primary,
            ),
            key: Key(WidgetKey.loginButtonKey.text),
            onPressed: () {
              if (formKey.currentState!.validate()) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SplashPage()));
              }
            },
            child: Text(
              (vm as LoginPageVM).loginButtonText,
              style: Theme.of(context).textTheme.button,
            ),
          )
        ],
      ),
    ];
  }
}
