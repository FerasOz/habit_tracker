import 'package:flutter/material.dart';

class AddHabitTextFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hintText;

  const AddHabitTextFieldWidget({
    super.key,
    required this.controller,
    required this.label,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        TextField(
          controller: controller,
          decoration: InputDecoration(hintText: hintText),
        ),
      ],
    );
  }
}
