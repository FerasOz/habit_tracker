import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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

    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: ColorsManager.primary,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            LocaleKeys.habitDetails_weeklyProgress.tr(),
            style: textTheme.bodySmall?.copyWith(color: Colors.white70),
          ),
          verticalSpace(8),
          Text(
            "$completedThisWeek / $target",
            style: textTheme.displayLarge?.copyWith(color: Colors.white),
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
