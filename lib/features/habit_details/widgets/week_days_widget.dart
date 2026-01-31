import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:habit_tracker/core/helpers/spacing.dart';
import 'package:habit_tracker/data/models/habit_model.dart';
import 'package:habit_tracker/core/styles/colors.dart';
import 'package:habit_tracker/generated/locale_keys.g.dart';

class WeekDaysWidget extends StatelessWidget {
  final HabitModel habit;
  final DateTime selectedDay;

  const WeekDaysWidget({
    super.key,
    required this.habit,
    required this.selectedDay,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    final weekStart = selectedDay.subtract(
      Duration(days: selectedDay.weekday - 1),
    );

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

            final date = weekStart.add(Duration(days: index));
            final dateKey = DateFormat('yyyy-MM-dd').format(date);

            final isCompleted = habit.completedDates.contains(dateKey);
            final isToday = DateUtils.isSameDay(date, selectedDay);

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
