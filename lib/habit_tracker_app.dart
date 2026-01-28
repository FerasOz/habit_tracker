import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:habit_tracker/core/routing/app_routers.dart';
import 'package:habit_tracker/core/routing/routes.dart';
import 'package:habit_tracker/core/styles/themes.dart';
import 'package:habit_tracker/cubit/habit_cubit.dart';
import 'package:habit_tracker/cubit/habit_state.dart';

class HabitTrackerApp extends StatelessWidget {
  final AppRouters appRouters;
  const HabitTrackerApp({super.key, required this.appRouters});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => appRouters.habitCubit,
      child: ScreenUtilInit(
        designSize: const Size(393, 852),
        minTextAdapt: true,
        builder: (context, child) {
          return BlocBuilder<HabitCubit, HabitState>(
            builder: (context, state) {
              return MaterialApp(
                localizationsDelegates: context.localizationDelegates,
                supportedLocales: context.supportedLocales,
                locale: context.locale,
                debugShowCheckedModeBanner: false,
                title: 'Habit Tracker',
                themeMode: state.isDarkMode ? ThemeMode.dark : ThemeMode.light,
                theme: AppThemes.lightTheme,
                darkTheme: AppThemes.darkTheme,
                onGenerateRoute: appRouters.onGenerateRoute,
                initialRoute: Routes.homeScreen,
              );
            },
          );
        },
      ),
    );
  }
}
