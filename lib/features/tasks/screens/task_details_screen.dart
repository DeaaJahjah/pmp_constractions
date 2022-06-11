import 'package:action_slider/action_slider.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:pmpconstractions/core/config/enums/enums.dart';
import 'package:pmpconstractions/core/config/theme/theme.dart';
import 'package:pmpconstractions/features/tasks/models/task.dart';
import 'package:pmpconstractions/features/tasks/screens/widgets/contributer_card.dart';

class TaskDetailsScreen extends StatefulWidget {
  static const String routeName = '/task_details';
  Task? task;
  TaskDetailsScreen({Key? key, this.task}) : super(key: key);

  @override
  State<TaskDetailsScreen> createState() => _TaskDetailsScreenState();
}

class _TaskDetailsScreenState extends State<TaskDetailsScreen> {
  final _controller = ActionSliderController();
  ScrollController scrollController = ScrollController();
  String state = '';
  getState(TaskState taskState) {
    switch (taskState) {
      case TaskState.notStarted:
        state = 'NOT-STARTED';
        break;
      case TaskState.inProgress:
        state = 'IN-PROGRESS';
        break;
      case TaskState.completed:
        state = 'COMPLETED';
        break;
    }
  }

  @override
  void initState() {
    getState(widget.task!.taskState);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(widget.task!.title), elevation: 0.0, centerTitle: true),
        backgroundColor: darkBlue,
        body: Stack(
          children: [
            ListView(controller: scrollController,
             children: [
              Container(
                  alignment: Alignment.center,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 130, vertical: 10),
                  decoration: BoxDecoration(
                      color: beg.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(12)),
                  child: Text(state)),

              Container(
                decoration: BoxDecoration(
                    color: orange, borderRadius: BorderRadius.circular(10)),
                padding: const EdgeInsets.all(15),
                margin:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'START POINT',
                            style: TextStyle(
                                color: darkBlue, fontWeight: FontWeight.w800),
                          ),
                          Text(
                            widget.task!.getStartPoint(),
                            style: Theme.of(context).textTheme.headlineSmall,
                          )
                        ],
                      ),
                      Container(
                        height: 40,
                        width: 2,
                        color: darkBlue,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            '  END POINT',
                            style: TextStyle(
                                color: darkBlue, fontWeight: FontWeight.w800),
                          ),
                          Text(
                            "  ${widget.task!.getStartPoint()}",
                            style: Theme.of(context).textTheme.headlineSmall,
                          )
                        ],
                      ),
                    ]),
              ),

              Container(
                margin: const EdgeInsets.all(40),
                child: CircularPercentIndicator(
                  radius: 45,
                  footer: const Text('Completed'),
                  percent: widget.task!.getProgressValue(),
                  center: Text(
                    "${widget.task!.getProgressValue() * 100} %",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  lineWidth: 8,
                  backgroundColor: orange.withOpacity(0.2),
                  animation: true,
                  animationDuration: 300,
                  curve: Curves.easeInCirc,
                  progressColor: orange,
                ),
              ),

              //description
              Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 4,
                          height: 20,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: orange,
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text('Description',
                            style: Theme.of(context).textTheme.headlineMedium),
                      ],
                    ),
                    Text(widget.task!.description),
                  ],
                ),
              ),
              customText(text: 'Attchment'),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'water diagram.dxf',
                    style: TextStyle(
                        fontFamily: font, color: white.withOpacity(0.3)),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text('DOWNLOAD',
                        style: Theme.of(context).textTheme.headlineMedium),
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(karmedi)),
                  )
                ],
              ),
              customText(text: 'Contributers'),
              SizedBox(
                height: 300,
                child: GridView.builder(
                  controller: scrollController,
                  itemCount: widget.task!.members!.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 1,
                      crossAxisSpacing: 2,
                      childAspectRatio: 1.5),
                  itemBuilder: (BuildContext context, int index) {
                    return ContributerCard(
                        member: widget.task!.members![index]);
                  },
                ),
              )
            ]),
            Positioned(
              bottom: 15.0,
              left: 50,
              child: ActionSlider.standard(
                sliderBehavior: SliderBehavior.stretch,
                rolling: true,
                width: 300.0,
                height: 54,
                child: Text('Swipe to submit',
                    style: Theme.of(context).textTheme.bodyMedium),
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
                onSlide: (controller) async {
                  controller.loading(); //starts loading animation
                  await Future.delayed(const Duration(seconds: 3));
                  controller.success(); //starts success animation
                  await Future.delayed(const Duration(seconds: 1));
                  controller.reset();
                  //resets the slider
                },
              ),
            )
          ],
        ));
  }

  customText({required String text}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 4,
                height: 20,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: orange,
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Text(text, style: Theme.of(context).textTheme.headlineMedium),
            ],
          ),
        ],
      ),
    );
  }
}
