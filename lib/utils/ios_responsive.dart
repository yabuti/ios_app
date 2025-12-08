import 'dart:io';
import 'package:flutter/material.dart';

/// iOS-specific responsive utilities
class IOSResponsive {
  /// Check if running on iOS
  static bool get isIOS => Platform.isIOS;
  
  /// Check if running on iPad
  static bool isIPad(BuildContext context) {
    if (!isIOS) return false;
    final size = MediaQuery.of(context).size;
    return size.shortestSide >= 600;
  }
  
  /// Get safe area padding for iOS notch
  static EdgeInsets getSafeArea(BuildContext context) {
    return MediaQuery.of(context).padding;
  }
  
  /// Get responsive padding based on device
  static EdgeInsets getResponsivePadding(BuildContext context) {
    if (isIPad(context)) {
      return const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0);
    }
    return const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0);
  }
  
  /// Get responsive font size
  static double getResponsiveFontSize(BuildContext context, double baseSize) {
    if (isIPad(context)) {
      return baseSize * 1.2; // 20% larger on iPad
    }
    return baseSize;
  }
  
  /// Get responsive icon size
  static double getResponsiveIconSize(BuildContext context, double baseSize) {
    if (isIPad(context)) {
      return baseSize * 1.3; // 30% larger on iPad
    }
    return baseSize;
  }
  
  /// Get responsive spacing
  static double getResponsiveSpacing(BuildContext context, double baseSpacing) {
    if (isIPad(context)) {
      return baseSpacing * 1.5; // 50% more spacing on iPad
    }
    return baseSpacing;
  }
  
  /// Get grid column count based on device
  static int getGridColumnCount(BuildContext context) {
    if (isIPad(context)) {
      final orientation = MediaQuery.of(context).orientation;
      return orientation == Orientation.landscape ? 4 : 3;
    }
    return 2; // iPhone
  }
  
  /// Get responsive card height
  static double getCardHeight(BuildContext context, double baseHeight) {
    if (isIPad(context)) {
      return baseHeight * 1.3;
    }
    return baseHeight;
  }
  
  /// Get responsive button height
  static double getButtonHeight(BuildContext context) {
    if (isIPad(context)) {
      return 60.0;
    }
    return 50.0;
  }
  
  /// Get responsive app bar height
  static double getAppBarHeight(BuildContext context) {
    if (isIPad(context)) {
      return 70.0;
    }
    return 56.0;
  }
  
  /// iOS-style bottom sheet
  static Future<T?> showIOSBottomSheet<T>({
    required BuildContext context,
    required Widget child,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 8),
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 16),
            child,
          ],
        ),
      ),
    );
  }
  
  /// iOS-style alert dialog
  static Future<T?> showIOSAlert<T>({
    required BuildContext context,
    required String title,
    required String message,
    String? cancelText,
    String? confirmText,
    VoidCallback? onConfirm,
  }) {
    return showDialog<T>(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
        ),
        content: Text(
          message,
          style: const TextStyle(
            fontSize: 13,
            color: Colors.black87,
          ),
        ),
        actions: [
          if (cancelText != null)
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                cancelText,
                style: const TextStyle(
                  fontSize: 17,
                  color: Colors.blue,
                ),
              ),
            ),
          if (confirmText != null)
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                onConfirm?.call();
              },
              child: Text(
                confirmText,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  color: Colors.blue,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
