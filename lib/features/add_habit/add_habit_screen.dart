import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_tracker/features/add_habit/widgets/active_days_widget.dart';
import 'package:habit_tracker/features/add_habit/widgets/add_habit_text_field_widget.dart';
import 'package:habit_tracker/features/add_habit/widgets/save_habit_btn.dart';
import 'package:habit_tracker/features/cubit/habit_cubit.dart';

class AddHabitScreen extends StatelessWidget {
  const AddHabitScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<HabitCubit>();
    return Scaffold(
      appBar: AppBar(title: const Text("Add New Habit"), centerTitle: true),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            //----- CARD -----
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AddHabitTextFieldWidget(
                    controller: cubit.titleController,
                    label: "Habit title",
                    hintText: "Drink water",
                  ),

                  const SizedBox(height: 16),

                  AddHabitTextFieldWidget(
                    controller: cubit.descriptionController,
                    label: "Description (optional)",
                    hintText: "Short note",
                  ),

                  const SizedBox(height: 16),

                  const Text(
                    "Target per week",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),

                  ValueListenableBuilder(
                    valueListenable: cubit.targetPerWeek,
                    builder: (context, value, _) {
                      return Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              if (value > 1) cubit.targetPerWeek.value--;
                            },
                            icon: const Icon(Icons.remove_circle_outline),
                          ),
                          Text("$value times"),
                          IconButton(
                            onPressed: () => cubit.targetPerWeek.value++,
                            icon: const Icon(Icons.add_circle_outline),
                          ),
                        ],
                      );
                    },
                  ),

                  const SizedBox(height: 16),

                  ActiveDaysWidget(activeDays: cubit.activeDays),
                ],
              ),
            ),

            const SizedBox(height: 25),

            SaveHabitBtn(),
          ],
        ),
      ),
    );
  }
}
