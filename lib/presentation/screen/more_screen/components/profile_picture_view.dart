import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../data/data_provider/remote_url.dart';
import '../../../../data/model/auth/user_response_model.dart';
import '../../../../logic/cubit/profile/profile_cubit.dart';
import '../../../../logic/cubit/website_setup/website_setup/website_setup_cubit.dart';
import '../../../../utils/constraints.dart';
import '../../../../utils/k_images.dart';
import '../../../../utils/utils.dart';
import '../../../../widgets/circle_image.dart';
import '../../../../widgets/custom_image.dart';


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

        // Show newly picked image first, then existing server image, then default
        String displayImage;
        bool isFileImage = false;
        
        if (state.image.isNotEmpty && !state.image.startsWith('http')) {
          // Newly picked local file
          displayImage = state.image;
          isFileImage = true;
        } else if (state.tempImage.isNotEmpty) {
          // Existing server image
          displayImage = RemoteUrls.imageUrl(state.tempImage);
          isFileImage = false;
        } else {
          // Default image
          displayImage = defaultImg;
          isFileImage = false;
        }
        
        debugPrint('state-image ${state.image}');
        debugPrint('display-image $displayImage');
        return Center(
          child: Stack(
            children: [
              CircleImage(
                  image: displayImage, size: 140.0, isFile: isFileImage),
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
    final sCubit = context.read<WebsiteSetupCubit>();
    return BlocBuilder<ProfileCubit, User>(
      builder: (context, state) {
        // Show newly picked banner first, then existing server banner, then default
        String displayBanner;
        bool isFileBanner = false;
        
        if (state.bannerImage.isNotEmpty && !state.bannerImage.startsWith('http')) {
          // Newly picked local file
          displayBanner = state.bannerImage;
          isFileBanner = true;
        } else if (state.bannerTempImage.isNotEmpty) {
          // Existing server image
          displayBanner = RemoteUrls.imageUrl(state.bannerTempImage);
          isFileBanner = false;
        } else {
          // Default image
          displayBanner = KImages.bannersImage;
          isFileBanner = false;
        }
        
        debugPrint('banner-image ${state.bannerImage}');
        debugPrint('display-banner $displayBanner');
        return Center(
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: CustomImage(
                  path: displayBanner,
                  isFile: isFileBanner,
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
