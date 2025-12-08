import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/constraints.dart';
import '../utils/utils.dart';
import 'custom_text.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    this.maximumSize = const Size(double.infinity, 56),
    required this.text,
    this.fontSize = 16.0,
    required this.onPressed,
    this.textColor = whiteColor,
    this.bgColor = primaryColor,
    this.minimumSize = const Size(double.infinity, 56),
    this.borderRadiusSize = 6.0,
    this.isGradient = true,
  });

  final VoidCallback? onPressed;

  final String text;
  final Size maximumSize;
  final Size minimumSize;
  final double fontSize;
  final double borderRadiusSize;
  final Color textColor;
  final Color bgColor;
  final bool isGradient;

  @override
  Widget build(BuildContext context) {
    final borderRadius = Utils.borderRadius(r: borderRadiusSize);
    if (isGradient) {
      return Container(
        decoration: BoxDecoration(
          gradient: buttonGradient,
          borderRadius: borderRadius,
        ),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(bgColor),
            splashFactory: NoSplash.splashFactory,
            shadowColor: WidgetStateProperty.all(transparent),
            overlayColor: WidgetStateProperty.all(transparent),
            elevation: WidgetStateProperty.all(0.0),
            shape: WidgetStateProperty.all(
                RoundedRectangleBorder(borderRadius: borderRadius)),
            minimumSize: WidgetStateProperty.all(minimumSize),
            maximumSize: WidgetStateProperty.all(maximumSize),
          ),
          child: CustomText(
            text: text,
            color: textColor,
            fontSize: fontSize.sp,
            height: 1.5.h,
            fontWeight: FontWeight.w400,
          ),
        ),
      );
    } else {
      return ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(bgColor),
          splashFactory: NoSplash.splashFactory,
          shadowColor: WidgetStateProperty.all(transparent),
          overlayColor: WidgetStateProperty.all(transparent),
          elevation: WidgetStateProperty.all(0.0),
          shape: WidgetStateProperty.all(
              RoundedRectangleBorder(borderRadius: borderRadius)),
          minimumSize: WidgetStateProperty.all(minimumSize),
          maximumSize: WidgetStateProperty.all(maximumSize),
        ),
        child: CustomText(
          text: text,
          color: textColor,
          fontSize: fontSize.sp,
          height: 1.5.h,
          fontWeight: FontWeight.w400,
        ),
      );
    }
  }
}
