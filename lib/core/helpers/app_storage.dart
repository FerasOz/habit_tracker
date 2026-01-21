import 'dart:convert';

import 'package:habit_tracker/core/models/habit_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppStorage {
  static late SharedPreferences _prefs;
  static const String _habitsKey = "HABITS_DATA";
  static const String _languageKey = 'APP_LANGUAGE';

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static Future<void> saveHabits(List<HabitModel> habits) async {
    final String jsonString = jsonEncode(
      habits.map((habit) => habit.toMap()).toList(),
    );
    await _prefs.setString(_habitsKey, jsonString);
  }

  static Future<List<HabitModel>> getHabits() async {
    try {
      final jsonString = _prefs.getString(_habitsKey);
      if (jsonString == null) return [];

      final List decoded = jsonDecode(jsonString);
      return decoded.map((e) => HabitModel.fromMap(e)).toList();
    } catch (e) {
      return [];
    }
  }

  static Future<void> deleteHabit(String id) async {
    final habits = await getHabits();
    final updated = habits.where((h) => h.id != id).toList();
    await saveHabits(updated);
  }

  static Future<void> updateHabit(HabitModel habit) async {
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

  // save language

  static Future<void> saveLanguage(String code) async {
    await _prefs.setString(_languageKey, code);
  }

  static Future<String?> getSavedLanguage() async {
    return _prefs.getString(_languageKey);
  }
}
