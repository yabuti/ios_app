import 'package:blackdiamondcar/logic/bloc/login/login_bloc.dart';
import 'package:blackdiamondcar/logic/cubit/compare/compare_list_cubit.dart';
import 'package:blackdiamondcar/routes/route_names.dart';
import 'package:blackdiamondcar/utils/k_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/data_provider/remote_url.dart';
import '../../../../data/model/auth/login_state_model.dart';
import '../../../../logic/cubit/profile/profile_cubit.dart';
import '../../../../utils/constraints.dart';
import '../../../../utils/utils.dart';
import '../../../../widgets/circle_image.dart';
import '../../../../widgets/custom_image.dart';
import '../../../../widgets/custom_text.dart';


class HomeAppBar extends StatefulWidget {
  const HomeAppBar({super.key});

  @override
  State<HomeAppBar> createState() => _HomeAppBarState();
}

class _HomeAppBarState extends State<HomeAppBar> {
  late ProfileCubit profileCubit;
  late CompareCubit compareCubit;
  late LoginBloc loginBloc;
  late String image;

  @override
  void initState() {
    super.initState();
    profileCubit = context.read<ProfileCubit>();
    loginBloc = context.read<LoginBloc>();
    compareCubit = context.read<CompareCubit>();
    compareCubit.getCompareList();

    // Initialize image based on LoginBloc userInformation
    final user = loginBloc.userInformation?.user;
    if (user?.image.isNotEmpty == true) {
      image = RemoteUrls.imageUrl(user!.image);
    } else {
      image = KImages.profileImage;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      toolbarHeight: Utils.vSize(130.0),
      backgroundColor: const Color(0xFFE9D634),
      pinned: true,
      flexibleSpace: Stack(
        fit: StackFit.loose,
        clipBehavior: Clip.none,
        children: [
          FlexibleSpaceBar(
            titlePadding: Utils.only(top: 55.0, left: 20.0, right: 20.0),
            title: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            if (Utils.isLoggedIn(context)) {
                              Navigator.pushNamed(
                                  context, RouteNames.profileScreen);
                            } else {
                              Utils.showSnackBarWithLogin(context);
                            }
                          },
                          child: BlocBuilder<LoginBloc, LoginStateModel>(
                            builder: (context, state) {
                              final user = loginBloc.userInformation?.user;
                              final userImage = user?.image.isNotEmpty == true
                                  ? RemoteUrls.imageUrl(user!.image)
                                  : KImages.profileImage;
                              return CircleImage(image: userImage, size: 56.0);
                            },
                          ),
                        ),
                        Utils.horizontalSpace(8.0),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            BlocBuilder<LoginBloc, LoginStateModel>(
                              builder: (context, state) {
                                final user = loginBloc.userInformation?.user;
                                return CustomText(
                                  maxLine: 2,
                                  text: user?.name.isNotEmpty == true
                                      ? user!.name
                                      : "Guest",
                                  fontSize: 16.0,
                                  color: whiteColor,
                                  fontFamily: bold700,
                                );
                              },
                            ),
                            Utils.verticalSpace(4.0),
                            const CustomText(
                              text: 'Welcome back !',
                              fontSize: 12.0,
                              color: whiteColor,
                            )
                          ],
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        if (Utils.isLoggedIn(context)) {
                          Navigator.pushNamed(
                              context, RouteNames.compareScreen);
                        } else {
                          Utils.showSnackBarWithLogin(context);
                        }
                      },
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                  color:
                                      const Color(0xFFFFFFFF).withOpacity(0.5)),
                            ),
                            child: Padding(
                              padding: Utils.all(value: 16.0),
                              child: const CustomImage(
                                path: KImages.compare,
                              ),
                            ),
                          ),
                          Positioned(
                            top: -10,
                            right: -4,
                            child: Container(
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle, color: whiteColor),
                              child: Padding(
                                padding: Utils.all(value: 8.0),
                                child: CustomText(
                                  text: compareCubit
                                          .compareListModel?.compareList?.length
                                          .toString() ??
                                      '0',
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            bottom: -44.0,
            left: 20.0,
            right: 20.0,
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, RouteNames.allCarScreen);
              },
              child: Container(
                height: Utils.vSize(56.0),
                width: Utils.mediaQuery(context).width,
                margin: Utils.symmetric(v: 16.0, h: 0.0),
                padding:
                    Utils.only(left: 20.0, right: 6.0, top: 6.0, bottom: 6.0),
                decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius: Utils.borderRadius(),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0x00000000).withOpacity(0.12),
                      blurRadius: 40.0,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: 'Search here...',
                          color: sTextColor,
                        ),
                      ],
                    ),
                    Container(
                      padding: Utils.all(value: 13.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: const Color(0xFFE9D634)),
                      child: const CustomImage(
                        path: KImages.searchIcon,
                        height: 18.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
