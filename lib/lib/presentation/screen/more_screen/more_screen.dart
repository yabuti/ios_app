import 'package:carsbnb/data/data_provider/remote_url.dart';
import 'package:carsbnb/logic/cubit/forgot_password/forgot_password_cubit.dart';
import 'package:carsbnb/logic/cubit/kyc/kyc_info_cubit.dart';
import 'package:carsbnb/logic/cubit/language_code_state.dart';
import 'package:carsbnb/logic/cubit/profile/profile_cubit.dart';
import 'package:carsbnb/utils/language_string.dart';
import 'package:carsbnb/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/model/auth/login_state_model.dart';
import '../../../logic/bloc/login/login_bloc.dart';
import '../../../logic/cubit/manage_car/getCarCreatedata/car_create_data_cubit.dart';
import '../../../logic/cubit/manage_car/getCarCreatedata/car_create_data_state.dart';
import '../../../routes/route_names.dart';
import '../../../utils/constraints.dart';
import '../../../utils/k_images.dart';
import '../../../utils/utils.dart';
import '../../../widgets/custom_image.dart';
import '../../../widgets/custom_text.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({super.key});

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  late ProfileCubit profileData;
  late KycInfoCubit kycInfoCubit;
  late String image;
  late String name;
  late String email;

  @override
  void initState() {
    _initState();
    super.initState();
  }

  void _initState() {
    profileData = context.read<ProfileCubit>();
    kycInfoCubit = context.read<KycInfoCubit>();
    profileData.getProfileInfo();

    final user = profileData.state; // state is the User

    if (user.image.isNotEmpty) {
      image = RemoteUrls.imageUrl(user.image);
      // name = user.name;
      // email = user.email;
    } else {
      image = KImages.profileImage;
      // name = 'User';
      // email = 'user@gmail.com';
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: const CustomAppBar(title: "Menu", visibleLeading: false),
      body: SingleChildScrollView(
        child: Padding(
          padding: Utils.symmetric(),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: whiteColor,
                    border: Border.all(color: borderColor)),
                child: Padding(
                  padding: Utils.symmetric(v: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text:
                            Utils.translatedText(context, Language.userProfile),
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                      Utils.verticalSpace(16.0),
                      DrawerItem(
                          icon: KImages.user,
                          title:
                              Utils.translatedText(context, Language.profile),
                          onTap: () {
                            Navigator.pushNamed(
                                context, RouteNames.profileScreen);
                          }),
                      DrawerItem(
                          icon: KImages.star,
                          title: Utils.translatedText(context, Language.review),
                          onTap: () {
                            Navigator.pushNamed(
                                context, RouteNames.reviewScreen);
                          }),
                      DrawerItem(
                          icon: KImages.editProfile,
                          title: Utils.translatedText(
                              context, Language.editProfile),
                          onTap: () {
                            Navigator.pushNamed(
                                context, RouteNames.editProfileScreen);
                          }),
                      DrawerItem(
                          isVisibleBorder: false,
                          icon: KImages.lock,
                          title: Utils.translatedText(
                              context, Language.changePassword),
                          onTap: () {
                            context.read<ForgotPasswordCubit>().clear();
                            Navigator.pushNamed(
                                context, RouteNames.changePassword);
                          }),
                    ],
                  ),
                ),
              ),
              Utils.verticalSpace(20.0),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: whiteColor,
                    border: Border.all(color: borderColor)),
                child: Padding(
                  padding: Utils.symmetric(v: 20.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: Utils.translatedText(
                              context, Language.dealerProfile),
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                        Utils.verticalSpace(16.0),

                        BlocListener<CarCreateDataCubit, LanguageCodeState>(
                          listener: (context, state) {
                            final car = state.carCreateDataState;
                            // if (car is GetCarCreateDataLoading) {
                            //   if (!Utils.isDialogShowing(context)) {
                            //     print('Opening loading dialog');
                            //     Utils.loadingDialog(context);
                            //   }
                            // }
                            if (car is GetCarCreateDataError) {
                              Utils.errorSnackBar(context, car.message);
                            } else if (car is GetCarCreateDataLoaded) {
                              Navigator.pushNamed(
                                  context, RouteNames.purposeSelectScreen);
                            }
                          },
                          child: DrawerItem(
                              icon: KImages.addCar,
                              title: Utils.translatedText(
                                  context, Language.addCar),
                              onTap: () {
                                context
                                    .read<CarCreateDataCubit>()
                                    .getCarCreateData();
                                // Navigator.pushNamed(
                                //     context, RouteNames.manageCarScreen);
                              }),
                        ),
                        DrawerItem(
                            icon: KImages.car,
                            title: Utils.translatedText(
                                context, Language.manageCar),
                            onTap: () {
                              Navigator.pushNamed(
                                  context, RouteNames.manageCarScreen);
                            }),
                        DrawerItem(
                          icon: KImages
                              .spareParts, // Make sure you have an icon in KImages
                          title: Utils.translatedText(context,
                              Language.spareParts), // Add a key in Language
                          onTap: () {
                            Navigator.pushNamed(
                                context, RouteNames.sparePartsScreen);
                          },
                        ),
                        DrawerItem(
                          icon: KImages
                              .preOrder, // Make sure you have an icon for Pre-Order in KImages
                          title:
                              Utils.translatedText(context, Language.preOrder),
                          onTap: () {
                            Navigator.pushNamed(
                                context, RouteNames.preOrderScreen);
                          },
                        ),

                        DrawerItem(
                          icon: KImages.delivery,
                          title:
                              Utils.translatedText(context, Language.delivery),
                          onTap: () {
                            Navigator.pushNamed(
                                context, RouteNames.deliveryScreen);
                          },
                        ),

                        DrawerItem(
                            isVisibleBorder: false,
                            icon: KImages.kyc,
                            title: Utils.translatedText(
                                context, Language.kycVerification),
                            onTap: () {
                              if (kycInfoCubit.kycModel!.kyc != null) {
                                Navigator.pushNamed(
                                    context, RouteNames.kycViewScreen);
                              } else {
                                Navigator.pushNamed(
                                    context, RouteNames.kycScreen);
                              }
                            }),

                        // DrawerItem(
                        //     isVisibleBorder: false,
                        //     icon: KImages.transaction,
                        //     title: Utils.translatedText(
                        //         context, Language.transactionInvoice),
                        //     onTap: () {
                        //       Navigator.pushNamed(
                        //           context, RouteNames.transactionScreen);
                        //     }),
                      ],
                    ),
                  ),
                ),
              ),
              Utils.verticalSpace(20.0),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: whiteColor,
                    border: Border.all(color: borderColor)),
                child: Padding(
                  padding: Utils.symmetric(v: 20.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: Utils.translatedText(
                              context, Language.helpSetting),
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                        Utils.verticalSpace(16.0),
                        DrawerItem(
                            icon: KImages.language,
                            title: Utils.translatedText(
                                context, Language.languageC),
                            onTap: () {
                              Navigator.pushNamed(
                                  context, RouteNames.languageScreen);
                            }),
                        DrawerItem(
                            icon: KImages.privacy,
                            title: Utils.translatedText(
                                context, Language.privacyPolicy),
                            onTap: () {
                              Navigator.pushNamed(
                                  context, RouteNames.privacyPolicyScreen);
                            }),
                        DrawerItem(
                            icon: KImages.terms,
                            title: Utils.translatedText(
                                context, Language.termsCondition),
                            onTap: () {
                              Navigator.pushNamed(
                                  context, RouteNames.termsConditionScreen);
                            }),
                        DrawerItem(
                            icon: KImages.contactUs,
                            title: Utils.translatedText(
                                context, Language.contactUs),
                            onTap: () {
                              Navigator.pushNamed(
                                  context, RouteNames.contactScreen);
                            }),
                        DrawerItem(
                            isVisibleBorder: false,
                            icon: KImages.appInfo,
                            title:
                                Utils.translatedText(context, Language.appInfo),
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return Dialog(
                                      backgroundColor: whiteColor,
                                      child: Padding(
                                        padding: Utils.symmetric(v: 20.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    const CustomImage(
                                                        path: KImages.appIcon),
                                                    Utils.horizontalSpace(10.0),
                                                    const CustomText(
                                                      text: "BlackDiamondCar",
                                                      fontSize: 18.0,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    )
                                                  ],
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Container(
                                                    padding:
                                                        Utils.all(value: 4.0),
                                                    decoration:
                                                        const BoxDecoration(
                                                            shape:
                                                                BoxShape.circle,
                                                            color: Colors.red),
                                                    child: const Icon(
                                                      Icons.close,
                                                      color: whiteColor,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Utils.verticalSpace(20.0),
                                            const CustomText(
                                              text: "App Info",
                                              fontSize: 18.0,
                                            ),
                                            Utils.verticalSpace(20.0),
                                            const CustomText(
                                              text: "Name: ${'BlackDiamondCar'}",
                                              fontSize: 18.0,
                                            ),
                                            const CustomText(
                                              text: "Version: ${'1.9'}",
                                              fontSize: 18.0,
                                            ),
                                            const CustomText(
                                              text:
                                                  "Last Update: ${'1 Dec 2024'}",
                                              fontSize: 18.0,
                                            ),
                                            const CustomText(
                                              text: "Developed By: ${'BlackDimond'}",
                                              fontSize: 18.0,
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  });
                            }),
                      ],
                    ),
                  ),
                ),
              ),
              Utils.verticalSpace(20.0),
              GestureDetector(
                onTap: () {
                  if (Utils.isLoggedIn(context)) {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return Dialog(
                            backgroundColor: whiteColor,
                            insetPadding: Utils.symmetric(),
                            child: Padding(
                              padding: Utils.symmetric(h: 24.0, v: 32.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const CustomImage(path: KImages.logout),
                                  Utils.verticalSpace(18.0),
                                  const CustomText(
                                    text: "Logout",
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  Utils.verticalSpace(10.0),
                                  const CustomText(
                                    text:
                                        "Are you sure you want to log out from Carsbnb?",
                                    fontSize: 16.0,
                                    color: sTextColor,
                                    textAlign: TextAlign.center,
                                  ),
                                  Utils.verticalSpace(20.0),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(4.0),
                                              color: whiteColor,
                                              border: Border.all(
                                                  color: borderColor)),
                                          child: Padding(
                                            padding: Utils.symmetric(
                                                h: 30.0, v: 16.0),
                                            child: const CustomText(
                                              text: "Cancel",
                                              fontSize: 16.0,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Utils.horizontalSpace(14.0),
                                      BlocListener<LoginBloc, LoginStateModel>(
                                        listener: (context, state) {
                                          if (state.loginState
                                              is LoginStateLogoutLoaded) {
                                            Navigator.pushNamedAndRemoveUntil(
                                                context,
                                                RouteNames.loginScreen,
                                                (route) => false);
                                          }
                                        },
                                        child: GestureDetector(
                                          onTap: () {
                                            context
                                                .read<LoginBloc>()
                                                .add(const LoginEventLogout());
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(4.0),
                                                color: redColor),
                                            child: Padding(
                                              padding: Utils.symmetric(
                                                  h: 30.0, v: 16.0),
                                              child: const CustomText(
                                                text: "Logout",
                                                color: whiteColor,
                                                fontSize: 16.0,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        });
                  } else {
                    Utils.showSnackBarWithLogin(context);
                  }
                },
                child: Container(
                  width: double.infinity,
                  padding: Utils.symmetric(h: 24.0, v: 14.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(color: redColor)),
                  child: CustomText(
                    text: Utils.translatedText(context, Language.logout),
                    fontWeight: FontWeight.w500,
                    fontSize: 16.0,
                    textAlign: TextAlign.center,
                    color: redColor,
                  ),
                ),
              ),
              Utils.verticalSpace(20.0),
            ],
          ),
        ),
      ),
    );
  }
}

