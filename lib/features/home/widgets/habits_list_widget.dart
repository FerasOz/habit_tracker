import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habit_tracker/core/helpers/spacing.dart';
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
          "No habits yet",
          style: GoogleFonts.poppins(color: Colors.grey),
        ),
      );
    }

    return ListView.separated(
      itemCount: state.habits.length,
      separatorBuilder: (_, __) => verticalSpace(12),
      itemBuilder: (context, index) {
        final habit = state.habits[index];

        final progress = habit.targetPerWeek == 0
            ? 0.0
            : (habit.completedDays / habit.targetPerWeek).clamp(0.0, 1.0);

        return HabitCardWidget(
          habit: habit,
          progress: progress,
        );
      },
    );
  }
}

