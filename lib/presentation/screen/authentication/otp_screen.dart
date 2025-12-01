import 'package:blackdiamondcar/data/model/auth/register_state_model.dart';
import 'package:blackdiamondcar/logic/cubit/register/register_cubit.dart';
import 'package:blackdiamondcar/routes/route_names.dart';
import 'package:blackdiamondcar/utils/constraints.dart';
import 'package:blackdiamondcar/widgets/custom_app_bar.dart';
import 'package:blackdiamondcar/widgets/custom_image.dart';
import 'package:blackdiamondcar/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';

import '../../../logic/cubit/register/register_state.dart';
import '../../../utils/k_images.dart';
import '../../../utils/utils.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  late RegisterCubit rCubit;

  @override
  void initState() {
    super.initState();
    rCubit = context.read<RegisterCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: "",
        visibleLeading: true,
      ),
      body: BlocListener<RegisterCubit, RegisterStateModel>(
        listener: (context, state) {
          final otp = state.registerState;
          if (otp is RegisterOtpStateError) {
            Utils.failureSnackBar(context, otp.message);
          } else if (otp is RegisterOtpStateSuccess) {
            Utils.successSnackBar(context, otp.message);
            // signUp.clearState();

            Navigator.pushNamed(context, RouteNames.loginScreen);
          }
        },
        child: Padding(
          padding: Utils.symmetric(),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Utils.verticalSpace(20.0),
                const CustomImage(
                  path: KImages.otpImage,
                  height: 120,
                  width: 160,
                ),
                Utils.verticalSpace(50.0),
                const CustomText(
                    text: "Check your Phone",
                    fontSize: 24.0,
                    fontWeight: FontWeight.w500),
                Utils.verticalSpace(26.0),
                const CustomText(
                    text:
                        "You should soon receive an SMS with your verification code. Please check your messages.",
                    textAlign: TextAlign.center,
                    color: sTextColor),
                Utils.verticalSpace(30.0),
                Pinput(
                  length: 6,
                  defaultPinTheme: PinTheme(
                    height: Utils.vSize(60.0),
                    width: Utils.hSize(60.0),
                    textStyle: GoogleFonts.roboto(
                        fontSize: 24.0, fontWeight: FontWeight.w700),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: borderColor),
                        borderRadius: BorderRadius.circular(10.0)),
                  ),
                  onChanged: (String code) {
                    rCubit.otpChange(code);
                  },
                  onCompleted: (String code) {
                    if (code.length == 6) {
                      rCubit.verifyRegOtp();
                    } else {
                      Utils.errorSnackBar(context, "enter 6 digit");
                    }
                  },
                ),
                Utils.verticalSpace(40.0),
                // BlocBuilder<RegisterCubit, RegisterStateModel>(
                //     builder: (context, state) {
                //   if (state is RegisterOtpStateLoading) {
                //     return const LoadingWidget();
                //   }
                //   return PrimaryButton(
                //       text: 'Send Code',
                //       onPressed: () {
                //        rCubit.verifyRegOtp();
                //       });
                // }),
                Utils.verticalSpace(30.0),
                // const CustomText(
                //   text: "Did’t receive the email?",
                //   fontSize: 20.0,
                // ),
                // GestureDetector(
                //     onTap: () {},
                //     child: const CustomText(
                //       text: "Click to resend",
                //       fontSize: 20.0,
                //       color: textColor,
                //     )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
