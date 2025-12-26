import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habit_tracker/core/styles/colors.dart';

class HabitDetailsScreen extends StatefulWidget {
  final String habitName;
  final int target;
  final int completed;
  final IconData icon;

  const HabitDetailsScreen({
    super.key,
    required this.habitName,
    required this.target,
    required this.completed,
    required this.icon,
  });

  @override
  State<HabitDetailsScreen> createState() => _HabitDetailsScreenState();
}

class _HabitDetailsScreenState extends State<HabitDetailsScreen> {
  late int completedCount;

  @override
  void initState() {
    super.initState();
    completedCount = widget.completed;
  }

  @override
  Widget build(BuildContext context) {
    final progress = completedCount / widget.target;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.habitName,
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
        actions: [
          IconButton(icon: const Icon(Icons.delete_outline), onPressed: () {}),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _headerCard(),
            const SizedBox(height: 24),
            _progressCard(progress),
            const Spacer(),
            _actionButton(),
          ],
        ),
      ),
    );
  }

  Widget _headerCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF8B7CF6),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: 36,
            backgroundColor: Colors.white,
            child: Icon(widget.icon, size: 36, color: const Color(0xFF8B7CF6)),
          ),
          const SizedBox(height: 12),
          Text(
            widget.habitName,
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            "Target: ${widget.target}",
            style: GoogleFonts.poppins(color: Colors.white70),
          ),
        ],
      ),
    );
  }

  Widget _progressCard(double progress) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          SizedBox(
            height: 120.h,
            width: 120.w,
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 100.w,
                  height: 100.h,
                  child: CircularProgressIndicator(
                    value: progress,
                    strokeWidth: 10,
                    backgroundColor: Colors.grey.shade200,
                    valueColor: const AlwaysStoppedAnimation(
                      ColorsManager.primaryColor,
                    ),
                  ),
                ),
                Text(
                  "$completedCount / ${widget.target}",
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Text(
            "Completed Progress",
            style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _actionButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          if (completedCount < widget.target) {
            setState(() => completedCount++);
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF8B7CF6),
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Text(
          "Mark as Done",
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
