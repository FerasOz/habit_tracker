import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habit_tracker/core/styles/colors.dart';

class SummaryCardWidget extends StatelessWidget {
  int done;
  int total;
  double progress;

  SummaryCardWidget({
    super.key,
    required this.done,
    required this.total,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: ColorsManager.primaryColor,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Today Progress",
            style: GoogleFonts.poppins(color: Colors.white70, fontSize: 14.sp),
          ),
          const SizedBox(height: 10),
          Text(
            "$done / $total Habits Completed",
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 22.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 10),
          LinearProgressIndicator(
            value: progress,
            backgroundColor: Colors.white30,
            valueColor: AlwaysStoppedAnimation(Colors.white),
          ),
        ],
      ),
    );
  }
}
