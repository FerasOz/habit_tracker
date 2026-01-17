import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habit_tracker/core/helpers/spacing.dart';
import 'package:habit_tracker/core/styles/colors.dart';
import 'package:habit_tracker/generated/locale_keys.g.dart';

class SummaryCardWidget extends StatelessWidget {
  final int done;
  final int total;
  final double progress;

  const SummaryCardWidget({
    super.key,
    required this.done,
    required this.total,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    final percentage = (progress * 100).toInt();

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            ColorsManager.primaryColor,
            ColorsManager.primaryColor.withOpacity(0.85),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                LocaleKeys.home_summary_title.tr(),
                style: GoogleFonts.poppins(
                  color: Colors.white70,
                  fontSize: 14.sp,
                ),
              ),
              Icon(
                Icons.trending_up,
                color: Colors.white70,
                size: 22.sp,
              ),
            ],
          ),
          verticalSpace(12),
          Text(
            "$done / $total ${LocaleKeys.home_summary_completed.tr()}",
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          verticalSpace(6.h),
          Text(
            "$percentage%",
            style: GoogleFonts.poppins(
              color: Colors.white70,
              fontSize: 14.sp,
            ),
          ),
          verticalSpace(14.h),
          ClipRRect(
            borderRadius: BorderRadius.circular(10.r),
            child: LinearProgressIndicator(
              value: progress.clamp(0.0, 1.0),
              minHeight: 8.h,
              backgroundColor: Colors.white24,
              valueColor: const AlwaysStoppedAnimation(Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
