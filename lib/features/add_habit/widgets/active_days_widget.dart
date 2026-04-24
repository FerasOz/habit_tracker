import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:habit_tracker/core/helpers/spacing.dart';
import 'package:habit_tracker/generated/locale_keys.g.dart';

class ActiveDaysWidget extends StatelessWidget {
  final ValueNotifier<Set<int>> activeDays;
  final ValueChanged<Set<int>>? onChanged;
  const ActiveDaysWidget({super.key, required this.activeDays, this.onChanged});

  static const List<int> weekDays = [1, 2, 3, 4, 5, 6, 7];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          LocaleKeys.addHabit_activeDays.tr(),
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        verticalSpace(8),
        ValueListenableBuilder(
          valueListenable: activeDays,
          builder: (context, value, _) {
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: weekDays.map((d) {
                  final bool selected = value.contains(d);
                  final date = DateTime(2024, 1, d);

                  return Padding(
                    padding: EdgeInsetsDirectional.only(end: 8.w),
                    child: FilterChip(
                      showCheckmark: false,
                      labelPadding: EdgeInsets.symmetric(horizontal: 8.w),
                      selectedColor: Theme.of(context).colorScheme.primary,
                      backgroundColor: Theme.of(context).cardColor,
                      label: Text(
                        DateFormat(
                          'E',
                          context.locale.languageCode,
                        ).format(date),
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: selected ? Colors.white : null,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      selected: selected,
                      onSelected: (_) {
                        final set = {...value};
                        selected ? set.remove(d) : set.add(d);
                        activeDays.value = set;
                        onChanged?.call(set);
                      },
                    ),
                  );
                }).toList(),
              ),
            );
          },
        ),
      ],
    );
  }
}
