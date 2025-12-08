import 'package:carsbnb/data/data_provider/remote_url.dart';
import 'package:carsbnb/utils/constraints.dart';
import 'package:carsbnb/utils/k_images.dart';
import 'package:carsbnb/widgets/circle_image.dart';
import 'package:carsbnb/widgets/custom_image.dart';
import 'package:carsbnb/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sliver_tools/sliver_tools.dart';

import '../../../../data/model/home/home_model.dart';
import '../../../../routes/route_names.dart';
import '../../../../utils/language_string.dart';
import '../../../../utils/utils.dart';
import '../../../../widgets/title_and_navigator.dart';

class TopDealerSection extends StatelessWidget {
  const TopDealerSection({super.key, required this.dealers,});

  final List<Dealers> dealers;
  @override
  Widget build(BuildContext context) {
    return MultiSliver(
      children: <Widget>[
        TitleAndNavigator(
          title: Utils.translatedText(context, Language.topDealers),
          press: () {
            Navigator.pushNamed(context, RouteNames.carDealer);
          },
        ),
        Utils.verticalSpace(14.0),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Row(
              children: [
                ...List.generate(dealers.length, (index) {
                  final dealer = dealers[index];
                  return   Padding(
                    padding: const EdgeInsets.only(right: 12.0),
                    child: DealersCard(dealer: dealer,),
                  );
                }),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class DealersCard extends StatelessWidget {
  const DealersCard({super.key, required this.dealer});

  final Dealers dealer;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: (){
        Navigator.pushNamed(context, RouteNames.dealerProfileScreen,arguments: dealer.username);
      },
      child: Container(
        width: size.width * 0.78,
        padding: Utils.all(value: 20.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: whiteColor
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
              Row(children: [
                CircleImage(image: RemoteUrls.imageUrl(dealer.image),size: 48.0,),
                Utils.horizontalSpace(4.0),
                 Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  CustomText(text: dealer.name, fontSize: 16.0,fontWeight: FontWeight.w500,),
                   CustomText(text: "Total Cars ${dealer.totalCar}", fontSize: 12.0,fontWeight: FontWeight.w400,),
                ],)

              ],),
          Utils.verticalSpace(10.0),
          Utils.horizontalLine(),
          Utils.verticalSpace(10.0),
          Row(children: [
            const CustomImage(path: KImages.call),
            Utils.horizontalSpace(6.0),
            CustomText(text: dealer.phone),
          ],),
            Utils.verticalSpace(10.0),
          Row(children: [
            const CustomImage(path: KImages.locationsIcon),
            Utils.horizontalSpace(6.0),
            CustomText(text: dealer.address, maxLine: 2,),
          ],),
        ],),
      ),
    );
  }
}
