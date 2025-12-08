import 'package:carsbnb/logic/cubit/termsPolicy/terms_cubit.dart';
import 'package:carsbnb/logic/cubit/termsPolicy/terms_state.dart';
import 'package:carsbnb/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
//import 'package:flutter_widget_from_html/flutter_widget_from_html.dart'; // Add this import

import '../../../../logic/cubit/language_code_state.dart';
import '../../../../utils/utils.dart';
import '../../../../widgets/fetch_error_text.dart';
import '../../../../widgets/loading_widget.dart';

class TermsConditionScreen extends StatefulWidget {
  const TermsConditionScreen({super.key});

  @override
  State<TermsConditionScreen> createState() => _TermsConditionScreenState();
}

class _TermsConditionScreenState extends State<TermsConditionScreen> {
  late TermsPolicyCubit tCubit;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tCubit = context.read<TermsPolicyCubit>();
    tCubit.getTermsCondition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Terms and Condition"),
      body: BlocConsumer<TermsPolicyCubit, LanguageCodeState>(
          listener: (context, state) {
        final terms = state.termsPolicyState;
        if (terms is GetTermsStateError) {
          if (terms.statusCode == 503) {
            Utils.errorSnackBar(context, terms.message);
          }
        }
      }, builder: (context, state) {
        final terms = state.termsPolicyState;
        if (terms is GetTermsStateLoading) {
          return const LoadingWidget();
        } else if (terms is GetTermsStateError) {
          return FetchErrorText(
              text: Utils.translatedText(context, 'Something went wrong'));
        } else if (terms is GetTermsStateLoaded) {
          return Padding(
            padding: Utils.symmetric(v: 10.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  HtmlWidget(
                    terms.terms.description,
                    customStylesBuilder: (element) {
                      if (element.localName == 'p') {
                        return {'color': '#6B6C6C'}; // Change paragraph color here
                      }
                      return null;
                    },
                    textStyle: const TextStyle(color: Colors.black), // Change default text color here
                  ),
                ],
              ),
            ),
          );
        }
        return const SizedBox.shrink();
      }),
    );
  }
}
