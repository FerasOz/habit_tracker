import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_tracker/core/helpers/dialogs.dart';
import 'package:habit_tracker/core/helpers/spacing.dart';
import 'package:habit_tracker/core/routing/routes.dart';
import 'package:habit_tracker/cubit/habit_cubit.dart';
import 'package:habit_tracker/cubit/habit_state.dart';
import 'package:habit_tracker/data/models/habit_model.dart';
import 'package:habit_tracker/features/habit_details/widgets/mark_as_done_btn.dart';
import 'package:habit_tracker/features/habit_details/widgets/progress_card_widget.dart';
import 'package:habit_tracker/features/habit_details/widgets/stat_card_widget.dart';
import 'package:habit_tracker/features/habit_details/widgets/week_days_widget.dart';
import 'package:habit_tracker/features/home/widgets/week_selector_widget.dart';
import 'package:habit_tracker/generated/locale_keys.g.dart';

class HabitDetailsScreen extends StatelessWidget {
  final HabitModel habit;

  const HabitDetailsScreen({super.key, required this.habit});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<HabitCubit>();

    return BlocBuilder<HabitCubit, HabitState>(
      builder: (context, state) {
        final currentHabit = cubit.habitById(habit.id);
        if (currentHabit == null) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }
          });
          return const SizedBox.shrink();
        }

        final statWidth = (MediaQuery.of(context).size.width - 44) / 2;

        return Scaffold(
          appBar: AppBar(
            title: Text(currentHabit.title),
            actions: [
              IconButton(
                icon: const Icon(Icons.edit_outlined),
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    Routes.addHabitScreen,
                    arguments: currentHabit,
                  );
                },
              ),
              IconButton(
                icon: const Icon(Icons.delete_outline),
                onPressed: () async {
                  final confirmed = await showConfirmDeleteDialog(context);

                  if (confirmed == true) {
                    cubit.deleteHabit(currentHabit.id);
                    Navigator.pop(context);
                  }
                },
              ),
            ],
          ),
          body: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              WeekSelectorWidget(
                selectedDay: state.selectedDay,
                onDaySelected: context.read<HabitCubit>().changeSelectedDay,
              ),
              verticalSpace(14),
              ProgressCardWidget(habit: currentHabit),
              verticalSpace(14),
              if (currentHabit.description != null &&
                  currentHabit.description!.trim().isNotEmpty)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Text(
                    currentHabit.description!,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              if (currentHabit.description != null &&
                  currentHabit.description!.trim().isNotEmpty)
                verticalSpace(14),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  SizedBox(
                    width: statWidth,
                    child: StatCardWidget(
                      title: LocaleKeys.habitDetails_streakTitle.tr(),
                      value: currentHabit.currentStreak(state.selectedDay).toString(),
                      icon: Icons.local_fire_department,
                    ),
                  ),
                  SizedBox(
                    width: statWidth,
                    child: StatCardWidget(
                      title: LocaleKeys.habitDetails_completedTitle.tr(),
                      value: currentHabit.completedDates.length.toString(),
                      icon: Icons.check_circle,
                    ),
                  ),
                  SizedBox(
                    width: statWidth,
                    child: StatCardWidget(
                      title: LocaleKeys.habitDetails_bestStreakTitle.tr(),
                      value: currentHabit.bestStreak().toString(),
                      icon: Icons.emoji_events_outlined,
                    ),
                  ),
                  SizedBox(
                    width: statWidth,
                    child: StatCardWidget(
                      title: LocaleKeys.habitDetails_consistencyTitle.tr(),
                      value:
                          "${(currentHabit.completionRate(state.selectedDay) * 100).round()}%",
                      icon: Icons.insights_outlined,
                    ),
                  ),
                ],
              ),
              verticalSpace(14),
              _InsightCard(habit: currentHabit, selectedDay: state.selectedDay),
              verticalSpace(20),
              WeekDaysWidget(
                habit: currentHabit,
                selectedDay: state.selectedDay,
              ),
              verticalSpace(20),
              MarkAsDoneBtn(habit: currentHabit),
              verticalSpace(8),
            ],
          ),
        );
      },
    );
  }
}

class _InsightCard extends StatelessWidget {
  final HabitModel habit;
  final DateTime selectedDay;

  const _InsightCard({required this.habit, required this.selectedDay});

  @override
  Widget build(BuildContext context) {
    final isActiveDay = habit.isActiveOn(selectedDay);
    final isDone = habit.isCompletedOn(selectedDay);
    final remaining = habit.remainingThisWeek(selectedDay);

    final message = isDone
        ? LocaleKeys.habitDetails_insightDone.tr()
        : isActiveDay
            ? remaining == 0
                ? LocaleKeys.habitDetails_insightGoalReached.tr()
                : LocaleKeys.habitDetails_insightActivePending.tr()
            : LocaleKeys.habitDetails_insightRestDay.tr();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: Theme.of(context).dividerColor.withOpacity(0.2),
        ),
      ),
      child: Text(
        message,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
  }
}
