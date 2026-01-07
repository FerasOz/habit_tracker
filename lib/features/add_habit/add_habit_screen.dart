import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_tracker/core/models/habit_model.dart';
import 'package:habit_tracker/features/cubit/habit_cubit.dart';
import 'package:uuid/uuid.dart';

class AddHabitScreen extends StatelessWidget {
  AddHabitScreen({super.key});

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  final ValueNotifier<int> targetPerWeek = ValueNotifier(3);

  final List<int> weekDays = [1, 2, 3, 4, 5, 6, 7];
  final ValueNotifier<Set<int>> activeDays = ValueNotifier({1, 2, 3, 4, 5});

  @override
  Widget build(BuildContext context) {
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
                  const Text(
                    "Habit title",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),

                  TextField(
                    controller: titleController,
                    decoration: const InputDecoration(hintText: "Drink water"),
                  ),

                  const SizedBox(height: 16),

                  const Text(
                    "Description (optional)",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),

                  TextField(
                    controller: descriptionController,
                    decoration: const InputDecoration(hintText: "Short note"),
                  ),

                  const SizedBox(height: 16),

                  const Text(
                    "Target per week",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),

                  ValueListenableBuilder(
                    valueListenable: targetPerWeek,
                    builder: (context, value, _) {
                      return Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              if (value > 1) targetPerWeek.value--;
                            },
                            icon: const Icon(Icons.remove_circle_outline),
                          ),
                          Text("$value times"),
                          IconButton(
                            onPressed: () => targetPerWeek.value++,
                            icon: const Icon(Icons.add_circle_outline),
                          ),
                        ],
                      );
                    },
                  ),

                  const SizedBox(height: 16),

                  const Text(
                    "Active days",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),

                  const SizedBox(height: 8),

                  ValueListenableBuilder(
                    valueListenable: activeDays,
                    builder: (context, value, _) {
                      return Wrap(
                        spacing: 10,
                        children: weekDays.map((d) {
                          final bool selected = value.contains(d);

                          return ChoiceChip(
                            label: Text(_dayName(d)),
                            selected: selected,
                            onSelected: (_) {
                              final set = {...value};
                              selected ? set.remove(d) : set.add(d);
                              activeDays.value = set;
                            },
                          );
                        }).toList(),
                      );
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => _saveHabit(context),
                child: const Text("Save Habit"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _dayName(int d) {
    switch (d) {
      case 1:
        return "Mon";
      case 2:
        return "Tue";
      case 3:
        return "Wed";
      case 4:
        return "Thu";
      case 5:
        return "Fri";
      case 6:
        return "Sat";
      case 7:
        return "Sun";
      default:
        return "";
    }
  }

  void _saveHabit(BuildContext context) {
    if (titleController.text.trim().isEmpty) return;

    final habit = HabitModel(
      id: const Uuid().v4(),
      title: titleController.text.trim(),
      description: descriptionController.text.trim().isEmpty
          ? null
          : descriptionController.text.trim(),
      createdAt: DateTime.now(),
      targetPerWeek: targetPerWeek.value,
      completedDays: 0,
      currentStreak: 0,
      doneToday: false,
      activeDays: activeDays.value.toList(),
    );

    context.read<HabitCubit>().addHabit(habit);

    Navigator.pop(context);
  }
}
