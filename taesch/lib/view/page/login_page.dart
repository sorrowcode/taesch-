import 'package:flutter/material.dart';
import 'package:taesch/api/actions/firebase_actions.dart';
import 'package:taesch/api/implementation/ping.dart';
import 'package:taesch/api/repositories/ping_repository.dart';
import 'package:taesch/api/repositories/repository_type.dart';
import 'package:taesch/api/repository_holder.dart';
import 'package:taesch/exceptions/custom/login_exception.dart';
import 'package:taesch/middleware/log/log_level.dart';
import 'package:taesch/model/error_case.dart';
import 'package:taesch/model/log_message.dart';
import 'package:taesch/model/widget_key.dart';
import 'package:taesch/view/custom_widget/connection_alert.dart';
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
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  _LoginPageState() {
    vm = LoginPageVM();
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
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        child: TextFormField(
          //initialValue: "test@test.de",
          controller: _emailController,
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
              style: Theme.of(context).textTheme.labelLarge,
              (vm as LoginPageVM).registrationButtonText,
            ),
          ),
          TextButton(
            //style: OutlinedButton.styleFrom(),
            key: Key(WidgetKey.loginButtonKey.text),
            onPressed: () async {
              logger.log(
                  level: LogLevel.info,
                  logMessage: LogMessage(
                      message:
                          "${(vm as LoginPageVM).loginButtonText} button pressed"));
              if (formKey.currentState!.validate()) {
                logger.log(
                    level: LogLevel.debug,
                    logMessage: LogMessage(message: "form valid"));
                if (((RepositoryHolder().getRepositoryByType(RepositoryType.ping) as PingRepository).pingActions as Ping).isOnline) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) => ConnectionAlert(),
                  );
                } else {
                  try {
                    await (RepositoryHolder()
                        .getRepositoryByType(RepositoryType.firebase)
                        ?.actions as FirebaseActions)
                        .login(
                        email: _emailController.text,
                        password: _passwordController.text)
                        .then((value) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SplashPage()));
                    });
                  } on LoginException {
                    await showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          actions: [
                            IconButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                icon: const Icon(Icons.close))
                          ],
                          title: const Text(
                            "wrong credentials",
                            style: TextStyle(
                              color: Colors.red,
                            ),
                          ),
                          content: const Text(
                              "your email or your password are invalid"),
                        ));
                  }
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
