import 'package:flutter/material.dart';
import 'package:taesch/middleware/log/log_level.dart';
import 'package:taesch/model/error_case.dart';
import 'package:taesch/model/log_message.dart';
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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      (vm as LoginPageVM).connection.addListener(() {
        if(!(vm as LoginPageVM).connection.isOnline){
          (vm as LoginPageVM).showAlertDialog(context);
        }
      });
    });
  }

  @override
  List<Widget> bodyElements() {

    logger.log(
        level: LogLevel.info,
        logMessage: LogMessage(message: "entered login page"));
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
            logger.log(
                level: LogLevel.debug,
                logMessage: LogMessage(
                    message:
                        "email validation: ${vm.validateEMail(value)?.message}"));
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
            logger.log(
                level: LogLevel.debug,
                logMessage: LogMessage(
                    message:
                        "password validation: ${vm.validatePassword(value)?.message}"));
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
              logger.log(
                  level: LogLevel.info,
                  logMessage: LogMessage(
                      message:
                          "${(vm as LoginPageVM).registrationButtonText} button pressed"));
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
              logger.log(
                  level: LogLevel.info,
                  logMessage: LogMessage(
                      message:
                          "${(vm as LoginPageVM).loginButtonText} button pressed"));
              if (formKey.currentState!.validate()) {
                logger.log(
                    level: LogLevel.debug,
                    logMessage: LogMessage(message: "form valid"));
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SplashPage()));
              } else {
                logger.log(
                    level: LogLevel.debug,
                    logMessage: LogMessage(message: "invalid form"));
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
