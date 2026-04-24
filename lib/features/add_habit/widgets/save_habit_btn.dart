import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_tracker/cubit/habit_cubit.dart';
import 'package:habit_tracker/data/models/habit_model.dart';
import 'package:habit_tracker/generated/locale_keys.g.dart';
import 'package:uuid/uuid.dart';

class SaveHabitBtn extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final HabitModel? habitToEdit;

  const SaveHabitBtn({
    super.key,
    required this.formKey,
    this.habitToEdit,
  });

  @override
  State<SaveHabitBtn> createState() => _SaveHabitBtnState();
}

class _SaveHabitBtnState extends State<SaveHabitBtn> {
  bool _isSaving = false;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<HabitCubit>();
    final isEditing = widget.habitToEdit != null;

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _isSaving
            ? null
            : () async {
                FocusScope.of(context).unfocus();

                final isValid = widget.formKey.currentState?.validate() ?? false;
                if (!isValid) return;

                final selectedDays = cubit.activeDays.value.toList()..sort();
                if (selectedDays.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        LocaleKeys.addHabit_validationActiveDayRequired.tr(),
                      ),
                    ),
                  );
                  return;
                }

                final target = min(cubit.targetPerWeek.value, selectedDays.length);

                setState(() => _isSaving = true);
                try {
                  final habit = HabitModel(
                    id: widget.habitToEdit?.id ?? const Uuid().v4(),
                    title: cubit.titleController.text.trim(),
                    description: cubit.descriptionController.text.trim().isEmpty
                        ? null
                        : cubit.descriptionController.text.trim(),
                    createdAt: widget.habitToEdit?.createdAt ?? DateTime.now(),
                    activeDays: selectedDays,
                    targetPerWeek: target,
                    completedDates: widget.habitToEdit?.completedDates ?? {},
                  );

                  if (isEditing) {
                    await cubit.updateHabit(habit);
                  } else {
                    await cubit.addHabit(habit);
                  }
                  cubit.resetHabitForm();

                  if (!mounted) return;
                  Navigator.pop(context);
                } finally {
                  if (mounted) {
                    setState(() => _isSaving = false);
                  }
                }
              },
        child: _isSaving
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            : Text(
                isEditing
                    ? LocaleKeys.addHabit_saveChanges.tr()
                    : LocaleKeys.addHabit_save.tr(),
              ),
      ),
    );
  }
}
