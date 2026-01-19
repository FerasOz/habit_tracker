import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habit_tracker/core/helpers/spacing.dart';
import 'package:habit_tracker/generated/locale_keys.g.dart';

class AboutAppSection extends StatelessWidget {
  const AboutAppSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          LocaleKeys.settings_about.tr(),
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
                style: GoogleFonts.poppins(color: Colors.grey, fontSize: 14.sp),
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
    );
  }
}
