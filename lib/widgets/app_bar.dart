import 'package:dhc_assignment/utils/app_colors/app_colors.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onBackPressed;
  final List<Widget>? actions;
  const CustomAppBar({super.key, required this.title, this.onBackPressed, this.actions});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.lightBlackBackgroundColor,
      centerTitle: true,
      title: Text(title, 
      style: TextStyle(
        color: AppColors.kWhite
      )
      ),
      leading: (onBackPressed == null)
          ? SizedBox.shrink()
          : IconButton(
              onPressed: onBackPressed,
              icon: Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.kWhite,),
            ),
      actions: actions,
    );
  }
}
