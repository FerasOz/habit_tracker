import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:habit_tracker/core/helpers/spacing.dart';
import 'package:habit_tracker/data/models/habit_model.dart';
import 'package:habit_tracker/core/styles/colors.dart';
import 'package:habit_tracker/generated/locale_keys.g.dart';

class WeekDaysWidget extends StatelessWidget {
  final HabitModel habit;
  const WeekDaysWidget({super.key, required this.habit});

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();
    final textTheme = Theme.of(context).textTheme;

    final weekDays = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          LocaleKeys.habitDetails_thisWeek.tr(),
          style: textTheme.titleMedium,
        ),
        verticalSpace(12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(7, (index) {
            final dayNumber = index + 1;
            final isActive = habit.activeDays.contains(dayNumber);

            final dateKey = today
                .subtract(Duration(days: today.weekday - dayNumber))
                .toIso8601String()
                .substring(0, 10);

            final isCompleted = habit.completedDates.contains(dateKey);
            final isToday = today.weekday == dayNumber;

            Color bgColor;
            IconData icon;

            if (!isActive) {
              bgColor = Colors.grey.shade300;
              icon = Icons.close;
            } else if (isCompleted) {
              bgColor = ColorsManager.primary;
              icon = Icons.check;
            } else {
              bgColor = ColorsManager.secondary;
              icon = Icons.remove;
            }

            return Column(
              children: [
                CircleAvatar(
                  radius: 18.r,
                  backgroundColor: bgColor,
                  child: Icon(icon, size: 16, color: Colors.white),
                ),
                verticalSpace(6),
                Text(
                  weekDays[index],
                  style: textTheme.bodySmall?.copyWith(
                    fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ],
            );
          }),
        ),
      ],
    );
  }
}
