import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habit_tracker/core/helpers/spacing.dart';
import 'package:habit_tracker/core/models/habit_model.dart';
import 'package:habit_tracker/core/routing/routes.dart';
import 'package:habit_tracker/core/styles/colors.dart';
import 'package:habit_tracker/features/home/widgets/active_days_row.dart';

class HabitItemWidget extends StatelessWidget {
  final double progress;
  final HabitModel habit;
  final bool achieved;
  final Color streakColor;

  const HabitItemWidget({
    super.key,
    required this.progress,
    required this.habit,
    required this.achieved,
    required this.streakColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          Routes.habitDetailsScreen,
          arguments: habit,
        );
      },
      child: Container(
        padding: EdgeInsets.all(14.r),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 22.r,
                  backgroundColor: streakColor.withOpacity(0.15),
                  child: Icon(
                    habit.doneToday
                        ? Icons.check_circle
                        : Icons.circle_outlined,
                    color: streakColor,
                  ),
                ),
                horizontalSpace(14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        habit.title,
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          fontSize: 15.sp,
                        ),
                      ),
                      verticalSpace(4),
                      Text(
                        "🔥 ${habit.currentStreak} day streak",
                        style: GoogleFonts.poppins(
                          fontSize: 12.sp,
                          color: streakColor,
                        ),
                      ),
                    ],
                  ),
                ),

                if (achieved)
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.w,
                      vertical: 4.h,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Text(
                      "Goal 🎯",
                      style: TextStyle(color: Colors.white, fontSize: 11.sp),
                    ),
                  ),
              ],
            ),
            verticalSpace(12),
            ClipRRect(
              borderRadius: BorderRadius.circular(10.r),
              child: LinearProgressIndicator(
                value: progress,
                minHeight: 6.h,
                backgroundColor: Colors.grey.withOpacity(0.2),
                valueColor: AlwaysStoppedAnimation(ColorsManager.primaryColor),
              ),
            ),
            verticalSpace(10),
            ActiveDaysRow(activeDays: habit.activeDays),
          ],
        ),
      ),
    );
  }
}
