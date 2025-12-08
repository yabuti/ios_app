import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../data/data_provider/remote_url.dart';
import '../../../../data/model/car/car_state_model.dart';
import '../../../../logic/cubit/manage_car/manage_car_cubit.dart';
import '../../../../logic/cubit/manage_car/manage_car_state.dart';
import '../../../../utils/constraints.dart';
import '../../../../utils/utils.dart';
import '../../../../widgets/custom_image.dart';
import '../../../../widgets/custom_text.dart';
import '../../../../widgets/fetch_error_text.dart';

class AddCarImage extends StatelessWidget {
  const AddCarImage({super.key});

  @override
  Widget build(BuildContext context) {
    final mCubit = context.read<ManageCarCubit>();
    return BlocBuilder<ManageCarCubit, CarsStateModel>(
      builder: (context, state) {
        final existImage = mCubit.state.tempImage.isNotEmpty
            ? RemoteUrls.imageUrl(mCubit.state.tempImage)
            : state.tempImage;

        final pickImage =
            state.thumbImage.isNotEmpty ? state.thumbImage : existImage;

        print('pickImage:$pickImage');
        print('tempImage:${state.tempImage}');
        final edit = state.manageCarState;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                padding: Utils.symmetric(v: 16.0, h: 0.0),
                width: double.infinity,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: const Color(0xFFE9EDFF)),
                child: const CustomText(
                  text: "Thumbnail Image",
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                )),
            Utils.verticalSpace(20.0),
            if (state.thumbImage.isEmpty && state.tempImage.isEmpty) ...[
              GestureDetector(
                onTap: () async {
                  final image = await Utils.pickSingleImage();
                  if (image != null && image.isNotEmpty) {
                    mCubit.thumbImageChange(image);
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: Utils.borderRadius(),
                  ),
                  child: Center(
                    child: DottedBorder(
                      padding: Utils.symmetric(v: 24.0),
                      borderType: BorderType.RRect,
                      radius: Radius.circular(Utils.radius(10.0)),
                      color: Color(0xFFE9D634),
                      dashPattern: const [6, 3],
                      strokeCap: StrokeCap.square,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.image_outlined,
                            color: Color(0xFFE9D634),
                          ),
                          Utils.verticalSpace(5.0),
                          const CustomText(
                            text: "Choose Image",
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500,
                            color: primaryColor,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ] else ...[
              Stack(
                children: [
                  Container(
                    height: Utils.hSize(180.0),
                    margin: Utils.symmetric(v: 16.0, h: 0.0),
                    width: double.infinity,
                    child: ClipRRect(
                      borderRadius: Utils.borderRadius(),
                      child: CustomImage(
                        path: pickImage,
                        isFile: state.thumbImage.isNotEmpty,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    right: 10,
                    top: 20,
                    child: InkWell(
                      onTap: () async {
                        final image = await Utils.pickSingleImage();
                        if (image != null && image.isNotEmpty) {
                          mCubit.thumbImageChange(image);
                        }
                      },
                      child: const CircleAvatar(
                        maxRadius: 16.0,
                        backgroundColor: Color(0xFFE9D634),
                        child:
                            Icon(Icons.edit, color: Colors.white, size: 20.0),
                      ),
                    ),
                  )
                ],
              )
            ],
            if (edit is ManageCarAddFormValidate) ...[
              if (edit.error.thumbImage.isNotEmpty)
                FetchErrorText(text: edit.error.thumbImage.first),
            ]
          ],
        );
      },
    );
  }
}

class GalleryCarImage extends StatelessWidget {
  const GalleryCarImage({super.key});

  @override
  Widget build(BuildContext context) {
    final mCubit = context.read<ManageCarCubit>();
    return BlocBuilder<ManageCarCubit, CarsStateModel>(
      builder: (context, state) {
        final galleryImages = state.galleryImages ?? [];

        final edit = state.manageCarState;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                padding: Utils.symmetric(v: 16.0, h: 0.0),
                width: double.infinity,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: const Color(0xFFE9EDFF)),
                child: CustomText(
                  text: "Gallery Images (${galleryImages.length}/5)",
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                )),
            Utils.verticalSpace(20.0),
            GestureDetector(
              onTap: () async {
                if (galleryImages.length >= 5) {
                  Utils.failureSnackBar(context, "Maximum 5 images allowed");
                  return;
                }
                final images = await Utils.pickMultipleImage();
                if (images.isNotEmpty) {
                  final newImages = images.whereType<String>().toList();
                  final totalImages = galleryImages.length + newImages.length;
                  
                  if (totalImages > 5) {
                    Utils.failureSnackBar(context, "You can only upload up to 5 images total");
                    // Take only the images that fit within the limit
                    final remainingSlots = 5 - galleryImages.length;
                    final imagesToAdd = newImages.take(remainingSlots).toList();
                    mCubit.galleryImagesChange([...galleryImages, ...imagesToAdd]);
                  } else {
                    mCubit.galleryImagesChange([...galleryImages, ...newImages]);
                  }
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius: Utils.borderRadius(),
                ),
                child: Center(
                  child: DottedBorder(
                    padding: Utils.symmetric(v: 24.0),
                    borderType: BorderType.RRect,
                    radius: Radius.circular(Utils.radius(10.0)),
                    color: primaryColor,
                    dashPattern: const [6, 3],
                    strokeCap: StrokeCap.square,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.image_outlined,
                          color: primaryColor,
                        ),
                        Utils.verticalSpace(5.0),
                        const CustomText(
                          text: "Add Images",
                          fontSize: 16.0,
                          fontWeight: FontWeight.w500,
                          color: primaryColor,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Utils.verticalSpace(20.0),
            if (galleryImages.isNotEmpty) ...[
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                ),
                itemCount: galleryImages.length,
                itemBuilder: (context, index) {
                  final image = galleryImages[index];
                  return Stack(
                    children: [
                      SizedBox(
                        height: Utils.hSize(100.0),
                        width: Utils.hSize(100.0),
                        child: ClipRRect(
                          borderRadius: Utils.borderRadius(),
                          child: CustomImage(
                            path: image,
                            isFile: true,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        right: 5,
                        top: 5,
                        child: InkWell(
                          onTap: () {
                            mCubit.removeGalleryImage(image);
                          },
                          child: const CircleAvatar(
                            maxRadius: 12.0,
                            backgroundColor: Colors.red,
                            child: Icon(Icons.close,
                                color: Colors.white, size: 16.0),
                          ),
                        ),
                      )
                    ],
                  );
                },
              ),
            ],
            if (edit is ManageCarAddFormValidate) ...[
              if (edit.error.galleryImage.isNotEmpty)
                FetchErrorText(text: edit.error.galleryImage.first),
            ]
          ],
        );
      },
    );
  }
}
