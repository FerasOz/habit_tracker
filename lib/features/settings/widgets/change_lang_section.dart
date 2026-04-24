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
            border: Border.all(
              color: Theme.of(context).dividerColor.withOpacity(0.2),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Theme.of(
                        context,
                      ).colorScheme.primary.withOpacity(0.12),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.language),
                  ),
                  horizontalSpace(12),
                  Expanded(
                    child: Text(
                      LocaleKeys.settings_appLanguage.tr(),
                      style: textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              verticalSpace(12),
              BlocBuilder<HabitCubit, HabitState>(
                builder: (context, state) {
                  return Wrap(
                    spacing: 8,
                    children: [
                      ChoiceChip(
                        label: Text(LocaleKeys.settings_english.tr()),
                        selected: state.locale.languageCode == 'en',
                        onSelected: (_) {
                          context.read<HabitCubit>().changeLanguage(
                            context,
                            const Locale('en'),
                          );
                        },
                      ),
                      ChoiceChip(
                        label: Text(LocaleKeys.settings_arabic.tr()),
                        selected: state.locale.languageCode == 'ar',
                        onSelected: (_) {
                          context.read<HabitCubit>().changeLanguage(
                            context,
                            const Locale('ar'),
                          );
                        },
                      ),
                    ],
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
