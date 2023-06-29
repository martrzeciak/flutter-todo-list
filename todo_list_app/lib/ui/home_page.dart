import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:todo_list_app/controllers/task_controller.dart';
import 'package:todo_list_app/themes/colors.dart';
import 'package:todo_list_app/themes/text_themes.dart';
import 'package:todo_list_app/themes/box_decorations.dart';
import 'package:todo_list_app/ui/add_task.dart';
import 'package:get/get.dart';
import '../models/task.dart';
import '../widgets/task_tile.dart';
import 'edit_task.dart';

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
      endDrawer: _addDrawer(),
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
          Container(
            color: secondaryBackgroundColor,
            child: Row(
              children: [
                Expanded(
                  child: _addDateBar(),
                ),
              ],
            ),
          ),
          Container(
            //color: secondaryBackgroundColor,
            padding: const EdgeInsets.only(bottom: 10),
            margin: const EdgeInsets.only(bottom: 15),
            decoration:
                BoxDecoration(color: secondaryBackgroundColor, boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.6),
                spreadRadius: 1,
                blurRadius: 6,
                offset: const Offset(0, 6),
              )
            ]),
            child: _addCalenderBar(),
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

  _addDrawer() {
    return Drawer(
      backgroundColor: secondaryBackgroundColor,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
              decoration: BoxDecoration(color: secondaryColor),
              child: Text("Todo List App")),
          ListTile(
            leading: const Icon(
              Icons.delete,
            ),
            title: const Text("Remove all tasks"),
            onTap: () {
              _taskController.deleteAll();
              Get.back();
            },
          )
        ],
      ),
    );
  }

  _addDateBar() {
    return Container(
      decoration: getContainerDecoration(),
      //color: Color.fromRGBO(76, 76, 76, 1),
      padding: const EdgeInsets.all(20),
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
          setState(() {
            _selectedDate = date;
          });
        },
      ),
    );
  }

  _addTasksList() {
    return Expanded(child: Obx(() {
      return ListView.builder(
          itemCount: _taskController.taskList.length,
          itemBuilder: (_, index) {
            Task task = _taskController.taskList[index];
            if (task.date == DateFormat.yMd().format(_selectedDate)) {
              return AnimationConfiguration.staggeredList(
                  position: index,
                  child: SlideAnimation(
                      child: FadeInAnimation(
                    child: Row(children: [
                      GestureDetector(
                        onTap: () {
                          _showPopupBottomMenu(context, task);
                        },
                        child: TaskTile(task),
                      )
                    ]),
                  )));
            } else {
              return Container();
            }
          });
    }));
  }

  _showPopupBottomMenu(BuildContext context, Task task) {
    Get.bottomSheet(Container(
      padding: const EdgeInsets.only(top: 4),
      height: task.isCompleted == 1
          ? MediaQuery.of(context).size.height * 0.20
          : MediaQuery.of(context).size.height * 0.34,
      color: backgroundColor,
      child: Column(children: [
        Container(
          height: 6,
          width: 120,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: secondaryColor),
        ),
        const Spacer(),
        task.isCompleted == 1
            ? Container()
            : Column(
                children: [
                  _popupMenuButton(
                      label: "Mark as completed",
                      onTap: () {
                        _taskController.markTaskAsCompleted(task.id!);
                        Get.back();
                      },
                      color: secondaryColor,
                      context: context),
                  _popupMenuButton(
                      label: "Edit task",
                      onTap: () async {
                        Get.back();
                        await Get.to(() => EditTaskPage(task: task));
                        _taskController.getTasks();
                      },
                      color: secondaryColor,
                      context: context),
                ],
              ),
        _popupMenuButton(
            label: "Delete task",
            onTap: () {
              _taskController.delete(task);
              Get.back();
            },
            color: Colors.red[300]!,
            context: context),
        const SizedBox(
          height: 15,
        ),
        _popupMenuButton(
            label: "Close",
            onTap: () {
              Get.back();
            },
            color: primaryColor,
            context: context),
        const SizedBox(
          height: 15,
        )
      ]),
    ));
  }

  _popupMenuButton(
      {required String label,
      required Function() onTap,
      required Color color,
      required BuildContext context}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          margin: const EdgeInsets.symmetric(vertical: 4),
          height: 55,
          width: MediaQuery.of(context).size.width * 0.8,
          //color: color,
          decoration: BoxDecoration(
              color: color, borderRadius: BorderRadius.circular(20)),
          child: Center(
            child: Text(
              label,
              style: getTitleTextStyle(),
            ),
          )),
    );
  }
}
