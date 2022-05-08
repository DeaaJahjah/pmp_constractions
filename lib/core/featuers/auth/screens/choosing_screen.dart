import 'package:flutter/material.dart';
import 'package:pmpconstractions/core/config/constants/constant.dart';
import 'package:pmpconstractions/core/widgets/radio_button_custom.dart';

class ChoosingScreen extends StatelessWidget {
  static const routeName = '/t';

  const ChoosingScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Choose one'),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Image.asset(
            'assets/images/chose_one.png',
            fit: BoxFit.fill,
          ),
          sizedBoxLarge,
          const CustomRadioButton(),
          sizedBoxMedium,
          ElevatedButton(
            onPressed: () {},
            child: Text(
              'NEXT',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          )
        ]),
      ),
    );
  }
}
