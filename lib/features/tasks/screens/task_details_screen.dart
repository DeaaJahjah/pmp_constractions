import 'package:action_slider/action_slider.dart';
import 'package:flutter/material.dart';
import 'package:pmpconstractions/core/config/theme/theme.dart';
import 'package:pmpconstractions/features/tasks/models/task.dart';

class TaskDetailsScreen extends StatefulWidget {
  static const String routeName = '/task_details';
  Task? task;
  TaskDetailsScreen({Key? key, this.task}) : super(key: key);

  @override
  State<TaskDetailsScreen> createState() => _TaskDetailsScreenState();
}

class _TaskDetailsScreenState extends State<TaskDetailsScreen> {
  final _controller = ActionSliderController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(widget.task!.title), elevation: 0.0),
        backgroundColor: darkBlue,
        body: Column(
            //padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            children: [
              Text(widget.task!.description),
              ActionSlider.standard(
                sliderBehavior: SliderBehavior.stretch,
                rolling: true,
                width: 300.0,
                child: Text('Swipe to Submit',
                    style: Theme.of(context).textTheme.bodySmall),
                backgroundColor: Colors.white,
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
                onSlide: (controller) async {
                  controller.loading(); //starts loading animation
                  await Future.delayed(const Duration(seconds: 3));
                  controller.success(); //starts success animation
                  await Future.delayed(const Duration(seconds: 1));
                  controller.reset(); //resets the slider
                },
              ),
            ]));
  }
}
