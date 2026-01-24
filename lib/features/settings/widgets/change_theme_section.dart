import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habit_tracker/core/helpers/spacing.dart';
import 'package:habit_tracker/core/styles/colors.dart';
import 'package:habit_tracker/generated/locale_keys.g.dart';

class ChangeThemeSection extends StatelessWidget {
  bool isDark = false;
  ChangeThemeSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          LocaleKeys.settings_appearance.tr(),
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            fontSize: 14.sp,
          ),
        ),
        verticalSpace(6),
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
          ),
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
                activeThumbColor: ColorsManager.primaryColor,
                onChanged: (v) {
                  //todo change theme mode
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
