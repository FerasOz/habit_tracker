import 'dart:convert';

import 'package:habit_tracker/core/models/habit_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HabitStorage {
  static late SharedPreferences _prefs;
  static const String key = "HABITS_DATA";

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static Future<void> saveHabits(List<HabitModel> habits) async {
    final String jsonString =
        jsonEncode(habits.map((habit) => habit.toMap()).toList());
    await _prefs.setString(key, jsonString);
  }

  static Future<List<HabitModel>> getHabits() {
    final jsonString = _prefs.getString(key);
    if (jsonString != null) {
      final List decoded = jsonDecode(jsonString);
      return Future.value(decoded.map((e) => HabitModel.fromMap(e)).toList());
    }
    return Future.value([]);
  }

Future<void> deleteHabit(String id) async {
  final habits = await getHabits();
  final updated = habits.where((h) => h.id != id).toList();
  await saveHabits(updated);
}

Future<void> updateHabit(HabitModel habit) async {
  final habits = await getHabits();

  final updated = habits.map((h) {
    if (h.id == habit.id) return habit;
    return h;
  }).toList();

  await saveHabits(updated);
}

  static Future<void> clearAllData() async {
    await _prefs.clear();
  }

  

}