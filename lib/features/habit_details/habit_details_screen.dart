import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_tracker/core/helpers/spacing.dart';
import 'package:habit_tracker/data/models/habit_model.dart';
import 'package:habit_tracker/cubit/habit_cubit.dart';
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
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(habit.title),
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
          children: [
            ProgressCardWidget(habit: habit),
            verticalSpace(20),
            Row(
              children: [
                StatCardWidget(
                  title: LocaleKeys.habitDetails_streakTitle.tr(),
                  value: habit.currentStreak(context.read<HabitCubit>().state.selectedDay,).toString(),
                  icon: Icons.local_fire_department,
                ),
                horizontalSpace(12),
                StatCardWidget(
                  title: LocaleKeys.habitDetails_completedTitle.tr(),
                  value: habit.completedDates.length.toString(),
                  icon: Icons.check_circle,
                ),
              ],
            ),
            verticalSpace(20),
            WeekDaysWidget(habit: habit, selectedDay: context.read<HabitCubit>().state.selectedDay),
            const Spacer(),
            MarkAsDoneBtn(habit: habit),
          ],
        ),
      ),
    );
  }
}
