import 'package:flutter/material.dart';
import 'package:habit_tracker/core/styles/colors.dart';

class ActiveDaysRow extends StatelessWidget {
  final List<int> activeDays;
  final List<String> days = ["S", "M", "T", "W", "T", "F", "S"];

  ActiveDaysRow({super.key, required this.activeDays});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(7, (index) {
        final isActive = activeDays.contains(index);
        return Container(
          margin: const EdgeInsets.only(right: 4),
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isActive
                ? ColorsManager.primaryColor
                : Colors.grey.withOpacity(0.2),
          ),
          child: Text(
            days[index],
            style: TextStyle(
              fontSize: 10,
              color: isActive ? Colors.white : Colors.grey,
            ),
          ),
        );
      }),
    );
  }
}
