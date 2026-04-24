import 'package:flutter/material.dart';

class AddHabitTextFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hintText;
  final int maxLines;
  final TextInputAction textInputAction;
  final String? Function(String?)? validator;

  const AddHabitTextFieldWidget({
    super.key,
    required this.controller,
    required this.label,
    required this.hintText,
    this.maxLines = 1,
    this.textInputAction = TextInputAction.next,
    this.validator,
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
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          textInputAction: textInputAction,
          validator: validator,
          decoration: InputDecoration(
            hintText: hintText,
            alignLabelWithHint: maxLines > 1,
          ),
        ),
      ],
    );
  }
}
