import 'package:flutter/material.dart';
import 'package:pmpconstractions/core/config/constants/constant.dart';
import 'package:pmpconstractions/core/featuers/auth/services/authentication_service.dart';
import 'package:pmpconstractions/core/widgets/custom_text_field.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  static const routeName = '/sign_up';
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          centerTitle: true,
          title: const Text('Sign up'),
        ),
        body: SingleChildScrollView(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Image.asset(
              'assets/images/signup.png',
              fit: BoxFit.fill,
            ),
            sizedBoxXLarge,
            TextFieldCustome(
              controller: emailController,
              text: 'Email',
            ),
            sizedBoxMedium,
            TextFieldCustome(
              controller: passwordController,
              text: 'Password',
            ),
            sizedBoxLarge,
            ElevatedButton(
                onPressed: () {
                  Provider.of<FlutterFireAuthService>(context, listen: false)
                      .signUp(
                          email: emailController.text,
                          password: passwordController.text,
                          context: context);
                },
                child: Text(
                  'SIGNUP',
                  style: Theme.of(context).textTheme.headlineSmall,
                )),
          ]),
        ));
  }
}
