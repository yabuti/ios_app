import 'package:carsbnb/data/data_provider/remote_url.dart';
import 'package:carsbnb/data/model/dashboard/dashboard_model.dart';
import 'package:carsbnb/logic/cubit/dashboard/user_dashboard_cubit.dart';
import 'package:carsbnb/logic/cubit/dashboard/user_dashboard_state.dart';
import 'package:carsbnb/logic/cubit/language_code_state.dart';
import 'package:carsbnb/widgets/custom_app_bar.dart';
import 'package:carsbnb/widgets/custom_image.dart';
import 'package:carsbnb/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../routes/route_names.dart';
import '../../../utils/constraints.dart';
import '../../../utils/k_images.dart';
import '../../../utils/utils.dart';
import '../../../widgets/circle_image.dart';
import '../../../widgets/custom_text.dart';
import '../../../widgets/fetch_error_text.dart';
import '../manage_car/components/manage_car_card.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late UserDashboardCubit dashboardCubit;

  @override
  void initState() {
    super.initState();
    dashboardCubit = context.read<UserDashboardCubit>();
    dashboardCubit.getUserDashboard();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Profile"),
      body: Utils.logout(
        child: BlocConsumer<UserDashboardCubit, LanguageCodeState>(
            listener: (context, state) {
          final dash = state.userDashboardState;
          if (dash is UserDashboardStateError) {
            if (dash.statusCode == 503) {
              Utils.errorSnackBar(context, dash.message);
            }
            if (dash.statusCode == 401) {
              Utils.logoutFunction(context);
            }
          }
        }, builder: (context, state) {
          final dash = state.userDashboardState;
          if (dash is UserDashboardStateLoading) {
            return const LoadingWidget();
          } else if (dash is UserDashboardStateError) {
            if (dash.statusCode == 503) {
              return LoadedDashboardData(
                data: dashboardCubit.dashboardModel!,
              );
            } else if (dash.statusCode == 500) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error_outline, size: 64, color: Colors.red),
                    const SizedBox(height: 16),
                    FetchErrorText(
                      text: dash.message.isNotEmpty 
                          ? dash.message 
                          : 'Internal server error. Please try again later.',
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        dashboardCubit.getUserDashboard();
                      },
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            } else {
              return FetchErrorText(text: dash.message);
            }
          } else if (dash is UserDashboardStateLoaded) {
            return LoadedDashboardData(
              data: dashboardCubit.dashboardModel!,
            );
          }
          if (dashboardCubit.dashboardModel != null) {
            return LoadedDashboardData(
              data: dashboardCubit.dashboardModel!,
            );
          } else {
            return const FetchErrorText(
              text: "Something went wrong",
            );
          }
        }),
      ),
    );
  }
}

class LoadedDashboardData extends StatelessWidget {
  const LoadedDashboardData({
    super.key,
    required this.data,
  });

  final DashboardModel data;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: Utils.symmetric(),
            child: Container(
              padding: Utils.symmetric(v: 20.0),
              decoration: BoxDecoration(
                color: const Color(0xFFF3F7FC),
                borderRadius: BorderRadius.circular(10.0),

              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          data.user != null
                              ? CircleImage(
                                  image: RemoteUrls.imageUrl(data.user!.image),
                                  size: 56.0)
                              : const CircleImage(
                                  image: KImages.profileImage,
                                  size: 56,
                                ),
                          Utils.horizontalSpace(8.0),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                maxLine: 2,
                                text: data.user != null
                                    ? data.user!.name
                                    : "user Name",
                                fontSize: 16.0,
                                color: blackColor,
                                fontFamily: bold700,
                                // overflow: TextOverflow.ellipsis,
                              ),
                              Utils.verticalSpace(4.0),
                              CustomText(
                                text: data.user!.email,
                                fontSize: 12.0,
                                color: blackColor,
                              )
                            ],
                          ),
                        ],
                      ),
                      GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                                context, RouteNames.editProfileScreen);
                          },
                          child: const CustomImage(
                            path: KImages.edit,
                            color: Color(0xFF46D993),
                            height: 24.0,
                          ))
                    ],
                  ),
                  Utils.verticalSpace(16.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      buildCard(
                        icon: KImages.cars,
                        number: data.totalCar.toString(),
                        title: "Total Car",
                      ),
                      buildCard(
                        icon: KImages.cars,
                        number: data.totalFeaturedCar.toString(),
                        title: "Features Car",
                      ),
                      buildCard(
                        icon: KImages.star,
                        number: data.totalWishlist.toString(),
                        title: "Reviews",
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Utils.verticalSpace(20.0),
          Padding(
            padding: Utils.symmetric(h: 0.0, v: 14.0),
            child: Column(
              children: [
                Padding(
                  padding: Utils.symmetric(),
                  child: const Row(
                    // mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: CustomText(
                          text: "Recently Added Cars",
                          color: blackColor,
                          fontSize: 20.0,
                          fontWeight: FontWeight.w400,
                          maxLine: 1,
                        ),
                      ),
                    ],
                  ),
                ),
                Utils.verticalSpace(14.0),
                Container(
                  decoration: const BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x0A000012),
                        blurRadius: 30,
                        offset: Offset(0, 2),
                        spreadRadius: 0,
                      )
                    ],
                  ),
                  child: Padding(
                    padding: Utils.symmetric(),
                    child: Column(children: [
                      ...List.generate(data.cars!.length, (index) {
                        final car = data.cars![index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: ManageCarCard(
                            cars: car,
                          ),
                        );
                      })
                    ],),
                  ),
                ),
                // ...List.generate(data.cars!.length, (index) {
                //   final car = data.cars![index];
                //   return Padding(
                //     padding: const EdgeInsets.only(bottom: 10.0),
                //     child: ManageCarCard(
                //       cars: car,
                //     ),
                //   );
                // })
              ],
            ),
          )
        ],
      ),
    );
  }
}

// boxShadow: [
// BoxShadow(
// color: Color(0x0A000012),
// blurRadius: 30,
// offset: Offset(0, 2),
// spreadRadius: 0,
// )
// ],

class buildCard extends StatelessWidget {
  const buildCard({
    super.key,
    required this.icon,
    required this.number,
    required this.title,
  });

  final String icon;
  final String number;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: Utils.all(value: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              CustomImage(
                path: icon,
                height: 22.0,
              ),
              Utils.horizontalSpace(6.0),
              CustomText(
                text: number,
                fontSize: 16.0,
                fontWeight: FontWeight.w600,
              )
            ],
          ),
          Utils.verticalSpace(10.0),
          CustomText(
            text: title,
            color: Color(0xFF6B6C6C),
          )
        ],
      ),
    );
  }
}

class DashboardCard extends StatelessWidget {
  const DashboardCard({
    super.key,
    required this.value,
    required this.title,
    required this.icon,
  });

  final String value;
  final String title;
  final String icon;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      //height: 70.0,
      width: size.width * 0.43,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6.0),
          color: whiteColor,
          border: Border.all(color: borderColor)),
      child: Padding(
        padding: Utils.all(value: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: value,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
                Utils.verticalSpace(10.0),
                CustomText(
                  text: title,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ],
            ),
            Container(
              height: 40.0,
              width: 40.0,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFFE8EFFF),
              ),
              child: Padding(
                padding: Utils.all(value: 10.0),
                child: Center(child: CustomImage(path: icon)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
