import 'package:blackdiamondcar/logic/cubit/all_cars/all_cars_cubit.dart';
import 'package:blackdiamondcar/utils/language_string.dart';
import 'package:blackdiamondcar/widgets/custom_app_bar.dart';
import 'package:blackdiamondcar/widgets/custom_image.dart';
import 'package:blackdiamondcar/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sliver_tools/sliver_tools.dart';
import '../../../../data/data_provider/remote_url.dart';
import '../../../../data/model/home/home_model.dart';
import '../../../../routes/route_names.dart';
import '../../../../utils/utils.dart';
import '../../../../widgets/title_and_navigator.dart';

class BrandScreen extends StatelessWidget {
  const BrandScreen({super.key, required this.brands});

  final List<Brands> brands;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return MultiSliver(
      children: <Widget>[
        SliverToBoxAdapter(child: Utils.verticalSpace(size.height * 0.02)),
        SliverToBoxAdapter(
          child: TitleAndNavigator(
            title: Utils.translatedText(context, Language.popularCategories),
            press: () {
              Navigator.pushNamed(context, RouteNames.allBrandScreen,
                  arguments: brands);
            },
          ),
        ),
        SliverToBoxAdapter(child: Utils.verticalSpace(14.0)),
        SliverToBoxAdapter(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                children: [
                  ...List.generate(brands.length, (index) {
                    final brand = brands[index];
                    return Padding(
                      padding: const EdgeInsets.only(right: 12.0),
                      child: BrandCard(
                        brand: brand,
                      ),
                    );
                  })
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class BrandCard extends StatelessWidget {
  const BrandCard({super.key, required this.brand});

  final Brands brand;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            context
                .read<AllCarsCubit>()
                .brandChange(brand.id.toString());
            Navigator.pushNamed(context, RouteNames.allCarScreen);
          },
          child: Container(
            height: 84,
            width: 96,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6.0),
                color: const Color(0xFFF8FAFC)
                ),
            child: Column(
              children: [
                ClipRRect(
                    child: Padding(
                      padding: Utils.only(left: 10.0, right: 10.0, top: 10.0),
                      child: Center(
                        child: CustomImage(
                          path: RemoteUrls.imageUrl(brand.image),
                          fit: BoxFit.fill,
                          width: 60.0,
                          height: 36.0,
                        ),
                      ),
                    )),
                Utils.verticalSpace(10.0),
                CustomText(
                  text: "${brand.name} (${brand.totalCar})",
                  fontSize: 12.0,
                  color: const Color(0xFF5B5B5B),
                )
              ],
            ),
          ),
        ),

      ],
    );
  }
}

class AllBrandScreen extends StatelessWidget {
  const AllBrandScreen({super.key, required this.brands});

  final List<Brands> brands;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          CustomAppBar(title: Utils.translatedText(context, Language.exploreCategories)),
      body: GridView.builder(
          padding: Utils.symmetric(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
          ),
          itemCount: brands.length,
          itemBuilder: (context, index) {
            final brand = brands[index];
            return AllBrandCard(
              brand: brand,
            );
          }),
    );
  }
}

class AllBrandCard extends StatelessWidget {
  const AllBrandCard({super.key, required this.brand});

  final Brands brand;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 108,
          width: 106,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6.0),
              color: Color(0xFFF8FAFC)
            // shape: BoxShape.circle
          ),
          child: Column(
            children: [
              ClipRRect(
                  child: Padding(
                    padding: Utils.only(left: 10.0, right: 10.0, top: 10.0),
                    child: Center(
                      child: GestureDetector(
                        onTap: () {
                          context
                              .read<AllCarsCubit>()
                              .brandChange(brand.id.toString());
                          Navigator.pushNamed(context, RouteNames.allCarScreen);
                        },
                        child: CustomImage(
                          path: RemoteUrls.imageUrl(brand.image),
                          fit: BoxFit.fill,
                          width: 90.0,
                          height: 60.0,
                        ),
                      ),
                    ),
                  )),
              Utils.verticalSpace(10.0),
              CustomText(
                text: "${brand.name} (${brand.totalCar})",
                fontSize: 12.0,
                color: const Color(0xFF5B5B5B),
              )
            ],
          ),
        ),

      ],
    );
  }
}
