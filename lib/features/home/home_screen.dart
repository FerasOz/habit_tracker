import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habit_tracker/core/helpers/constants.dart';
import 'package:habit_tracker/core/helpers/spacing.dart';
import 'package:habit_tracker/core/routing/routes.dart';
import 'package:habit_tracker/core/styles/colors.dart';
import 'package:habit_tracker/features/cubit/habit_cubit.dart';
import 'package:habit_tracker/features/cubit/habit_state.dart';
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
                  SummaryCardWidget(
                    done: doneToday,
                    total: total,
                    progress: progress,
                  ),
                  verticalSpace(20),
                  Expanded(child: HabitsListWidget(state: state)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
