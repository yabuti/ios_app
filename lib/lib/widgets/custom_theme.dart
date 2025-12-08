import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/constraints.dart';

class MyTheme {
  static final borderRadius = BorderRadius.circular(10.0);
  static final theme = ThemeData(
      brightness: Brightness.light,
      primaryColor: whiteColor,

      scaffoldBackgroundColor: scaffoldBgColor,
       bottomSheetTheme: const BottomSheetThemeData(backgroundColor: whiteColor),

      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        scrolledUnderElevation: 0.0,
        titleTextStyle: GoogleFonts.roboto(
            color: blackColor, fontSize: 20, fontWeight: FontWeight.bold),
        iconTheme: const IconThemeData(color: blackColor),
        elevation: 0,
      ),
      textTheme: GoogleFonts.robotoTextTheme(
        TextTheme(
          bodySmall: GoogleFonts.roboto(fontSize: 14, height: 1.83),
          bodyLarge: GoogleFonts.roboto(
              fontSize: 16, fontWeight: FontWeight.w500, height: 1.375),
          bodyMedium: GoogleFonts.roboto(fontSize: 14, height: 1.5714),
          labelLarge: GoogleFonts.roboto(
              fontSize: 16, height: 2, fontWeight: FontWeight.w600),
          titleLarge: GoogleFonts.roboto(
              fontSize: 16, height: 2, fontWeight: FontWeight.w600),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(double.infinity, 64),
          backgroundColor: whiteColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
        ),
      ),
      textButtonTheme: const TextButtonThemeData(
        style: ButtonStyle(
            shadowColor: WidgetStatePropertyAll(transparent),
            elevation: WidgetStatePropertyAll(0.0),
            iconSize: WidgetStatePropertyAll(20.0),
            splashFactory: NoSplash.splashFactory,
            overlayColor: WidgetStatePropertyAll(
              (transparent),
            ),
            padding: WidgetStatePropertyAll(EdgeInsets.zero)),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        elevation: 3,
        backgroundColor: whiteColor,
        showUnselectedLabels: true,
        selectedLabelStyle: GoogleFonts.roboto(
          fontWeight: FontWeight.w400,
          color: textColor,
          fontSize: 14.0,
        ),
        unselectedLabelStyle: GoogleFonts.roboto(
          fontWeight: FontWeight.w400,
          color: blackColor,
          fontSize: 14.0,
        ),
        selectedItemColor: textColor,
        unselectedItemColor: blackColor,
      ),

      inputDecorationTheme: InputDecorationTheme(
        isDense: true,
        hintStyle: GoogleFonts.roboto(
          fontWeight: FontWeight.w400,
          fontSize: 16.0,
          color: const Color(0xFFBABABA),
        ),
        labelStyle: GoogleFonts.roboto(
          fontWeight: FontWeight.w400,
          fontSize: 16.0,
          color: hintTextColor,
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 17.0, horizontal: 20.0),
        fillColor: const Color(0xFFF8FAFC),
        filled: true,
        border: InputBorder.none, // No border initially
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(
            color: borderColor,
            width: 1,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(
            color: borderColor,
            width: 1,
          ),
        ),
      ),
      textSelectionTheme:  TextSelectionThemeData(
        cursorColor: blackColor,
        selectionColor: primaryColor.withOpacity(0.5),
        selectionHandleColor: primaryColor,
      ),
      progressIndicatorTheme:
          const ProgressIndicatorThemeData(color: primaryColor));
}
