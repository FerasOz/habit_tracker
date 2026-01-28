import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:habit_tracker/core/helpers/spacing.dart';
import 'package:habit_tracker/features/settings/widgets/about_app_section.dart';
import 'package:habit_tracker/features/settings/widgets/change_lang_section.dart';
import 'package:habit_tracker/features/settings/widgets/change_theme_section.dart';
import 'package:habit_tracker/generated/locale_keys.g.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: Text(LocaleKeys.settings_title.tr())),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ChangeThemeSection(),
            verticalSpace(16),
            ChangeLangSection(),
            verticalSpace(16),
            AboutAppSection(),
          ],
        ),
      ),
    );
  }
}
