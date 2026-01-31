import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:habit_tracker/core/helpers/spacing.dart';
import 'package:habit_tracker/core/styles/colors.dart';

class ActiveDaysRow extends StatelessWidget {
  final List<int> activeDays;

  const ActiveDaysRow({super.key, required this.activeDays});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final days = ["M", "T", "W", "T", "F", "S", "S"];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(7, (index) {
        final dayNumber = index + 1;
        final active = activeDays.contains(dayNumber);

        return Column(
          children: [
            Text(days[index], style: theme.textTheme.bodySmall),
            verticalSpace(4),
            Container(
              width: 18.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: active
                    ? ColorsManager.primary
                    : theme.dividerColor.withOpacity(0.3),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ],
        );
      }),
    );
  }
}
