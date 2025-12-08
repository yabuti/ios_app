import 'package:carsbnb/logic/cubit/profile/profile_cubit.dart';
import 'package:carsbnb/logic/cubit/website_setup/website_setup/website_setup_cubit.dart';
import 'package:carsbnb/widgets/custom_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../utils/constraints.dart';
import '../../../../../utils/utils.dart';
import '../../../../data/data_provider/remote_url.dart';
import '../../../../data/model/auth/user_response_model.dart';
import '../../../../utils/k_images.dart';
import '../../../../widgets/circle_image.dart';


class ProfilePictureView extends StatelessWidget {
  const ProfilePictureView({super.key});

  @override
  Widget build(BuildContext context) {
    final pCubit = context.read<ProfileCubit>();
    final sCubit = context.read<WebsiteSetupCubit>();
    return BlocBuilder<ProfileCubit, User>(
      builder: (context, state) {
        final defaultImg = sCubit.setting != null &&
            sCubit.setting!.setting != null &&
            sCubit.setting!.setting!.defaultAvatar.isNotEmpty
            ? RemoteUrls.imageUrl(sCubit.setting!.setting!.defaultAvatar)
            : KImages.profileImage;

        // Determine which image to display
        String displayImage;
        bool isFile = false;
        
        if (state.tempImage.isNotEmpty) {
          // User just picked a new image
          displayImage = state.tempImage;
          isFile = true;
        } else if (state.image.isNotEmpty) {
          // User has an existing profile image from server
          displayImage = RemoteUrls.imageUrl(state.image);
          isFile = false;
        } else {
          // No image, use default
          displayImage = defaultImg;
          isFile = false;
        }
        
        debugPrint('Profile image: $displayImage, isFile: $isFile');
        
        return Center(
          child: Stack(
            children: [
              CircleImage(
                  image: displayImage, size: 140.0, isFile: isFile),
              Positioned(
                right: 6.0,
                bottom: 5.0,
                child: GestureDetector(
                  onTap: () async {
                    final img = await Utils.pickSingleImage();
                    if (img != null && img.isNotEmpty) {
                      pCubit.imageChange(img);
                    }
                  },
                  child: const CircleAvatar(
                    maxRadius: 16.0,
                    backgroundColor: primaryColor,
                    child: Icon(
                      Icons.camera_alt_outlined,
                      color: whiteColor,
                      size: 20.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}



class ProfileBannerView extends StatelessWidget {
  const ProfileBannerView({super.key});

  @override
  Widget build(BuildContext context) {
    final pCubit = context.read<ProfileCubit>();
    return BlocBuilder<ProfileCubit, User>(
      builder: (context, state) {
        // Determine which banner image to display
        String displayImage;
        bool isFile = false;
        
        if (state.bannerTempImage.isNotEmpty) {
          // User just picked a new banner image
          displayImage = state.bannerTempImage;
          isFile = true;
        } else if (state.bannerImage.isNotEmpty) {
          // User has an existing banner image from server
          displayImage = RemoteUrls.imageUrl(state.bannerImage);
          isFile = false;
        } else {
          // No banner image, use default
          displayImage = KImages.bannersImage;
          isFile = false;
        }
        
        debugPrint('Banner image: $displayImage, isFile: $isFile');
        
        return Center(
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: CustomImage(
                  path: displayImage,
                  isFile: isFile,
                  height: 130,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                right: 6.0,
                bottom: 5.0,
                child: GestureDetector(
                  onTap: () async {
                    final img = await Utils.pickSingleImage();
                    if (img != null && img.isNotEmpty) {
                      pCubit.bannerImageChange(img);
                    }
                  },
                  child: const CircleAvatar(
                    maxRadius: 16.0,
                    backgroundColor: primaryColor,
                    child: Icon(
                      Icons.camera_alt_outlined,
                      color: whiteColor,
                      size: 20.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
