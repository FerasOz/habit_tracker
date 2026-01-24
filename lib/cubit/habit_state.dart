import 'dart:ui';
import 'package:habit_tracker/core/helpers/constants.dart';
import 'package:habit_tracker/data/models/habit_model.dart';

class HabitState {
  final RequestsStatus fetchHabitsStatus;
  final List<HabitModel> habits;
  final Locale locale;
  final String? errorMessage;

  HabitState({
    this.fetchHabitsStatus = RequestsStatus.initial,
    this.habits = const [],
    this.locale = const Locale('en'),
    this.errorMessage,
  });

  HabitState copyWith({
    RequestsStatus? fetchHabitsStatus,
    List<HabitModel>? habits,
    Locale? locale,
    String? errorMessage,
  }) {
    return HabitState(
      fetchHabitsStatus: fetchHabitsStatus ?? this.fetchHabitsStatus,
      habits: habits ?? this.habits,
      locale: locale ?? this.locale,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
