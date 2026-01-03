import 'package:habit_tracker/core/helpers/constants.dart';
import 'package:habit_tracker/core/models/habit_model.dart';

class HabitState {
  final RequestsStatus fetchHabitsStatus;
  final List<HabitModel> habitModel;
  final String? errorMessage;

  HabitState({
    this.fetchHabitsStatus = RequestsStatus.initial,
    this.habitModel = const [],
    this.errorMessage,
  });

  HabitState copyWith({
    RequestsStatus? fetchHabitsStatus,
    List<HabitModel>? habitModel,
    String? errorMessage,
  }) {
    return HabitState(
      fetchHabitsStatus: fetchHabitsStatus ?? this.fetchHabitsStatus,
      habitModel: habitModel ?? this.habitModel,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
