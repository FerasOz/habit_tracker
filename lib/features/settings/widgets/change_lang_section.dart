import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_tracker/core/helpers/spacing.dart';
import 'package:habit_tracker/cubit/habit_cubit.dart';
import 'package:habit_tracker/cubit/habit_state.dart';
import 'package:habit_tracker/generated/locale_keys.g.dart';

class ChangeLangSection extends StatelessWidget {
  const ChangeLangSection({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(LocaleKeys.settings_language.tr(), style: textTheme.titleSmall),
        verticalSpace(6),
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(18),
          ),
          child: Row(
            children: [
              const Icon(Icons.language),
              horizontalSpace(12),
              Expanded(
                child: Text(
                  LocaleKeys.settings_language.tr(),
                  style: textTheme.bodyMedium,
                ),
              ),
              BlocBuilder<HabitCubit, HabitState>(
                builder: (context, state) {
                  return DropdownButton<Locale>(
                    value: state.locale,
                    underline: const SizedBox(),
                    items: [
                      DropdownMenuItem(
                        value: const Locale('en'),
                        child: Text(LocaleKeys.settings_english.tr()),
                      ),
                      DropdownMenuItem(
                        value: const Locale('ar'),
                        child: Text(LocaleKeys.settings_arabic.tr()),
                      ),
                    ],
                    onChanged: (locale) {
                      if (locale == null) return;
                      context.read<HabitCubit>().changeLanguage(
                        context,
                        locale,
                      );
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
