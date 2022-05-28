import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:pmpconstractions/core/config/theme/theme.dart';

class WattingScreen extends StatelessWidget {
  const WattingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: darkBlue,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CircularProgressIndicator(
                color: orange,
              ),
              SizedBox(
                height: 80,
                child: AnimatedTextKit(
                  repeatForever: true,
                  animatedTexts: [
                    FadeAnimatedText('Just a moment'),
                    FadeAnimatedText('We setup everything to you'),
                    FadeAnimatedText('Almost done'),
                  ],
                ),
              )
            ]),
      ),
    );
  }
}
