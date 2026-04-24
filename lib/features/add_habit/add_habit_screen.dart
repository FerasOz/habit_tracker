import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:habit_tracker/core/helpers/spacing.dart';
import 'package:habit_tracker/core/styles/colors.dart';
import 'package:habit_tracker/cubit/habit_cubit.dart';
import 'package:habit_tracker/data/models/habit_model.dart';
import 'package:habit_tracker/features/add_habit/widgets/active_days_widget.dart';
import 'package:habit_tracker/features/add_habit/widgets/add_habit_text_field_widget.dart';
import 'package:habit_tracker/features/add_habit/widgets/save_habit_btn.dart';
import 'package:habit_tracker/generated/locale_keys.g.dart';

class AddHabitScreen extends StatefulWidget {
  final HabitModel? habitToEdit;

  const AddHabitScreen({super.key, this.habitToEdit});

  @override
  State<AddHabitScreen> createState() => _AddHabitScreenState();
}

class _AddHabitScreenState extends State<AddHabitScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _didPopulateForm = false;

  String? _titleValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return LocaleKeys.addHabit_validationNameRequired.tr();
    }
    if (value.trim().length < 2) {
      return LocaleKeys.addHabit_validationNameShort.tr();
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<HabitCubit>();
    final textTheme = Theme.of(context).textTheme;
    final isEditing = widget.habitToEdit != null;

    if (!_didPopulateForm) {
      _didPopulateForm = true;
      if (widget.habitToEdit != null) {
        cubit.populateHabitForm(widget.habitToEdit!);
      } else {
        cubit.resetHabitForm();
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          isEditing ? LocaleKeys.addHabit_editTitle.tr() : LocaleKeys.addHabit_title.tr(),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: EdgeInsets.all(16.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _HeaderCard(
                  title: isEditing
                      ? LocaleKeys.addHabit_editHeaderTitle.tr()
                      : LocaleKeys.addHabit_title.tr(),
                  subtitle: isEditing
                      ? LocaleKeys.addHabit_editHeaderSubtitle.tr()
                      : LocaleKeys.addHabit_createHeaderSubtitle.tr(),
                ),
                verticalSpace(16),
                _SectionCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AddHabitTextFieldWidget(
                        controller: cubit.titleController,
                        label: LocaleKeys.addHabit_nameLabel.tr(),
                        hintText: LocaleKeys.addHabit_nameHint.tr(),
                        validator: _titleValidator,
                      ),
                      verticalSpace(14),
                      AddHabitTextFieldWidget(
                        controller: cubit.descriptionController,
                        label: LocaleKeys.addHabit_descriptionLabel.tr(),
                        hintText: LocaleKeys.addHabit_descriptionHint.tr(),
                        maxLines: 3,
                        textInputAction: TextInputAction.newline,
                      ),
                    ],
                  ),
                ),
                verticalSpace(14),
                _SectionCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        LocaleKeys.addHabit_target.tr(),
                        style: textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      verticalSpace(8),
                      ValueListenableBuilder<int>(
                        valueListenable: cubit.targetPerWeek,
                        builder: (context, value, _) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "$value ${LocaleKeys.addHabit_times.tr()} / 7",
                                style: textTheme.bodyMedium,
                              ),
                              Slider(
                                value: value.toDouble(),
                                min: 1,
                                max: 7,
                                divisions: 6,
                                label: value.toString(),
                                onChanged: (newValue) {
                                  cubit.targetPerWeek.value = newValue.round();
                                },
                              ),
                            ],
                          );
                        },
                      ),
                      verticalSpace(6),
                      ActiveDaysWidget(
                        activeDays: cubit.activeDays,
                        onChanged: (days) {
                          if (days.isNotEmpty &&
                              cubit.targetPerWeek.value > days.length) {
                            cubit.targetPerWeek.value = days.length;
                          }
                        },
                      ),
                    ],
                  ),
                ),
                verticalSpace(14),
                _HabitPreviewCard(cubit: cubit),
                verticalSpace(22),
                SaveHabitBtn(
                  formKey: _formKey,
                  habitToEdit: widget.habitToEdit,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _HeaderCard extends StatelessWidget {
  final String title;
  final String subtitle;

  const _HeaderCard({required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(18.r),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            ColorsManager.primary,
            ColorsManager.secondary.withOpacity(0.88),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
          verticalSpace(6),
          Text(
            subtitle,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Colors.white.withOpacity(0.9),
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  final Widget child;

  const _SectionCard({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(
          color: Theme.of(context).dividerColor.withOpacity(0.18),
        ),
      ),
      child: child,
    );
  }
}

class _HabitPreviewCard extends StatelessWidget {
  final HabitCubit cubit;

  const _HabitPreviewCard({required this.cubit});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return _SectionCard(
      child: ValueListenableBuilder<TextEditingValue>(
        valueListenable: cubit.titleController,
        builder: (context, titleValue, _) {
          return ValueListenableBuilder<TextEditingValue>(
            valueListenable: cubit.descriptionController,
            builder: (context, descValue, __) {
              return ValueListenableBuilder<int>(
                valueListenable: cubit.targetPerWeek,
                builder: (context, target, ___) {
                  return ValueListenableBuilder<Set<int>>(
                    valueListenable: cubit.activeDays,
                    builder: (context, days, ____) {
                      final title = titleValue.text.trim().isEmpty
                          ? LocaleKeys.addHabit_nameHint.tr()
                          : titleValue.text.trim();
                      final desc = descValue.text.trim().isEmpty
                          ? LocaleKeys.addHabit_descriptionHint.tr()
                          : descValue.text.trim();
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            LocaleKeys.addHabit_quickPreview.tr(),
                            style: textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          verticalSpace(10),
                          Text(
                            title,
                            style: textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          verticalSpace(4),
                          Text(desc, style: textTheme.bodySmall),
                          verticalSpace(10),
                          Text(
                            "${LocaleKeys.addHabit_target.tr()}: $target ${LocaleKeys.addHabit_times.tr()}",
                            style: textTheme.bodyMedium,
                          ),
                          verticalSpace(4),
                          Text(
                            "${LocaleKeys.addHabit_activeDays.tr()}: ${days.length}/7",
                            style: textTheme.bodyMedium,
                          ),
                        ],
                      );
                    },
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
