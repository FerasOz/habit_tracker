import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_tracker/data/models/habit_model.dart';
import 'package:habit_tracker/cubit/habit_cubit.dart';
import 'package:habit_tracker/generated/locale_keys.g.dart';
import 'package:uuid/uuid.dart';

class SaveHabitBtn extends StatelessWidget {
  const SaveHabitBtn({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<HabitCubit>();
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          if (cubit.titleController.text.trim().isEmpty) return;

          final habit = HabitModel(
            id: const Uuid().v4(),
            title: cubit.titleController.text.trim(),
            description: cubit.descriptionController.text.trim().isEmpty
                ? null
                : cubit.descriptionController.text.trim(),
            createdAt: DateTime.now(),
            targetPerWeek: cubit.targetPerWeek.value,
            completedDays: 0,
            currentStreak: 0,
            doneToday: false,
            activeDays: cubit.activeDays.value.toList(),
          );

          cubit.addHabit(habit);
          cubit.titleController.clear();
          cubit.descriptionController.clear();
          Navigator.pop(context);
        },
        child: Text(LocaleKeys.addHabit_save.tr()),
      ),
    );
  }
}
