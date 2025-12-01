import 'package:blackdiamondcar/widgets/custom_app_bar.dart';
import 'package:blackdiamondcar/widgets/fetch_error_text.dart';
import 'package:flutter/material.dart';

class BankPaymentScreen extends StatelessWidget {
  const BankPaymentScreen({super.key, required this.id});

  final String id;

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(title: 'Bank Payment'),
      body: Center(
        child: FetchErrorText(text: 'Payment not available'),
      ),
    );
  }
}
