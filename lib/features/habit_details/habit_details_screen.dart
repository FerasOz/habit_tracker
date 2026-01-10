import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habit_tracker/core/models/habit_model.dart';
import 'package:habit_tracker/core/styles/colors.dart';
import 'package:habit_tracker/features/cubit/habit_cubit.dart';

class HabitDetailsScreen extends StatelessWidget {
  final HabitModel habit;

  const HabitDetailsScreen({super.key, required this.habit});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<HabitCubit>();

    final progress = (habit.completedDays / habit.targetPerWeek).clamp(
      0.0,
      1.0,
    );

    final days = ["M", "T", "W", "T", "F", "S", "S"];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          habit.title,
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline),
            onPressed: () {
              cubit.deleteHabit(habit.id);
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// ===== PROGRESS CARD =====
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: ColorsManager.primaryColor,
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Weekly Progress",
                    style: GoogleFonts.poppins(
                      color: Colors.white70,
                      fontSize: 14.sp,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "${habit.completedDays} / ${habit.targetPerWeek}",
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 26.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 12),
                  LinearProgressIndicator(
                    value: progress,
                    backgroundColor: Colors.white30,
                    valueColor: const AlwaysStoppedAnimation(Colors.white),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            /// ===== STATS =====
            Row(
              children: [
                _statCard(
                  title: "Streak",
                  value: "${habit.currentStreak} days",
                  icon: Icons.local_fire_department,
                ),
                const SizedBox(width: 12),
                _statCard(
                  title: "Completed",
                  value: "${habit.completedDays}",
                  icon: Icons.check_circle,
                ),
              ],
            ),

            const SizedBox(height: 20),

            /// ===== WEEK DAYS =====
            Text(
              "This Week",
              style: GoogleFonts.poppins(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 12),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(7, (index) {
                final isActive = habit.activeDays.contains(index);
                return Column(
                  children: [
                    CircleAvatar(
                      radius: 18,
                      backgroundColor: isActive
                          ? ColorsManager.primaryColor
                          : Colors.grey.shade300,
                      child: Icon(
                        isActive ? Icons.check : Icons.close,
                        size: 16,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(days[index]),
                  ],
                );
              }),
            ),

            const Spacer(),

            /// ===== ACTION BUTTON =====
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  final updatedHabit = HabitModel(
                    id: habit.id,
                    title: habit.title,
                    description: habit.description,
                    createdAt: habit.createdAt,
                    targetPerWeek: habit.targetPerWeek,
                    completedDays: habit.doneToday
                        ? habit.completedDays - 1
                        : habit.completedDays + 1,
                    currentStreak: habit.doneToday
                        ? habit.currentStreak - 1
                        : habit.currentStreak + 1,
                    doneToday: !habit.doneToday,
                    activeDays: habit.activeDays,
                  );

                  cubit.updateHabit(updatedHabit);
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: habit.doneToday
                      ? Colors.grey
                      : ColorsManager.primaryColor,
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                ),
                child: Text(
                  habit.doneToday ? "Undo Today" : "Mark as Done Today",
                  style: GoogleFonts.poppins(
                    fontSize: 16.sp,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _statCard({
    required String title,
    required String value,
    required IconData icon,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Column(
          children: [
            Icon(icon, color: ColorsManager.primaryColor),
            const SizedBox(height: 8),
            Text(
              value,
              style: GoogleFonts.poppins(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(title, style: GoogleFonts.poppins(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}
