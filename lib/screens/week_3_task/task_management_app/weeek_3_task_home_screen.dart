import 'package:flutter/material.dart';
import 'package:dhc_assignment/model/task_model.dart';
import 'package:dhc_assignment/utils/app_colors/app_colors.dart';
import 'package:dhc_assignment/widgets/app_bar.dart';
import 'shared_preferences/week_3_task_pref.dart';
import 'widgets/week_3_task_card.dart';

class Week3TaskHomeScreen extends StatefulWidget {
  const Week3TaskHomeScreen({super.key});

  @override
  State<Week3TaskHomeScreen> createState() => _Week3TaskHomeScreenState();
}

class _Week3TaskHomeScreenState extends State<Week3TaskHomeScreen> {
  List<TaskModel> taskList = [];

  @override
  void initState() {
    super.initState();
    loadTasks();
  }

  void loadTasks() async {
    taskList = await Week3TaskPref().loadTasks();
    setState(() {});
  }

  void saveTasks() {
    Week3TaskPref().saveTasks(taskList);
  }

  void addTask(String title, String desc) {
    setState(() {
      taskList.add(TaskModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: title,
        description: desc,
        isCompleted: false,
      ));
    });
    saveTasks();
  }

  void showAddDialog() {
    TextEditingController title = TextEditingController();
    TextEditingController desc = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Add Task"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: title, decoration: const InputDecoration(labelText: "Title")),
            TextField(controller: desc, decoration: const InputDecoration(labelText: "Description")),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              addTask(title.text, desc.text);
              Navigator.pop(context);
            },
            child: const Text("Add"),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: const CustomAppBar(title: "Task Manager"),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.kWhite,
        onPressed: () {
          showDialog(
            context: context, 
            builder: (context) {
              String title = "";
              String description = "";
              return AlertDialog(
                backgroundColor: AppColors.lightBlackBackgroundColor,
                title: Text("Add Task", style: TextStyle(color: AppColors.kWhite),),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      onChanged: (value) => title = value,
                      decoration: InputDecoration(
                        hintText: "Title",
                        hintStyle: TextStyle(color: AppColors.kDarkGrey),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: AppColors.kDarkGrey),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: AppColors.kWhite),
                        ),
                      ),
                      style: TextStyle(color: AppColors.kWhite),
                    ),
                    TextField(
                      onChanged: (value) => description = value,
                      decoration: InputDecoration(
                        hintText: "Description",
                        hintStyle: TextStyle(color: AppColors.kDarkGrey),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: AppColors.kDarkGrey),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: AppColors.kWhite),
                        ),
                      ),
                      style: TextStyle(color: AppColors.kWhite),
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      if(title.isEmpty || description.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            duration: Duration(milliseconds: 500),
                            content: Text("Please fill in all fields"),
                            backgroundColor: AppColors.kRed,
                          )
                        );
                        return;
                      }
                      setState(() {
                        taskList.add(TaskModel(title: title, description: description, id: taskList.length.toString(), isCompleted: false));
                      });
                      Navigator.pop(context);
                    }, 
                    child: Text("Add", style: TextStyle(color: AppColors.kWhite),)
                  )
                ],
              );
            }
          );
        },
        child: Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView.builder(
          itemCount: taskList.length,
          itemBuilder: (context, index) {
            final task = taskList[index];
            return Week3TaskCard(
              task: task,
              onChanged: (value) {
                setState(() {
                  task.isCompleted = value ?? false;
                });
                saveTasks();
              },
              onDelete: () {
                setState(() {
                  taskList.removeAt(index);
                });
                saveTasks();
              },
            );
          },
        ),
      ),
    );
  }
}
