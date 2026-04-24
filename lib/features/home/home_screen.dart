import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_tracker/core/helpers/constants.dart';
import 'package:habit_tracker/core/helpers/spacing.dart';
import 'package:habit_tracker/core/routing/routes.dart';
import 'package:habit_tracker/cubit/habit_cubit.dart';
import 'package:habit_tracker/cubit/habit_state.dart';
import 'package:habit_tracker/features/home/widgets/habits_list_widget.dart';
import 'package:habit_tracker/features/home/widgets/summary_card_widget.dart';
import 'package:habit_tracker/features/home/widgets/week_selector_widget.dart';
import 'package:habit_tracker/generated/locale_keys.g.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(LocaleKeys.home_title.tr(), style: textTheme.titleLarge),
            Text(LocaleKeys.home_subtitle.tr(), style: textTheme.bodySmall),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.pushNamed(context, Routes.settingsScreen);
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<HabitCubit>().resetHabitForm();
          Navigator.pushNamed(context, Routes.addHabitScreen);
        },
        child: const Icon(Icons.add),
      ),
      body: BlocBuilder<HabitCubit, HabitState>(
        builder: (context, state) {
          if (state.fetchHabitsStatus == RequestsStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          final habits = context.read<HabitCubit>().habitsForSelectedDay;
          final todayKey = DateFormat('yyyy-MM-dd').format(state.selectedDay);

          final doneCount = habits
              .where((h) => h.completedDates.contains(todayKey))
              .length;
          final remainingCount = habits.length - doneCount;
          final totalWeeklyRemaining = habits.fold<int>(
            0,
            (sum, habit) => sum + habit.remainingThisWeek(state.selectedDay),
          );
          final strongestStreak = habits.fold<int>(0, (best, habit) {
            final streak = habit.currentStreak(state.selectedDay);
            return streak > best ? streak : best;
          });

          return RefreshIndicator(
            onRefresh: () {
              return context.read<HabitCubit>().fetchHabits();
            },
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  WeekSelectorWidget(
                    selectedDay: state.selectedDay,
                    onDaySelected: context.read<HabitCubit>().changeSelectedDay,
                  ),
                  verticalSpace(14),
                  SummaryCardWidget(
                    done: doneCount,
                    total: habits.length,
                    progress: habits.isEmpty ? 0 : doneCount / habits.length,
                  ),
                  verticalSpace(10),
                  _HomeInsightBanner(
                    selectedDay: state.selectedDay,
                    weeklyRemaining: totalWeeklyRemaining,
                    strongestStreak: strongestStreak,
                    doneCount: doneCount,
                    totalCount: habits.length,
                  ),
                  verticalSpace(10),
                  Row(
                    children: [
                      _StatusPill(
                        icon: Icons.check_circle,
                        color: Colors.green,
                        label: "$doneCount",
                        subtitle: LocaleKeys.home_statusDone.tr(),
                      ),
                      horizontalSpace(10),
                      _StatusPill(
                        icon: Icons.pending_actions,
                        color: Colors.orange,
                        label: "$remainingCount",
                        subtitle: LocaleKeys.home_statusRemaining.tr(),
                      ),
                    ],
                  ),
                  verticalSpace(16),
                  Expanded(
                    child: habits.isEmpty
                        ? _EmptyHabitsState(textTheme: textTheme)
                        : HabitsListWidget(
                            habits: habits,
                            selectedDay: state.selectedDay,
                          ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _HomeInsightBanner extends StatelessWidget {
  final DateTime selectedDay;
  final int weeklyRemaining;
  final int strongestStreak;
  final int doneCount;
  final int totalCount;

  const _HomeInsightBanner({
    required this.selectedDay,
    required this.weeklyRemaining,
    required this.strongestStreak,
    required this.doneCount,
    required this.totalCount,
  });

  @override
  Widget build(BuildContext context) {
    final isToday = DateUtils.isSameDay(selectedDay, DateTime.now());
    final message = totalCount == 0
        ? LocaleKeys.home_insightEmpty.tr()
        : doneCount == totalCount
            ? LocaleKeys.home_insightAllDone.tr()
            : LocaleKeys.home_insightProgress.tr(
                namedArgs: {
                  'weeklyRemaining': '$weeklyRemaining',
                  'strongestStreak': '$strongestStreak',
                },
              );

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Icon(
            isToday ? Icons.wb_sunny_outlined : Icons.calendar_today_outlined,
          ),
          horizontalSpace(10),
          Expanded(
            child: Text(
              message,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}

class _StatusPill extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String label;
  final String subtitle;

  const _StatusPill({
    required this.icon,
    required this.color,
    required this.label,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          children: [
            Icon(icon, size: 18, color: color),
            horizontalSpace(8),
            Text(label, style: Theme.of(context).textTheme.titleSmall),
            horizontalSpace(6),
            Text(subtitle, style: Theme.of(context).textTheme.bodySmall),
          ],
        ),
      ),
    );
  }
}

class _EmptyHabitsState extends StatelessWidget {
  final TextTheme textTheme;

  const _EmptyHabitsState({required this.textTheme});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.track_changes_rounded,
            size: 52,
            color: Theme.of(context).colorScheme.primary.withOpacity(0.9),
          ),
          verticalSpace(12),
          Text(
            LocaleKeys.home_emptyHabits.tr(),
            textAlign: TextAlign.center,
            style: textTheme.bodyMedium,
          ),
          verticalSpace(16),
          ElevatedButton.icon(
            onPressed: () => Navigator.pushNamed(context, Routes.addHabitScreen),
            icon: const Icon(Icons.add),
            label: Text(LocaleKeys.addHabit_title.tr()),
          ),
        ],
      ),
    );
  }
}
