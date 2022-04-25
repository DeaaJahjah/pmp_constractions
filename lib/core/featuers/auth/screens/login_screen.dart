import 'package:flutter/material.dart';

import 'package:pmpconstractions/core/config/constants/constant.dart';
import 'package:pmpconstractions/core/config/theme/theme.dart';
import 'package:pmpconstractions/core/widgets/custom_text_field.dart';

class LogInScreen extends StatelessWidget {
  static const routeName = '/g';
  const LogInScreen({Key? key}) : super(key: key);

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
            text: 'Enter email',
            onSaved: (email) {},
          ),
          sizedBoxMedium,
          TextFieldCustome(
            text: 'Enter password',
            onSaved: (password) {},
          ),
          sizedBoxMedium,
          ElevatedButton(
              onPressed: () {},
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
                onPressed: () {},
              ),
            ],
          )
        ]),
      ),
    );
  }
}
