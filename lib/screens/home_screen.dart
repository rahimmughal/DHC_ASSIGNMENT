import 'package:dhc_assignment/data/week_task_data.dart';
import 'package:dhc_assignment/utils/app_colors/app_colors.dart';
import 'package:dhc_assignment/widgets/week_task_card.dart';
import 'package:flutter/material.dart';

import '../widgets/app_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: CustomAppBar(
        title: "Dashboard",
      ),
      body: Column(
        children: [
          SizedBox(height: 10,),
          Expanded(
            child: ListView.separated(
              itemCount: WeekTaskData.weekTaskList.length,
              itemBuilder: (context, index) {
                return WeekTaskData.weekTaskList[index];
              },
              separatorBuilder: (context, index) {
                return SizedBox(height: 10);
              },
            ),
          ),
        ],
      ),
    );
  }
}