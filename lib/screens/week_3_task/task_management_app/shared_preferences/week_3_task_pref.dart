import 'dart:convert';
import 'package:dhc_assignment/model/task_model.dart';
import 'package:dhc_assignment/utils/shared_pref_config.dart';

class Week3TaskPref {
  static const taskKey = "week_3_tasks";
  Future<void> saveTasks(List<Taskodel> taskList) async {
    final prefs = SharedPrefConfig.pref;

    if (prefs == null) return;

    List<String> taskJsonList =
        taskList.map((task) => jsonEncode(task.toJson())).toList();

    await prefs.setStringList(taskKey, taskJsonList);
  }

  Future<List<Taskodel>> loadTasks() async {
    final prefs = SharedPrefConfig.pref;

    if (prefs == null) return [];

    List<String>? taskJsonList = prefs.getStringList(taskKey);

    if (taskJsonList == null) return [];

    return taskJsonList
        .map((taskString) =>
            Taskodel.fromJson(jsonDecode(taskString)))
        .toList();
  }
}
