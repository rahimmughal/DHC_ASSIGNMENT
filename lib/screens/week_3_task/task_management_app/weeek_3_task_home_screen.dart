import 'package:dhc_assignment/model/task_model.dart';
import 'package:dhc_assignment/screens/week_3_task/task_management_app/shared_preferences/week_3_task_pref.dart';
import 'package:dhc_assignment/screens/week_3_task/task_management_app/widgets/week_3_task_card.dart';
import 'package:dhc_assignment/utils/app_colors/app_colors.dart';
import 'package:dhc_assignment/widgets/app_bar.dart';
import 'package:flutter/material.dart';

class Week3TaskHomeScreen extends StatefulWidget {
  const Week3TaskHomeScreen({super.key});

  @override
  State<Week3TaskHomeScreen> createState() => _Week3TaskHomeScreenState();
}

class _Week3TaskHomeScreenState extends State<Week3TaskHomeScreen> with WidgetsBindingObserver{

  List<Taskodel> taskList = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    loadTasks();
  }

  Future<void> loadTasks() async {
    taskList = await Week3TaskPref().loadTasks();
    setState(() {});
  }

  Future<void> saveTasks() async {
    await Week3TaskPref().saveTasks(taskList);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    saveTasks();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.detached) {
      saveTasks();
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: CustomAppBar(title: "Week 3 Task App", 
      onBackPressed: () => Navigator.pop(context),
      ),
      body: Column(
        children: [
          SizedBox(height: 10),
          Expanded(
            child: Container( 
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: (taskList.isEmpty) ? Center(
                child: Text("No tasks available", style: TextStyle(color: AppColors.kWhite),),
              ) : ListView.separated(
                itemCount: taskList.length,
                itemBuilder: (context, index) {
                  final task = taskList[index];
                  return Week3TaskCard(
                    taskodel: task, 
                    onChanged: (value){
                      setState(() {
                        taskList[index].isCompleted = value ?? false;
                      });
                    },
                    onDelete: () {
                      showDialog(
                        context: context, 
                        builder: (context) {
                          return AlertDialog(
                            backgroundColor: AppColors.lightBlackBackgroundColor,
                            title: Text("Delete Task", style: TextStyle(color: AppColors.kWhite),),
                            content: Text("Are you sure you want to delete this task?", style: TextStyle(color: AppColors.kWhite),),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    taskList.removeAt(index);
                                  });
                                  Navigator.pop(context);
                                }, 
                                child: Text("Delete", style: TextStyle(color: AppColors.kRed),)
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                }, 
                                child: Text("Cancel", style: TextStyle(color: AppColors.kWhite),)
                              )
                            ],
                          );
                        },
                      );
                    },
                  );
                },
                separatorBuilder: (context, index) => SizedBox(height: 8),
              ),
            ),
          ),

        ],
      ),
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
                         taskList.add(Taskodel(
                          title: title,
                          description: description,
                          id: DateTime.now().millisecondsSinceEpoch.toString(),
                          isCompleted: false,
                        ));
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
    );
  }
}