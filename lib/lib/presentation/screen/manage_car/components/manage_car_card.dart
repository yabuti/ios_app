import 'package:carsbnb/data/data_provider/remote_url.dart';
import 'package:carsbnb/logic/cubit/manage_car/delete_car/delete_car_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/model/home/home_model.dart';
import '../../../../logic/cubit/user_cars_list/user_cars_cubit.dart';
import '../../../../routes/route_names.dart';
import '../../../../utils/constraints.dart';
import '../../../../utils/k_images.dart';
import '../../../../utils/utils.dart';
import '../../../../widgets/custom_image.dart';
import '../../../../widgets/custom_text.dart';

class ManageCarCard extends StatelessWidget {
  const ManageCarCard({super.key, required this.cars});

  final FeaturedCars cars;

  @override
  Widget build(BuildContext context) {
    final dCubit = context.read<DeleteCarCubit>();
    return Container(
      padding: Utils.all(value: 10.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0), color: whiteColor),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                height: 48.0,
                width: 48.0,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(4.0),
                  topRight: Radius.circular(4.0),
                )),
                child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(4.0),
                      topRight: Radius.circular(4.0),
                    ),
                    child: CustomImage(
                      path: RemoteUrls.imageUrl(cars.thumbImage),
                      fit: BoxFit.cover,
                    )),
              ),
              Utils.horizontalSpace(8.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: cars.title,
                    fontWeight: FontWeight.w500,
                    fontSize: 16.0,
                    maxLine: 2,
                  ),
                  cars.brands != null
                      ? CustomText(
                          text: cars.brands!.name,
                          fontSize: 10.0,
                          color: sTextColor,
                          maxLine: 1,
                        )
                      : const SizedBox.shrink(),
                ],
              )
            ],
          ),
          Utils.verticalSpace(10.0),
          Utils.horizontalLine(),
          Utils.verticalSpace(10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const CustomText(
                    text: "Price",
                    color: Color(0xFF6B6C6C),
                  ),
                  Utils.horizontalSpace(4.0),
                  CustomText(
                    text: Utils.formatAmount(context, cars.regularPrice),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: textColor,
                  ),
                ],
              ),
              Row(
                children: [
                  const CustomText(text: "Status:", color: Color(0xFF6B6C6C)),
                  Utils.horizontalSpace(4.0),
                  CustomText(
                    text: cars.status[0].toUpperCase() +
                        cars.status.substring(1).toLowerCase(),
                    color: const Color(0xFF46D993),
                  ),
                ],
              ),
            ],
          ),
          Utils.verticalSpace(10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
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
                                const CustomImage(path: KImages.circleDelete),
                                Utils.verticalSpace(18.0),
                                const CustomText(
                                  text:
                                      "Are you sure you want to delete this record ?",
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w500,
                                  textAlign: TextAlign.center,
                                ),
                                Utils.verticalSpace(10.0),
                                const CustomText(
                                  text: "You won't be able to revert this!?",
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
                                            border:
                                                Border.all(color: borderColor)),
                                        child: Padding(
                                          padding:
                                              Utils.symmetric(h: 30.0, v: 16.0),
                                          child: const CustomText(
                                            text: "Cancel",
                                            fontSize: 16.0,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Utils.horizontalSpace(14.0),
                                    GestureDetector(
                                      onTap: () {
                                        dCubit.deleteCar(cars.id.toString());
                                        Navigator.of(context).pop(true);
                                        context
                                            .read<UserCarsCubit>()
                                            .getUserCarsList();
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(4.0),
                                            color: redColor),
                                        child: Padding(
                                          padding:
                                              Utils.symmetric(h: 30.0, v: 16.0),
                                          child: const CustomText(
                                            text: "Yes",
                                            color: whiteColor,
                                            fontSize: 16.0,
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
                },
                child: Container(
                  padding: Utils.symmetric(h: 48.0, v: 10.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: const Color(0xFFFFF0EA),
                  ),
                  child: const CustomText(
                    text: "Delete",
                    color: redColor,
                    fontSize: 18.0,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, RouteNames.addCarScreen,
                      arguments: cars.id.toString());
                },
                child: Container(
                  padding: Utils.symmetric(h: 58.0, v: 10.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: const Color(0xFFE9D634),
                  ),
                  child: const CustomText(
                    text: "Edit",
                    color: whiteColor,
                    fontSize: 18.0,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
