import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habit_tracker/core/styles/colors.dart';
import 'package:habit_tracker/features/cubit/habit_state.dart';
import 'package:habit_tracker/features/home/widgets/habit_card_widget.dart';

class HabitsListWidget extends StatelessWidget {
  final HabitState state;

  const HabitsListWidget({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    if (state.habits.isEmpty) {
      return Center(
        child: Text(
          "No habits yet 🌱",
          style: GoogleFonts.poppins(color: Colors.grey),
        ),
      );
    }

    return ListView.separated(
      itemCount: state.habits.length,
      separatorBuilder: (_, __) => SizedBox(height: 12.h),
      itemBuilder: (context, index) {
        final habit = state.habits[index];

        final progress = habit.targetPerWeek == 0
            ? 0.0
            : (habit.completedDays / habit.targetPerWeek).clamp(0.0, 1.0);

        final achieved = habit.completedDays >= habit.targetPerWeek;
        final streakColor = _streakColor(habit.currentStreak);

        return HabitCardWidget(
          progress: progress,
          habit: habit,
          achieved: achieved,
          streakColor: streakColor,
        );
      },
    );
  }

  Color _streakColor(int streak) {
    if (streak >= 30) return Colors.orange;
    if (streak >= 14) return Colors.deepPurple;
    if (streak >= 7) return Colors.blue;
    return ColorsManager.primaryColor;
  }
}
