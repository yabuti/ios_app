import 'package:carsbnb/presentation/screen/home/components/popular_card.dart';
import 'package:carsbnb/utils/language_string.dart';
import 'package:carsbnb/widgets/custom_image.dart';
import 'package:carsbnb/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sliver_tools/sliver_tools.dart';
import '../../../../data/model/home/home_model.dart';
import '../../../../logic/cubit/all_cars/all_cars_cubit.dart';
import '../../../../routes/route_names.dart';
import '../../../../utils/k_images.dart';
import '../../../../utils/utils.dart';
import '../../../../widgets/title_and_navigator.dart';

class PopularCarScreen extends StatelessWidget {
  const PopularCarScreen({super.key, required this.latestCars});

  final List<FeaturedCars> latestCars;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    double childAspectRatio = size.width / (size.height / 1.46);
    return MultiSliver(
      children: <Widget>[
        SliverToBoxAdapter(
          child: TitleAndNavigator(
            title: Utils.translatedText(context, Language.carListing),
            press: () {
              context.read<AllCarsCubit>().clearFilters();
              Navigator.pushNamed(context, RouteNames.allCarScreen);
            },
          ),
        ),
        Utils.verticalSpace(14.0),
        if (latestCars.isNotEmpty) ...[
          SliverPadding(
            padding: Utils.symmetric(h: 20.0),
            sliver: SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0,
                childAspectRatio: childAspectRatio,
              ),
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  final cars = latestCars[index];
                  return PopularCarCard(
                    cars: cars,
                  );
                },
                childCount: latestCars.length,
              ),
            ),
          ),
        ] else ...[
          SliverToBoxAdapter(
              child: Column(
            children: [
              const CustomImage(
                path: KImages.emptyImage,
                height: 150,
              ),
              Utils.verticalSpace(20.0),
               CustomText(
                text: Utils.translatedText(context, Language.noCarList),
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ],
          )),
        ],
      ],
    );
  }
}


