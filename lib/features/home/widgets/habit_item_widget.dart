import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:habit_tracker/core/helpers/spacing.dart';
import 'package:habit_tracker/core/routing/routes.dart';
import 'package:habit_tracker/core/styles/colors.dart';
import 'package:habit_tracker/cubit/habit_cubit.dart';
import 'package:habit_tracker/data/models/habit_model.dart';
import 'package:habit_tracker/features/home/widgets/active_days_row.dart';
import 'package:habit_tracker/generated/locale_keys.g.dart';

class HabitItemWidget extends StatelessWidget {
  final HabitModel habit;

  const HabitItemWidget({super.key, required this.habit});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final selectedDay = context.read<HabitCubit>().state.selectedDay;
    final selectedDayKey = DateFormat('yyyy-MM-dd').format(selectedDay);
    final completedThisWeek = habit.completedThisWeek(selectedDay);
    final target = habit.targetPerWeek;
    final progress = target == 0 ? 0.0 : completedThisWeek / target;
    final doneOnSelectedDay = habit.completedDates.contains(selectedDayKey);
    final streak = habit.currentStreak(selectedDay);
    final isActiveDay = habit.isActiveOn(selectedDay);

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
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.titleMedium,
                    ),
                  ),
                  if (doneOnSelectedDay)
                    const Icon(
                      Icons.check_circle,
                      color: ColorsManager.success,
                    ),
                  if (!doneOnSelectedDay && !isActiveDay)
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 5.h,
                      ),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.surfaceContainerHighest,
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Text(
                        LocaleKeys.home_restDay.tr(),
                        style: theme.textTheme.labelSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                ],
              ),
              verticalSpace(6),
              Text(
                "$completedThisWeek / $target ${LocaleKeys.home_thisWeek.tr()}",
                style: theme.textTheme.bodySmall,
              ),
              if (habit.description != null && habit.description!.trim().isNotEmpty)
                Padding(
                  padding: EdgeInsets.only(top: 4.h),
                  child: Text(
                    habit.description!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.textTheme.bodySmall?.color?.withOpacity(0.85),
                    ),
                  ),
                ),
              verticalSpace(8),
              LinearProgressIndicator(
                value: progress.clamp(0.0, 1.0),
                minHeight: 5.h,
                backgroundColor: theme.dividerColor.withOpacity(0.3),
                valueColor: const AlwaysStoppedAnimation(ColorsManager.primary),
              ),
              verticalSpace(12),
              Row(
                children: [
                  Expanded(child: ActiveDaysRow(activeDays: habit.activeDays)),
                  if (streak > 0)
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.local_fire_department,
                          color: Colors.orange,
                          size: 16,
                        ),
                        horizontalSpace(4),
                        Text(
                          streak.toString(),
                          style: theme.textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
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
