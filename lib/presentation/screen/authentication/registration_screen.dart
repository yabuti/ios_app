import 'package:blackdiamondcar/data/model/auth/register_state_model.dart';
import 'package:blackdiamondcar/logic/cubit/register/register_cubit.dart';
import 'package:blackdiamondcar/utils/constraints.dart';
import 'package:blackdiamondcar/widgets/custom_form.dart';
import 'package:blackdiamondcar/widgets/custom_text.dart';
import 'package:blackdiamondcar/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import '../../../logic/cubit/register/register_state.dart';
import '../../../routes/route_names.dart';
import '../../../utils/utils.dart';
import '../../../widgets/custom_app_bar.dart';
import '../../../widgets/fetch_error_text.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  late RegisterCubit rCubit;

  @override
  void initState() {
    super.initState();
    rCubit = context.read<RegisterCubit>();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: const CustomAppBar(
        title: '',
        visibleLeading: true,
      ),
      backgroundColor: const Color(0xFFEEF2F6),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              height: size.height * 0.8,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20.0),
                  topLeft: Radius.circular(20.0),
                ),
                color: whiteColor,
              ),
              child: ListView(
                padding: Utils.symmetric(v: 20.0),
                children: [
                  const CustomText(
                    text: "Sign Up to your Account",
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                  ),
                  Utils.verticalSpace(16.0),

                  // Name Field
                  BlocBuilder<RegisterCubit, RegisterStateModel>(
                    builder: (context, state) {
                      final validate = state.registerState;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomForm(
                            label: 'Name',
                            child: TextFormField(
                              initialValue: state.name,
                              onChanged: rCubit.changeName,
                              decoration: const InputDecoration(
                                hintText: 'Name here',
                              ),
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(
                                  errorText: 'Please enter a name',
                                ),
                              ]),
                              keyboardType: TextInputType.text,
                            ),
                          ),
                          if (validate is RegisterValidateStateError)
                            if (validate.errors.name.isNotEmpty)
                              FetchErrorText(text: validate.errors.name.first),
                        ],
                      );
                    },
                  ),

                  Utils.verticalSpace(10.0),

                  // Phone Number Field
                  BlocBuilder<RegisterCubit, RegisterStateModel>(
                    builder: (context, state) {
                      final validate = state.registerState;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomForm(
                            label: 'Phone Number',
                            child: TextFormField(
                              initialValue: state.phone,
                              onChanged: rCubit.changePhone,
                              decoration: const InputDecoration(
                                hintText: 'Enter 10 digit phone number',
                              ),
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(
                                  errorText: 'Please enter your phone number',
                                ),
                                FormBuilderValidators.numeric(
                                  errorText: 'Enter valid phone number',
                                ),
                                FormBuilderValidators.minLength(10,
                                    errorText: 'Phone number must be 10 digits'),
                                FormBuilderValidators.maxLength(10,
                                    errorText: 'Phone number must be 10 digits'),
                              ]),
                              keyboardType: TextInputType.phone,
                              maxLength: 10,
                            ),
                          ),
                          if (validate is RegisterValidateStateError)
                            if (validate.errors.phone.isNotEmpty)
                              FetchErrorText(text: validate.errors.phone.first),
                        ],
                      );
                    },
                  ),

                  Utils.verticalSpace(10.0),

                  // Password Field
                  BlocBuilder<RegisterCubit, RegisterStateModel>(
                    builder: (context, state) {
                      final p = state.registerState;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomForm(
                            label: "Password",
                            child: TextFormField(
                              keyboardType: TextInputType.visiblePassword,
                              initialValue: state.password,
                              obscureText: state.showPassword,
                              onChanged: rCubit.changePassword,
                              decoration: InputDecoration(
                                hintText: 'Password',
                                suffixIcon: IconButton(
                                  onPressed: rCubit.showPassword,
                                  icon: Icon(
                                    state.showPassword
                                        ? Icons.visibility_off_outlined
                                        : Icons.visibility_outlined,
                                    color: blackColor,
                                  ),
                                ),
                              ),
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(
                                  errorText: 'Please enter a password',
                                ),
                                FormBuilderValidators.minLength(6,
                                    errorText: 'Too short'),
                              ]),
                            ),
                          ),
                          if (p is RegisterValidateStateError)
                            if (p.errors.password.isNotEmpty)
                              FetchErrorText(text: p.errors.password.first),
                        ],
                      );
                    },
                  ),

                  Utils.verticalSpace(16.0),

                  // Confirm Password Field
                  BlocBuilder<RegisterCubit, RegisterStateModel>(
                    builder: (context, state) {
                      final p = state.registerState;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomForm(
                            label: "Confirm Password",
                            child: TextFormField(
                              keyboardType: TextInputType.visiblePassword,
                              initialValue: state.confirmPassword,
                              obscureText: state.showConPassword,
                              onChanged: rCubit.changeConPassword,
                              decoration: InputDecoration(
                                hintText: 'Confirm password',
                                suffixIcon: IconButton(
                                  onPressed: rCubit.showConfirmPassword,
                                  icon: Icon(
                                    state.showConPassword
                                        ? Icons.visibility_off_outlined
                                        : Icons.visibility_outlined,
                                    color: blackColor,
                                  ),
                                ),
                              ),
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(
                                  errorText: 'Please confirm password',
                                ),
                                FormBuilderValidators.minLength(6,
                                    errorText: 'Too short'),
                              ]),
                            ),
                          ),
                          if (p is RegisterValidateStateError)
                            if (p.errors.confirmPassword.isNotEmpty)
                              FetchErrorText(
                                  text: p.errors.confirmPassword.first),
                        ],
                      );
                    },
                  ),

                  Utils.verticalSpace(30.0),

                  // Sign Up Button
                  BlocListener<RegisterCubit, RegisterStateModel>(
                    listener: (context, state) {
                      final reg = state.registerState;
                      if (reg is RegisterStateLoading) {
                        Utils.loadingDialog(context);
                      } else {
                        Utils.closeDialog(context);
                        if (reg is RegisterStateError) {
                          Utils.failureSnackBar(context, reg.message);
                        } else if (reg is RegisterStateSuccess) {
                          debugPrint('✅ RegisterStateSuccess detected! Navigating to dashboard...');
                          Utils.successSnackBar(context, reg.message);
                          // Redirect to dashboard after registration
                          Navigator.pushNamedAndRemoveUntil(context,
                              RouteNames.dashboardScreen, (route) => false);
                          debugPrint('✅ Navigation called!');
                        }
                      }
                    },
                    child: PrimaryButton(
                      text: "Sign Up",
                      onPressed: () {
                        rCubit.userRegister();
                      },
                    ),
                  ),

                  Utils.verticalSpace(18.0),

                  // Navigate to Login
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CustomText(
                        text: "Already have an account? ",
                        fontSize: 16.0,
                        fontWeight: FontWeight.w400,
                        color: blackColor,
                        height: 1.6,
                      ),
                      GestureDetector(
                        onTap: () => Navigator.pushNamed(
                            context, RouteNames.loginScreen),
                        child: const CustomText(
                          text: 'Sign In',
                          fontSize: 16.0,
                          fontWeight: FontWeight.w400,
                          fontFamily: bold700,
                          color: primaryColor,
                          height: 1.6,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
