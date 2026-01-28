import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:habit_tracker/core/helpers/spacing.dart';
import 'package:habit_tracker/features/add_habit/widgets/active_days_widget.dart';
import 'package:habit_tracker/features/add_habit/widgets/add_habit_text_field_widget.dart';
import 'package:habit_tracker/features/add_habit/widgets/save_habit_btn.dart';
import 'package:habit_tracker/cubit/habit_cubit.dart';
import 'package:habit_tracker/generated/locale_keys.g.dart';

class AddHabitScreen extends StatelessWidget {
  const AddHabitScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<HabitCubit>();
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.addHabit_title.tr()),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AddHabitTextFieldWidget(
                    controller: cubit.titleController,
                    label: LocaleKeys.addHabit_nameLabel.tr(),
                    hintText: LocaleKeys.addHabit_nameHint.tr(),
                  ),
                  verticalSpace(16),
                  AddHabitTextFieldWidget(
                    controller: cubit.descriptionController,
                    label: LocaleKeys.addHabit_descriptionLabel.tr(),
                    hintText: LocaleKeys.addHabit_descriptionHint.tr(),
                  ),
                  verticalSpace(16),
                  Text(
                    LocaleKeys.addHabit_target.tr(),
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
                          Text("$value ${LocaleKeys.addHabit_times.tr()}"),
                          IconButton(
                            onPressed: () => cubit.targetPerWeek.value++,
                            icon: const Icon(Icons.add_circle_outline),
                          ),
                        ],
                      );
                    },
                  ),
                  verticalSpace(16),
                  ActiveDaysWidget(activeDays: cubit.activeDays),
                ],
              ),
            ),
            verticalSpace(24),
            SaveHabitBtn(),
          ],
        ),
      ),
    );
  }
}
