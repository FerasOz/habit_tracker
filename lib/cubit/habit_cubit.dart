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
          clearError: true,
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

  Future<void> clearHabitsOnly() async {
    await AppStorage.saveHabits([]);
    emit(state.copyWith(habits: []));
  }

  List<HabitModel> get habitsForSelectedDay {
    final weekday = state.selectedDay.weekday;
    return state.habits
        .where((habit) => habit.activeDays.contains(weekday))
        .toList();
  }

  HabitModel? habitById(String id) {
    for (final habit in state.habits) {
      if (habit.id == id) {
        return habit;
      }
    }
    return null;
  }

  void changeSelectedDay(DateTime day) {
    emit(
      state.copyWith(
        selectedDay: DateTime(day.year, day.month, day.day),
      ),
    );
  }

  Future<void> toggleHabitDoneToday(HabitModel habit) async {
    final todayKey = DateFormat('yyyy-MM-dd').format(state.selectedDay);

    final updatedDates = Set<String>.from(habit.completedDates);

    if (updatedDates.contains(todayKey)) {
      updatedDates.remove(todayKey);
    } else {
      updatedDates.add(todayKey);
    }

    final updatedHabit = habit.copyWith(completedDates: updatedDates);

    await updateHabit(updatedHabit);
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

  // CHANGE theme
  Future<void> toggleTheme() async {
    final newTheme = !state.isDarkMode;
    await AppStorage.saveTheme(newTheme);
    emit(state.copyWith(isDarkMode: newTheme));
  }

  Future<void> loadSavedTheme() async {
    final savedTheme = await AppStorage.getSavedTheme();
    if (savedTheme != null) {
      emit(state.copyWith(isDarkMode: savedTheme));
    }
  }

  void resetHabitForm() {
    titleController.clear();
    descriptionController.clear();
    activeDays.value = {1, 2, 3, 4, 5};
    targetPerWeek.value = 3;
  }

  void populateHabitForm(HabitModel habit) {
    titleController.text = habit.title;
    descriptionController.text = habit.description ?? '';
    activeDays.value = habit.activeDays.toSet();
    targetPerWeek.value = habit.targetPerWeek.clamp(1, habit.activeDays.length);
  }

  @override
  Future<void> close() {
    titleController.dispose();
    descriptionController.dispose();
    activeDays.dispose();
    targetPerWeek.dispose();
    return super.close();
  }
}
