import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:pmpconstractions/core/config/constants/constant.dart';
import 'package:pmpconstractions/core/config/enums/enums.dart';
import 'package:pmpconstractions/core/config/theme/theme.dart';
import 'package:pmpconstractions/core/extensions/loc.dart';
import 'package:pmpconstractions/core/featuers/auth/providers/auth_state_provider.dart';
import 'package:pmpconstractions/core/featuers/auth/services/file_service.dart';
import 'package:pmpconstractions/core/widgets/custom_snackbar.dart';
import 'package:pmpconstractions/core/widgets/custom_text_field.dart';
import 'package:pmpconstractions/core/widgets/phone_card.dart';
import 'package:pmpconstractions/features/home_screen/models/project.dart';
import 'package:pmpconstractions/features/home_screen/screens/widgets/member_card.dart';
import 'package:pmpconstractions/features/tasks/models/task.dart';
import 'package:pmpconstractions/features/tasks/providers/selected_project_provider.dart';
import 'package:pmpconstractions/features/tasks/screens/widgets/date_picker.dart';
import 'package:pmpconstractions/features/tasks/screens/widgets/search_dropdown.dart';
import 'package:pmpconstractions/features/tasks/services/tasks_db_service.dart';
import 'package:provider/provider.dart';
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
  MemberRole? selectedItem;
  List<MemberRole> selectedMembers = [];
  File? attchmentFile;
  String? attchmentName;
  bool checkByManager = false;
  ScrollController scrollController = ScrollController();
  _pickFile() async {
    try {
      FilePickerResult? result =
          await FilePicker.platform.pickFiles(type: FileType.any);
      print(result);
      if (result != null) {
        attchmentFile = File(result.files.single.path!);
        attchmentName = result.files.first.name;
        setState(() {});
        print(attchmentFile);
      } else {
        // User canceled the picker
        // attchmentFile = null;
        // attchmentName = null;
      }
    } catch (e) {
      print(e);
    }
  }

  Project? project;
  @override
  void initState() {
    project =
        Provider.of<SelectedProjectProvider>(context, listen: false).project;
    selectedItem = project!.members!.first;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var members = project!.members;
    selectedItem = (members!.isNotEmpty) ? members.first : null;
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
            sizedBoxMedium,
            Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(context.loc.start_point,
                          style: Theme.of(context).textTheme.bodySmall),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const SizedBox(width: 10),
                          Text(
                              '${startDate.year}-${startDate.month}-${startDate.day}',
                              style: Theme.of(context).textTheme.headlineSmall),
                          IconButton(
                            icon: const Icon(
                              Icons.calendar_today,
                              color: beg,
                            ),
                            onPressed: () async {
                              DateTime? newDate = await pickDate(context);
                              if (newDate != null) {
                                if (newDate.isBefore(endDate)) {
                                  setState(() {
                                    startDate = newDate;
                                  });
                                } else {
                                  showErrorSnackBar(context,
                                      'Start date must be before end date');
                                }
                              }

                              const Text('pick date');
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(context.loc.end_point,
                          style: Theme.of(context).textTheme.bodySmall),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const SizedBox(width: 10),
                          Text(
                              '${endDate.year}-${endDate.month}-${endDate.day}',
                              style: Theme.of(context).textTheme.headlineSmall),
                          IconButton(
                            icon: const Icon(
                              Icons.calendar_today,
                              color: beg,
                            ),
                            onPressed: () async {
                              DateTime? newDate = await pickDate(context);
                              if (newDate != null) {
                                if (newDate.isAfter(startDate)) {
                                  setState(() {
                                    endDate = newDate;
                                  });
                                } else {
                                  showErrorSnackBar(context,
                                      'End date must be after start date');
                                }
                              }
                              const Text('pick date');
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            sizedBoxMedium,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                children: [
                  Expanded(
                      child: Text('Assigned to',
                          style: Theme.of(context).textTheme.bodySmall)),
                  Expanded(
                      flex: 2,
                      child: SearchDropDown(
                          members: project!.members!,
                          selectedItem: selectedItem,
                          onChanged: (member) {
                            selectedItem = member;
                            if (selectedItem != null) {
                              setState(() {
                                selectedMembers.add(selectedItem!);
                                members.remove(selectedItem);
                              });
                            }
                          })),
                  const SizedBox(width: 10),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 30),
              constraints: const BoxConstraints(
                maxHeight: double.infinity,
              ),
              child: ListView.builder(
                  shrinkWrap: true,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  controller: scrollController,
                  itemCount: selectedMembers.length,
                  itemBuilder: (context, i) => MemberCard(
                      name: selectedMembers[i].memberName,
                      role: selectedMembers[i].role!,
                      photoUrl: selectedMembers[i].profilePicUrl,
                      onTap: () {
                        setState(() {
                          members.add(selectedMembers[i]);
                          selectedMembers.removeAt(i);
                        });
                      })),
            ),
            sizedBoxMedium,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: ElevatedButton(
                child: Text(context.loc.upload_attachment),
                onPressed: () {
                  _pickFile();
                  setState(() {});
                },
              ),
            ),
            if (attchmentName != null)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: PhoneCard(
                    text: '$attchmentName',
                    onTap: () {
                      setState(() {
                        attchmentName = null;
                        attchmentFile = null;
                      });
                    }),
              ),
            sizedBoxMedium,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                children: [
                  Text(context.loc.check_by_project_manager),
                  Checkbox(
                      activeColor: beg,
                      checkColor: orange,
                      value: checkByManager,
                      onChanged: (value) {
                        checkByManager = value!;
                        setState(() {});
                      })
                ],
              ),
            ),
            sizedBoxMedium,
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Consumer<AuthSataProvider>(
                    builder: (context, value, child) => (AuthState.waiting !=
                            Provider.of<AuthSataProvider>(context).authState)
                        ? ElevatedButton(
                            child: Text(context.loc.add),
                            onPressed: () async {
                              print(selectedMembers.length);
                              if (nameController.text.isEmpty) {
                                showSuccessSnackBar(
                                    context, 'name is required');
                                return;
                              }
                              Provider.of<AuthSataProvider>(context,
                                      listen: false)
                                  .changeAuthState(newState: AuthState.waiting);
                              String attchmentUrl = '';
                              if (attchmentFile != null) {
                                attchmentUrl = await FileService().uploadeFile(
                                    attchmentName!, attchmentFile!, context);
                              }
                              if (attchmentUrl == 'error') {
                                showErrorSnackBar(
                                    context, 'error uploading file');
                                return;
                              }
                              var task = Task(
                                  title: nameController.text,
                                  description: descController.text,
                                  taskState: taskState,
                                  startPoint: startDate,
                                  endPoint: endDate,
                                  attchmentUrl: attchmentUrl,
                                  checkByManager: checkByManager,
                                  members: selectedMembers);
                              bool state = await TasksDbService().addTask(
                                  project: project!,
                                  task: task,
                                  context: context);
                              if (state) {
                                Provider.of<AuthSataProvider>(context,
                                        listen: false)
                                    .changeAuthState(
                                        newState: AuthState.notSet);
                                Navigator.pop(context);
                                showSuccessSnackBar(
                                    context, 'task added successfully');
                              } else {
                                showErrorSnackBar(context, 'error adding task');
                                Provider.of<AuthSataProvider>(context,
                                        listen: false)
                                    .changeAuthState(
                                        newState: AuthState.notSet);
                              }
                            })
                        : const Center(
                            child: CircularProgressIndicator(
                              color: orange,
                            ),
                          ))),
          ],
        ));
  }
}
