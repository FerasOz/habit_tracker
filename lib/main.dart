import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:habit_tracker/core/helpers/app_storage.dart';
import 'package:habit_tracker/core/routing/app_routers.dart';
import 'package:habit_tracker/generated/codegen_loader.g.dart';
import 'package:habit_tracker/habit_tracker_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppStorage.init();
  await ScreenUtil.ensureScreenSize();
  await EasyLocalization.ensureInitialized();
  runApp(
    EasyLocalization(
      supportedLocales: [Locale('en'), Locale('ar')],
      path: 'assets/translations',
      fallbackLocale: Locale('ar'),
      assetLoader: CodegenLoader(),
      child: HabitTrackerApp(appRouters: AppRouters()),
    ),
  );
}
