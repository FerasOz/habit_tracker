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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          LocaleKeys.habitDetails_thisWeek.tr(),
          style: textTheme.titleMedium,
        ),
        verticalSpace(12),
        Wrap(
          spacing: 8.w,
          runSpacing: 8.h,
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

            return Container(
              width: 44.w,
              padding: EdgeInsets.symmetric(vertical: 8.h),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(
                  color: isToday
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).dividerColor.withOpacity(0.18),
                ),
              ),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 14.r,
                    backgroundColor: bgColor,
                    child: Icon(icon, size: 14, color: Colors.white),
                  ),
                  verticalSpace(4),
                  Text(
                    DateFormat('E', context.locale.languageCode).format(date),
                    style: textTheme.bodySmall?.copyWith(
                      fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      ],
    );
  }
}
