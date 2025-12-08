import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../data/data_provider/remote_url.dart';
import '../../../../data/model/home/home_model.dart';
import '../../../../utils/utils.dart';
import '../../../../widgets/custom_image.dart';

class BannerSlider extends StatelessWidget {
  const BannerSlider({
    super.key,
    required this.offers,
  });

  final List<AdsBanners> offers;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SliverToBoxAdapter(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Row(
            children: [
              ...List.generate(offers.length, (index) {
                final offer = offers[index];
                return Padding(
                  padding: Utils.only(right: 16.0),
                  child: Container(
                    width: size.width * 0.7,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(4.0),
                      child: CustomImage(
                        path: RemoteUrls.imageUrl(offer.image),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}
