import 'package:get/get.dart';
import 'package:todo_list_app/db/db.dart';

import '../models/task.dart';

class TaskController extends GetxController {

  @override
  void onReady() {
    getTasks();
    super.onReady();
    print("TaskController onReady method has been called");
  }

  var taskList = <Task>[].obs;

  Future<int> addTask({Task? task}) async {
    return await DB.insert(task);
  }

  void getTasks() async {
    List<Map<String, dynamic>> tasks = await DB.query(); 
    taskList.assignAll(tasks.map((data) => Task.fromJson(data)).toList());
  }

  void delete(Task task) {
    DB.delete(task);
  }
}