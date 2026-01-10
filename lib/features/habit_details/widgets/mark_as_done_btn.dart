import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habit_tracker/core/models/habit_model.dart';
import 'package:habit_tracker/core/styles/colors.dart';
import 'package:habit_tracker/features/cubit/habit_cubit.dart';

class MarkAsDoneBtn extends StatelessWidget {
  final HabitModel habit;
  const MarkAsDoneBtn({super.key, required this.habit});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<HabitCubit>();

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          final updatedHabit = HabitModel(
            id: habit.id,
            title: habit.title,
            description: habit.description,
            createdAt: habit.createdAt,
            targetPerWeek: habit.targetPerWeek,
            completedDays: habit.doneToday
                ? habit.completedDays - 1
                : habit.completedDays + 1,
            currentStreak: habit.doneToday
                ? habit.currentStreak - 1
                : habit.currentStreak + 1,
            doneToday: !habit.doneToday,
            activeDays: habit.activeDays,
          );

          cubit.updateHabit(updatedHabit);
          Navigator.pop(context);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: habit.doneToday
              ? Colors.grey
              : ColorsManager.primaryColor,
          padding: EdgeInsets.symmetric(vertical: 14.h),
        ),
        child: Text(
          habit.doneToday ? "Undo Today" : "Mark as Done Today",
          style: GoogleFonts.poppins(fontSize: 16.sp, color: Colors.white),
        ),
      ),
    );
  }
}
