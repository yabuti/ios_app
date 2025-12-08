import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../../utils/k_images.dart';

class OnBoardingData extends Equatable {
  final String image;
  final String title;
//  final String subTitle;

  const OnBoardingData({
    required this.image,
    required this.title,
    //required this.subTitle,
  });

  @override
  List<Object?> get props => [
        image,
        title,
        //subTitle,
      ];
}

 List<OnBoardingData> data(BuildContext context) => [
   const OnBoardingData(
    image: KImages.onBoarding2,
    title: "We provide high-quality services car rental just for you.",
  ),
   const OnBoardingData(
    image: KImages.onBoarding3,
    title:"Toyota, Tesla, Ford, Nissan, Mercedes, Mazda etc Car booking.",
  ),
   const OnBoardingData(
    image: KImages.onBoarding4,
    title: "Your satisfaction is our number of one most priority"

  ),

];
