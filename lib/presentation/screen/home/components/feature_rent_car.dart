import 'package:blackdiamondcar/utils/constraints.dart';
import 'package:blackdiamondcar/utils/language_string.dart';
import 'package:blackdiamondcar/widgets/custom_image.dart';
import 'package:blackdiamondcar/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sliver_tools/sliver_tools.dart';

import '../../../../data/data_provider/remote_url.dart';
import '../../../../data/model/home/home_model.dart';
import '../../../../logic/cubit/all_cars/all_cars_cubit.dart';
import '../../../../logic/cubit/wishlist/wishlist_cubit.dart';
import '../../../../logic/cubit/compare/compare_list_cubit.dart';
import '../../../../routes/route_names.dart';
import '../../../../utils/k_images.dart';
import '../../../../utils/utils.dart';
import '../../../../widgets/title_and_navigator.dart';

class FeatureCarScreen extends StatelessWidget {
  const FeatureCarScreen({super.key, required this.featuredCars});

  final List<FeaturedCars> featuredCars;

  @override
  Widget build(BuildContext context) {
    return MultiSliver(
      children: <Widget>[
        TitleAndNavigator(
          title: Utils.translatedText(context, Language.featureCarListing),
          press: () {
            context.read<AllCarsCubit>().clearFilters();
            Navigator.pushNamed(context, RouteNames.allCarScreen);
          },
        ),
        Utils.verticalSpace(14.0),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Row(
              children: [
                ...List.generate(featuredCars.length, (index) {
                  final car = featuredCars[index];
                  return Padding(
                    padding: const EdgeInsets.only(right: 12.0),
                    child: FeatureCarCard(
                      cars: car,
                    ),
                  );
                })
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class FeatureCarCard extends StatefulWidget {
  const FeatureCarCard({super.key, required this.cars});

  final FeaturedCars cars;

  @override
  State<FeatureCarCard> createState() => _FeatureCarCardState();
}

class _FeatureCarCardState extends State<FeatureCarCard> {
  late WishlistCubit wishList;
  late CompareCubit compareCubit;

  @override
  void initState() {
    super.initState();
    wishList = context.read<WishlistCubit>();
    compareCubit = context.read<CompareCubit>();
  }

  bool checkIfFavorite() {
    // Check if the item is in the wishlist
    return wishList.wishlistModel?.any((item) => item.id == widget.cars.id) ?? false;
  }

  void toggleFavorite() async {
    final isCurrentlyFavorite = checkIfFavorite();
    
    if (isCurrentlyFavorite) {
      // Remove from wishlist
      await wishList.removeWishlist(widget.cars.id.toString());
      if (mounted) {
        Utils.successSnackBar(context, 'Removed from wishlist');
      }
    } else {
      // Add to wishlist
      await wishList.addToWishlist(widget.cars.id.toString());
      if (mounted) {
        Utils.successSnackBar(context, 'Added to wishlist');
      }
    }
    
    // Refresh wishlist to update UI
    await wishList.getWishlist();
    
    if (mounted) {
      setState(() {});
    }
  }

  void _addToCompare() async {
    final body = {'car_id': widget.cars.id.toString()};
    await compareCubit.addCompare(body);
    await compareCubit.getCompareList();
    
    if (mounted) {
      Utils.successSnackBar(context, 'Added to compare');
      // Navigate to compare screen
      Navigator.pushNamed(context, RouteNames.compareScreen);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, RouteNames.detailsCarScreen,
            arguments: widget.cars.id.toString());
      },
      child: Container(
        height: size.height*0.31,
        width: 210,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0), 
            color: whiteColor,
        ),
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                    height: size.height*0.16,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0)),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10.0),
                        topRight: Radius.circular(10.0),
                      ),
                      child: CustomImage(
                        path: RemoteUrls.imageUrl(widget.cars.thumbImage),
                        fit: BoxFit.cover,
                      ),
                    )),
                Positioned(
                    right: 10.0,
                    top: 10.0,
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: (){
                            if (Utils.isLoggedIn(context)) {
                              _addToCompare();
                            } else {
                              Utils.showSnackBarWithLogin(context);
                            }
                          },
                          child: Container(
                            padding: Utils.all(value: 8.0),
                            decoration:const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xFFEEF2F6),
                            ),
                            child: const CustomImage(
                              path: KImages.compare,
                              height: 17.0,
                              width: 20.0,
                            ),
                          ),
                        ),
                        Utils.horizontalSpace(8.0),
                        GestureDetector(
                          onTap: (){
                            if (Utils.isLoggedIn(context)) {
                              toggleFavorite();
                            } else {
                              Utils.showSnackBarWithLogin(context);
                            }
                          },
                          child: Container(
                            padding: Utils.all(value: 8.0),
                            decoration:const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xFFEEF2F6),
                            ),
                            child: CustomImage(
                              path: checkIfFavorite()
                                  ? KImages.loveActiveIcon
                                  : KImages.loveIcon,
                              height: 17.0,
                              width: 20.0,
                            ),
                          ),
                        ),
                      ],
                    ))
              ],
            ),
            Padding(
              padding: Utils.all(value: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: widget.cars.brands!.name,
                    fontSize: 10.0,
                    color: sTextColor,
                  ),
                  Utils.verticalSpace(6.0),
                  CustomText(
                    text: widget.cars.title,
                    fontWeight: FontWeight.w600,
                    maxLine: 2,
                  ),
                  Utils.verticalSpace(6.0),
                  CustomText(
                    text:
                        Utils.formatAmount(context, widget.cars.regularPrice),
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: textColor,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
