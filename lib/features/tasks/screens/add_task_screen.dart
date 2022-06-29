import 'package:flutter/material.dart';
import 'package:pmpconstractions/core/config/constants/constant.dart';
import 'package:pmpconstractions/core/config/enums/enums.dart';
import 'package:pmpconstractions/core/config/theme/theme.dart';
import 'package:pmpconstractions/core/extensions/loc.dart';
import 'package:pmpconstractions/core/widgets/custom_text_field.dart';
import 'package:pmpconstractions/features/tasks/screens/widgets/date_picker.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class AddTaskScreen extends StatefulWidget {
  static const String routeName = '/add-task';
  const AddTaskScreen({Key? key}) : super(key: key);

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  var nameController = TextEditingController();
  var descController = TextEditingController();
  DateRangePickerController dateController = DateRangePickerController();
  TaskState taskState = TaskState.notStarted;
  List<TaskState> taskStates = TaskState.values;
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(context.loc.add_task),
          centerTitle: true,
          elevation: 0,
        ),
        body: ListView(
          padding: const EdgeInsets.only(top: 20),
          children: [
            TextFieldCustome(
              controller: nameController,
              text: context.loc.name,
            ),
            sizedBoxMedium,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: TextFormField(
                controller: descController,
                maxLines: 4,
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: const EdgeInsets.all(14),
                  label: Text(context.loc.descripton,
                      style: Theme.of(context).textTheme.bodySmall),
                  alignLabelWithHint: true,
                ),
                textAlign: TextAlign.start,
                autofocus: false,
              ),
            ),
            sizedBoxMedium,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Expanded(
                flex: 1,
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Text(context.loc.state,
                          style: Theme.of(context).textTheme.bodySmall),
                    ),
                    Expanded(
                      flex: 3,
                      child: FormField<TaskState>(
                        builder: (FormFieldState<TaskState> state) {
                          return InputDecorator(
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    gapPadding: 4,
                                    borderRadius: BorderRadius.circular(5.0))),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<TaskState>(
                                dropdownColor: beg,
                                elevation: 10,
                                iconEnabledColor: orange,
                                style: const TextStyle(
                                    color: orange,
                                    fontFamily: font,
                                    fontWeight: FontWeight.bold),
                                alignment: AlignmentDirectional.center,
                                focusColor: orange,
                                value: taskState,
                                isDense: true,
                                onChanged: (TaskState? newValue) {
                                  setState(() {
                                    taskState = newValue!;
                                  });
                                },
                                items: taskStates.map((TaskState state) {
                                  return DropdownMenuItem<TaskState>(
                                    value: state,
                                    child: Text(state.name),
                                  );
                                }).toList(),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            sizedBoxMedium,
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                children: [
                  Text(context.loc.start_point,
                      style: Theme.of(context).textTheme.bodySmall),
                  const SizedBox(width: 10),
                  Text('${startDate.year}-${startDate.month}-${startDate.day}',
                      style: Theme.of(context).textTheme.headlineSmall),
                  IconButton(
                    icon: const Icon(
                      Icons.calendar_today,
                      color: beg,
                    ),
                    onPressed: () async {
                      DateTime? newDate = await pickDate(context);
                      if (newDate != null) {
                        setState(() {
                          startDate = newDate;
                        });
                      }
                      const Text('pick date');
                    },
                  ),
                ],
              ),
            ),
            sizedBoxMedium,
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                children: [
                  Text(context.loc.end_point,
                      style: Theme.of(context).textTheme.bodySmall),
                  const SizedBox(width: 10),
                  Text('${endDate.year}-${endDate.month}-${endDate.day}',
                      style: Theme.of(context).textTheme.headlineSmall),
                  IconButton(
                    icon: const Icon(
                      Icons.calendar_today,
                      color: beg,
                    ),
                    onPressed: () async {
                      DateTime? newDate = await pickDate(context);
                      if (newDate != null) {
                        setState(() {
                          endDate = newDate;
                        });
                      }
                      const Text('pick date');
                    },
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
