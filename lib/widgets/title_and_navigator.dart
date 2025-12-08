import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/constraints.dart';
import 'custom_text.dart';

class TitleAndNavigator extends StatelessWidget {
  const TitleAndNavigator({
    super.key,
    required this.title,
    required this.press,
    this.isSeeAll = true,
  });

  final String title;
  final VoidCallback press;
  final bool isSeeAll;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Row(
        // mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: CustomText(
              text: title,
              color: blackColor,
              fontSize: 18.0,
              fontWeight: FontWeight.w500,
              maxLine: 1,
            ),
          ),
          isSeeAll
              ? GestureDetector(
                  onTap: press,
                  child:  const CustomText(
                    text:  'See All',
                    color: Color(0xFF405FF2),
                  ),
                )
              : const SizedBox(),
          //Utils.horizontalSpace(6),
          //const Icon(Icons.arrow_forward, color: primaryColor),
        ],
      ),
    );
  }
}
