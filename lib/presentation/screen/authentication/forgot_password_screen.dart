import 'package:blackdiamondcar/logic/cubit/forgot_password/forgot_password_cubit.dart';
import 'package:blackdiamondcar/routes/route_names.dart';
import 'package:blackdiamondcar/utils/constraints.dart';
import 'package:blackdiamondcar/widgets/custom_app_bar.dart';
import 'package:blackdiamondcar/widgets/custom_form.dart';
import 'package:blackdiamondcar/widgets/custom_image.dart';
import 'package:blackdiamondcar/widgets/custom_text.dart';
import 'package:blackdiamondcar/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../logic/cubit/forgot_password/forgot_password_state_model.dart';
import '../../../utils/k_images.dart';
import '../../../utils/utils.dart';
import '../../../widgets/fetch_error_text.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
   final fCubit = context.read<ForgotPasswordCubit>();
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: const CustomAppBar(title: '', visibleLeading: true,),
      backgroundColor: scaffoldBgColor,
      body: ListView(
        padding: Utils.symmetric(),
        children: [
          Utils.verticalSpace(size.height * 0.08),
          const CustomImage(path: KImages.forgotPassword),
          Utils.verticalSpace(10.0),
          const CustomText(
            text: "Forgot Password",
            fontSize: 24,
            fontWeight: FontWeight.w500,
          ),
          Utils.verticalSpace(16.0),
          BlocBuilder<ForgotPasswordCubit, PasswordStateModel>(
            builder: (context, state) {
              final validate = state.passwordState;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomForm(
                      label: 'Phone Number',
                      child: TextFormField(
                        initialValue: state.email,
                        onChanged: fCubit.changeEmail,
                        decoration: const InputDecoration(
                          hintText: 'phone number here',
                        ),
                        keyboardType: TextInputType.phone,
                      )),
                  if (validate is ForgotPasswordFormValidateError) ...[
                    if (validate.errors.email.isNotEmpty)
                      FetchErrorText(text: validate.errors.email.first),
                  ]
                ],
              );
            }
          ),

          Utils.verticalSpace(30.0),
          BlocListener<ForgotPasswordCubit, PasswordStateModel>(
            listener: (context, state) {
              final reg = state.passwordState;
              if (reg is ForgotPasswordStateLoading) {
                Utils.loadingDialog(context);
              } else {
                Utils.closeDialog(context);
                if (reg is ForgotPasswordStateError) {
                  Utils.failureSnackBar(context,reg.message);
                } else if (reg is ForgotPasswordStateLoaded) {
                  Utils.successSnackBar(context, reg.message);
                  Navigator.pushNamedAndRemoveUntil(
                      context, RouteNames.forgotPasswordOtpScreen, (route) => false);

                }
              }
            },
            child: PrimaryButton(
                text: "Send Code",
                onPressed: () {
                  fCubit.forgotPassWord();
                }),
          ),

        ],
      ),
    );
  }
}
