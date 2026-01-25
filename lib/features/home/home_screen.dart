import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habit_tracker/core/helpers/constants.dart';
import 'package:habit_tracker/core/helpers/spacing.dart';
import 'package:habit_tracker/core/routing/routes.dart';
import 'package:habit_tracker/core/styles/colors.dart';
import 'package:habit_tracker/cubit/habit_cubit.dart';
import 'package:habit_tracker/cubit/habit_state.dart';
import 'package:habit_tracker/features/home/widgets/habits_list_widget.dart';
import 'package:habit_tracker/features/home/widgets/summary_card_widget.dart';
import 'package:habit_tracker/generated/locale_keys.g.dart';

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
              LocaleKeys.home_title.tr(),
              style: GoogleFonts.poppins(
                fontSize: 22.sp,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            Text(
              LocaleKeys.home_subtitle.tr(),
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
            return Center(child: Text(LocaleKeys.home_emptyHabits.tr()));
          }
          final habits = context.read<HabitCubit>().habitsForSelectedDay;
          final todayKey = DateFormat('yyyy-MM-dd').format(state.selectedDay);

          final doneCount = habits
              .where((h) => h.completedDates.contains(todayKey))
              .length;

          return RefreshIndicator(
            onRefresh: () {
              return context.read<HabitCubit>().fetchHabits();
            },
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  SummaryCardWidget(
                    done: doneCount,
                    total: habits.length,
                    progress: habits.isEmpty ? 0 : doneCount / habits.length,
                  ),
                  verticalSpace(16),
                  Expanded(
                    child: HabitsListWidget(
                      habits: habits,
                      selectedDay: state.selectedDay,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
