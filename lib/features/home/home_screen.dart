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

          if (habits.isEmpty) {
            return Center(
              child: Text(
                LocaleKeys.home_emptyHabits.tr(),
                style: textTheme.bodyMedium,
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () {
              return context.read<HabitCubit>().fetchHabits();
            },
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  SummaryCardWidget(
                    done: doneCount,
                    total: habits.length,
                    progress: habits.isEmpty ? 0 : doneCount / habits.length,
                  ),
                  verticalSpace(16),
                  Expanded(
                    child: HabitsListWidget(
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
