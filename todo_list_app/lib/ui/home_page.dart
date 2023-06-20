import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:todo_list_app/controllers/task_controller.dart';
import 'package:todo_list_app/themes/colors.dart';
import 'package:todo_list_app/themes/text_themes.dart';
import 'package:todo_list_app/themes/decorations_themes.dart';
import 'package:todo_list_app/ui/add_task.dart';
import 'package:get/get.dart';

import '../models/task.dart';
import '../widgets/task_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime _selectedDate = DateTime.now();
  final _taskController = Get.put(TaskController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: _addAppBar(),
      floatingActionButton: FloatingActionButton.extended(
        label: Text(
          'Add Task',
          style: getSubHeadingTextStyle(),
        ),
        backgroundColor: primaryColor,
        onPressed: () async {
          //Get.to(const AddTaskPage());
          await Get.to(() => const AddTaskPage());
          _taskController.getTasks();
        },
      ),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _addDateBar(),
              ),
            ],
          ),
          _addCalenderBar(),
          Divider(
            height: 15,
            thickness: 2,
            color: appBarColor,
          ),
          _addTasksList(),
        ],
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

  _addDateBar() {
    return Container(
      decoration: getContainerDecoration(),
      //color: Color.fromRGBO(76, 76, 76, 1),
      padding: const EdgeInsets.all(17),
      margin: const EdgeInsets.only(left: 10, top: 10, right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Today is:",
            style: getSubHeadingTextStyle(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(DateFormat.yMMMMEEEEd().format(DateTime.now()),
                  style: getHeadingTextStyle()),
            ],
          ),
        ],
      ),
    );
  }

  _addCalenderBar() {
    return Container(
      decoration: getContainerDecoration(),
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(left: 10, top: 10, right: 10),
      child: DatePicker(
        DateTime.now(),
        initialSelectedDate: DateTime.now(),
        selectionColor: primaryColor,
        selectedTextColor: Colors.white,
        monthTextStyle: GoogleFonts.lato(
            color: Colors.white70, fontWeight: FontWeight.bold),
        dateTextStyle: GoogleFonts.lato(
            color: Colors.white70, fontWeight: FontWeight.bold),
        dayTextStyle: GoogleFonts.lato(
            color: Colors.white70, fontWeight: FontWeight.bold),
        width: 70,
        onDateChange: (date) {
          _selectedDate = date;
        },
      ),
    );
  }

  _addTasksList() {
    return Expanded(child: Obx(() {
      return ListView.builder(
          itemCount: _taskController.taskList.length,
          itemBuilder: (_, index) {
            return AnimationConfiguration.staggeredList(
                position: index,
                child: SlideAnimation(
                    child: FadeInAnimation(
                  child: Row(children: [
                    GestureDetector(
                      onTap: () {
                        _showPopupBottomMenu(
                            context, _taskController.taskList[index]);
                      },
                      child: TaskTile(_taskController.taskList[index]),
                    )
                  ]),
                )));
          });
    }));
  }

  _showPopupBottomMenu(BuildContext context, Task task) {
    Get.bottomSheet(Container(
      padding: const EdgeInsets.only(top: 4),
      height: task.isCompleted == 1
          ? MediaQuery.of(context).size.height * 0.25
          : MediaQuery.of(context).size.height * 0.33,
      color: backgroundColor,
      child: Column(children: [
        Container(
          height: 6,
          width: 120,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: secondaryColor),
        ),
        Spacer(),
        task.isCompleted == 1 ?
        Container() :
        _popupMenuButton(label: "Mark as completed", onTap: () {Get.back();}, color: primaryColor, context: context)
      ]),
    ));
  }

  _popupMenuButton(
      {required String label, required Function() onTap, required Color color, bool isClose = false, required BuildContext context}) {
        return GestureDetector(
          onTap: onTap,
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 4),
            height: 55,
            width: MediaQuery.of(context).size.width * 0.8,
            //color: color,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(20)
            ),
          ),
        );
      }
}
