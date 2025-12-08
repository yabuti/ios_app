import 'package:carsbnb/data/model/cars_details/car_details_model.dart';
import 'package:carsbnb/presentation/screen/details_screen/components/review_tab_content.dart';
import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';

import '../../../../utils/constraints.dart';
import '../../../../utils/utils.dart';
import '../../../../widgets/custom_text.dart';
import 'details_tab_content.dart';

class TavView extends StatefulWidget {
  const TavView({super.key, required this.detailsModel});

  final CarDetailsModel detailsModel;

  @override
  State<TavView> createState() => _TavViewState();
}

class _TavViewState extends State<TavView> {
  int _currentTab = 0;

  @override
  Widget build(BuildContext context) {
    return ExpandablePageView.builder(
      itemCount: detailScreen.length,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, position) {
        return Column(
          children: [
            Row(
              //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                tabButton.length,
                (index) {
                  final active = _currentTab == index;
                  return Padding(
                    padding: Utils.only(right: 16.0),
                    child: GestureDetector(
                      onTap: () => setState(() => _currentTab = index),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 500),
                        padding: Utils.symmetric(h: 18.0, v: 14.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.0),
                          color: active ? primaryColor : whiteColor,
                        ),
                        child: CustomText(
                          text: tabButton[index],
                          fontWeight: FontWeight.w400,
                          fontSize: 14.0,
                          color: active ? whiteColor : greyColor,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: Utils.symmetric(v: 14.0, h: 0.0).copyWith(bottom: 0.0),
              child: detailScreen[_currentTab],
            ),
            Utils.verticalSpace(Utils.mediaQuery(context).height * 0.02),
          ],
        );
      },
    );
  }

  List<Widget> get detailScreen => [
        DetailsTabContent(cars: widget.detailsModel.car!),
        ReviewTabContent(
          reviews: widget.detailsModel.reviews!,
        ),
      ];
  final List<String> tabButton = ['View Details', 'All Review'];
}
