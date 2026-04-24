import 'package:easy_localization/easy_localization.dart';
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

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(7, (index) {
        final dayNumber = index + 1;
        final active = activeDays.contains(dayNumber);
        final dayDate = DateTime(2024, 1, dayNumber);
        final dayLabel = DateFormat(
          'EEEEE',
          context.locale.languageCode,
        ).format(dayDate);

        return Column(
          children: [
            Text(dayLabel, style: theme.textTheme.bodySmall),
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
