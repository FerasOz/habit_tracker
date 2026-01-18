import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habit_tracker/core/helpers/spacing.dart';
import 'package:habit_tracker/core/styles/colors.dart';
import 'package:habit_tracker/features/cubit/habit_cubit.dart';
import 'package:habit_tracker/features/cubit/habit_state.dart';
import 'package:habit_tracker/generated/locale_keys.g.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({super.key});
  bool isDark = false;
  String language = "English";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          LocaleKeys.settings_title.tr(),
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _sectionTitle(LocaleKeys.settings_appearance.tr()),
          _settingsCard(
            child: Row(
              children: [
                const Icon(Icons.dark_mode_outlined),
                horizontalSpace(12),
                Expanded(
                  child: Text(
                    LocaleKeys.settings_darkMode.tr(),
                    style: GoogleFonts.poppins(fontSize: 15.sp),
                  ),
                ),
                Switch(
                  value: isDark,
                  activeColor: ColorsManager.primaryColor,
                  onChanged: (v) {
                    //todo change theme mode
                  },
                ),
              ],
            ),
          ),

          verticalSpace(14),

          _sectionTitle(LocaleKeys.settings_language.tr()),
          _settingsCard(
            child: Row(
              children: [
                const Icon(Icons.language),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    LocaleKeys.settings_language.tr(),
                    style: GoogleFonts.poppins(fontSize: 16.sp),
                  ),
                ),
                BlocBuilder<HabitCubit, HabitState>(
                  builder: (context, state) {
                    return DropdownButton<Locale>(
                      value: state.locale,
                      underline: const SizedBox(),
                      items: [
                        DropdownMenuItem(
                          value: const Locale('en'),
                          child: Text(LocaleKeys.settings_english.tr()),
                        ),
                        DropdownMenuItem(
                          value: const Locale('ar'),
                          child: Text(LocaleKeys.settings_arabic.tr()),
                        ),
                      ],
                      onChanged: (locale) {
                        if (locale == null) return;
                        context.read<HabitCubit>().changeLanguage(
                          context,
                          locale,
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),

          verticalSpace(14),

          _sectionTitle(LocaleKeys.settings_about.tr()),
          _settingsCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Habit Tracker App",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: 16.sp,
                  ),
                ),
                verticalSpace(4),
                Text(
                  "Version 1.0.0",
                  style: GoogleFonts.poppins(
                    color: Colors.grey,
                    fontSize: 14.sp,
                  ),
                ),
                verticalSpace(6),
                Text(
                  "Built with Flutter 💙",
                  style: GoogleFonts.poppins(fontSize: 14.sp),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        title,
        style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 14),
      ),
    );
  }

  Widget _settingsCard({required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: child,
    );
  }
}
