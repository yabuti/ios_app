import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../data/data_provider/remote_url.dart';
import '../../../../data/model/home/home_model.dart';
import '../../../../utils/constraints.dart';
import '../../../../utils/utils.dart';
import '../../../../widgets/custom_image.dart';

class SliderSection extends StatefulWidget {
  const SliderSection({super.key, required this.slider});

  final List<Sliders> slider;

  @override
  State<SliderSection> createState() => _SliderSectionState();
}

class _SliderSectionState extends State<SliderSection> {
  int _currentIndex = 1;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [
            //SliverToBoxAdapter(child: Utils.verticalSpace(size.height * 0.06)),
            Utils.verticalSpace(size.height * 0.05),
            Stack(
              children: [
                CarouselSlider(
                  options: CarouselOptions(
                    height: 164.0,
                    viewportFraction: 1.0,
                    initialPage: _currentIndex,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 3),
                    autoPlayAnimationDuration: const Duration(seconds: 1),
                    autoPlayCurve: Curves.easeInOut,
                    enlargeCenterPage: true,
                    onPageChanged: callbackFunction,
                    scrollDirection: Axis.horizontal,
                  ),
                  items: widget.slider.map((e) {
                    return Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0)),
                      //margin: Utils.symmetric(h: 10.0),
                      width: double.infinity,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: CustomImage(
                          path: RemoteUrls.imageUrl(e.image),
                          fit: BoxFit.fill,
                        ),
                        // child: Image.network(e.image),
                      ),
                    );
                  }).toList(),
                ),
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

  void callbackFunction(int index, CarouselPageChangedReason reason) {
    setState(() {
      _currentIndex = index;
    });
  }

  Widget _buildDotIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        widget.slider.length,
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
