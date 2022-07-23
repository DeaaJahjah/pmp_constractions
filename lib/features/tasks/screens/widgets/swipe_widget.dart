import 'package:action_slider/action_slider.dart';
import 'package:flutter/material.dart';
import 'package:pmpconstractions/core/config/theme/theme.dart';

class SwipeWidget extends StatelessWidget {
  String text;
  dynamic Function(ActionSliderController)? onSlide;
  SwipeWidget({Key? key, required this.onSlide, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: ActionSlider.standard(
            sliderBehavior: SliderBehavior.stretch,
            rolling: true,
            width: 300.0,
            height: 54,
            child: Text(text, style: Theme.of(context).textTheme.bodyMedium),
            backgroundColor: beg.withOpacity(0.25),
            toggleColor: orange,
            iconAlignment: Alignment.centerRight,
            loadingIcon: const SizedBox(
                width: 50,
                child: Center(
                    child: SizedBox(
                  width: 24.0,
                  height: 24.0,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.0,
                    color: beg,
                  ),
                ))),
            successIcon: const SizedBox(
                width: 50, child: Center(child: Icon(Icons.check_rounded))),
            icon: const SizedBox(
              width: 50,
              child: Center(child: Icon(Icons.send)),
            ),
            onSlide: onSlide),
      ),
    );
  }
}
