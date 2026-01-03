import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habit_tracker/core/routing/routes.dart';
import 'package:habit_tracker/core/styles/colors.dart';

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
              "My Habits",
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

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildSummaryCard(),
            const SizedBox(height: 20),
            Expanded(child: _buildHabitsList()),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCard() {
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
            "3 / 5 Habits Completed",
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 22.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHabitsList() {
    return ListView.separated(
      itemCount: 3,
      separatorBuilder: (_, _) => SizedBox(height: 12.h),
      itemBuilder: (context, index) {
        return _habitCard(
          icon: Icons.water_drop,
          title: "Drink Water",
          progress: "2 / 8",
          value: 0.25,
          onTap: () {
            Navigator.pushNamed(context, Routes.habitDetailsScreen,
                arguments: null);
          },
        );
      },
    );
  }

  Widget _habitCard({
    required IconData icon,
    required String title,
    required String progress,
    required double value,
    required Function()? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18.r),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 24,
              backgroundColor: const Color(0xFFEDEBFF),
              child: Icon(icon, color: ColorsManager.primaryColor),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.poppins(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 6),
                  LinearProgressIndicator(
                    value: value,
                    backgroundColor: Colors.grey.shade200,
                    valueColor: const AlwaysStoppedAnimation(
                      ColorsManager.primaryColor,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Text(
              progress,
              style: GoogleFonts.poppins(fontSize: 14.sp, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
