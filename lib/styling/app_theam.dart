  import 'package:flutter/material.dart';
  import 'package:google_fonts/google_fonts.dart';
  import 'app_color.dart';
  import 'app_font_anybody.dart';
  import 'app_font_poppins.dart';

  class LightTheme {
    static theme() => ThemeData(
      scaffoldBackgroundColor: AppColor.cF6F7FF,
      colorScheme: ColorScheme.fromSeed(seedColor: AppColor.cEAE8E8),
      useMaterial3: true,
      fontFamily: GoogleFonts.anybody().fontFamily,
      inputDecorationTheme: InputDecorationTheme(

        fillColor: AppColor.cF6F7FF,
        filled: true,
        labelStyle: w400_13a(color: AppColor.c455A64),
        hintStyle: w400_14p(color: AppColor.c2C2A2A.withOpacity(0.40)),
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),

        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColor.cEAE8E8.withOpacity(1)),
          borderRadius: BorderRadius.circular(28),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColor.c5C6B72.withOpacity(0.5)),
          borderRadius: BorderRadius.circular(28),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColor.c5C6B72.withOpacity(0.5)),
          borderRadius: BorderRadius.circular(28),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColor.c5C6B72.withOpacity(0.5)),
          borderRadius: BorderRadius.circular(28),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColor.c5C6B72.withOpacity(0.5)),
          borderRadius: BorderRadius.circular(28),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: AppColor.c5C6B72.withOpacity(1)),
          borderRadius: BorderRadius.circular(28),
        ),
      ),
    );
  }
