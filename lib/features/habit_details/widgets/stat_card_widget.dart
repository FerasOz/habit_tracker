import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:habit_tracker/core/helpers/spacing.dart';
import 'package:habit_tracker/core/styles/colors.dart';

class StatCardWidget extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const StatCardWidget({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Column(
          children: [
            Icon(icon, color: ColorsManager.primary),
            verticalSpace(8),
            Text(value, style: textTheme.titleLarge),
            Text(title, style: textTheme.bodySmall),
          ],
        ),
      ),
    );
  }
}
