import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:habit_tracker/core/helpers/dialogs.dart';
import 'package:habit_tracker/core/styles/colors.dart';
import 'package:habit_tracker/cubit/habit_cubit.dart';
import 'package:habit_tracker/data/models/habit_model.dart';
import 'package:habit_tracker/features/home/widgets/habit_item_widget.dart';
import 'package:habit_tracker/generated/locale_keys.g.dart';

class HabitCardWidget extends StatelessWidget {
  final HabitModel habit;

  const HabitCardWidget({super.key, required this.habit});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<HabitCubit>();
    final selectedDay = cubit.state.selectedDay;
    final selectedDayKey = DateFormat('yyyy-MM-dd').format(selectedDay);
    final isDoneForSelectedDay = habit.completedDates.contains(selectedDayKey);

    return Dismissible(
      key: ValueKey(habit.id),

      background: _swipeBackground(
        color: ColorsManager.success,
        icon: Icons.check,
        alignment: Alignment.centerLeft,
      ),

      secondaryBackground: _swipeBackground(
        color: ColorsManager.danger,
        icon: Icons.delete,
        alignment: Alignment.centerRight,
      ),

      confirmDismiss: (direction) async {
        if (direction == DismissDirection.startToEnd) {
          if (!habit.isActiveOn(selectedDay)) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  LocaleKeys.home_inactiveDayError.tr(),
                ),
              ),
            );
            return false;
          }

          final updatedDates = {...habit.completedDates};

          isDoneForSelectedDay
              ? updatedDates.remove(selectedDayKey)
              : updatedDates.add(selectedDayKey);

          cubit.updateHabit(habit.copyWith(completedDates: updatedDates));
          return false;
        } else {
          final confirmed = await showConfirmDeleteDialog(context);

          if (confirmed == true) {
            cubit.deleteHabit(habit.id);
            return true;
          }
          return false;
        }
      },

      child: HabitItemWidget(habit: habit),
    );
  }

  Widget _swipeBackground({
    required Color color,
    required IconData icon,
    required Alignment alignment,
  }) {
    return Container(
      alignment: alignment,
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(18.r),
      ),
      child: Icon(icon, color: Colors.white),
    );
  }
}
