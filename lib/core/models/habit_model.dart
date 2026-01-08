class HabitModel {
  final String id;
  final String title;
  final String? description;
  final DateTime createdAt;
  final int targetPerWeek;
  final int completedDays;
  final int currentStreak;
  final bool doneToday;
  final List<int> activeDays;

  HabitModel({
    required this.id,
    required this.title,
    this.description,
    required this.createdAt,
    required this.targetPerWeek,
    required this.completedDays,
    required this.currentStreak,
    required this.doneToday,
    required this.activeDays,
  });

  HabitModel copyWith({
    String? id,
    String? title,
    String? description,
    DateTime? createdAt,
    int? targetPerWeek,
    int? completedDays,
    int? currentStreak,
    bool? doneToday,
    List<int>? activeDays,
  }) {
    return HabitModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      targetPerWeek: targetPerWeek ?? this.targetPerWeek,
      completedDays: completedDays ?? this.completedDays,
      currentStreak: currentStreak ?? this.currentStreak,
      doneToday: doneToday ?? this.doneToday,
      activeDays: activeDays ?? this.activeDays,
    );
  }

  factory HabitModel.fromMap(Map<String, dynamic> map) {
    return HabitModel(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      createdAt: DateTime.parse(map['createdAt']),
      targetPerWeek: map['targetPerWeek'],
      completedDays: map['completedDays'],
      currentStreak: map['currentStreak'],
      doneToday: map['doneToday'],
      activeDays: List<int>.from(map['activeDays']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'createdAt': createdAt.toIso8601String(),
      'targetPerWeek': targetPerWeek,
      'completedDays': completedDays,
      'currentStreak': currentStreak,
      'doneToday': doneToday,
      'activeDays': activeDays,
    };
  }
}
