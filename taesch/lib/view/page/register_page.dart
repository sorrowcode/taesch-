import 'package:flutter/material.dart';
import 'package:taesch/middleware/log/log_level.dart';
import 'package:taesch/model/error_case.dart';
import 'package:taesch/model/log_message.dart';
import 'package:taesch/model/widget_key.dart';
import 'package:taesch/view/page/splash_page.dart';
import 'package:taesch/view/page/starting_page.dart';
import 'package:taesch/view_model/page/register_page_vm.dart';

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
    logger.log(level: LogLevel.info, logMessage: LogMessage(
        message: "entered register page"
    ));
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
          key: Key(WidgetKey.usernameRegisterKey.text),
          validator: (value) {
            logger.log(level: LogLevel.debug, logMessage: LogMessage(
                message: "username validation: ${(vm as RegisterPageVM).validateUsername(value)?.message}"
            ));
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
          key: Key(WidgetKey.emailRegisterKey.text),
          validator: (value) {
            logger.log(level: LogLevel.debug, logMessage: LogMessage(
                message: "email validation: ${vm.validateEMail(value)?.message}"
            ));
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
          key: Key(WidgetKey.firstPasswordRegisterKey.text),
          obscureText: true,
          controller: (vm as RegisterPageVM).passwordController,
          validator: (value) {
            logger.log(level: LogLevel.debug, logMessage: LogMessage(
                message: "password validation: ${vm.validatePassword(value)?.message}"
            ));
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
          key: Key(WidgetKey.secondPasswordRegisterKey.text),
          obscureText: true,
          validator: (value) {
            logger.log(level: LogLevel.debug, logMessage: LogMessage(
                message: "password comparison validation: ${(vm as RegisterPageVM).validateSamePassword(value)?.message}"
            ));
            return (vm as RegisterPageVM).validateSamePassword(value)?.message;
          },
          decoration: const InputDecoration(
            hintText: RegisterPageVM.passwordHint,
            border: OutlineInputBorder(),
          ),
        ),
      ),
      OutlinedButton(
        key: Key(WidgetKey.submitButtonKey.text),
        onPressed: () {
          logger.log(level: LogLevel.info, logMessage: LogMessage(
              message: "${(vm as RegisterPageVM).submitButtonText} pressed"
          ));
          if (formKey.currentState!.validate()) {
            logger.log(level: LogLevel.debug, logMessage: LogMessage(
                message: "form valid"
            ));
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const SplashPage()));
          } else {
            logger.log(level: LogLevel.debug, logMessage: LogMessage(
                message: "invalid form"
            ));
          }
        },
        child: Text((vm as RegisterPageVM).submitButtonText),
      ),
    ];
  }
}
