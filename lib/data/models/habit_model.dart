class HabitModel {
  final String id;
  final String title;
  final String? description;
  final DateTime createdAt;
  final List<int> activeDays;
  final Set<String> completedDates;

  int completedThisWeek() {
    final now = DateTime.now();
    final weekStart = now.subtract(Duration(days: now.weekday - 1));

    return completedDates.where((d) {
      final date = DateTime.parse(d);
      return date.isAfter(weekStart.subtract(const Duration(days: 1)));
    }).length;
  }

  int currentStreak() {
    int streak = 0;
    DateTime day = DateTime.now();

    while (completedDates.contains(day.toIso8601String().substring(0, 10))) {
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
