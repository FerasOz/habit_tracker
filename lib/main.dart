import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:habit_tracker/core/routing/app_routers.dart';
import 'package:habit_tracker/habit_tracker_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  runApp(HabitTrackerApp(appRouters: AppRouters()));
}
