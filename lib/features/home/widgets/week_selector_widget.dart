import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WeekSelectorWidget extends StatelessWidget {
  final DateTime selectedDay;
  final ValueChanged<DateTime> onDaySelected;

  const WeekSelectorWidget({
    super.key,
    required this.selectedDay,
    required this.onDaySelected,
  });

  @override
  Widget build(BuildContext context) {
    final localeCode = context.locale.languageCode;
    final weekStart = selectedDay.subtract(
      Duration(days: selectedDay.weekday - 1),
    );
    final days = List.generate(7, (index) => weekStart.add(Duration(days: index)));

    return SizedBox(
      height: 84.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: days.length,
        separatorBuilder: (_, _) => SizedBox(width: 10.w),
        itemBuilder: (_, index) {
          final day = days[index];
          final isSelected = DateUtils.isSameDay(day, selectedDay);
          final dayLabel = DateFormat('E', localeCode).format(day);
          final dateLabel = DateFormat('d', localeCode).format(day);

          return GestureDetector(
            onTap: () => onDaySelected(day),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 220),
              width: 66.w,
              padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 8.w),
              decoration: BoxDecoration(
                color: isSelected
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    dayLabel,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: isSelected ? Colors.white : null,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 6.h),
                  Text(
                    dateLabel,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: isSelected ? Colors.white : null,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
