import 'package:blackdiamondcar/widgets/custom_app_bar.dart';
import 'package:blackdiamondcar/widgets/fetch_error_text.dart';
import 'package:flutter/material.dart';

class PurchaseHistoryScreen extends StatelessWidget {
  const PurchaseHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(title: "Purchase History"),
      body: Center(
        child: FetchErrorText(text: 'No purchase history available'),
      ),
    );
  }
}
