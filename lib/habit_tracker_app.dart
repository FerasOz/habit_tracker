import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:habit_tracker/core/routing/app_routers.dart';
import 'package:habit_tracker/core/routing/routes.dart';

class HabitTrackerApp extends StatelessWidget {
  final AppRouters appRouters;
  const HabitTrackerApp({super.key, required this.appRouters});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 852),
      minTextAdapt: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Habit Tracker',
          themeMode: ThemeMode.system,
          // theme: lightTheme,
          // darkTheme: darkTheme,
                    onGenerateRoute: appRouters.onGenerateRoute,
          initialRoute: Routes.homeScreen,
        );
      },
    );
  }
}
