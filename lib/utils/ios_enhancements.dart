import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// iOS-specific enhancements and optimizations
class IOSEnhancements {
  /// Initialize iOS-specific configurations
  static void initialize() {
    if (Platform.isIOS) {
      // Set iOS status bar style
      SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          statusBarBrightness: Brightness.light,
          statusBarIconBrightness: Brightness.dark,
        ),
      );
      
      // Enable edge-to-edge display
      SystemChrome.setEnabledSystemUIMode(
        SystemUiMode.edgeToEdge,
        overlays: [SystemUiOverlay.top],
      );
    }
  }
  
  /// Show iOS-style loading indicator
  static void showIOSLoading(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: CupertinoActivityIndicator(
          radius: 20,
          color: Colors.white,
        ),
      ),
    );
  }
  
  /// Show iOS-style action sheet
  static Future<T?> showIOSActionSheet<T>({
    required BuildContext context,
    required String title,
    required List<IOSActionSheetAction> actions,
  }) {
    return showCupertinoModalPopup<T>(
      context: context,
      builder: (context) => CupertinoActionSheet(
        title: Text(
          title,
          style: const TextStyle(fontSize: 13),
        ),
        actions: actions.map((action) {
          return CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context);
              action.onPressed();
            },
            isDefaultAction: action.isDefault,
            isDestructiveAction: action.isDestructive,
            child: Text(action.label),
          );
        }).toList(),
        cancelButton: CupertinoActionSheetAction(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
      ),
    );
  }
  
  /// Show iOS-style picker
  static Future<T?> showIOSPicker<T>({
    required BuildContext context,
    required Widget picker,
    String? title,
  }) {
    return showCupertinoModalPopup<T>(
      context: context,
      builder: (context) => Container(
        height: 250,
        color: CupertinoColors.systemBackground.resolveFrom(context),
        child: Column(
          children: [
            Container(
              height: 44,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: CupertinoColors.separator.resolveFrom(context),
                    width: 0.5,
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel'),
                  ),
                  if (title != null)
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    onPressed: () => Navigator.pop(context, true),
                    child: const Text('Done'),
                  ),
                ],
              ),
            ),
            Expanded(child: picker),
          ],
        ),
      ),
    );
  }
  
  /// iOS-style text field
  static Widget iosTextField({
    required TextEditingController controller,
    required String placeholder,
    TextInputType? keyboardType,
    bool obscureText = false,
    Widget? prefix,
    Widget? suffix,
    int? maxLines = 1,
  }) {
    return CupertinoTextField(
      controller: controller,
      placeholder: placeholder,
      keyboardType: keyboardType,
      obscureText: obscureText,
      prefix: prefix,
      suffix: suffix,
      maxLines: maxLines,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: CupertinoColors.systemGrey6,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
  
  /// iOS-style button
  static Widget iosButton({
    required String text,
    required VoidCallback onPressed,
    Color? color,
    bool isDestructive = false,
  }) {
    return CupertinoButton(
      onPressed: onPressed,
      color: isDestructive ? CupertinoColors.destructiveRed : (color ?? CupertinoColors.activeBlue),
      borderRadius: BorderRadius.circular(10),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
    );
  }
  
  /// iOS-style switch
  static Widget iosSwitch({
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return CupertinoSwitch(
      value: value,
      onChanged: onChanged,
      activeColor: CupertinoColors.activeGreen,
    );
  }
  
  /// iOS-style segmented control
  static Widget iosSegmentedControl<T>({
    required Map<T, Widget> children,
    required T groupValue,
    required ValueChanged<T?> onValueChanged,
  }) {
    return CupertinoSegmentedControl<T>(
      children: children,
      groupValue: groupValue,
      onValueChanged: onValueChanged,
      borderColor: CupertinoColors.systemGrey,
      selectedColor: CupertinoColors.activeBlue,
      unselectedColor: CupertinoColors.white,
    );
  }
  
  /// iOS-style navigation bar
  static CupertinoNavigationBar iosNavigationBar({
    required String title,
    Widget? leading,
    Widget? trailing,
    bool automaticallyImplyLeading = true,
  }) {
    return CupertinoNavigationBar(
      middle: Text(title),
      leading: leading,
      trailing: trailing,
      automaticallyImplyLeading: automaticallyImplyLeading,
      backgroundColor: CupertinoColors.systemBackground,
      border: const Border(
        bottom: BorderSide(
          color: CupertinoColors.separator,
          width: 0.5,
        ),
      ),
    );
  }
  
  /// iOS-style list tile
  static Widget iosListTile({
    required String title,
    String? subtitle,
    Widget? leading,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return CupertinoListTile(
      title: Text(title),
      subtitle: subtitle != null ? Text(subtitle) : null,
      leading: leading,
      trailing: trailing ?? const CupertinoListTileChevron(),
      onTap: onTap,
    );
  }
  
  /// Haptic feedback for iOS
  static void hapticFeedback({HapticFeedbackType type = HapticFeedbackType.light}) {
    if (Platform.isIOS) {
      switch (type) {
        case HapticFeedbackType.light:
          HapticFeedback.lightImpact();
          break;
        case HapticFeedbackType.medium:
          HapticFeedback.mediumImpact();
          break;
        case HapticFeedbackType.heavy:
          HapticFeedback.heavyImpact();
          break;
        case HapticFeedbackType.selection:
          HapticFeedback.selectionClick();
          break;
      }
    }
  }
}

/// iOS Action Sheet Action
class IOSActionSheetAction {
  final String label;
  final VoidCallback onPressed;
  final bool isDefault;
  final bool isDestructive;

  IOSActionSheetAction({
    required this.label,
    required this.onPressed,
    this.isDefault = false,
    this.isDestructive = false,
  });
}

/// Haptic Feedback Types
enum HapticFeedbackType {
  light,
  medium,
  heavy,
  selection,
}
