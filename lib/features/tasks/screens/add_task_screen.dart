import 'dart:io';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:pmpconstractions/core/config/constants/constant.dart';
import 'package:pmpconstractions/core/config/enums/enums.dart';
import 'package:pmpconstractions/core/config/theme/theme.dart';
import 'package:pmpconstractions/core/extensions/loc.dart';
import 'package:pmpconstractions/core/featuers/auth/services/file_service.dart';
import 'package:pmpconstractions/core/widgets/custom_snackbar.dart';
import 'package:pmpconstractions/core/widgets/custom_text_field.dart';
import 'package:pmpconstractions/core/widgets/phone_card.dart';
import 'package:pmpconstractions/features/home_screen/models/project.dart';
import 'package:pmpconstractions/features/home_screen/screens/widgets/member_card.dart';
import 'package:pmpconstractions/features/tasks/models/task.dart';
import 'package:pmpconstractions/features/tasks/providers/selected_project_provider.dart';
import 'package:pmpconstractions/features/tasks/screens/widgets/date_picker.dart';
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

  @override
  Widget build(BuildContext context) {
    var project = Provider.of<SelectedProjectProvider>(context).project;
    selectedItem = project!.members!.first;

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
                        if (newDate.isBefore(endDate)) {
                          setState(() {
                            startDate = newDate;
                          });
                        } else {
                          showErrorSnackBar(
                              context, 'Start date must be before end date');
                        }
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
                        if (newDate.isAfter(startDate)) {
                          setState(() {
                            endDate = newDate;
                          });
                        } else {
                          showErrorSnackBar(
                              context, 'End date must be after start date');
                        }
                      }
                      const Text('pick date');
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: DropdownSearch<MemberRole>(
                      items: project.members!,
                      dropdownDecoratorProps: const DropDownDecoratorProps(
                          dropdownSearchDecoration:
                              InputDecoration(fillColor: darkBlue)),
                      popupProps: PopupProps.menu(
                        menuProps: MenuProps(
                          backgroundColor: const Color.fromARGB(255, 8, 22, 42),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        showSelectedItems: true,
                        itemBuilder: buildItemDropdown,
                      ),

                      compareFn: (me, ma) {
                        return me.memberId == ma.memberId;
                      },

                      //showSelectedItems: true,

                      itemAsString: (member) {
                        return member.memberName;
                      },
                      selectedItem: selectedItem,
                      onChanged: (member) {
                        selectedItem = member!;
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: CircleAvatar(
                      radius: 25,
                      backgroundColor: orange,
                      child: IconButton(
                          onPressed: () {
                            setState(() {
                              if (selectedItem != null) {
                                bool found =
                                    selectedMembers.contains(selectedItem!);
                                if (!found) {
                                  selectedMembers.add(selectedItem!);
                                  print(selectedItem!.collectionName);
                                }
                              }
                            });
                          },
                          icon: const Icon(
                            Icons.add,
                            size: 20,
                            color: beg,
                          )),
                    ),
                  ),
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
              child: ElevatedButton(
                  child: Text(context.loc.add),
                  onPressed: () async {
                    if (nameController.text.isEmpty) {
                      showSuccessSnackBar(context, 'name is required');
                      return;
                    }
                    String attchmentUrl = '';
                    if (attchmentFile != null) {
                      attchmentUrl = await FileService()
                          .uploadeFile(attchmentName!, attchmentFile!, context);
                    }
                    if (attchmentUrl == 'error') {
                      showErrorSnackBar(context, 'error uploading file');
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
                        project: project, task: task, context: context);
                    if (state) {
                      Navigator.pop(context);
                      showSuccessSnackBar(context, 'task added successfully');
                    } else {
                      showErrorSnackBar(context, 'error adding task');
                    }
                  }),
            )
          ],
        ));
  }
}

Widget buildItemDropdown(BuildContext context, MemberRole item, bool s) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(20, 20, 0, 0),
    child: Row(
      children: [
        CircleAvatar(
          radius: 20,
          backgroundColor: orange,
          child: CircleAvatar(
              radius: 19, backgroundImage: NetworkImage(item.profilePicUrl!)),
        ),
        const SizedBox(
          width: 10,
        ),
        Text(
          item.memberName,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ],
    ),
  );
}
