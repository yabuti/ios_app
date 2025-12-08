import 'package:flutter/material.dart';

/// === Brand Colors ===
const primaryColor = Color(0xFFE9D634); // Yellow - Main Accent
const secondaryColor = Color(0xFF000000); // Black - Brand Base
const lightGreyColor = Color(0xFFF2F2F2); // Light Grey - Backgrounds

/// === Supporting Colors ===
const blackColor = Color(0xFF000000);
const greyColor = Color(0xFFB0B0B0);
Color hintTextColor = const Color(0xFF000000).withOpacity(0.3);
const whiteColor = Color(0xFFFFFFFF);

/// === Functional / State Colors ===
/// Keep for warning/error/success states used throughout the app
const greenColor = Color(0xFF22C55E); // Success / Confirm
const blueColor = Color(0xFF3266CC); // Info / Upload / Action
const redColor = Color(0xFFFF3838); // Error / Delete / Warning

/// === UI Backgrounds & Borders ===
const scaffoldBgColor = Color(0xFFF2F2F2);
const grayBackgroundColor = Color(0xFFF2F2F2);
const borderColor = Color(0xFFE0E0E0);

/// === Text Colors ===
const sTextColor = Color(0xFF4A4A4A);
const textColor = Color(0xFF000000);

/// === Animation Durations ===
const kDuration = Duration(milliseconds: 300);

/// === Misc ===
const Color transparent = Colors.transparent;
const double dialogHeight = 270.0;

/// === Custom Fonts ===
const String bold400 = 'Regular400';
const String bold500 = 'Regular500';
const String bold700 = 'Bold700';

/// === Gradients ===
/// Use company palette: yellow → black
const buttonGradient = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [Color(0xFFE9D634), Color(0xFF000000)],
);

const activeTabButtonGradient = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [Color(0xFFE9D634), Color(0xFF000000)],
);

const inactiveTabButtonGradient = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [Colors.white, lightGreyColor],
);

const dialogCircleGradient = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [Color(0xFFE9D634), Color(0xFF000000)],
);
