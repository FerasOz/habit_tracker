import 'package:easy_localization/easy_localization.dart';

class HabitModel {
  final String id;
  final String title;
  final String? description;
  final DateTime createdAt;
  final List<int> activeDays;
  final int targetPerWeek;
  final Set<String> completedDates;

  static final DateFormat _dateFormat = DateFormat('yyyy-MM-dd');

  String _dateKey(DateTime date) {
    return _dateFormat.format(DateTime(date.year, date.month, date.day));
  }

  bool isActiveOn(DateTime date) => activeDays.contains(date.weekday);

  bool isCompletedOn(DateTime date) => completedDates.contains(_dateKey(date));

  int completedThisWeek(DateTime selectedDay) {
    final weekStart = selectedDay.subtract(
      Duration(days: selectedDay.weekday - 1),
    );
    final weekEnd = weekStart.add(const Duration(days: 6));

    return completedDates.where((d) {
      final date = DateTime.parse(d);
      return !date.isBefore(weekStart) && !date.isAfter(weekEnd);
    }).length;
  }

  int remainingThisWeek(DateTime selectedDay) {
    final remaining = targetPerWeek - completedThisWeek(selectedDay);
    return remaining < 0 ? 0 : remaining;
  }

  double completionRate(DateTime selectedDay, {int lookbackDays = 28}) {
    final end = DateTime(selectedDay.year, selectedDay.month, selectedDay.day);
    final start = end.subtract(Duration(days: lookbackDays - 1));

    int scheduledDays = 0;
    int completedScheduledDays = 0;

    for (int index = 0; index < lookbackDays; index++) {
      final day = start.add(Duration(days: index));
      if (!isActiveOn(day)) continue;
      scheduledDays++;
      if (isCompletedOn(day)) {
        completedScheduledDays++;
      }
    }

    if (scheduledDays == 0) {
      return 0;
    }

    return completedScheduledDays / scheduledDays;
  }

  int currentStreak(DateTime selectedDay) {
    int streak = 0;
    DateTime day = DateTime(
      selectedDay.year,
      selectedDay.month,
      selectedDay.day,
    );
    int guard = 0;

    // Count consecutive completed active-days going backward from selectedDay.
    while (guard < 3660) {
      guard++;
      if (!activeDays.contains(day.weekday)) {
        day = day.subtract(const Duration(days: 1));
        continue;
      }

      final dateKey = DateFormat('yyyy-MM-dd').format(day);
      if (!completedDates.contains(dateKey)) {
        break;
      }

      streak++;
      day = day.subtract(const Duration(days: 1));
    }

    return streak;
  }

  int bestStreak() {
    if (completedDates.isEmpty) {
      return 0;
    }

    final sortedDates = completedDates.map(DateTime.parse).toList()
      ..sort((a, b) => a.compareTo(b));

    int best = 0;

    for (final completedDay in sortedDates) {
      final streak = currentStreak(completedDay);
      if (streak > best) {
        best = streak;
      }
    }

    return best;
  }

  HabitModel({
    required this.id,
    required this.title,
    this.description,
    required this.createdAt,
    required this.activeDays,
    required this.targetPerWeek,
    required this.completedDates,
  });

  HabitModel copyWith({
    String? id,
    String? title,
    String? description,
    DateTime? createdAt,
    List<int>? activeDays,
    int? targetPerWeek,
    Set<String>? completedDates,
  }) {
    return HabitModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      activeDays: activeDays ?? this.activeDays,
      targetPerWeek: targetPerWeek ?? this.targetPerWeek,
      completedDates: completedDates ?? this.completedDates,
    );
  }

  factory HabitModel.fromMap(Map<String, dynamic> map) {
    return HabitModel(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      createdAt: DateTime.parse(map['createdAt']),
      activeDays: List<int>.from(map['activeDays']),
      targetPerWeek: map['targetPerWeek'] ?? List<int>.from(map['activeDays']).length,
      completedDates: Set<String>.from(map['completedDates'] ?? []),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'createdAt': createdAt.toIso8601String(),
      'activeDays': activeDays,
      'targetPerWeek': targetPerWeek,
      'completedDates': completedDates.toList(),
    };
  }
}
