import 'package:dhc_assignment/screens/week_1_task/login_screen.dart';
import 'package:dhc_assignment/screens/week_2_task/week_2_main_screen.dart';
import 'package:dhc_assignment/screens/week_3_task/task_management_app/weeek_3_task_home_screen.dart';
import 'package:dhc_assignment/screens/week_5_task/week_5_login_screen.dart';
import 'package:dhc_assignment/utils/constants.dart';
import 'package:dhc_assignment/widgets/week_task_card.dart';
import 'package:flutter/material.dart';


import '../screens/week_4_task/week_4_task_home_screen.dart';
import '../screens/week_6_task/week_6_home_screen.dart';

class WeekTaskData {
  static List<Widget> weekTaskList = [
    WeekTaskCard(
      title: "Week 1 Assignment",
      description:
          "In Week 1, I set up the Flutter development environment using Android Studio/VS Code and created a basic Flutter application to understand the framework’s structure and workflow. I designed a responsive login user interface that includes email and password input fields using TextFormField, along with a login button and a “Forgot Password?” option, structured using core widgets such as Column, Row, and Container. Form validation was implemented to ensure proper email format and non-empty password input. I also developed a second screen (Home Screen) and implemented navigation between screens using Navigator.push(). The completed project demonstrates fundamental Flutter concepts including UI building, form handling, and screen navigation, and the source code has been organized and uploaded to a GitHub repository with a README file.",
    
    onTap: () {
      if(Constants.globalNavigatorKey.currentContext?.mounted?? false){
        Navigator.push(
        Constants.globalNavigatorKey.currentContext!,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
      }
    },
    ),
    WeekTaskCard(
      title: "Week 2 Assignment",
      description:
          "In Week 2, I focused on understanding basic state management and implementing local data persistence in Flutter. I used the setState method to manage widget state by developing a counter application that allows users to increase and decrease a counter value dynamically. To ensure data persistence, I integrated SharedPreferences to store and retrieve the counter value so that it remains saved even after the app is closed and restarted. Additionally, I built a simple to-do list application that enables users to add tasks and view them in a ListView, with all tasks stored locally using SharedPreferences for persistent storage. This project demonstrates practical implementation of state management, local data handling, and dynamic UI updates, and the complete source code has been uploaded to a GitHub repository along with a README explaining the application.",
      onTap:(){
        if(Constants.globalNavigatorKey.currentContext?.mounted?? false){
          Navigator.push(
          Constants.globalNavigatorKey.currentContext!,
          MaterialPageRoute(builder: (context) => Week2MainScreen()),
        );
        }
      }
    ),
    WeekTaskCard(
      title: "Week 3 Assignment",
      description:
          "In Week 3, I developed a complete Task Management App by combining the core Flutter concepts learned throughout the internship. The application features a home screen that displays a list of tasks, along with the ability to add new tasks, delete existing ones, and mark tasks as completed. I implemented local data persistence using SharedPreferences to ensure that task data is saved and retained even after the app is closed or restarted. The app was thoroughly tested to ensure smooth navigation and reliable data storage, and any issues were resolved using Flutter’s built-in debugging tools. To improve the user experience, I enhanced the interface by adding a custom AppBar with a title and an action button for adding tasks, along with relevant icons from the Flutter Icons library for better visual appeal. The final project is fully functional, with the source code uploaded to a GitHub repository including setup instructions, along with a short demonstration video of the application.",
    onTap: () {
        if(Constants.globalNavigatorKey.currentContext?.mounted?? false){
          Navigator.push(
          Constants.globalNavigatorKey.currentContext!,
          MaterialPageRoute(builder: (context) => Week3TaskHomeScreen()),
        );
        }
    },
    ),
    WeekTaskCard(
      title: "Week 4 Assignment",
      description:
          "In Week 4, I developed a complete User Management System by combining the core Flutter concepts learned throughout the internship. The application features a home screen that displays a list of users, along with the ability to add new users, delete existing ones, and update user information. I implemented local data persistence using SharedPreferences to ensure that user data is saved and retained even after the app is closed or restarted. The app was thoroughly tested to ensure smooth navigation and reliable data storage, and any issues were resolved using Flutter’s built-in debugging tools. To improve the user experience, I enhanced the interface by adding a custom AppBar with a title and an action button for adding users, along with relevant icons from the Flutter Icons library for better visual appeal. The final project is fully functional, with the source code uploaded to a GitHub repository including setup instructions, along with a short demonstration video of the application.",
    onTap: () {
        if(Constants.globalNavigatorKey.currentContext?.mounted?? false){
          Navigator.push(
          Constants.globalNavigatorKey.currentContext!,
          MaterialPageRoute(builder: (context) => Week4TaskHomeScreen()),
        );
        }
    },
    ),
    WeekTaskCard(
      title: "Week 5 Assignment",
      description:
          "In Week 5, I focused on implementing user authentication and authorization features in the application. This involved creating a secure login screen, integrating Firebase Authentication for user sign-in and sign-up, and implementing role-based access control to restrict certain functionalities based on user roles. I also worked on improving the overall user experience by adding loading indicators during authentication processes and providing clear feedback messages for successful or failed login attempts. The application was tested thoroughly to ensure that all security measures were in place and functioning correctly.",
    onTap: () {
        if(Constants.globalNavigatorKey.currentContext?.mounted?? false){
          Navigator.push(
          Constants.globalNavigatorKey.currentContext!,
          MaterialPageRoute(builder: (context) => Week5LoginScreen()),
        );
        }
    },
    ),
    WeekTaskCard(
      title: "Week 6 Assignment",
      description:
          "In Week 6, I focused on implementing a task management system using Flutter. This involved creating a user-friendly interface for adding, updating, and deleting tasks, as well as integrating local storage solutions to persist task data across app launches. I utilized the Provider package for state management, ensuring that the UI remained responsive and up-to-date with the underlying data model. Additionally, I implemented basic authentication features to secure user data and prevent unauthorized access.",
    onTap: () {
        if(Constants.globalNavigatorKey.currentContext?.mounted?? false){
          Navigator.push(
          Constants.globalNavigatorKey.currentContext!,
          MaterialPageRoute(builder: (context) => Week6HomeScreen()),
        );
        }
    },
    ),
  ];
}
