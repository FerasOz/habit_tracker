import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:habit_tracker/core/routing/routes.dart';
import 'package:habit_tracker/features/cubit/habit_state.dart';

class HabitsListWidget extends StatelessWidget {
  HabitState state;
  
  HabitsListWidget({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: state.habits.length,
      separatorBuilder: (_, _) => SizedBox(height: 12.h),
      itemBuilder: (context, index) {
        final habit = state.habits[index];

        return ListTile(
          onTap: () {
            Navigator.pushNamed(
              context,
              Routes.habitDetailsScreen,
              arguments: habit,
            );
          },
          leading: Icon(
            habit.doneToday ? Icons.check_circle : Icons.circle_outlined,
            color: habit.doneToday ? Colors.green : Colors.grey,
          ),
          title: Text(habit.title),
          subtitle: habit.description == null || habit.description!.isEmpty
              ? null
              : Text(habit.description!),
        );
      },
    );
  }
}
