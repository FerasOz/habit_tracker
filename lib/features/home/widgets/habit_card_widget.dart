import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:habit_tracker/core/styles/colors.dart';
import 'package:habit_tracker/data/models/habit_model.dart';
import 'package:habit_tracker/cubit/habit_cubit.dart';
import 'package:habit_tracker/features/home/widgets/habit_item_widget.dart';

class HabitCardWidget extends StatelessWidget {
  final HabitModel habit;

  const HabitCardWidget({super.key, required this.habit});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<HabitCubit>();
    final todayKey = DateTime.now().toIso8601String().substring(0, 10);
    final isDoneToday = habit.completedDates.contains(todayKey);

    return Dismissible(
      key: ValueKey(habit.id),

      background: _swipeBackground(
        color: ColorsManager.success,
        icon: Icons.check,
        alignment: Alignment.centerLeft,
      ),

      secondaryBackground: _swipeBackground(
        color: ColorsManager.danger,
        icon: Icons.delete,
        alignment: Alignment.centerRight,
      ),

      confirmDismiss: (direction) async {
        if (direction == DismissDirection.startToEnd) {
          final updatedDates = {...habit.completedDates};

          isDoneToday
              ? updatedDates.remove(todayKey)
              : updatedDates.add(todayKey);

          cubit.updateHabit(habit.copyWith(completedDates: updatedDates));
          return false;
        } else {
          cubit.deleteHabit(habit.id);
          return true;
        }
      },

      child: HabitItemWidget(habit: habit),
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
