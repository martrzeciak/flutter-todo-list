import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo_list_app/controllers/task_controller.dart';
import 'package:todo_list_app/models/task.dart';
import 'package:todo_list_app/themes/box_decorations.dart';
import 'package:todo_list_app/themes/colors.dart';
import 'package:todo_list_app/themes/text_themes.dart';
import 'package:todo_list_app/widgets/input_field.dart';

class EditTaskPage extends StatefulWidget {
  final Task task;

  const EditTaskPage({super.key, required this.task});

  @override
  State<EditTaskPage> createState() => _EditTaskPageState();
}

class _EditTaskPageState extends State<EditTaskPage> {
  final TaskController _taskController = Get.find();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  late DateTime _selectedDate;
  late String _startTime;
  late String _endTime;
  late int _selectedTaskPriority;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateFormat.yMd().parse(widget.task.date!);
    _startTime = widget.task.startTime!;
    _endTime = widget.task.endTime!;
    _selectedTaskPriority = widget.task.priority!;
    _titleController.text = widget.task.title!;
    _descriptionController.text = widget.task.description!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: _addAppBar(),
      floatingActionButton: FloatingActionButton.extended(
        label: Text(
          'Edit',
          style: getSubHeadingTextStyle(),
        ),
        icon: const Icon(
          Icons.edit,
          color: Colors.white,
        ),
        backgroundColor: primaryColor,
        onPressed: () {
          _validateData();
        },
      ),
      body: Container(
        margin: const EdgeInsets.all(10),
        decoration: getContainerDecoration(),
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Edit task",
                style: getHeadingTextStyle(),
              ),
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
                  icon: const Icon(Icons.calendar_today),
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
                    Text(
                      "Task Priority",
                      style: getTitleTextStyle(),
                    ),
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
                                          Icons.check,
                                          color: Colors.white,
                                          size: 25,
                                        )
                                      : null,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Text(
                                "Low",
                                style: getPriorityListTextStyle(),
                              ),
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
                                  backgroundColor: Colors.yellow,
                                  child: _selectedTaskPriority == 2
                                      ? const Icon(
                                          Icons.check,
                                          color: Colors.black,
                                          size: 25,
                                        )
                                      : null,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Text(
                                "Medium",
                                style: getPriorityListTextStyle(),
                              ),
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
                                  backgroundColor: Colors.red,
                                  child: _selectedTaskPriority == 3
                                      ? const Icon(
                                          Icons.check,
                                          color: Colors.white,
                                          size: 25,
                                        )
                                      : null,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Text(
                                "High",
                                style: getPriorityListTextStyle(),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _addAppBar() {
    return AppBar(
      backgroundColor: appBarColor,
      centerTitle: true,
      title: const Text("Todo List"),
    );
  }

  void _getDateFromUser() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  void _getTimeFromUser({required bool isStartTime}) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: isStartTime
          ? TimeOfDay.fromDateTime(DateFormat.jm().parse(_startTime))
          : TimeOfDay.fromDateTime(DateFormat.jm().parse(_endTime)),
    );
    if (pickedTime != null) {
      final String formattedTime = DateFormat.jm()
          .format(DateTime(1, 1, 1, pickedTime.hour, pickedTime.minute));
      setState(() {
        if (isStartTime) {
          _startTime = formattedTime;
        } else {
          _endTime = formattedTime;
        }
      });
    }
  }

  void _validateData() {
    final String title = _titleController.text.trim();
    final String description = _descriptionController.text.trim();

    if (title.isNotEmpty) {
      _updateTask(title, description);
    } else {
      Get.snackbar("Required", "All fields are required!",
          backgroundColor: Colors.white60,
          colorText: Colors.red,
          icon: const Icon(
            Icons.warning_amber_rounded,
            color: Colors.red,
          ));
    }
  }

  void _updateTask(String title, String description) async {
    final Task updatedTask = Task(
      id: widget.task.id,
      title: title,
      description: description,
      date: DateFormat.yMd().format(_selectedDate),
      startTime: _startTime,
      endTime: _endTime,
      priority: _selectedTaskPriority,
      isCompleted: widget.task.isCompleted,
    );

    await _taskController.updateTask(updatedTask);
    Get.back();
  }
}
