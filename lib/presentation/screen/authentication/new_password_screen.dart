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

class NewPasswordScreen extends StatelessWidget {
  const NewPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final fCubit = context.read<ForgotPasswordCubit>();
    return Scaffold(
      appBar: const CustomAppBar(
        title: '',
        visibleLeading: true,
      ),
      backgroundColor: scaffoldBgColor,
      body: ListView(
        padding: Utils.symmetric(),
        children: [
          Utils.verticalSpace(size.height * 0.06),
          const CustomImage(path: KImages.setPasswordImage, height: 140,width: 130,),
          Utils.verticalSpace(size.height * 0.06),
          const CustomText(
            text: "Create New Password",
            fontSize: 24,
            fontWeight: FontWeight.w500,
          ),
          Utils.verticalSpace(16.0),
          BlocBuilder<ForgotPasswordCubit, PasswordStateModel>(
            builder: (context, state) {
              final p = state.passwordState;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomForm(
                    label: "New Password",
                    child: TextFormField(
                      keyboardType: TextInputType.visiblePassword,
                      initialValue: state.password,
                      decoration: InputDecoration(
                        hintText: 'password',
                        suffixIcon: IconButton(
                          icon: Icon(
                            state.showPassword
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                            color: greyColor,
                          ),
                          onPressed: () => fCubit.showPassword,
                        ),
                      ),

                      obscureText: state.showPassword,
                      onChanged: fCubit.passwordChange,
                    ),
                  ),
                  if (p is SetPasswordFormValidateError)
                    if (p.errors.password.isNotEmpty)
                      FetchErrorText(text: p.errors.password.first),
                ],
              );
            },
          ),
          Utils.verticalSpace(10.0),
          BlocBuilder<ForgotPasswordCubit, PasswordStateModel>(
            builder: (context, state) {
              final p = state.passwordState;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomForm(
                    label: "Confirm New Password",
                    child: TextFormField(
                      keyboardType: TextInputType.visiblePassword,
                      initialValue: state.confirmPassword,
                      decoration: InputDecoration(
                        hintText: 'password',
                        suffixIcon: IconButton(
                          icon: Icon(
                            state.showConfirmPassword
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                            color: greyColor,
                          ),
                          onPressed: () => fCubit.showConfirmPassword,
                        ),
                      ),

                      obscureText: state.showConfirmPassword,
                      onChanged: fCubit.changeConfirmPassword,
                    ),
                  ),
                  if (p is SetPasswordFormValidateError)
                    if (p.errors.confirmPassword.isNotEmpty)
                      FetchErrorText(text: p.errors.confirmPassword.first),
                ],
              );
            },
          ),


          Utils.verticalSpace(30.0),
          BlocListener<ForgotPasswordCubit, PasswordStateModel>(
            listener: (context, state) {
              final reg = state.passwordState;
              if (reg is SetPasswordStateLoading) {
                Utils.loadingDialog(context);
              } else {
                Utils.closeDialog(context);
                if (reg is SetPasswordStateError) {
                  Utils.errorSnackBar(context,reg.message);
                } else if (reg is SetForgotPasswordLoaded) {
                  Utils.showSnackBar(context, reg.message);
                  Navigator.pushNamedAndRemoveUntil(
                      context, RouteNames.loginScreen, (route) => false);

                }
              }
            },
            child: PrimaryButton(
                text: "Create New",
                onPressed: () {
                  fCubit.setForgotPassword();
                }),
          ),
        ],
      ),
    );
  }
}
