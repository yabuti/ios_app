import 'package:blackdiamondcar/widgets/custom_app_bar.dart';
import 'package:blackdiamondcar/widgets/fetch_error_text.dart';
import 'package:flutter/material.dart';
import '../../../utils/utils.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({
    super.key,
    required this.id,
  });

  final String id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: Utils.translatedText(context, 'Payment Method')),
      body: const Center(
        child: FetchErrorText(text: 'Payment not available'),
      ),
    );
  }
}
