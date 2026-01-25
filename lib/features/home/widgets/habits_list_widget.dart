import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
       if (habits.isEmpty) {
      return Center(
        child: Text(
          LocaleKeys.home_emptyHabits.tr(),
          style: GoogleFonts.poppins(color: Colors.grey),
        ),
      );
    }

    return ListView.separated(
      itemCount: habits.length,
      separatorBuilder: (_, _) => verticalSpace(12),
      itemBuilder: (context, index) {
        return HabitCardWidget(
          habit: habits[index],
        );
      },
    );
  }
}

