import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import '../../../logic/bloc/login/login_bloc.dart';
import '../../../data/model/auth/login_state_model.dart';
import '../../../routes/route_names.dart';
import '../../../utils/utils.dart';
import '../../../widgets/custom_app_bar.dart';
import '../../../widgets/custom_form.dart';
import '../../../widgets/custom_text.dart';
import '../../../widgets/primary_button.dart';
import '../../../widgets/fetch_error_text.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late LoginBloc loginBloc;

  @override
  void initState() {
    super.initState();
    loginBloc = context.read<LoginBloc>();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: const CustomAppBar(title: 'Login', visibleLeading: true),
      backgroundColor: const Color(0xFFEEF2F6),
      body: SingleChildScrollView(
        child: Container(
          height: size.height * 0.8,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(20.0),
              topLeft: Radius.circular(20.0),
            ),
            color: Colors.white,
          ),
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const CustomText(
                text: 'Sign in to your Account',
                fontSize: 24,
                fontWeight: FontWeight.w500,
              ),
              const SizedBox(height: 16),

              // Phone Number Field
              BlocBuilder<LoginBloc, LoginStateModel>(
                builder: (context, state) {
                  final validate = state.loginState;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomForm(
                        label: 'Phone Number',
                        child: TextFormField(
                          initialValue: state.phone,
                          keyboardType: TextInputType.phone,
                          onChanged: (value) =>
                              loginBloc.add(LoginEventUserPhone(value)),
                          decoration:
                              const InputDecoration(hintText: 'Enter 10 digit phone number'),
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(
                                errorText: 'Please enter phone number'),
                            FormBuilderValidators.numeric(
                                errorText: 'Enter valid phone number'),
                            FormBuilderValidators.minLength(10,
                                errorText: 'Phone number must be 10 digits'),
                            FormBuilderValidators.maxLength(10,
                                errorText: 'Phone number must be 10 digits'),
                          ]),
                          maxLength: 10,
                        ),
                      ),
                      if (validate is LoginStateFormValidate &&
                          validate.errors.phone.isNotEmpty)
                        FetchErrorText(text: validate.errors.phone.first),
                    ],
                  );
                },
              ),
              const SizedBox(height: 10),

              // Password Field
              BlocBuilder<LoginBloc, LoginStateModel>(
                builder: (context, state) {
                  final loginState = state.loginState;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomForm(
                        label: 'Password',
                        child: TextFormField(
                          initialValue: state.password,
                          obscureText: state.show,
                          onChanged: (value) =>
                              loginBloc.add(LoginEventPassword(value)),
                          decoration: InputDecoration(
                            hintText: 'Password',
                            suffixIcon: IconButton(
                              onPressed: () =>
                                  loginBloc.add(ShowPasswordEvent(state.show)),
                              icon: Icon(
                                state.show
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(
                                errorText: 'Please enter password'),
                            FormBuilderValidators.minLength(6,
                                errorText: 'Too short'),
                          ]),
                        ),
                      ),
                      if (loginState is LoginStateFormValidate &&
                          loginState.errors.password.isNotEmpty)
                        FetchErrorText(text: loginState.errors.password.first),
                    ],
                  );
                },
              ),
              const SizedBox(height: 20),

              // Remember Me
              BlocBuilder<LoginBloc, LoginStateModel>(
                builder: (context, state) {
                  return Row(
                    children: [
                      Checkbox(
                        value: state.isActive,
                        onChanged: (_) =>
                            loginBloc.add(const LoginEventRememberMe()),
                      ),
                      const CustomText(
                        text: 'Remember Me',
                        fontSize: 16,
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 20),

              // Login Button
              BlocListener<LoginBloc, LoginStateModel>(
                listener: (context, state) {
                  final loginState = state.loginState;
                  if (loginState is LoginStateLoading) {
                    Utils.loadingDialog(context);
                  } else {
                    Utils.closeDialog(context);
                    if (loginState is LoginStateError) {
                      Utils.failureSnackBar(context, loginState.message);
                    } else if (loginState is LoginStateLoaded) {
                      Utils.successSnackBar(context, 'Login successful');
                      Navigator.pushNamedAndRemoveUntil(context,
                          RouteNames.dashboardScreen, (route) => false);
                    }
                  }
                },
                child: PrimaryButton(
                  text: 'Login',
                  onPressed: () {
                    loginBloc.add(const LoginEventSubmit());
                  },
                ),
              ),

              const SizedBox(height: 18),
              // Navigate to Register
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CustomText(
                    text: "Don't have an account? ",
                    fontSize: 16.0,
                  ),
                  GestureDetector(
                    onTap: () =>
                        Navigator.pushNamed(context, RouteNames.registerScreen),
                    child: const CustomText(
                      text: 'Sign Up',
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
