import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habit_tracker/core/models/habit_model.dart';
import 'package:habit_tracker/core/styles/colors.dart';

class WeekDaysWidget extends StatelessWidget {
  final HabitModel habit;

  const WeekDaysWidget({super.key, required this.habit});

  @override
  Widget build(BuildContext context) {
    final days = ["M", "T", "W", "T", "F", "S", "S"];
    return Column(
      children: [
        Text(
          "This Week",
          style: GoogleFonts.poppins(
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(7, (index) {
            final isActive = habit.activeDays.contains(index);
            return Column(
              children: [
                CircleAvatar(
                  radius: 18,
                  backgroundColor: isActive
                      ? ColorsManager.primaryColor
                      : Colors.grey.shade300,
                  child: Icon(
                    isActive ? Icons.check : Icons.close,
                    size: 16,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 6),
                Text(days[index]),
              ],
            );
          }),
        ),
      ],
    );
  }
}
