import 'package:easy_localization/easy_localization.dart';

class HabitModel {
  final String id;
  final String title;
  final String? description;
  final DateTime createdAt;
  final List<int> activeDays;
  final Set<String> completedDates;

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

  int currentStreak(DateTime selectedDay) {
    int streak = 0;
    DateTime day = selectedDay;

    while (completedDates.contains(DateFormat('yyyy-MM-dd').format(day))) {
      streak++;
      day = day.subtract(const Duration(days: 1));
    }
    return streak;
  }

  HabitModel({
    required this.id,
    required this.title,
    this.description,
    required this.createdAt,
    required this.activeDays,
    required this.completedDates,
  });

  HabitModel copyWith({
    String? id,
    String? title,
    String? description,
    DateTime? createdAt,
    List<int>? activeDays,
    Set<String>? completedDates,
  }) {
    return HabitModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      activeDays: activeDays ?? this.activeDays,
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
      'completedDates': completedDates.toList(),
    };
  }
}
