import 'dart:ui';
import 'package:habit_tracker/core/helpers/constants.dart';
import 'package:habit_tracker/data/models/habit_model.dart';

class HabitState {
  final RequestsStatus fetchHabitsStatus;
  final List<HabitModel> habits;
  final bool isDarkMode;
  final Locale locale;
  final String? errorMessage;
  final DateTime selectedDay;

  HabitState({
    this.fetchHabitsStatus = RequestsStatus.initial,
    this.habits = const [],
    this.locale = const Locale('en'),
    this.errorMessage,
    this.isDarkMode = false,
    DateTime? selectedDay,
  }) : selectedDay = selectedDay ?? DateTime.now();

  HabitState copyWith({
    RequestsStatus? fetchHabitsStatus,
    List<HabitModel>? habits,
    bool? isDarkMode,
    Locale? locale,
    String? errorMessage,
    DateTime? selectedDay,
  }) {
    return HabitState(
      fetchHabitsStatus: fetchHabitsStatus ?? this.fetchHabitsStatus,
      habits: habits ?? this.habits,
      locale: locale ?? this.locale,
      isDarkMode: isDarkMode ?? this.isDarkMode,
      errorMessage: errorMessage,
      selectedDay: selectedDay ?? this.selectedDay,
    );
  }
}
