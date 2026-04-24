import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:habit_tracker/core/helpers/spacing.dart';
import 'package:habit_tracker/data/models/habit_model.dart';
import 'package:habit_tracker/features/home/widgets/habit_card_widget.dart';
import 'package:habit_tracker/generated/locale_keys.g.dart';

class HabitsListWidget extends StatelessWidget {
  final List<HabitModel> habits;
  final DateTime selectedDay;

  const HabitsListWidget({
    super.key,
    required this.habits,
    required this.selectedDay,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final selectedKey = DateFormat('yyyy-MM-dd').format(selectedDay);

    if (habits.isEmpty) {
      return Center(
        child: Text(
          LocaleKeys.home_emptyHabits.tr(),
          style: textTheme.bodyMedium,
        ),
      );
    }

    final sortedHabits = [...habits]
      ..sort((a, b) {
        final aDone = a.completedDates.contains(selectedKey);
        final bDone = b.completedDates.contains(selectedKey);
        if (aDone != bDone) {
          return aDone ? 1 : -1;
        }
        return a.title.toLowerCase().compareTo(b.title.toLowerCase());
      });

    return ListView.separated(
      itemCount: sortedHabits.length,
      separatorBuilder: (_, _) => verticalSpace(12),
      itemBuilder: (context, index) {
        return HabitCardWidget(habit: sortedHabits[index]);
      },
    );
  }
}
