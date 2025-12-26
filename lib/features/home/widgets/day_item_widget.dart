import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:habit_tracker/core/styles/colors.dart';

class DayItemWidget extends StatelessWidget {
  String label;
  bool selected;
  DayItemWidget({super.key, required this.label, required this.selected});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 12),
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: selected ? ColorsManager.primaryColor : Colors.transparent,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: selected ? Colors.transparent : const Color(0xFFCABDFF),
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: selected ? Colors.white : ColorsManager.primaryColor,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
