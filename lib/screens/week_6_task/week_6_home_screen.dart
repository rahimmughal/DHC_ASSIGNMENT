
import 'package:dhc_assignment/screens/week_6_task/models/todo_model.dart';
import 'package:dhc_assignment/screens/week_6_task/providers/todo_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;

class Week6HomeScreen extends StatefulWidget {
  const Week6HomeScreen({super.key});

  @override
  State<Week6HomeScreen> createState() => _Week6HomeScreenState();
}

class _Week6HomeScreenState extends State<Week6HomeScreen>
    with WidgetsBindingObserver {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<TodoProvider>().initialCall();
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
     context.read<TodoProvider>().saveTodo();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.detached ||
        state == AppLifecycleState.inactive) {
       context.read<TodoProvider>().saveTodo();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Todo App"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final TextEditingController titleController = TextEditingController();
          final TextEditingController descriptionController = TextEditingController();
          showDialog(
            context: context, 
            builder: (context) {
              return AlertDialog(
                title: const Text("Add Todo"),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: titleController,
                      decoration: const InputDecoration(labelText: "Title"),
                    ),
                    TextField(
                      controller: descriptionController, 
                      decoration: const InputDecoration(labelText: "Description"),
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      // Add new todo
                      context.read<TodoProvider>().addTodo(
                        TodoModel(
                          id: math.Random().nextInt(9999999).toString(),
                          title: titleController.text,
                          description: descriptionController.text,
                          isCompleted: false,
                        ),
                      );
                      Navigator.of(context).pop();
                    },
                    child: const Text("Add"),
                  ),
                ],
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
      body: Consumer<TodoProvider>(
        builder: (context, todoProvider, child) {
          if (todoProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
    
          if (todoProvider.todos.isEmpty) {
            return const Center(child: Text("No todos yet"));
          }
    
          return ListView.builder(
            itemCount: todoProvider.todos.length,
            itemBuilder: (context, index) {
              final todo = todoProvider.todos[index];
              return ListTile(
  title: Text(
    todo.title,
    style: TextStyle(
      decoration: todo.isCompleted ? TextDecoration.lineThrough : null,
    ),
  ),
  subtitle: Text(
    todo.description,
    style: TextStyle(
      decoration: todo.isCompleted ? TextDecoration.lineThrough : null,
    ),
  ),
  leading: Checkbox(
    value: todo.isCompleted,
    onChanged: (_) {
      todoProvider.completeTodo(todo);
    },
  ),
  trailing: Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      IconButton(
        tooltip: "Edit",
        icon: const Icon(Icons.edit),
        onPressed: () async {
          final result = await showDialog<Map<String, String>>(
            context: context,
            builder: (_) => _EditTodoDialog(
              title: todo.title,
              description: todo.description,
            ),
          );

          if (result != null) {
            showDialog(
              context: context, 
              builder: (context) {
                return AlertDialog(
                  title: const Text("Confirm Edit"),
                  content: const Text("Are you sure you want to edit this todo?"),
                  actions: [
                    TextButton(
                      onPressed: () {
                        // Update the todo
                        todoProvider.updateTodo(
                          TodoModel(
                            id: todo.id,
                            title: result['title']!,
                            description: result['description']!,
                            isCompleted: todo.isCompleted,
                          ),
                        );
                        Navigator.of(context).pop();
                      },
                      child: const Text("Yes"),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text("No"),
                    ),
                  ],
                );
              },
            );
          }
        },
      ),
      IconButton(
        tooltip: "Delete",
        icon: const Icon(Icons.delete),
        onPressed: () {
          showDialog(
            context: context, 
            builder: (context) {
              return AlertDialog(
                title: const Text("Confirm Delete"),
                content: const Text("Are you sure you want to delete this todo?"),
                actions: [
                  TextButton(
                    onPressed: () {
                      // Delete the todo
                      todoProvider.removeTodo(todo);
                      Navigator.of(context).pop();
                    },
                    child: const Text("Yes"),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text("No"),
                  ),
                ],
              );
            },
          );
        },
      ),
    ],
  ),
);
            },
          );
        },
      ),
    );
  }
}

class _EditTodoDialog extends StatefulWidget {
  final String title;
  final String description;

  const _EditTodoDialog({
    required this.title,
    required this.description,
  });

  @override
  State<_EditTodoDialog> createState() => _EditTodoDialogState();
}

class _EditTodoDialogState extends State<_EditTodoDialog> {
  late final TextEditingController _titleController;
  late final TextEditingController _descController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.title);
    _descController = TextEditingController(text: widget.description);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Update Todo"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _titleController,
            decoration: const InputDecoration(labelText: "Title"),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: _descController,
            decoration: const InputDecoration(labelText: "Description"),
            maxLines: 2,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Cancel"),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context, {
              "title": _titleController.text.trim(),
              "description": _descController.text.trim(),
            });
          },
          child: const Text("Update"),
        ),
      ],
    );
  }
}