import 'package:dhc_assignment/screens/week_6_task/models/todo_model.dart';
import 'package:dhc_assignment/screens/week_6_task/shared_preferences/week_6_shared_preferences.dart';
import 'package:flutter/material.dart';

class TodoProvider extends ChangeNotifier {
  final List<TodoModel> _todos = [];

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<TodoModel> get todos => _todos;

  initialCall() async {
    _isLoading = true;
    notifyListeners();
    await Week6SharedPreferences().loadTodos().then((todos) async {
      await Future.delayed(const Duration(seconds: 2)).then((value){
        _todos.addAll(todos);
      _isLoading = false;
      notifyListeners();
      });
    });
  }

  saveTodo() async {
    await Week6SharedPreferences().saveTodos(_todos);
  }

  void addTodo(TodoModel todo) {
    _todos.add(todo);
    notifyListeners();
  }

  void removeTodo(TodoModel todo) {
    _todos.remove(todo);
    notifyListeners();
  }

  void updateTodo(TodoModel todo) {
    final index = _todos.indexWhere((t) => t.id == todo.id);
    if (index != -1) {
      _todos[index] = todo;
      notifyListeners();
    }
  }

  void completeTodo(TodoModel todo) {
    final index = _todos.indexWhere((t) => t.id == todo.id);
    if (index != -1) {
      _todos[index].isCompleted = !_todos[index].isCompleted;
      notifyListeners();
    }
  }

}
