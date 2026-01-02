import 'package:flutter/material.dart';

class HabitDetailsScreen extends StatelessWidget {
  final String habitName;

  const HabitDetailsScreen({super.key, required this.habitName});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(habitName), centerTitle: true),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // ===== Progress Circle =====
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  Text("Progress", style: theme.textTheme.titleMedium),
                  const SizedBox(height: 12),

                  SizedBox(
                    height: 140,
                    width: 140,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        CircularProgressIndicator(value: 0.65, strokeWidth: 10),
                        Text("65%", style: theme.textTheme.headlineMedium),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // ===== STREAK CARD =====
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: theme.colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Current Streak", style: theme.textTheme.titleMedium),
                  Row(
                    children: [
                      Icon(Icons.local_fire_department),
                      const SizedBox(width: 4),
                      Text("7 days", style: theme.textTheme.titleLarge),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // ===== Week Row =====
            Align(
              alignment: Alignment.centerLeft,
              child: Text("This week", style: theme.textTheme.titleMedium),
            ),

            const SizedBox(height: 12),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(7, (index) {
                final days = ["M", "T", "W", "T", "F", "S", "S"];
                final done = index < 4;

                return Column(
                  children: [
                    CircleAvatar(
                      radius: 18,
                      backgroundColor: done
                          ? theme.colorScheme.primary
                          : Colors.grey[400],
                      child: Icon(
                        done ? Icons.check : Icons.close,
                        size: 18,
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

            // ===== ACTION BUTTONS =====
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text("✔ تم إنجازه اليوم"),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {},
                    child: const Text("✖ لم يتم إنجازه"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
