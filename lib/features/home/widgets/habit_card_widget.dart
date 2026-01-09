import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:habit_tracker/core/models/habit_model.dart';
import 'package:habit_tracker/features/cubit/habit_cubit.dart';
import 'package:habit_tracker/features/home/widgets/habit_item_widget.dart';

class HabitCardWidget extends StatelessWidget {
  final double progress;
  final HabitModel habit;
  final bool achieved;
  final Color streakColor;

  const HabitCardWidget({
    super.key,
    required this.progress,
    required this.habit,
    required this.achieved,
    required this.streakColor,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(habit.id),

      background: Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(left: 20.w),
        decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: const Icon(Icons.check, color: Colors.white),
      ),

      secondaryBackground: Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20.w),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: const Icon(Icons.delete, color: Colors.white),
      ),

      confirmDismiss: (direction) async {
        final cubit = context.read<HabitCubit>();

        if (direction == DismissDirection.startToEnd) {
          cubit.updateHabit(
            habit.copyWith(
              doneToday: true,
              completedDays: habit.completedDays + 1,
              currentStreak: habit.currentStreak + 1,
            ),
          );
          return false;
        } else {
          cubit.deleteHabit(habit.id);
          return true;
        }
      },

      child: HabitItemWidget(
        progress: progress,
        habit: habit,
        achieved: achieved,
        streakColor: streakColor,
      ),
    );
  }
}
