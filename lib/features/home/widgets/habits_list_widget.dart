import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habit_tracker/core/models/habit_model.dart';
import 'package:habit_tracker/core/routing/routes.dart';
import 'package:habit_tracker/core/styles/colors.dart';
import 'package:habit_tracker/features/cubit/habit_cubit.dart';
import 'package:habit_tracker/features/cubit/habit_state.dart';

class HabitsListWidget extends StatelessWidget {
  final HabitState state;

  const HabitsListWidget({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    if (state.habits.isEmpty) {
      return Center(
        child: Text(
          "No habits yet 🌱",
          style: GoogleFonts.poppins(color: Colors.grey),
        ),
      );
    }

    return ListView.separated(
      itemCount: state.habits.length,
      separatorBuilder: (_, __) => SizedBox(height: 12.h),
      itemBuilder: (context, index) {
        final habit = state.habits[index];

        final progress = habit.targetPerWeek == 0
            ? 0.0
            : (habit.completedDays / habit.targetPerWeek).clamp(0.0, 1.0);

        final achieved = habit.completedDays >= habit.targetPerWeek;
        final streakColor = _streakColor(habit.currentStreak);

        return Dismissible(
          key: ValueKey(habit.id),

          // Swipe Right → Done Today
          background: Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: 20.w),
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: const Icon(Icons.check, color: Colors.white),
          ),

          // Swipe Left → Delete
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

          child: GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                context,
                Routes.habitDetailsScreen,
                arguments: habit,
              );
            },
            child: Container(
              padding: EdgeInsets.all(14.r),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      // Icon
                      CircleAvatar(
                        radius: 22,
                        backgroundColor: streakColor.withOpacity(0.15),
                        child: Icon(
                          habit.doneToday
                              ? Icons.check_circle
                              : Icons.circle_outlined,
                          color: streakColor,
                        ),
                      ),

                      SizedBox(width: 14.w),

                      // Texts
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              habit.title,
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600,
                                fontSize: 15.sp,
                              ),
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              "🔥 ${habit.currentStreak} day streak",
                              style: GoogleFonts.poppins(
                                fontSize: 12.sp,
                                color: streakColor,
                              ),
                            ),
                          ],
                        ),
                      ),

                      if (achieved)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.orange,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            "Goal 🎯",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 11.sp,
                            ),
                          ),
                        ),
                    ],
                  ),

                  SizedBox(height: 12.h),

                  // Progress
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10.r),
                    child: LinearProgressIndicator(
                      value: progress,
                      minHeight: 6.h,
                      backgroundColor: Colors.grey.withOpacity(0.2),
                      valueColor: AlwaysStoppedAnimation(
                        ColorsManager.primaryColor,
                      ),
                    ),
                  ),

                  SizedBox(height: 10.h),

                  // Active Days
                  _activeDaysRow(habit.activeDays),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Color _streakColor(int streak) {
    if (streak >= 30) return Colors.orange;
    if (streak >= 14) return Colors.deepPurple;
    if (streak >= 7) return Colors.blue;
    return ColorsManager.primaryColor;
  }

  Widget _activeDaysRow(List<int> activeDays) {
    final days = ["S", "M", "T", "W", "T", "F", "S"];

    return Row(
      children: List.generate(7, (index) {
        final isActive = activeDays.contains(index);
        return Container(
          margin: const EdgeInsets.only(right: 4),
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isActive
                ? ColorsManager.primaryColor
                : Colors.grey.withOpacity(0.2),
          ),
          child: Text(
            days[index],
            style: TextStyle(
              fontSize: 10,
              color: isActive ? Colors.white : Colors.grey,
            ),
          ),
        );
      }),
    );
  }
}
