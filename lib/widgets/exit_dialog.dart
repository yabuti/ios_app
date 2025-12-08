import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils/constraints.dart';
import '../utils/k_images.dart';
import '../utils/utils.dart';
import 'custom_dialog.dart';
import 'custom_text.dart';
import 'primary_button.dart';

class ExitDialog extends StatelessWidget {
  const ExitDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return CustomDialog(
      icon: KImages.exitFromAppIcon,
      height: size.height * 0.30,
      child: SingleChildScrollView(
        child: Padding(
          padding: Utils.symmetric(h: 10.0, v: 32.0),
          child: Column(
            children: [
              const CustomText(
                text: 'Are you sure\nYou want to Exit?',
                fontSize: 18.0,
                fontWeight: FontWeight.w700,
                color: blackColor,
                textAlign: TextAlign.center,
              ),
              Utils.verticalSpace(8.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: PrimaryButton(
                      text: 'Cancel',
                      onPressed: () => Navigator.of(context).pop(),
                      borderRadiusSize: 6.0,
                      bgColor: blackColor,
                      isGradient: false,
                      fontSize: 16.0,

                    ),
                  ),
                  Utils.horizontalSpace(14.0),
                  Expanded(
                    child: PrimaryButton(
                      text: 'Exit',
                      onPressed: () => SystemNavigator.pop(),
                      bgColor: redColor,
                      borderRadiusSize: 6.0,
                      fontSize: 16.0,

                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
