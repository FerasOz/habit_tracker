import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:habit_tracker/core/helpers/spacing.dart';
import 'package:habit_tracker/core/styles/colors.dart';
import 'package:habit_tracker/features/settings/widgets/about_app_section.dart';
import 'package:habit_tracker/features/settings/widgets/change_lang_section.dart';
import 'package:habit_tracker/features/settings/widgets/change_theme_section.dart';
import 'package:habit_tracker/generated/locale_keys.g.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(LocaleKeys.settings_title.tr())),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _SettingsHeader(),
          verticalSpace(16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ChangeThemeSection(),
              verticalSpace(16),
              ChangeLangSection(),
              verticalSpace(16),
              AboutAppSection(),
            ],
          ),
        ],
      ),
    );
  }
}

class _SettingsHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            ColorsManager.primary,
            ColorsManager.secondary.withOpacity(0.88),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            LocaleKeys.settings_title.tr(),
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
          verticalSpace(6),
          Text(
            context.locale.languageCode == 'ar'
                ? 'خصص تجربة التطبيق كما تحب'
                : 'Personalize the app to fit your routine',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Colors.white.withOpacity(0.95),
            ),
          ),
        ],
      ),
    );
  }
}
