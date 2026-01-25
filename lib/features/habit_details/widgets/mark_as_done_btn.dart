import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habit_tracker/data/models/habit_model.dart';
import 'package:habit_tracker/core/styles/colors.dart';
import 'package:habit_tracker/cubit/habit_cubit.dart';
import 'package:habit_tracker/generated/locale_keys.g.dart';

class MarkAsDoneBtn extends StatelessWidget {
  final HabitModel habit;
  const MarkAsDoneBtn({super.key, required this.habit});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<HabitCubit>();
    final todayKey = DateTime.now().toIso8601String().substring(0, 10);
    final doneToday = habit.completedDates.contains(todayKey);

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          final newDates = {...habit.completedDates};

          doneToday ? newDates.remove(todayKey) : newDates.add(todayKey);

          cubit.updateHabit(habit.copyWith(completedDates: newDates));

          Navigator.pop(context);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: doneToday ? Colors.grey : ColorsManager.primaryColor,
          padding: EdgeInsets.symmetric(vertical: 14.h),
        ),
        child: Text(
          doneToday
              ? LocaleKeys.habitDetails_markUndone.tr()
              : LocaleKeys.habitDetails_markDone.tr(),
          style: GoogleFonts.poppins(fontSize: 16.sp, color: Colors.white),
        ),
      ),
    );
  }
}
