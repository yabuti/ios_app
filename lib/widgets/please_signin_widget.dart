import 'package:flutter/material.dart';

import '../routes/route_names.dart';
import '../utils/constraints.dart';
import '../utils/utils.dart';
import 'custom_text.dart';
import 'primary_button.dart';

class PleaseLoginFirst extends StatelessWidget {
  const PleaseLoginFirst({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: Utils.all(value: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
           CustomText(text: Utils.translatedText(context, 'Please login first'),color: redColor,fontWeight: FontWeight.w500,),
          Utils.verticalSpace(10.0),
          PrimaryButton(
            text: Utils.translatedText(context, 'Login'),
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(context, RouteNames.loginScreen,(route)=>false);
            },
          ),
        ],
      ),
    );
  }
}
