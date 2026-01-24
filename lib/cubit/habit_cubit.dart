import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_tracker/core/helpers/constants.dart';
import 'package:habit_tracker/data/local/app_storage.dart';
import 'package:habit_tracker/data/models/habit_model.dart';
import 'package:habit_tracker/cubit/habit_state.dart';

class HabitCubit extends Cubit<HabitState> {
  HabitCubit() : super(HabitState());

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final ValueNotifier<Set<int>> activeDays = ValueNotifier({1, 2, 3, 4, 5});
  final ValueNotifier<int> targetPerWeek = ValueNotifier(3);

  //fetch habits
  Future<void> fetchHabits() async {
    try {
      emit(state.copyWith(fetchHabitsStatus: RequestsStatus.loading));

      final habits = await AppStorage.getHabits();

      emit(
        state.copyWith(
          fetchHabitsStatus: RequestsStatus.success,
          habits: habits,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          fetchHabitsStatus: RequestsStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  // add habit
  Future<void> addHabit(HabitModel habit) async {
    final List<HabitModel> updated = List.from(state.habits)..add(habit);

    await AppStorage.saveHabits(updated);

    emit(state.copyWith(habits: updated));
  }

  // delete habit
  Future<void> deleteHabit(String id) async {
    final updated = state.habits.where((h) => h.id != id).toList();

    await AppStorage.saveHabits(updated);

    emit(state.copyWith(habits: updated));
  }

  // update habit
  Future<void> updateHabit(HabitModel habit) async {
    final updated = state.habits.map((h) {
      if (h.id == habit.id) return habit;
      return h;
    }).toList();

    await AppStorage.saveHabits(updated);

    emit(state.copyWith(habits: updated));
  }

  // change language
  Future<void> changeLanguage(BuildContext context, Locale locale) async {
    await context.setLocale(locale);
    await AppStorage.saveLanguage(locale.languageCode);
    emit(state.copyWith(locale: locale));
  }

Future<Locale?> loadSavedLanguage() async {
  final savedLang = await AppStorage.getSavedLanguage();
  if (savedLang != null) {
    final locale = Locale(savedLang);
    emit(state.copyWith(locale: locale));
    return locale;
  }
  return null;
}

}
