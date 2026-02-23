import 'package:flutter/material.dart';
import 'package:dhc_assignment/model/task_model.dart';
import 'package:dhc_assignment/utils/app_colors/app_colors.dart';

class Week3TaskCard extends StatelessWidget {
  final TaskModel task;
  final Function(bool?) onChanged;
  final VoidCallback onDelete;

  const Week3TaskCard({
    super.key,
    required this.task,
    required this.onChanged,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.kBlack,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      child: ListTile(
        leading: Checkbox(
          value: task.isCompleted,
          activeColor: AppColors.backgroundColor,
          onChanged: onChanged,
        ),
        title: Text(
          task.title,
          style: const TextStyle(color: Colors.white),
        ),
        subtitle: Text(
          task.description,
          style: const TextStyle(color: Colors.grey),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: onDelete,
        ),
      ),
    );
  }
}
