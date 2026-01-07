import 'package:flutter/material.dart';

class ActiveDaysWidget extends StatelessWidget {
  ValueNotifier<Set<int>> activeDays;
  ActiveDaysWidget({super.key, required this.activeDays});

  final List<int> weekDays = [1, 2, 3, 4, 5, 6, 7];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
}
