import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:habit_tracker/core/styles/colors.dart';
import 'package:habit_tracker/cubit/habit_cubit.dart';
import 'package:habit_tracker/data/models/habit_model.dart';
import 'package:habit_tracker/generated/locale_keys.g.dart';

class MarkAsDoneBtn extends StatelessWidget {
  final HabitModel habit;

  const MarkAsDoneBtn({super.key, required this.habit});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<HabitCubit>();
    final selectedDay = cubit.state.selectedDay;
    final selectedDayKey = DateFormat('yyyy-MM-dd').format(selectedDay);
    final isActiveDay = habit.activeDays.contains(selectedDay.weekday);
    final doneOnSelectedDay = habit.completedDates.contains(selectedDayKey);

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: isActiveDay
            ? () {
                final newDates = {...habit.completedDates};

                doneOnSelectedDay
                    ? newDates.remove(selectedDayKey)
                    : newDates.add(selectedDayKey);

                cubit.updateHabit(habit.copyWith(completedDates: newDates));
              }
            : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: !isActiveDay
              ? Colors.grey.shade500
              : doneOnSelectedDay
                  ? Colors.grey
                  : ColorsManager.primary,
          padding: EdgeInsets.symmetric(vertical: 14.h),
        ),
        child: Text(
          !isActiveDay
              ? LocaleKeys.habitDetails_inactiveDay.tr()
              : doneOnSelectedDay
                  ? LocaleKeys.habitDetails_markUndone.tr()
                  : LocaleKeys.habitDetails_markDone.tr(),
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(color: Colors.white),
        ),
      ),
    );
  }
}
