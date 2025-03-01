import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:warsha_counter/core/utils/themes/colors.dart';
import 'package:warsha_counter/core/utils/themes/fonts.dart';

class AppTheme {
  //!! LIGHT THEME
  static ThemeData get lightTheme {
    return ThemeData(
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          overlayColor:
              WidgetStatePropertyAll(ColorManager.white.withValues(alpha: 0.2)),
          foregroundColor: const WidgetStatePropertyAll(ColorManager.white),
          backgroundColor: const WidgetStatePropertyAll(ColorManager.blue),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          textStyle: WidgetStatePropertyAll(TextStyle(
            fontSize: 16.sp,
            fontFamily: FontManager.amiri,
          )),
        ),
      ),

      iconTheme: const IconThemeData(color: ColorManager.white, size: 25),
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: ColorManager.white,
      //-----------------------------------------------------------//* APP BAR
      appBarTheme: AppBarTheme(
        titleTextStyle: TextStyle(
          color: ColorManager.black,
          fontFamily: FontManager.amiri,
          fontWeight: FontWeight.w600,
          fontSize: 20.sp,
        ),
        backgroundColor: ColorManager.blue,
        centerTitle: false,
        scrolledUnderElevation: 0,
        iconTheme: const IconThemeData(color: ColorManager.white),
        elevation: 0,
        shadowColor: ColorManager.blue.withValues(alpha: 0.3),
      ),

      //-----------------------------------------------------------//* TEXT
      textTheme: TextTheme(
        bodyLarge: TextStyle(
          fontSize: 18.sp,
          color: ColorManager.black,
          fontFamily: FontManager.amiri,
          fontWeight: FontWeight.w600,
        ),
        bodyMedium: TextStyle(
          fontSize: 16.sp,
          color: ColorManager.black,
          fontFamily: FontManager.amiri,
          fontWeight: FontWeight.w300,
        ),
        bodySmall: TextStyle(
          fontSize: 14.sp,
          fontFamily: FontManager.amiri,
          color: ColorManager.black,
          fontWeight: FontWeight.w400,
        ),
      ),

      //-----------------------------------------------------------//* TEXT SELECTION
      textSelectionTheme: TextSelectionThemeData(
          cursorColor: ColorManager.blue,
          selectionColor: ColorManager.blue.withValues(alpha: 0.3),
          selectionHandleColor: ColorManager.blue),

      //--------------------------------------------------//* INPUT DECORATION Text Field
      inputDecorationTheme: InputDecorationTheme(
        isDense: true,
        contentPadding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 20.w),
        hintStyle: const TextStyle(color: ColorManager.white),
        labelStyle: TextStyle(
            color: ColorManager.blue,
            fontFamily: FontManager.amiri,
            fontWeight: FontWeight.w400,
            fontSize: 16.sp),
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: ColorManager.blue, width: 1.2),
          borderRadius: BorderRadius.all(Radius.circular(8.r)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.r)),
          borderSide: const BorderSide(color: ColorManager.blue, width: 1.2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.r)),
          borderSide: const BorderSide(color: ColorManager.blue, width: 1.2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.r)),
          borderSide: const BorderSide(color: Colors.red, width: 1.2),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.r)),
          borderSide: const BorderSide(color: Colors.red, width: 1.2),
        ),
      ),
    );
  }
}
