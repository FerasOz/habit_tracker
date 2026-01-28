import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_tracker/core/helpers/spacing.dart';
import 'package:habit_tracker/cubit/habit_cubit.dart';
import 'package:habit_tracker/cubit/habit_state.dart';
import 'package:habit_tracker/generated/locale_keys.g.dart';

class ChangeThemeSection extends StatelessWidget {
  const ChangeThemeSection({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(LocaleKeys.settings_appearance.tr(), style: textTheme.titleSmall),
        verticalSpace(6),
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(18),
          ),
          child: Row(
            children: [
              const Icon(Icons.dark_mode_outlined),
              horizontalSpace(12),
              Expanded(
                child: Text(
                  LocaleKeys.settings_darkMode.tr(),
                  style: textTheme.bodyMedium,
                ),
              ),
              BlocBuilder<HabitCubit, HabitState>(
                builder: (context, state) {
                  return Switch(
                    value: state.isDarkMode,
                    onChanged: (_) {
                      context.read<HabitCubit>().toggleTheme();
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
