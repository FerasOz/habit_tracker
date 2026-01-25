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
    final completedThisWeek = habit.completedThisWeek();
    final target = habit.activeDays.length;

    final progress = target == 0 ? 0.0 : completedThisWeek / target;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: ColorsManager.primaryColor,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(LocaleKeys.habitDetails_weeklyProgress.tr(),
              style: GoogleFonts.poppins(color: Colors.white70)),
          verticalSpace(8),
          Text(
            "$completedThisWeek / $target",
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 26.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          verticalSpace(12),
          LinearProgressIndicator(
            value: progress.clamp(0, 1),
            backgroundColor: Colors.white30,
            valueColor: const AlwaysStoppedAnimation(Colors.white),
          ),
        ],
      ),
    );
  }
}
