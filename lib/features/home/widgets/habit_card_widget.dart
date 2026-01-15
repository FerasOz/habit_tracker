import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:habit_tracker/core/models/habit_model.dart';
import 'package:habit_tracker/features/cubit/habit_cubit.dart';
import 'package:habit_tracker/features/home/widgets/habit_item_widget.dart';

class HabitCardWidget extends StatelessWidget {
  final HabitModel habit;
  final double progress;

  const HabitCardWidget({
    super.key,
    required this.habit,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<HabitCubit>();

    return Dismissible(
      key: ValueKey(habit.id),

      background: _swipeBackground(
        color: Colors.green,
        icon: Icons.check,
        alignment: Alignment.centerLeft,
      ),

      secondaryBackground: _swipeBackground(
        color: Colors.red,
        icon: Icons.delete,
        alignment: Alignment.centerRight,
      ),

      confirmDismiss: (direction) async {
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
        habit: habit,
      ),
    );
  }

  Widget _swipeBackground({
    required Color color,
    required IconData icon,
    required Alignment alignment,
  }) {
    return Container(
      alignment: alignment,
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(18.r),
      ),
      child: Icon(icon, color: Colors.white),
    );
  }
}
