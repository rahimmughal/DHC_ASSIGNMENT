import 'package:dhc_assignment/utils/app_colors/app_colors.dart';
import 'package:flutter/material.dart';

class WeekTaskCard extends StatelessWidget {
  final String title;
  final String description;
  final VoidCallback? onTap;

  const WeekTaskCard({super.key, required this.title, required this.description, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(12.0),
      margin: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        color: AppColors.lightBlackBackgroundColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(color: AppColors.kWhite, fontSize: 22),
          ),
          SizedBox(height: 4.0),
          Text(
            description,
            style: TextStyle(
              color: AppColors.kDarkGrey,
              fontSize: 16,
              overflow: TextOverflow.ellipsis,
            ),
            maxLines: 7,
          ),
          SizedBox(height: 6.0),
          InkWell(
            onTap: onTap,
            child: Container(
              width: double.infinity, 
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 12),
              decoration: BoxDecoration(
                color: AppColors.kWhite.withValues(alpha: .8), 
                borderRadius: BorderRadius.circular(6), 
              ),
              child: Text("Press to continue", style: TextStyle(color: AppColors.backgroundColor, fontSize: 16),),
            ),
          )
        ],
      ),
    );
  }
}
