import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:habit_tracker/core/helpers/spacing.dart';
import 'package:habit_tracker/cubit/habit_cubit.dart';
import 'package:habit_tracker/data/models/habit_model.dart';
import 'package:habit_tracker/core/routing/routes.dart';
import 'package:habit_tracker/core/styles/colors.dart';
import 'package:habit_tracker/features/home/widgets/active_days_row.dart';
import 'package:habit_tracker/generated/locale_keys.g.dart';

class HabitItemWidget extends StatelessWidget {
  final HabitModel habit;

  const HabitItemWidget({super.key, required this.habit});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final completedThisWeek = habit.completedThisWeek(
      context.read<HabitCubit>().state.selectedDay,
    );
    final target = habit.activeDays.length;
    final progress = target == 0 ? 0.0 : completedThisWeek / target;

    final selectedDay = context.read<HabitCubit>().state.selectedDay;

    final todayKey = DateFormat('yyyy-MM-dd').format(selectedDay);

    final doneToday = habit.completedDates.contains(todayKey);

    final streak = habit.currentStreak(selectedDay);

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          Routes.habitDetailsScreen,
          arguments: habit,
        );
      },
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(16.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      habit.title,
                      style: theme.textTheme.titleMedium,
                    ),
                  ),
                  if (doneToday)
                    const Icon(
                      Icons.check_circle,
                      color: ColorsManager.success,
                    ),
                ],
              ),

              verticalSpace(6),

              Text(
                "$completedThisWeek / $target ${LocaleKeys.home_thisWeek.tr()}",
                style: theme.textTheme.bodySmall,
              ),

              verticalSpace(8),

              LinearProgressIndicator(
                value: progress.clamp(0.0, 1.0),
                minHeight: 5.h,
                backgroundColor: theme.dividerColor.withOpacity(0.3),
                valueColor: AlwaysStoppedAnimation(ColorsManager.primary),
              ),

              verticalSpace(12),

              Row(
                children: [
                  Expanded(child: ActiveDaysRow(activeDays: habit.activeDays)),
                  if (streak > 0)
                    Padding(
                      padding: EdgeInsets.only(left: 8.w),
                      child: Text(
                        "🔥 $streak",
                        style: theme.textTheme.bodySmall,
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
