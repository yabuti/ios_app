import 'package:carsbnb/data/data_provider/remote_url.dart';
import 'package:carsbnb/data/model/review/review_list_model.dart';
import 'package:carsbnb/logic/cubit/language_code_state.dart';
import 'package:carsbnb/logic/cubit/review/review_cubit.dart';
import 'package:carsbnb/logic/cubit/review/review_state.dart';
import 'package:carsbnb/widgets/custom_app_bar.dart';
import 'package:carsbnb/widgets/custom_image.dart';
import 'package:carsbnb/widgets/fetch_error_text.dart';
import 'package:carsbnb/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:readmore/readmore.dart';

import '../../../../data/model/cars_details/car_details_model.dart';
import '../../../../utils/constraints.dart';
import '../../../../utils/k_images.dart';
import '../../../../utils/utils.dart';
import '../../../../widgets/circle_image.dart';
import '../../../../widgets/custom_text.dart';

class ReviewScreen extends StatefulWidget {
  const ReviewScreen({super.key});

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  late ReviewCubit rCubit;

  @override
  void initState() {
    super.initState();
    rCubit = context.read<ReviewCubit>();
    rCubit.getReviewList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(title: 'Review'),
        body: BlocConsumer<ReviewCubit, LanguageCodeState>(
            listener: (context, state) {
          final review = state.reviewListState;
          if (review is GetReviewListStateError) {
            if (review.statusCode == 503) {
              Utils.errorSnackBar(context, review.message);
            }
            if (review.statusCode == 401) {
              Utils.logoutFunction(context);
            }
          }
        }, builder: (context, state) {
          final review = state.reviewListState;
          if (review is GetReviewListStateLoading) {
            return LoadingWidget();
          } else if (review is GetReviewListStateError) {
            if (review.statusCode == 503 || rCubit.reviewList != null) {
              return LoadedReview(data: rCubit.reviewList!);
            } else {
              return FetchErrorText(
                text: review.message,
              );
            }
          } else if (review is GetReviewListStateLoaded) {
            return LoadedReview(data: rCubit.reviewList!);
          }
          if (rCubit.reviewList != null) {
            return LoadedReview(data: rCubit.reviewList!);
          } else {
            return const FetchErrorText(text: "Somwthing went wrong");
          }
        }));
  }
}

class LoadedReview extends StatelessWidget {
  const LoadedReview({
    super.key,
    required this.data,
  });

  final List<ReviewListModel> data;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: Utils.symmetric(),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.0),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0A000012),
            blurRadius: 30,
            offset: Offset(0, 2),
            spreadRadius: 0,
          )
        ],
      ),
      child: ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            final review = data[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: AllReviewCard(review: review),
            );
          },
          itemCount: data.length),
    );
  }
}

class AllReviewCard extends StatelessWidget {
  const AllReviewCard({
    super.key,
    required this.review,
  });

  final ReviewListModel review;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0), color: whiteColor),
      child: Padding(
        padding: Utils.all(value: 10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleImage(
              image: RemoteUrls.imageUrl(review.cars!.thumbImage),
              size: 40.0,
            ),
            Utils.horizontalSpace(12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        text: review.cars!.title,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                      Row(
                        children: [
                          Container(
                            height: 7,
                            width: 7,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle, color: textColor),
                          ),
                          Utils.horizontalSpace(8.0),
                          CustomText(
                            text: Utils.formatDateTime(review.createdAt),
                            fontSize: 10.0,
                            color: sTextColor,
                          ),
                        ],
                      ),
                    ],
                  ),
                  // CustomText(
                  //   text: review.comment,
                  //   fontSize: 14,
                  //   maxLine: 3,
                  //   color: sTextColor,
                  // ),
                  ReadMoreText(
                    Utils.htmlTextConverter(review.comment),
                    trimLength: 110,
                    trimCollapsedText: 'See More',
                    moreStyle: const TextStyle(
                        fontSize: 14.0, color: textColor, height: 1.6),
                    lessStyle: const TextStyle(
                        fontSize: 16.0, color: redColor, height: 1.6),
                    style: const TextStyle(
                      fontSize: 14.0,
                      color: blackColor,
                    ),
                  ),
                  Utils.verticalSpace(12.0),
                  Row(
                    children: [
                      ...List.generate(review.rating, (index) {
                        return Padding(
                          padding: Utils.only(right: 6.5),
                          child: const CustomImage(
                            path: KImages.starIcon,
                            height: 12.0,
                            width: 12.0,
                          ),
                        );
                      })
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ReviewCard extends StatelessWidget {
  const ReviewCard({
    super.key,
    required this.review,
  });

  final Reviews review;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Utils.all(value: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleImage(
            image: RemoteUrls.imageUrl(review.user!.image),
            size: 40.0,
          ),
          Utils.horizontalSpace(12.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      text: review.user!.name,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                    Row(
                      children: [
                        // const CustomText(
                        //   text: "Reply",
                        //   fontSize: 10,
                        //   color: textColor,
                        // ),
                        // Utils.horizontalSpace(8.0),
                        Container(
                          height: 7,
                          width: 7,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: textColor),
                        ),
                        Utils.horizontalSpace(8.0),
                        CustomText(
                          text: Utils.formatDateTime(review.createdAt),
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
                Utils.verticalSpace(12.0),
                Row(
                  children: [
                    ...List.generate(review.rating, (index) {
                      return Padding(
                        padding: Utils.only(right: 6.5),
                        child: const CustomImage(
                          path: KImages.starIcon,
                          height: 12.0,
                          width: 12.0,
                        ),
                      );
                    })
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
