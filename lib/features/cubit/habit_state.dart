import 'package:habit_tracker/core/helpers/constants.dart';
import 'package:habit_tracker/core/models/habit_model.dart';

class HabitState {
  final RequestsStatus fetchHabitsStatus;
  final List<HabitModel> habits;
  final String? errorMessage;

  HabitState({
    this.fetchHabitsStatus = RequestsStatus.initial,
    this.habits = const [],
    this.errorMessage,
  });

  HabitState copyWith({
    RequestsStatus? fetchHabitsStatus,
    List<HabitModel>? habits,
    String? errorMessage,
  }) {
    return HabitState(
      fetchHabitsStatus: fetchHabitsStatus ?? this.fetchHabitsStatus,
      habits: habits ?? this.habits,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
