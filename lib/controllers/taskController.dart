import 'package:get/get.dart';

import '../db/dbHelper.dart';
import '../model/task.dart';

class TaskController extends GetxController {
  var taskList = <Task>[].obs;

  Future<int> addTask({Task? task}) async {
    return await DbHelper.insert(task);
  }

  getTasks() async {
    List<Map<String, dynamic>> tasks = await DbHelper.query();
    taskList.assignAll(tasks.map((data) => Task.fromJson(data)).toList());
  }

  void delete(Task task) {
    DbHelper.delete(task);
    getTasks();
  }

  void markTaskCompleted(int id) async {
    await DbHelper.update(id);
    getTasks();
  }

  void editTask(Task task) async {
    await DbHelper.editTask(task);
    getTasks();
  }
}
