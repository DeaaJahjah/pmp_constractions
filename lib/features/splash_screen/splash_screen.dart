import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pmpconstractions/features/settings/settings_screen.dart';


class SplashScreen extends StatefulWidget {
  static const routeName = '/t';
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;


  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(
        seconds: 3,
      ),
      value: 0.1,
    )..repeat(reverse: false, max: 1);

    _animation =
        CurvedAnimation(parent: _animationController, curve: Curves.bounceIn);
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.stop();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Timer(
        const Duration(
          milliseconds: 3000,
        ), () {
      _animationController.stop();
      Navigator.of(context).pushReplacementNamed(SettingsScreen.routeName);
    });
    return Scaffold(
      body: Center(
        child: ScaleTransition(
          scale: _animation,
          alignment: Alignment.center,
          child: const Image(
            image: AssetImage('assets/images/final_logo.png'),
            width: 200,
            height: 200,
          ),
        ),
      ),
    );
  }
}