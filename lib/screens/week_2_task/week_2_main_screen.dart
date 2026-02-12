import 'package:dhc_assignment/screens/week_2_task/counter_app_screen/counter_screen.dart';
import 'package:dhc_assignment/screens/week_2_task/task_app_screen/weeek_2_task_home_screen.dart';
import 'package:dhc_assignment/utils/app_colors/app_colors.dart';
import 'package:dhc_assignment/widgets/app_bar.dart';
import 'package:dhc_assignment/widgets/week_task_card.dart';
import 'package:flutter/material.dart';

class Week2MainScreen extends StatelessWidget {
  const Week2MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: CustomAppBar(
        title: "Week 2",
        onBackPressed: () {
          Navigator.pop(context);
        },
      ),
      body: Column(
        children: [
          WeekTaskCard(
            title: "Counter",
            description:
                "This Counter App is a simple Flutter application that demonstrates basic state management using the setState method. The app allows users to increase or decrease a numeric value by tapping the increment and decrement buttons. Whenever a button is pressed, the setState function updates the UI instantly to reflect the new counter value. The interface is clean and easy to use, making it ideal for beginners to understand how Flutter rebuilds widgets when the state changes. This app highlights the core concept of local state management and real-time UI updates using simple functionality.",
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=> CounterScreen()));
            },
          ),
          SizedBox(height: 10),
          WeekTaskCard(
            title: "Task App",
            description:
                "This Task App is a simple Flutter application that helps users manage their daily tasks with basic functionality. Users can add new tasks, mark them as completed, and delete them when no longer needed. The app uses the `setState` method for state management, allowing the UI to update instantly whenever a task is added, updated, or removed. To ensure data persistence, the app integrates **SharedPreferences**, which stores the task list locally on the device so that the data remains available even after the app is closed or restarted. This project is ideal for beginners to understand local state management, real-time UI updates, and basic local data storage in Flutter.",
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=> Week2TaskHomeScreen()));
            },
          ),
        ],
      ),
    );
  }
}
