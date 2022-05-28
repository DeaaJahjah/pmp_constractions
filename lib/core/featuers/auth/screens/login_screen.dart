import 'package:flutter/material.dart';

import 'package:pmpconstractions/core/config/constants/constant.dart';
import 'package:pmpconstractions/core/config/enums/enums.dart';
import 'package:pmpconstractions/core/config/theme/theme.dart';
import 'package:pmpconstractions/core/featuers/auth/providers/auth_state_provider.dart';
import 'package:pmpconstractions/core/featuers/auth/screens/signup_screen.dart';
import 'package:pmpconstractions/core/extensions/loc.dart';
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
    return ChangeNotifierProvider<AuthSataProvider>(
      create: (context) => AuthSataProvider(),
      child: Scaffold(
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
                    context.loc.login,
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                ),
              ],
            ),
            sizedBoxMedium,
            TextFieldCustome(
              controller: emailController,
              text: context.loc.email,
            ),
            sizedBoxMedium,
            TextFieldCustome(
              controller: passwordController,
              text: context.loc.password,
            ),
            sizedBoxMedium,
            Consumer<AuthSataProvider>(
                builder: (context, state, child) => (state.authState ==
                        AuthState.notSet)
                    ? ElevatedButton(
                        onPressed: () {
                          if (emailController.text.isNotEmpty &&
                              passwordController.text.isNotEmpty) {
                            Provider.of<FlutterFireAuthService>(context,
                                    listen: false)
                                .signIn(
                                    email: emailController.text,
                                    password: passwordController.text,
                                    context: context);
                          } else {
                            final snakBar = const SnackBar(
                                content:
                                    Text('Please enter email and password'));
                            ScaffoldMessenger.of(context).showSnackBar(snakBar);
                          }
                        },
                        child: Text(
                          context.loc.login_btn,
                          style: Theme.of(context).textTheme.headlineSmall,
                        ))
                    : const CircularProgressIndicator()),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  context.loc.dont_have_account,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                TextButton(
                  style: const ButtonStyle(),
                  child: Text(context.loc.signup,
                      style: const TextStyle(
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
      ),
    );
  }
}
