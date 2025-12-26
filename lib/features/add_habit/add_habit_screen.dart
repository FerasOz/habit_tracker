import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habit_tracker/core/styles/colors.dart';

class AddHabitScreen extends StatefulWidget {
  const AddHabitScreen({super.key});

  @override
  State<AddHabitScreen> createState() => _AddHabitScreenState();
}

class _AddHabitScreenState extends State<AddHabitScreen> {
  final TextEditingController nameController = TextEditingController();

  String frequency = "Daily";
  int target = 1;
  IconData selectedIcon = Icons.check_circle;

  final List<IconData> icons = [
    Icons.local_drink,
    Icons.fitness_center,
    Icons.book,
    Icons.self_improvement,
    Icons.run_circle,
    Icons.nightlight_round,
    Icons.timer,
    Icons.water_drop,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add New Habit",
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _label("Habit Name"),
                  TextField(
                    controller: nameController,
                    decoration: _inputDecoration("Drink Water"),
                  ),
                  const SizedBox(height: 16),

                  _label("Frequency"),
                  DropdownButtonFormField<String>(
                    value: frequency,
                    items: const [
                      DropdownMenuItem(value: "Daily", child: Text("Daily")),
                      DropdownMenuItem(value: "Weekly", child: Text("Weekly")),
                    ],
                    onChanged: (value) {
                      setState(() => frequency = value!);
                    },
                    decoration: _inputDecoration(""),
                  ),
                  const SizedBox(height: 16),

                  _label("Target"),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          if (target > 1) setState(() => target--);
                        },
                        icon: const Icon(Icons.remove_circle_outline),
                      ),
                      Text(
                        "$target times",
                        style: GoogleFonts.poppins(fontSize: 16.sp),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() => target++);
                        },
                        icon: const Icon(Icons.add_circle_outline),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  _label("Icon"),
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: icons.map((icon) {
                      final isSelected = selectedIcon == icon;
                      return GestureDetector(
                        onTap: () {
                          setState(() => selectedIcon = icon);
                        },
                        child: CircleAvatar(
                          radius: 24,
                          backgroundColor: isSelected
                              ? ColorsManager.primaryColor
                              : const Color(0xFFEDEBFF),
                          child: Icon(
                            icon,
                            color: isSelected
                                ? Colors.white
                                : ColorsManager.primaryColor,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _saveHabit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF8B7CF6),
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                ),
                child: Text(
                  "Save Habit",
                  style: GoogleFonts.poppins(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
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

  void _saveHabit() {
    if (nameController.text.isEmpty) return;

    // لاحقًا نربطه بـ SharedPreferences
    Navigator.pop(context);
  }

  Widget _label(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        text,
        style: GoogleFonts.poppins(
          fontWeight: FontWeight.w500,
          fontSize: 14.sp,
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: const Color(0xFFF6F5FA),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14.r),
        borderSide: BorderSide.none,
      ),
    );
  }

  Widget _card({required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: child,
    );
  }
}
