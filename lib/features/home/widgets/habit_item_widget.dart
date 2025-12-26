import 'package:flutter/material.dart';

class HabitItemWidget extends StatelessWidget {
  String title;
  int current;
  int total;
  Color primary;

  HabitItemWidget({
    super.key,
    required this.title,
    required this.current,
    required this.total,
    required this.primary,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),

          const SizedBox(height: 10),

          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: current / total,
              minHeight: 8,
              backgroundColor: primary.withOpacity(0.2),
              color: primary,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            "$current / $total",
            style: const TextStyle(fontSize: 13, color: Color(0xFF7D7D7D)),
          ),
        ],
      ),
    );
  }
}
