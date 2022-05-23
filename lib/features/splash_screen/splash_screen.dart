import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pmpconstractions/core/featuers/auth/screens/login_screen.dart';
import 'package:pmpconstractions/features/home_screen/providers/data_provider.dart';
import 'package:pmpconstractions/features/home_screen/screens/home.dart';
import 'package:pmpconstractions/features/home_screen/services/project_db_service.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = '/h';
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
    final user = FirebaseAuth.instance.currentUser;
    ProjectDbService().getOpenProjects(['21sFqVCd5qwcwtYWTO02']);
    //fetch Data form database
    Provider.of<DataProvider>(context, listen: false).fetchData();

    Timer(
        const Duration(
          milliseconds: 3000,
        ), () {
      _animationController.stop();
      if (user != null) {
        print(user.displayName);

        Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
      } else {
        Navigator.of(context).pushReplacementNamed(LogInScreen.routeName);
      }
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
