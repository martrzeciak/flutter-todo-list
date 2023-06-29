import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo_list_app/controllers/task_controller.dart';
import 'package:todo_list_app/themes/box_decorations.dart';
import 'package:todo_list_app/themes/text_themes.dart';
import 'package:todo_list_app/widgets/input_field.dart';
import '../models/task.dart';
import '../themes/colors.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({super.key});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final TaskController _taskController = Get.put(TaskController());
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  String _startTime = DateFormat("hh:mm a").format(DateTime.now()).toString();
  String _endTime = DateFormat("hh:mm a").format(DateTime.now()).toString();
  int _selectedTaskPriority = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: _addAppBar(),
      floatingActionButton: FloatingActionButton.extended(
        label: Text(
          'Add',
          style: getSubHeadingTextStyle(),
        ),
        icon: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: primaryColor,
        onPressed: () {
          _validateData();
        },
      ),
      body: Container(
        decoration: getContainerDecoration(),
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text("Add task", style: getHeadingTextStyle()),
            InputField(
              title: "Title",
              placeholder: "Enter task title",
              textEditingController: _titleController,
            ),
            InputField(
              title: "Description",
              placeholder: "Enter task description",
              textEditingController: _descriptionController,
            ),
            InputField(
              title: "Date",
              placeholder: DateFormat.yMd().format(_selectedDate),
              widget: IconButton(
                icon: const Icon(Icons.calendar_month),
                color: Colors.white70,
                onPressed: () {
                  _getDateFromUser();
                },
              ),
            ),
            InputField(
              title: "Start Time",
              placeholder: _startTime,
              widget: IconButton(
                icon: const Icon(Icons.access_time),
                onPressed: () {
                  _getTimeFromUser(isStartTime: true);
                },
              ),
            ),
            InputField(
              title: "End Time",
              placeholder: _endTime,
              widget: IconButton(
                icon: const Icon(Icons.access_time),
                onPressed: () {
                  _getTimeFromUser(isStartTime: false);
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Task Priority", style: getTitleTextStyle()),
                  Container(
                    margin: const EdgeInsets.only(top: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selectedTaskPriority = 1;
                                });
                              },
                              child: CircleAvatar(
                                radius: 15,
                                backgroundColor: Colors.green,
                                child: _selectedTaskPriority == 1
                                    ? const Icon(
                                        Icons.done,
                                        color: Colors.white,
                                        size: 25,
                                      )
                                    : Container(),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(left: 10),
                              child: Text(
                                "Low",
                                style: getPriorityListTextStyle(),
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selectedTaskPriority = 2;
                                });
                              },
                              child: CircleAvatar(
                                radius: 15,
                                backgroundColor: Colors.amber[300],
                                child: _selectedTaskPriority == 2
                                    ? const Icon(
                                        Icons.done,
                                        color: Colors.black,
                                        size: 25,
                                      )
                                    : Container(),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(left: 10),
                              child: Text(
                                "Medium",
                                style: getPriorityListTextStyle(),
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selectedTaskPriority = 3;
                                });
                              },
                              child: CircleAvatar(
                                  radius: 15,
                                  backgroundColor: Colors.red[400],
                                  child: _selectedTaskPriority == 3
                                      ? const Icon(
                                          Icons.done,
                                          color: Colors.white,
                                          size: 25,
                                        )
                                      : Container()),
                            ),
                            Container(
                              margin: const EdgeInsets.only(left: 10),
                              child: Text(
                                "High",
                                style: getPriorityListTextStyle(),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }

  _addAppBar() {
    return AppBar(
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: const Icon(Icons.arrow_back_ios_new),
        ),
        backgroundColor: appBarColor,
        elevation: 0,
        centerTitle: true,
        title: const Text("Todo List"));
  }

  _getDateFromUser() async {
    DateTime? _pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2100));

    if (_pickedDate != null) {
      setState(() {
        _selectedDate = _pickedDate;
      });
    } else {
      print("Selected date error");
    }
  }

  _getTimeFromUser({required bool isStartTime}) async {
    var pickedTime = await _showTimePicker();
    if (!mounted) return;
    String formatedTime = pickedTime.format(context);

    if (pickedTime == null) {
      print("Time is empty");
    } else if (isStartTime) {
      setState(() {
        _startTime = formatedTime;
      });
    } else {
      setState(() {
        _endTime = formatedTime;
      });
    }
  }

  _showTimePicker() {
    return showTimePicker(
        context: context,
        initialTime: TimeOfDay(
            hour: int.parse(_startTime.split(':')[0]),
            minute: int.parse(_startTime.split(':')[1].split(' ')[0])),
        initialEntryMode: TimePickerEntryMode.input);
  }

  _validateData() {
    if (_titleController.text.isNotEmpty &&
        _descriptionController.text.isNotEmpty) {
      _addTaskToDatabase();
      //_taskController.getTasks();
      Get.back();
    } else if (_titleController.text.isEmpty || _titleController.text.isEmpty) {
      Get.snackbar("Required", "All fields are required!",
          backgroundColor: Colors.white60,
          colorText: Colors.red,
          icon: const Icon(
            Icons.warning_amber_rounded,
            color: Colors.red,
          ));
    }
  }

  _addTaskToDatabase() async {
   var val = await _taskController.addTask(
        task: Task(
            title: _titleController.text.toString(),
            description: _descriptionController.text.toString(),
            date: DateFormat().add_yMd().format(_selectedDate),
            startTime: _startTime,
            endTime: _endTime,
            priority: _selectedTaskPriority,
            isCompleted: 0));

  print("My id is: $val");
  }
}
