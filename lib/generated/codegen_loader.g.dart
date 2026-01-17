// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes, avoid_renaming_method_parameters, constant_identifier_names

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader{
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>?> load(String path, Locale locale) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String,dynamic> _ar = {
  "home": {
    "title": "متتبع العادات",
    "subtitle": "ابنِ عادات أفضل",
    "emptyHabits": "لا توجد عادات بعد، ابدأ بإضافة عادة جديدة",
    "summary": {
      "title": "تقدم اليوم",
      "completed": "عادات مكتملة"
    },
    "thisWeek": "هذا الأسبوع"
  },
  "addHabit": {
    "title": "إضافة عادة جديدة",
    "nameLabel": "اسم العادة",
    "nameHint": "مثال: شرب الماء",
    "descriptionLabel": "الوصف",
    "descriptionHint": "مثال: شرب 8 أكواب ماء يوميًا",
    "target": "الهدف الأسبوعي",
    "times": "مرات",
    "activeDays": "الأيام النشطة",
    "save": "حفظ العادة"
  },
  "habitDetails": {
    "weeklyProgress": "التقدم الأسبوعي",
    "streakTitle": "الاستمرارية",
    "days": "أيام",
    "completedTitle": "تم الإنجاز",
    "thisWeek": "هذا الأسبوع",
    "markDone": "تم إنجازه اليوم",
    "markUndone": "لم يتم اليوم"
  },
  "settings": {
    "title": "الإعدادات",
    "appearance": "المظهر",
    "darkMode": "الوضع الداكن",
    "language": "اللغة",
    "appLanguage": "لغة التطبيق",
    "english": "الإنجليزية",
    "arabic": "العربية",
    "about": "حول التطبيق",
    "aboutText": "يساعدك هذا التطبيق على تتبع وبناء عادات أفضل لتحسين حياتك اليومية."
  }
};
static const Map<String,dynamic> _en = {
  "home": {
    "title": "Habit Tracker",
    "subtitle": "Build better habits",
    "emptyHabits": "No habits yet. Start by adding a new habit!",
    "summary": {
      "title": "Today's Progress",
      "completed": "habits completed"
    },
    "thisWeek": "This week"
  },
  "addHabit": {
    "title": "Add New Habit",
    "nameLabel": "Habit Name",
    "nameHint": "e.g. Drink Water",
    "descriptionLabel": "Description",
    "descriptionHint": "e.g. Drink 8 glasses of water daily",
    "target": "Target per week",
    "times": "times",
    "activeDays": "Active days",
    "save": "Save Habit"
  },
  "habitDetails": {
    "weeklyProgress": "Weekly Progress",
    "streakTitle": "Streak",
    "days": "days",
    "completedTitle": "Completed",
    "thisWeek": "This Week",
    "markDone": "Mark as Done",
    "markUndone": "Not Done Today"
  },
  "settings": {
    "title": "Settings",
    "appearance": "Appearance",
    "darkMode": "Dark Mode",
    "language": "Language",
    "appLanguage": "App Language",
    "english": "English",
    "arabic": "Arabic",
    "about": "About",
    "aboutText": "This app helps you track and build better habits to improve your daily life."
  }
};
static const Map<String, Map<String,dynamic>> mapLocales = {"ar": _ar, "en": _en};
}
