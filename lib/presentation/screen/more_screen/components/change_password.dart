import 'package:carsbnb/logic/cubit/forgot_password/forgot_password_cubit.dart';
import 'package:carsbnb/widgets/custom_app_bar.dart';
import 'package:carsbnb/widgets/custom_form.dart';
import 'package:carsbnb/widgets/custom_image.dart';
import 'package:carsbnb/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../logic/cubit/forgot_password/forgot_password_state_model.dart';
import '../../../../utils/constraints.dart';
import '../../../../utils/k_images.dart';
import '../../../../utils/utils.dart';
import '../../../../widgets/fetch_error_text.dart';

class ChangePassword extends StatelessWidget {
  const ChangePassword({super.key});

  @override
  Widget build(BuildContext context) {
    final fCubit = context.read<ForgotPasswordCubit>();
    return Scaffold(
      appBar: const CustomAppBar(title: "Change Password"),
      body: ListView(
        padding: Utils.symmetric(),
        children: [
          const CustomImage(path: KImages.changePassword, height: 200,),
          Utils.verticalSpace(40.0),
          BlocBuilder<ForgotPasswordCubit, PasswordStateModel>(builder: (context, state) {
            final change = state.passwordState;
            return Column(
              children: [
                CustomForm(
                    label: 'Current Password',
                    child: TextFormField(
                      keyboardType: TextInputType.visiblePassword,
                      initialValue: state.oldPassword,
                      onChanged: fCubit.oldPassword,
                      obscureText: state.showOldPassword,
                      decoration: InputDecoration(
                        hintText: 'Password here',
                        suffixIcon: IconButton(
                          onPressed: fCubit.showOldPassword,
                          icon: Icon(
                              state.showOldPassword
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              color: blackColor),
                        ),
                      ),
                    )),
                if (change is UpdatePasswordFormValidateError) ...[
                  if (change.errors.currentPassword.isNotEmpty)
                    FetchErrorText(text: change.errors.currentPassword.first),
                ]
              ],
            );
          }),
          Utils.verticalSpace(14.0),
          BlocBuilder<ForgotPasswordCubit, PasswordStateModel>(builder: (context, state) {
            final change = state.passwordState;
            return Column(
              children: [
                CustomForm(
                    label: 'New Password',
                    child: TextFormField(
                      keyboardType: TextInputType.visiblePassword,
                      initialValue: state.password,
                      onChanged: fCubit.passwordChange,
                      obscureText: state.showPassword,
                      decoration: InputDecoration(
                        hintText: 'Password here',
                        suffixIcon: IconButton(
                          onPressed: fCubit.showPassword,
                          icon: Icon(
                              state.showPassword
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              color: blackColor),
                        ),
                      ),
                    )),
                if (change is UpdatePasswordFormValidateError) ...[
                  if (change.errors.password.isNotEmpty)
                    FetchErrorText(text: change.errors.password.first),
                ]
              ],
            );
          }),
          Utils.verticalSpace(14.0),
          BlocBuilder<ForgotPasswordCubit, PasswordStateModel>(builder: (context, state) {
            final change = state.passwordState;
            return Column(
              children: [
                CustomForm(
                    label: 'Confirm Password',
                    child: TextFormField(
                      keyboardType: TextInputType.visiblePassword,
                      initialValue: state.confirmPassword,
                      onChanged: fCubit.changeConfirmPassword,
                      obscureText: state.showConfirmPassword,
                      decoration: InputDecoration(
                        hintText: 'Password here',
                        suffixIcon: IconButton(
                          onPressed: fCubit.showConfirmPassword,
                          icon: Icon(
                              state.showConfirmPassword
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              color: blackColor),
                        ),
                      ),
                    )),
                if (change is UpdatePasswordFormValidateError) ...[
                  if (change.errors.confirmPassword.isNotEmpty)
                    FetchErrorText(text: change.errors.confirmPassword.first),
                ]
              ],
            );
          }),
          Utils.verticalSpace(22.0),
          BlocListener<ForgotPasswordCubit, PasswordStateModel>(
            listener: (context, state) {
              final reg = state.passwordState;
              if (reg is UpdatePasswordStateLoading) {
                Utils.loadingDialog(context);
              } else {
                Utils.closeDialog(context);
                if (reg is UpdatePasswordStateError) {
                  Utils.failureSnackBar(context,reg.message);
                } else if (reg is UpdatePasswordStateLoaded) {
                  Utils.successSnackBar(context, reg.message);
                 Navigator.of(context).pop(true);

                }
              }
            },
            child: PrimaryButton(
                text: "Create New",
                onPressed: () {
                  fCubit.changePassword();

                }),
          ),

        ],
      ),
    );
  }
}
