import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../data/data_provider/remote_url.dart';
import '../../../../data/model/home/home_model.dart';
import '../../../../logic/cubit/wishlist/wishlist_cubit.dart';
import '../../../../routes/route_names.dart';
import '../../../../utils/constraints.dart';
import '../../../../utils/k_images.dart';
import '../../../../utils/utils.dart';
import '../../../../widgets/custom_image.dart';
import '../../../../widgets/custom_text.dart';

class PopularCarCard extends StatefulWidget {
  const PopularCarCard({super.key, required this.cars});

  final FeaturedCars cars;

  @override
  State<PopularCarCard> createState() => _PopularCarCardState();
}

class _PopularCarCardState extends State<PopularCarCard> {
  late WishlistCubit wishList;

  @override
  void initState() {
    super.initState();
    wishList = context.read<WishlistCubit>();
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

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, RouteNames.detailsCarScreen,
            arguments: widget.cars.id.toString());
      },
      child: Container(
        height: size.height*0.28,
        width: 160,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0), color: whiteColor),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: size.height*0.15,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8.0),
                        topRight: Radius.circular(8.0),
                      )),
                  child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(8.0),
                        topRight: Radius.circular(8.0),
                      ),
                      child: CustomImage(
                        path: RemoteUrls.imageUrl(widget.cars.thumbImage),
                        fit: BoxFit.cover,
                      )),
                ),
                Positioned(
                    right: 10.0,
                    top: 10.0,
                    child: GestureDetector(
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
                    ))
              ],
            ),
            Padding(
              padding: Utils.all(value: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Utils.verticalSpace(2.0),
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
                    text: Utils.formatAmount(
                        context, widget.cars.regularPrice),
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