class DrawerItem extends StatelessWidget {
  const DrawerItem({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
    this.isVisibleBorder = true,
    this.version = false,
    this.isAuth = true,
  });

  final String icon;
  final String title;
  final bool isVisibleBorder;
  final bool version;
  final VoidCallback onTap;
  final bool isAuth;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Utils.symmetric(v: 20.0, h: 0.0).copyWith(top: 0.0, bottom: 0.0),
      child: Column(
        children: [
          if (isAuth) ...[
            GestureDetector(
              onTap: Utils.isLoggedIn(context)
                  ? onTap
                  : () {
                      Utils.showSnackBarWithLogin(context);
                    },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CustomImage(
                        path: icon,
                        fit: BoxFit.cover,
                        height: 26,
                        color: const Color(0xFFE9D634),
                      ),
                      Utils.horizontalSpace(12.0),
                      CustomText(
                        text: title,
                        color: const Color(0xFFE9D634),
                        fontSize: 16.0,
                      ),
                    ],
                  ),
                  version
                      ? const CustomText(
                          text: '1.0.0',
                          color: blackColor,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w700,
                        )
                      : const SizedBox(),
                ],
              ),
            ),
            isVisibleBorder
                ? Container(
                    height: 1.0,
                    width: double.infinity,
                    margin: Utils.only(right: 20.0, top: 12.0, bottom: 12.0),
                    color: borderColor,
                  )
                : const SizedBox(),
          ] else ...[
            GestureDetector(
              onTap: onTap,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CustomImage(
                        path: icon,
                        fit: BoxFit.cover,
                        height: 26,
                        color: const Color(0xFFE9D634),
                      ),
                      Utils.horizontalSpace(12.0),
                      CustomText(
                        text: title,
                        color: const Color(0xFFE9D634),
                        fontSize: 16.0,
                      ),
                    ],
                  ),
                  version
                      ? const CustomText(
                          text: '1.0.0',
                          color: blackColor,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w700,
                        )
                      : const SizedBox(),
                ],
              ),
            ),
            isVisibleBorder
                ? Container(
                    height: 1.0,
                    width: double.infinity,
                    margin: Utils.only(right: 20.0, top: 12.0, bottom: 12.0),
                    color: borderColor,
                  )
                : const SizedBox(),
          ]
        ],
      ),
    );
  }
}
