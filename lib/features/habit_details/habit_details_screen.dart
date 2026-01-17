import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habit_tracker/core/helpers/spacing.dart';
import 'package:habit_tracker/core/models/habit_model.dart';
import 'package:habit_tracker/features/cubit/habit_cubit.dart';
import 'package:habit_tracker/features/habit_details/widgets/mark_as_done_btn.dart';
import 'package:habit_tracker/features/habit_details/widgets/progress_card_widget.dart';
import 'package:habit_tracker/features/habit_details/widgets/stat_card_widget.dart';
import 'package:habit_tracker/features/habit_details/widgets/week_days_widget.dart';
import 'package:habit_tracker/generated/locale_keys.g.dart';

class HabitDetailsScreen extends StatelessWidget {
  final HabitModel habit;

  const HabitDetailsScreen({super.key, required this.habit});

  @override
  Widget build(BuildContext context) {
    
    final cubit = context.read<HabitCubit>();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          habit.title,
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline),
            onPressed: () {
              cubit.deleteHabit(habit.id);
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProgressCardWidget(habit: habit),
            verticalSpace(20),
            Row(
              children: [
                StatCardWidget(
                  title: LocaleKeys.habitDetails_streakTitle.tr(),
                  value: "${habit.currentStreak} ${LocaleKeys.habitDetails_days.tr()}",
                  icon: Icons.local_fire_department,
                ),
                verticalSpace(12),
                StatCardWidget(
                  title: LocaleKeys.habitDetails_completedTitle.tr(),
                  value: "${habit.completedDays}",
                  icon: Icons.check_circle,
                ),
              ],
            ),
            verticalSpace(20),
            WeekDaysWidget(habit: habit),
            const Spacer(),
            MarkAsDoneBtn(habit: habit),
          ],
        ),
      ),
    );
  }
}
