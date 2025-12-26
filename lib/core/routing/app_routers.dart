import 'package:flutter/material.dart';
import 'package:habit_tracker/core/routing/routes.dart';
import 'package:habit_tracker/features/add_habit/add_habit_screen.dart';
import 'package:habit_tracker/features/habit_details/habit_details_screen.dart';
import 'package:habit_tracker/features/home/home_screen.dart';
import 'package:habit_tracker/features/settings/settings_screen.dart';

class AppRouters {
  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.homeScreen:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case Routes.addHabitScreen:
        return MaterialPageRoute(builder: (_) => AddHabitScreen());
      case Routes.habitDetailsScreen:
        return MaterialPageRoute(
          builder: (_) => HabitDetailsScreen(
            habitName: '',
            target: 10,
            icon: Icons.add_ic_call,
            completed: 5,
          ),
        );
      case Routes.settingsScreen:
        return MaterialPageRoute(builder: (_) => SettingsScreen());
    }
    return null;
  }
}
