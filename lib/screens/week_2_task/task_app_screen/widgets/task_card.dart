import 'package:dhc_assignment/model/task_model.dart';
import 'package:dhc_assignment/utils/app_colors/app_colors.dart';
import 'package:flutter/material.dart';

class TaskCard extends StatelessWidget {
  final TaskModel? taskodel;
  final void Function()? onDelete;
  const TaskCard({super.key, this.taskodel, this.onDelete});

  @override
  Widget build(BuildContext context) {
    return ListTile(
                    visualDensity: VisualDensity.comfortable,
                    tileColor: AppColors.lightBlackBackgroundColor,
                    title: Text(taskodel?.title?? "N/A", style: TextStyle(color: AppColors.kWhite),),
                    subtitle: Text(taskodel?.description?? "N/A", style: TextStyle(color: AppColors.kDarkGrey),),
                    trailing: InkWell(
                      onTap: onDelete,
                      child: Icon(Icons.delete, color: AppColors.kRed,))
                  );
  }
}