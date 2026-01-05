import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habit_tracker/core/helpers/constants.dart';
import 'package:habit_tracker/core/routing/routes.dart';
import 'package:habit_tracker/core/styles/colors.dart';
import 'package:habit_tracker/features/cubit/habit_cubit.dart';
import 'package:habit_tracker/features/cubit/habit_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Habits Tracker",
              style: GoogleFonts.poppins(
                fontSize: 22.sp,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            Text(
              "Build better habits",
              style: GoogleFonts.poppins(fontSize: 14.sp, color: Colors.grey),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.black),
            onPressed: () {
              Navigator.pushNamed(context, Routes.settingsScreen);
            },
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: ColorsManager.primaryColor,
        onPressed: () {
          Navigator.pushNamed(context, Routes.addHabitScreen);
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),

      body: BlocBuilder<HabitCubit, HabitState>(
        builder: (context, state) {
          if (state.fetchHabitsStatus == RequestsStatus.loading) {
            return Center(child: CircularProgressIndicator());
          }

          if (state.habits.isEmpty) {
            return Center(child: Text("No habits yet"));
          }

          final total = state.habits.length;
          final doneToday = state.habits.where((h) => h.doneToday).length;
          final double progress = total == 0 ? 0 : doneToday / total;

          return RefreshIndicator(
            onRefresh: () {
              return context.read<HabitCubit>().fetchHabits();
            },
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _buildSummaryCard(doneToday, total, progress),
                  const SizedBox(height: 20),
                  Expanded(child: _buildHabitsList(state)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSummaryCard(int done, int total, double progress) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: ColorsManager.primaryColor,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Today Progress",
            style: GoogleFonts.poppins(color: Colors.white70, fontSize: 14.sp),
          ),
          const SizedBox(height: 10),
          Text(
            "$done / $total Habits Completed",
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 22.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 10),
          LinearProgressIndicator(
            value: progress,
            backgroundColor: Colors.white30,
            valueColor: AlwaysStoppedAnimation(Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildHabitsList(HabitState state) {
    return ListView.separated(
      itemCount: state.habits.length,
      separatorBuilder: (_, __) => SizedBox(height: 12.h),
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
