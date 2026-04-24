import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_tracker/core/helpers/spacing.dart';
import 'package:habit_tracker/cubit/habit_cubit.dart';
import 'package:habit_tracker/generated/locale_keys.g.dart';

class AboutAppSection extends StatelessWidget {
  const AboutAppSection({super.key});

  Future<void> _clearHabits(BuildContext context) async {
    final isArabic = context.locale.languageCode == 'ar';
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(isArabic ? 'حذف كل العادات' : 'Clear all habits'),
          content: Text(
            isArabic
                ? 'هل أنت متأكد من حذف جميع العادات؟'
                : 'Are you sure you want to delete all habits?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text(isArabic ? 'إلغاء' : 'Cancel'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context, true),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: Text(isArabic ? 'حذف' : 'Delete'),
            ),
          ],
        );
      },
    );

    if (confirmed == true) {
      await context.read<HabitCubit>().clearHabitsOnly();
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(isArabic ? 'تم حذف كل العادات' : 'All habits deleted'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(LocaleKeys.settings_about.tr(), style: textTheme.titleSmall),
        verticalSpace(6),
        Container(
          decoration: BoxDecoration(
            color: theme.cardColor,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: theme.dividerColor.withOpacity(0.2),
            ),
          ),
          child: Column(
            children: [
              ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary.withOpacity(0.12),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.track_changes),
                ),
                title: Text(
                  LocaleKeys.home_title.tr(),
                  style: textTheme.titleMedium,
                ),
                subtitle: Text(
                  LocaleKeys.home_subtitle.tr(),
                  style: textTheme.bodySmall,
                ),
              ),
              const Divider(height: 1),
              ListTile(
                leading: const Icon(Icons.info_outline),
                title: Text(
                  LocaleKeys.settings_version.tr(),
                  style: textTheme.bodyMedium,
                ),
                trailing: Text("1.0.0", style: textTheme.bodySmall),
              ),
              ListTile(
                leading: const Icon(Icons.code),
                title: Text(
                  LocaleKeys.settings_builtWith.tr(),
                  style: textTheme.bodyMedium,
                ),
              ),
              const Divider(height: 1),
              ListTile(
                leading: const Icon(Icons.delete_sweep, color: Colors.red),
                title: Text(
                  context.locale.languageCode == 'ar'
                      ? 'حذف كل العادات'
                      : 'Clear all habits',
                  style: textTheme.bodyMedium?.copyWith(
                    color: Colors.red,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                onTap: () => _clearHabits(context),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
