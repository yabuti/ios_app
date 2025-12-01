import 'package:blackdiamondcar/routes/route_names.dart';
import 'package:blackdiamondcar/utils/constraints.dart';
import 'package:blackdiamondcar/utils/k_images.dart';
import 'package:blackdiamondcar/widgets/custom_app_bar.dart';
import 'package:blackdiamondcar/widgets/custom_image.dart';
import 'package:blackdiamondcar/widgets/custom_text.dart';
import 'package:blackdiamondcar/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../logic/cubit/manage_car/manage_car_cubit.dart';
import '../../../../utils/utils.dart';

class PurposeSelectScreen extends StatefulWidget {
  const PurposeSelectScreen({super.key});

  @override
  State<PurposeSelectScreen> createState() => _PurposeSelectScreenState();
}

class _PurposeSelectScreenState extends State<PurposeSelectScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Add Car"),
      body: Padding(
        padding: Utils.symmetric(),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: Utils.all(value: 20.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: const Color(0xFFEEF2F6),
                ),
                child: Column(
                  children: [
                    Container(
                      height: 100.0,
                      width: 100.0,
                      decoration: const BoxDecoration(
                          color: whiteColor, shape: BoxShape.circle),
                      child: const Center(
                          child: CustomImage(path: KImages.rentCar)),
                    ),
                    Utils.verticalSpace(20.0),
                    const CustomText(
                      text: "Add Car for Rent",
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                    ),
                    Utils.verticalSpace(20.0),
                    const CustomText(
                      text:
                          "Your email address will not be published. Required fields are marked",
                      color: Color(0xFF6B6C6C),
                      textAlign: TextAlign.center,
                      maxLine: 2,
                    ),
                    Utils.verticalSpace(20.0),
                    // BlocConsumer<ManageCarCubit, CarsStateModel>(
                    //     listener: (context, state) {
                    //       final car = state.manageCarState;
                    //       // if (car is GetCarCreateDataLoading) {
                    //       //   if (!Utils.isDialogShowing(context)) {
                    //       //     print('Opening loading dialog');
                    //       //     Utils.loadingDialog(context);
                    //       //   }
                    //       // }
                    //         if (car is GetCarCreateDataError) {
                    //           Utils.errorSnackBar(context, car.message);
                    //         } else if (car is GetCarCreateDataLoaded) {
                    //           Utils.closeDialog(context);
                    //           Navigator.pushNamed(context, RouteNames.addCarScreen, arguments: '');
                    //         }
                    //
                    //     },
                    //   builder: (context, state) {
                    //     return PrimaryButton(text: "Create For Rent", onPressed: (){
                    //       context.read<ManageCarCubit>().clearAllField();
                    //       context.read<ManageCarCubit>().purposeChange("Rent");
                    //       context.read<ManageCarCubit>().getCarCreateData();
                    //     });
                    //   }
                    // ),
                    PrimaryButton(
                        text: "Create For Rent",
                        onPressed: () {
                          context.read<ManageCarCubit>().clearAllField();
                          context.read<ManageCarCubit>().slugController.clear();
                          context.read<ManageCarCubit>().purposeChange("Rent");
                          Navigator.pushNamed(context, RouteNames.addCarScreen, arguments: '');
                        })
                  ],
                ),
              ),
              Utils.verticalSpace(12.0),
              Container(
                padding: Utils.all(value: 20.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: const Color(0xFFEEF2F6),
                ),
                child: Column(
                  children: [
                    Container(
                      height: 100.0,
                      width: 100.0,
                      decoration: const BoxDecoration(
                          color: whiteColor, shape: BoxShape.circle),
                      child: const Center(
                          child: CustomImage(path: KImages.sellCar)),
                    ),
                    Utils.verticalSpace(20.0),
                    const CustomText(
                      text: "Add Car for Sale",
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                    ),
                    Utils.verticalSpace(20.0),
                    const CustomText(
                      text:
                          "Your email address will not be published. Required fields are marked",
                      color: Color(0xFF6B6C6C),
                      textAlign: TextAlign.center,
                      maxLine: 2,
                    ),
                    Utils.verticalSpace(20.0),
                    PrimaryButton(
                        text: "Create For Sale",
                        onPressed: () {
                          context.read<ManageCarCubit>().clearAllField();
                          context.read<ManageCarCubit>().slugController.clear();

                          context.read<ManageCarCubit>().purposeChange("Sale");
                          Navigator.pushNamed(context, RouteNames.addCarScreen, arguments: '');
                        })
                    // BlocConsumer<ManageCarCubit, CarsStateModel>(
                    //     listener: (context, state) {
                    //   final car = state.manageCarState;
                    //   if (car is GetCarCreateDataLoading) {
                    //     if (!Utils.isDialogShowing(context)) {
                    //       print('Opening loading dialog');
                    //       Utils.loadingDialog(context);
                    //     }
                    //   } else {
                    //     if (car is GetCarCreateDataError) {
                    //       Utils.errorSnackBar(context, car.message);
                    //     } else if (car is GetCarCreateDataLoaded) {
                    //       Utils.closeDialog(context);
                    //       Navigator.pushNamed(context, RouteNames.addCarScreen,
                    //           arguments: '');
                    //     }
                    //   }
                    // }, builder: (context, state) {
                    //   return PrimaryButton(
                    //       text: "Create For Sale",
                    //       onPressed: () {
                    //         context
                    //             .read<ManageCarCubit>()
                    //             .purposeChange("Sale");
                    //         context.read<ManageCarCubit>().getCarCreateData();
                    //       });
                    // }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
