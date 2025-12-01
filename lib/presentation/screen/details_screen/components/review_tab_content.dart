import 'package:blackdiamondcar/utils/constraints.dart';
import 'package:blackdiamondcar/widgets/circle_image.dart';
import 'package:blackdiamondcar/widgets/custom_image.dart';
import 'package:blackdiamondcar/widgets/custom_text.dart';
import 'package:flutter/material.dart';

import '../../../../data/model/cars_details/car_details_model.dart';
import '../../../../utils/k_images.dart';
import '../../../../utils/utils.dart';

class ReviewTabContent extends StatelessWidget {
  const ReviewTabContent({super.key, required this.reviews});

  final List<Reviews> reviews;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.0),
          border: Border.all(color: borderColor)),
      child: reviews.isNotEmpty
          ? Column(
              children: [
                ...List.generate(reviews.length, (index) {
                  final review = reviews[index];
                  return Padding(
                    padding: Utils.all(value: 10.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CircleImage(
                          image: KImages.profileImage,
                          size: 40.0,
                        ),
                        Utils.horizontalSpace(12.0),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomText(
                                    text: review.user!.name,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  Row(
                                    children: [
                                      // const CustomText(text: "Reply",fontSize: 10,color: textColor,),
                                      Utils.horizontalSpace(8.0),
                                      Container(
                                        height: 7,
                                        width: 7,
                                        decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: textColor),
                                      ),
                                      Utils.horizontalSpace(8.0),
                                      CustomText(
                                        text: Utils.formatRelativeTime(
                                            review.createdAt),
                                        fontSize: 10.0,
                                        color: sTextColor,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              CustomText(
                                text: review.comment,
                                fontSize: 14,
                                maxLine: 3,
                                color: sTextColor,
                              ),
                              Utils.verticalSpace(10.0),
                              Row(
                                children: [
                                  ...List.generate(5, (index) {
                                    return Padding(
                                      padding: Utils.only(right: 4.0),
                                      child: CustomImage(
                                        path: index < review.rating
                                            ? KImages.starIcon
                                            : KImages.starOutLine,
                                        height: 15.0,
                                      ),
                                    );
                                  }),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                })
              ],
            )
          : Column(
              children: [
                Utils.verticalSpace(20.0),
                const CustomImage(
                  path: KImages.emptyImage,
                  height: 120,
                ),
                Utils.verticalSpace(20.0),
                const CustomText(
                  text: "Review Not Found",
                  fontSize: 16.0,
                ),
              ],
            ),
    );
  }
}
