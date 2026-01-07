import 'package:flutter/material.dart';

class AddHabitTextFieldWidget extends StatelessWidget {
  TextEditingController controller;
  String label;
  String hintText;

  AddHabitTextFieldWidget({
    super.key,
    required this.controller,
    required this.label,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(label, style: TextStyle(fontWeight: FontWeight.w600)),

        TextField(
          controller: controller,
          decoration: InputDecoration(hintText: hintText),
        ),
      ],
    );
  }
}
