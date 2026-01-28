import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:habit_tracker/core/helpers/spacing.dart';
import 'package:habit_tracker/generated/locale_keys.g.dart';

class AboutAppSection extends StatelessWidget {
  const AboutAppSection({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(LocaleKeys.settings_about.tr(), style: textTheme.titleSmall),
        verticalSpace(6),
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(18),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Habit Tracker", style: textTheme.titleMedium),
              verticalSpace(4),
              Text("Version 1.0.0", style: textTheme.bodySmall),
              verticalSpace(6),
              Text("Built with Flutter 💙", style: textTheme.bodyMedium),
            ],
          ),
        ),
      ],
    );
  }
}
