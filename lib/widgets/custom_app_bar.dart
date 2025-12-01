import 'package:blackdiamondcar/widgets/custom_image.dart';
import 'package:flutter/material.dart';
import '../utils/constraints.dart';
import '../utils/k_images.dart';
import '../utils/utils.dart';
import 'custom_text.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    required this.title,
    this.onTap,
    this.horSpace = 24.0,
    this.bgColor = Colors.transparent,
    this.textColor = blackColor,
    this.iconColor = blackColor,
    this.visibleLeading = true,
    this.iconBgColor = primaryColor,
    this.action = const [],
    this.titleCenter = false,
  });

  final String title;
  final double horSpace;
  final Color bgColor;
  final Color textColor;
  final Color iconColor;
  final bool visibleLeading;
  final bool titleCenter;
  final Color iconBgColor;
  final Function()? onTap;
  final List<Widget> action;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: bgColor,
      surfaceTintColor: Colors.transparent,
      centerTitle: titleCenter,
      elevation: 0.0,
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          if (visibleLeading)
            GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: Container(
                  // height: 48.w,
                  // width: 48.w,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const CustomImage(path: KImages.arrowLeft)),
            ),
          Utils.horizontalSpace(horSpace),
          CustomText(
            textAlign: TextAlign.center,
            text: title,
            fontSize: 18.0,
            fontFamily: bold700,
            fontWeight: FontWeight.w500,
            color: textColor,
          ),
        ],
      ),
      actions: action,
      toolbarHeight: Utils.vSize(70.0),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(Utils.vSize(70.0));
}
