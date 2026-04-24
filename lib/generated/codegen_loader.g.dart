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
    "thisWeek": "هذا الأسبوع",
    "statusDone": "منجز",
    "statusRemaining": "متبقي",
    "restDay": "راحة",
    "inactiveDayError": "لا يمكن إكمال هذه العادة في يوم غير نشط",
    "insightEmpty": "ابدأ بإضافة عادة واحدة لتظهر لك الرؤية اليومية هنا.",
    "insightAllDone": "يوم ممتاز، أنجزت كل عادات اليوم.",
    "insightProgress": "متبقي {weeklyRemaining} إنجاز للوصول لأهداف هذا الأسبوع، وأطول سلسلة حالية {strongestStreak}.",
    "summary": {
      "title": "تقدم اليوم",
      "completed": "عادات مكتملة",
      "excellent": "أداء ممتاز اليوم",
      "good": "أنت على الطريق الصحيح",
      "start": "ابدأ بخطوة صغيرة اليوم"
    }
  },
  "addHabit": {
    "title": "إضافة عادة جديدة",
    "editTitle": "تعديل العادة",
    "nameLabel": "اسم العادة",
    "nameHint": "مثال: شرب الماء",
    "descriptionLabel": "الوصف",
    "descriptionHint": "مثال: شرب 8 أكواب ماء يوميًا",
    "target": "الهدف الأسبوعي",
    "times": "مرات",
    "activeDays": "الأيام النشطة",
    "save": "حفظ العادة",
    "saveChanges": "حفظ التعديلات",
    "quickPreview": "معاينة سريعة",
    "createHeaderSubtitle": "ابدأ بخطوة بسيطة اليوم وكررها كل أسبوع",
    "editHeaderTitle": "حدّث خطتك",
    "editHeaderSubtitle": "عدّل الأيام المستهدفة والوصف لتبقى العادة مناسبة لروتينك",
    "validationNameRequired": "يرجى إدخال اسم العادة",
    "validationNameShort": "اسم العادة قصير جداً",
    "validationActiveDayRequired": "اختر يوماً واحداً على الأقل"
  },
  "habitDetails": {
    "weeklyProgress": "التقدم الأسبوعي",
    "remainingThisWeek": "متبقي هذا الأسبوع: {count}",
    "streakTitle": "الاستمرارية",
    "bestStreakTitle": "أفضل سلسلة",
    "consistencyTitle": "نسبة الالتزام",
    "days": "أيام",
    "completedTitle": "تم الإنجاز",
    "thisWeek": "هذا الأسبوع",
    "markDone": "تم إنجازها اليوم",
    "markUndone": "لم يتم اليوم",
    "inactiveDay": "هذا اليوم غير نشط لهذه العادة",
    "insightDone": "أحسنت، هذه العادة منجزة في اليوم المحدد.",
    "insightGoalReached": "لقد أغلقت هدف الأسبوع. حافظ على الإيقاع.",
    "insightActivePending": "اليوم مناسب لهذه العادة، وإنجازها الآن يقربك من الهدف الأسبوعي.",
    "insightRestDay": "هذا اليوم غير نشط لهذه العادة، ويمكنك اعتباره مساحة راحة."
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
    "version": "الإصدار",
    "builtWith": "تم بناؤه باستخدام فلتر"
  },
  "dialogs": {
    "confirmDeleteTitle": "حذف العادة",
    "confirmDeleteMessage": "هل أنت متأكد أنك تريد حذف هذه العادة؟",
    "cancel": "إلغاء",
    "delete": "حذف"
  }
};
static const Map<String,dynamic> _en = {
  "home": {
    "title": "Habit Tracker",
    "subtitle": "Build better habits",
    "emptyHabits": "No habits yet. Start by adding a new habit!",
    "thisWeek": "This week",
    "statusDone": "Done",
    "statusRemaining": "Remaining",
    "restDay": "Rest day",
    "inactiveDayError": "You can only complete this habit on an active day",
    "insightEmpty": "Add your first habit to unlock daily insights here.",
    "insightAllDone": "Strong day. You completed every habit for this view.",
    "insightProgress": "{weeklyRemaining} check-ins left for this week, and your best current streak is {strongestStreak}.",
    "summary": {
      "title": "Today's Progress",
      "completed": "habits completed",
      "excellent": "Excellent momentum",
      "good": "You are building consistency",
      "start": "Start with one small win today"
    }
  },
  "addHabit": {
    "title": "Add New Habit",
    "editTitle": "Edit Habit",
    "nameLabel": "Habit Name",
    "nameHint": "e.g. Drink Water",
    "descriptionLabel": "Description",
    "descriptionHint": "e.g. Drink 8 glasses of water daily",
    "target": "Target per week",
    "times": "times",
    "activeDays": "Active days",
    "save": "Save Habit",
    "saveChanges": "Save Changes",
    "quickPreview": "Quick preview",
    "createHeaderSubtitle": "Start simple today and repeat it every week",
    "editHeaderTitle": "Refine your plan",
    "editHeaderSubtitle": "Adjust the target, active days, and notes to keep this habit realistic.",
    "validationNameRequired": "Please enter a habit name",
    "validationNameShort": "Habit name is too short",
    "validationActiveDayRequired": "Choose at least one active day"
  },
  "habitDetails": {
    "weeklyProgress": "Weekly Progress",
    "remainingThisWeek": "{count} remaining this week",
    "streakTitle": "Streak",
    "bestStreakTitle": "Best streak",
    "consistencyTitle": "Consistency",
    "days": "days",
    "completedTitle": "Completed",
    "thisWeek": "This Week",
    "markDone": "Mark as Done",
    "markUndone": "Not Done Today",
    "inactiveDay": "This is not an active day",
    "insightDone": "Nice work. This habit is already completed for the selected day.",
    "insightGoalReached": "Weekly goal reached. Keep the rhythm going.",
    "insightActivePending": "Today counts for this habit, and finishing it moves you closer to the weekly goal.",
    "insightRestDay": "This day is off for this habit, so you can treat it as recovery time."
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
    "version": "Version",
    "builtWith": "Built with Flutter"
  },
  "dialogs": {
    "confirmDeleteTitle": "Delete Habit",
    "confirmDeleteMessage": "Are you sure you want to delete this habit?",
    "cancel": "Cancel",
    "delete": "Delete"
  }
};
static const Map<String, Map<String,dynamic>> mapLocales = {"ar": _ar, "en": _en};
}
