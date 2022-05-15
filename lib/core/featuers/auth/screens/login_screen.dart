import 'package:flutter/material.dart';

import 'package:pmpconstractions/core/config/constants/constant.dart';
import 'package:pmpconstractions/core/config/theme/theme.dart';
import 'package:pmpconstractions/core/featuers/auth/screens/signup_screen.dart';
import 'package:pmpconstractions/core/featuers/auth/services/authentication_service.dart';
import 'package:pmpconstractions/core/widgets/custom_text_field.dart';
import 'package:provider/provider.dart';

class LogInScreen extends StatefulWidget {
  static const routeName = '/log_in';
  const LogInScreen({Key? key}) : super(key: key);

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(children: [
          Stack(
            children: [
              Image.asset(
                'assets/images/img.png',
                fit: BoxFit.fill,
              ),
              Positioned(
                top: 390,
                left: 10,
                child: Text(
                  'LOGIN',
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
              ),
            ],
          ),
          sizedBoxMedium,
          TextFieldCustome(
            controller: emailController,
            text: 'Enter email',
          ),
          sizedBoxMedium,
          TextFieldCustome(
            controller: passwordController,
            text: 'Enter password',
          ),
          sizedBoxMedium,
          ElevatedButton(
              onPressed: () {
                Provider.of<FlutterFireAuthService>(context, listen: false)
                    .signIn(
                        email: emailController.text,
                        password: passwordController.text,
                        context: context);
              },
              child: Text(
                'LOGIN',
                style: Theme.of(context).textTheme.headlineSmall,
              )),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "If you don't have an account ",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              TextButton(
                style: const ButtonStyle(),
                child: const Text('Sign Up',
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        decorationStyle: TextDecorationStyle.solid,
                        color: karmedi,
                        fontFamily: font,
                        fontSize: 18,
                        fontWeight: FontWeight.normal)),
                onPressed: () {
                  Navigator.of(context).pushNamed(SignUpScreen.routeName);
                },
              ),
            ],
          )
        ]),
      ),
    );
  }
}
