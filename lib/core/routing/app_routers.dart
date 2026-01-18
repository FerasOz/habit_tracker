import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_tracker/core/models/habit_model.dart';
import 'package:habit_tracker/core/routing/routes.dart';
import 'package:habit_tracker/features/add_habit/add_habit_screen.dart';
import 'package:habit_tracker/features/cubit/habit_cubit.dart';
import 'package:habit_tracker/features/habit_details/habit_details_screen.dart';
import 'package:habit_tracker/features/home/home_screen.dart';
import 'package:habit_tracker/features/settings/settings_screen.dart';

class AppRouters {
  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.homeScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => HabitCubit()..fetchHabits(),
            child: HomeScreen(),
          ),
        );
      case Routes.addHabitScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => HabitCubit(),
            child: AddHabitScreen(),
          ),
        );
      case Routes.habitDetailsScreen:
        final habit = settings.arguments as HabitModel;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => HabitCubit(),
            child: HabitDetailsScreen(habit: habit),
          ),
        );
      case Routes.settingsScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => HabitCubit(),
            child: SettingsScreen(),
          ),
        );
      default:
        return MaterialPageRoute(
          builder: (_) =>
              const Scaffold(body: Center(child: Text("Page not found"))),
        );
    }
  }
}
