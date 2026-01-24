import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habit_tracker/core/helpers/spacing.dart';
import 'package:habit_tracker/data/models/habit_model.dart';
import 'package:habit_tracker/core/styles/colors.dart';
import 'package:habit_tracker/generated/locale_keys.g.dart';

class ProgressCardWidget extends StatelessWidget {
  final HabitModel habit;
  const ProgressCardWidget({super.key, required this.habit});

  @override
  Widget build(BuildContext context) {
    final progress = (habit.completedDays / habit.targetPerWeek).clamp(
      0.0,
      1.0,
    );
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: ColorsManager.primaryColor,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            LocaleKeys.habitDetails_weeklyProgress.tr(),
            style: GoogleFonts.poppins(color: Colors.white70, fontSize: 14.sp),
          ),
          verticalSpace(8),
          Text(
            "${habit.completedDays} / ${habit.targetPerWeek}",
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 26.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          verticalSpace(12),
          LinearProgressIndicator(
            value: progress,
            backgroundColor: Colors.white30,
            valueColor: const AlwaysStoppedAnimation(Colors.white),
          ),
        ],
      ),
    );
  }
}
