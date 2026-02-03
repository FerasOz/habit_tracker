import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:habit_tracker/core/helpers/spacing.dart';
import 'package:habit_tracker/generated/locale_keys.g.dart';

class AboutAppSection extends StatelessWidget {
  const AboutAppSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(LocaleKeys.settings_about.tr(), style: textTheme.titleSmall),
        verticalSpace(6),
        Container(
          decoration: BoxDecoration(
            color: theme.cardColor,
            borderRadius: BorderRadius.circular(18),
          ),
          child: Column(
            children: [
              ListTile(
                leading: const Icon(Icons.track_changes),
                title: Text(
                  LocaleKeys.home_title.tr(),
                  style: textTheme.titleMedium,
                ),
                subtitle: Text(
                  LocaleKeys.home_subtitle.tr(),
                  style: textTheme.bodySmall,
                ),
              ),
              const Divider(height: 1),
              ListTile(
                leading: const Icon(Icons.info_outline),
                title: Text(
                  LocaleKeys.settings_version.tr(),
                  style: textTheme.bodyMedium,
                ),
                trailing: Text("1.0.0", style: textTheme.bodySmall),
              ),
              ListTile(
                leading: const Icon(Icons.code),
                title: Text(
                  LocaleKeys.settings_builtWith.tr(),
                  style: textTheme.bodyMedium,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
