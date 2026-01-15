import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habit_tracker/core/helpers/spacing.dart';
import 'package:habit_tracker/core/models/habit_model.dart';
import 'package:habit_tracker/core/routing/routes.dart';
import 'package:habit_tracker/core/styles/colors.dart';
import 'package:habit_tracker/features/home/widgets/active_days_row.dart';

class HabitItemWidget extends StatelessWidget {
  final HabitModel habit;

  const HabitItemWidget({super.key, required this.habit});

  @override
  Widget build(BuildContext context) {
    final progress = habit.targetPerWeek == 0
        ? 0.0
        : habit.completedDays / habit.targetPerWeek;

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          Routes.habitDetailsScreen,
          arguments: habit,
        );
      },
      child: Container(
        padding: EdgeInsets.all(16.r),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    habit.title,
                    style: GoogleFonts.poppins(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                if (habit.doneToday)
                  Icon(Icons.check_circle, size: 20, color: Colors.green),
              ],
            ),
            verticalSpace(6),
            Text(
              "${habit.completedDays} / ${habit.targetPerWeek} this week",
              style: GoogleFonts.poppins(
                fontSize: 12.sp,
                color: Colors.grey[600],
              ),
            ),

            verticalSpace(8),
            ClipRRect(
              borderRadius: BorderRadius.circular(6.r),
              child: LinearProgressIndicator(
                value: progress.clamp(0.0, 1.0),
                minHeight: 5.h,
                backgroundColor: Colors.grey.withOpacity(0.2),
                valueColor: AlwaysStoppedAnimation(ColorsManager.primaryColor),
              ),
            ),

            verticalSpace(12),
            Row(
              children: [
                Expanded(child: ActiveDaysRow(activeDays: habit.activeDays)),
                if (habit.currentStreak > 0)
                  Padding(
                    padding: EdgeInsets.only(left: 8.w),
                    child: Text(
                      "🔥 ${habit.currentStreak}",
                      style: GoogleFonts.poppins(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
