import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../data/data_provider/remote_url.dart';
import '../../../../data/model/home/home_model.dart';
import '../../../../utils/constraints.dart';
import '../../../../utils/utils.dart';
import '../../../../widgets/custom_image.dart';

class BannerSliderSection extends StatefulWidget {
  const BannerSliderSection({super.key, required this.offers});

  final List<AdsBanners> offers;

  @override
  State<BannerSliderSection> createState() => _BannerSliderSectionState();
}

class _BannerSliderSectionState extends State<BannerSliderSection> {
  int _currentIndex = 1;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    
    // Use default banner if no offers from backend
    final bannerItems = widget.offers.isEmpty 
        ? [_buildDefaultBanner()]
        : widget.offers.map((e) => _buildBannerItem(e)).toList();
    
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [
            Stack(
              children: [
                CarouselSlider(
                  options: CarouselOptions(
                    height: 132.0,
                    viewportFraction: 1.0,
                    initialPage: _currentIndex,
                    enableInfiniteScroll: widget.offers.length > 1,
                    reverse: false,
                    autoPlay: widget.offers.length > 1,
                    autoPlayInterval: const Duration(seconds: 3),
                    autoPlayAnimationDuration: const Duration(seconds: 1),
                    autoPlayCurve: Curves.easeInOut,
                    enlargeCenterPage: true,
                    onPageChanged: callbackFunction,
                    scrollDirection: Axis.horizontal,
                  ),
                  items: bannerItems,
                ),
                if (widget.offers.length > 1)
                  Positioned(
                      bottom: 10.0,
                      left: 0.0,
                      right: 0.0,
                      child: _buildDotIndicator()),
              ],
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildBannerItem(AdsBanners banner) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0)),
      width: double.infinity,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: CustomImage(
          path: RemoteUrls.imageUrl(banner.image),
          fit: BoxFit.fill,
        ),
      ),
    );
  }
  
  Widget _buildDefaultBanner() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0)),
      width: double.infinity,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: const CustomImage(
          path: 'assets/images/banner.png',
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  void callbackFunction(int index, CarouselPageChangedReason reason) {
    setState(() {
      _currentIndex = index;
    });
  }

  Widget _buildDotIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        widget.offers.length,
            (index) {
          final i = _currentIndex == index;
          return AnimatedContainer(
            duration: const Duration(seconds: 1),
            height: Utils.vSize(6.0),
            width: Utils.hSize(i ? 24.0 : 6.0),
            margin: Utils.only(right: 4.0),
            decoration: BoxDecoration(
              color: i ? whiteColor : whiteColor,
              borderRadius: BorderRadius.circular(i ? 50.0 : 5.0),
              //shape: i ? BoxShape.rectangle : BoxShape.circle,
            ),
          );
        },
      ),
    );
  }
}
