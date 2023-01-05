import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:taesch/middleware/log/log_level.dart';
import 'package:taesch/model/error_case.dart';
import 'package:taesch/model/log_message.dart';
import 'package:taesch/model/widget_key.dart';
import 'package:taesch/view/page/register_page.dart';
import 'package:taesch/view/page/splash_page.dart';
import 'package:taesch/view/page/starting_page.dart';
import 'package:taesch/view_model/page/login_page_vm.dart';

import '../../api/connectivity_provider.dart';

class LoginPage extends StartingPage {
  const LoginPage({super.key});

  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends StartingPageState {
  ConnectivityProvider connectivityProvider = ConnectivityProvider();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  _LoginPageState() {
    vm = LoginPageVM();
    (vm as LoginPageVM).connection.addListener(() {
      if(!(vm as LoginPageVM).connection.isOnline){
        setState(() {
          (vm as LoginPageVM).isOnline = false;
          (vm as LoginPageVM).showAlertDialog(context);
        });
      } else {
        setState(() {
          (vm as LoginPageVM).isOnline = true;
        });
      }
    });
  }

  @override
  List<Widget> bodyElements() {
    logger.log(
        level: LogLevel.info,
        logMessage: LogMessage(message: "entered login page"));
    return [
      Container(
        margin:
            EdgeInsets.only(bottom: MediaQuery.of(context).size.height / 30),
        child: Text(
          (vm as LoginPageVM).title,
          style: Theme.of(context).textTheme.displayMedium,
        ),
      ),
      (vm as LoginPageVM).isOnline ?
        const SizedBox.shrink()
          :
        Text((vm as LoginPageVM).notOnlineString ,style: TextStyle(color: Theme.of(context).errorColor)),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        child: TextFormField(
          //initialValue: "test@test.de",
          controller: _emailController,
          enabled: (vm as LoginPageVM).isOnline,
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
          //initialValue: "123TesT§",
          controller: _passwordController,
          enabled: (vm as LoginPageVM).isOnline,
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
              disabledBackgroundColor: Theme.of(context).disabledColor
            ),
            key: Key(WidgetKey.registrationButtonKey.text),
            onPressed: !(vm as LoginPageVM).isOnline? null: () {
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
              style: Theme.of(context).textTheme.labelLarge,
              (vm as LoginPageVM).registrationButtonText,
            ),
          ),
          TextButton(
            style: OutlinedButton.styleFrom(
              disabledBackgroundColor: Theme.of(context).disabledColor
            ),
            key: Key(WidgetKey.loginButtonKey.text),
            onPressed: !(vm as LoginPageVM).isOnline? null: () async {
              logger.log(
                  level: LogLevel.info,
                  logMessage: LogMessage(
                      message:
                          "${(vm as LoginPageVM).loginButtonText} button pressed"));
              if (formKey.currentState!.validate()) {
                logger.log(
                    level: LogLevel.debug,
                    logMessage: LogMessage(message: "form valid"));
                try {
                  FirebaseAuth.instance
                      .signInWithEmailAndPassword(
                          email: _emailController.text,
                          password: _passwordController.text)
                      .then((value) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SplashPage()));
                  });
                } on FirebaseException catch (_, e) {
                  logger.log(level: LogLevel.error, logMessage: LogMessage(
                    message: "$e"
                  ));
                  await showDialog(
                      context: context,
                      builder: (context) => const AlertDialog(
                            title: Text("wrong credentials"),
                            content:
                                Text("your email or your password are invalid"),
                          ));
                }
              } else {
                logger.log(
                    level: LogLevel.debug,
                    logMessage: LogMessage(message: "invalid form"));
              }
            },
            child: Text(
              style: Theme.of(context).textTheme.labelLarge,
              (vm as LoginPageVM).loginButtonText,
            ),
          )
        ],
      ),
    ];
  }
}
