import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'colors.dart';

class AppThemes {
  static const String fontFamily = 'Poppins';

  // ================= LIGHT THEME =================
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: fontFamily,

    scaffoldBackgroundColor: ColorsManager.lightBackground,

    primaryColor: ColorsManager.primary,

    appBarTheme: AppBarTheme(
      backgroundColor: ColorsManager.lightBackground,
      elevation: 0,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      titleTextStyle: TextStyle(
        color: ColorsManager.textPrimary,
        fontSize: 20.sp,
        fontWeight: FontWeight.w600,
        fontFamily: fontFamily,
      ),
      iconTheme: const IconThemeData(color: ColorsManager.textPrimary),
    ),

    cardTheme: CardThemeData(
      color: ColorsManager.lightCard,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
    ),

    textTheme: TextTheme(
      displayLarge: TextStyle(
        fontSize: 28.sp,
        fontWeight: FontWeight.w600,
        color: ColorsManager.textPrimary,
      ),
      titleLarge: TextStyle(
        fontSize: 18.sp,
        fontWeight: FontWeight.w600,
        color: ColorsManager.textPrimary,
      ),
      bodyMedium: TextStyle(
        fontSize: 14.sp,
        color: ColorsManager.textSecondary,
      ),
      bodySmall: TextStyle(fontSize: 12.sp, color: ColorsManager.textSecondary),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      contentPadding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: BorderSide(color: ColorsManager.borderLight),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: BorderSide(color: ColorsManager.borderLight),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: BorderSide(color: ColorsManager.primary),
      ),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: ColorsManager.primary,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14.r),
        ),
        textStyle: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
      ),
    ),
    colorScheme: ColorScheme.light(
      primary: ColorsManager.primary,
      secondary: ColorsManager.primary,
      surface: Colors.white,
      error: Colors.red,
    ),
  );

  // ================= DARK THEME =================
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: fontFamily,
    brightness: Brightness.dark,

    scaffoldBackgroundColor: ColorsManager.darkBackground,
    primaryColor: ColorsManager.primary,

    appBarTheme: AppBarTheme(
      backgroundColor: ColorsManager.darkBackground,
      elevation: 0,
      systemOverlayStyle: SystemUiOverlayStyle.light,
      titleTextStyle: TextStyle(
        color: ColorsManager.textLight,
        fontSize: 20.sp,
        fontWeight: FontWeight.w600,
      ),
      iconTheme: const IconThemeData(color: Colors.white),
    ),

    cardTheme: CardThemeData(
      color: ColorsManager.darkCard,
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
    ),

    textTheme: TextTheme(
      displayLarge: TextStyle(
        fontSize: 28.sp,
        fontWeight: FontWeight.w600,
        color: ColorsManager.textLight,
      ),
      titleLarge: TextStyle(
        fontSize: 18.sp,
        fontWeight: FontWeight.w600,
        color: ColorsManager.textLight,
      ),
      bodyMedium: TextStyle(
        fontSize: 14.sp,
        color: ColorsManager.textMutedDark,
      ),
      bodySmall: TextStyle(fontSize: 12.sp, color: ColorsManager.textMutedDark),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: ColorsManager.darkCard,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: BorderSide(color: ColorsManager.borderDark),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: BorderSide(color: ColorsManager.primary),
      ),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: ColorsManager.primary,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14.r),
        ),
      ),
    ),
    colorScheme: ColorScheme.dark(
      primary: ColorsManager.primary,
      secondary: ColorsManager.primary,
      surface: ColorsManager.darkBackground,
      error: Colors.red,
    ),
  );
}
