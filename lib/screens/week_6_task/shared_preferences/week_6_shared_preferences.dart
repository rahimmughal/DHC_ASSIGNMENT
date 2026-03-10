import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/todo_model.dart';

class Week6SharedPreferences {
  // Define keys for shared preferences
  static const String todosKey = 'todos';

  // Save todos to shared preferences
  Future<void> saveTodos(List<TodoModel> todos) async {
    final prefs = await SharedPreferences.getInstance();
    final todoJson = todos.map((todo) => todo.toJson()).toList();
    prefs.setString(todosKey, jsonEncode(todoJson));
  }

  // Load todos from shared preferences
  Future<List<TodoModel>> loadTodos() async {
    final prefs = await SharedPreferences.getInstance();
    final todoString = prefs.getString(todosKey);
    if (todoString != null) {
      final List<dynamic> todoJson = jsonDecode(todoString);
      return todoJson.map((json) => TodoModel.fromJson(json)).toList();
    }
    return [];
  }
}
