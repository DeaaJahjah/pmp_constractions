import 'package:flutter/material.dart';
import 'package:pmpconstractions/core/config/constants/constant.dart';
import 'package:pmpconstractions/core/widgets/custom_text_field.dart';

class SignUpScreen extends StatelessWidget {
  static const routeName = '/l';
  const SignUpScreen({Key? key}) : super(key: key);

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
            TextFieldCustome(text: 'Name', onSaved: (name) {}),
            sizedBoxMedium,
            TextFieldCustome(text: 'Email', onSaved: (email) {}),
            sizedBoxMedium,
            TextFieldCustome(text: 'Password', onSaved: (password) {}),
            sizedBoxLarge,
            ElevatedButton(
                onPressed: () {},
                child: Text(
                  'SIGNUP',
                  style: Theme.of(context).textTheme.headlineSmall,
                )),
          ]),
        ));
  }
}
