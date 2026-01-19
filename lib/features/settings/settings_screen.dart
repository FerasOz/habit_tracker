import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habit_tracker/core/helpers/spacing.dart';
import 'package:habit_tracker/features/settings/widgets/about_app_section.dart';
import 'package:habit_tracker/features/settings/widgets/change_lang_section.dart';
import 'package:habit_tracker/features/settings/widgets/change_theme_section.dart';
import 'package:habit_tracker/generated/locale_keys.g.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          LocaleKeys.settings_title.tr(),
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ChangeThemeSection(),
            verticalSpace(14),
            ChangeLangSection(),
            verticalSpace(14),
            AboutAppSection(),
          ],
        ),
      ),
    );
  }
}
