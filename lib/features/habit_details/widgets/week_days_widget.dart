import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habit_tracker/core/helpers/spacing.dart';
import 'package:habit_tracker/data/models/habit_model.dart';
import 'package:habit_tracker/core/styles/colors.dart';
import 'package:habit_tracker/generated/locale_keys.g.dart';

class WeekDaysWidget extends StatelessWidget {
  final HabitModel habit;

  const WeekDaysWidget({super.key, required this.habit});

  @override
  Widget build(BuildContext context) {
    final days = ["M", "T", "W", "T", "F", "S", "S"];
    return Column(
      children: [
        Text(
          LocaleKeys.habitDetails_thisWeek.tr(),
          style: GoogleFonts.poppins(
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        verticalSpace(12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(7, (index) {
            final isActive = habit.activeDays.contains(index);
            return Column(
              children: [
                CircleAvatar(
                  radius: 18.r,
                  backgroundColor: isActive
                      ? ColorsManager.primaryColor
                      : Colors.grey.shade300,
                  child: Icon(
                    isActive ? Icons.check : Icons.close,
                    size: 16,
                    color: Colors.white,
                  ),
                ),
                verticalSpace(6),
                Text(days[index]),
              ],
            );
          }),
        ),
      ],
    );
  }
}
