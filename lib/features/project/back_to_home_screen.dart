import 'package:flutter/material.dart';
import 'package:pmpconstractions/features/home_screen/screens/home.dart';

class BackToHomeScreen extends StatelessWidget {
  const BackToHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('the project not available'),
            ElevatedButton(
              onPressed: () => Navigator.of(context)
                  .pushReplacementNamed(HomeScreen.routeName),
              child: const Text('Back to home screen'),
            ),
          ],
        ),
      ),
    );
  }
}
