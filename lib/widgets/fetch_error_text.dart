import 'package:flutter/cupertino.dart';

import '../utils/constraints.dart';
import 'custom_text.dart';

class FetchErrorText extends StatelessWidget {
  const FetchErrorText(
      {super.key, required this.text, this.textColor = redColor});

  final String text;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return CustomText(
      text: text,
      color: textColor,
      fontSize: 14.0,
    );
  }
}
