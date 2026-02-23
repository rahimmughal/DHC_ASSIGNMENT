import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dhc_assignment/model/task_model.dart';

class Week3TaskPref {
  static const String key = "week3_tasks";

  Future<void> saveTasks(List<TaskModel> tasks) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> taskList =
        tasks.map((task) => jsonEncode(task.toJson())).toList();
    await prefs.setStringList(key, taskList);
  }

  Future<List<TaskModel>> loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? data = prefs.getStringList(key);

    if (data == null) return [];

    return data
        .map((task) => TaskModel.fromJson(jsonDecode(task)))
        .toList();
  }
}
