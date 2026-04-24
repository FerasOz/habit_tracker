import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:habit_tracker/core/helpers/spacing.dart';
import 'package:habit_tracker/cubit/habit_cubit.dart';
import 'package:habit_tracker/data/models/habit_model.dart';
import 'package:habit_tracker/core/styles/colors.dart';
import 'package:habit_tracker/generated/locale_keys.g.dart';

class ProgressCardWidget extends StatelessWidget {
  final HabitModel habit;
  const ProgressCardWidget({super.key, required this.habit});

  @override
  Widget build(BuildContext context) {
    final selectedDay = context.read<HabitCubit>().state.selectedDay;
    final completedThisWeek = habit.completedThisWeek(selectedDay);
    final target = habit.targetPerWeek;
    final progress = target == 0 ? 0.0 : completedThisWeek / target;
    final progressLabel = "${(progress.clamp(0.0, 1.0) * 100).round()}%";
    final remaining = habit.remainingThisWeek(selectedDay);

    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            ColorsManager.primary,
            ColorsManager.secondary.withOpacity(0.88),
          ],
        ),
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
          verticalSpace(6),
          Text(
            progressLabel,
            style: textTheme.bodySmall?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          verticalSpace(4),
          Text(
            LocaleKeys.habitDetails_remainingThisWeek.tr(
              namedArgs: {'count': '$remaining'},
            ),
            style: textTheme.bodySmall?.copyWith(color: Colors.white70),
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
