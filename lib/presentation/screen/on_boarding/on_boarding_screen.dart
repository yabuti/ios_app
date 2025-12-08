import 'package:carsbnb/utils/constraints.dart';
import 'package:carsbnb/widgets/custom_image.dart';
import 'package:carsbnb/widgets/custom_text.dart';
import 'package:flutter/material.dart';

import '../../../routes/route_names.dart';
import '../../../utils/utils.dart';
import 'data/on_boarding_data.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  late int _numPages;
  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _numPages = data(context).length;
    _pageController = PageController(initialPage: _currentPage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            child: PageView(
              physics: const ClampingScrollPhysics(),
              controller: _pageController,
              onPageChanged: (int page) {
                setState(() {
                  _currentPage = page;
                });
              },
              children: data(context)
                  .map(
                    (e) => CustomImage(
                      path: e.image,
                      fit: BoxFit.cover,
                    ),
                  )
                  .toList(),
            ),
          ),
          Positioned(top: 80.0, right: 16.0, child: _buildSkipButton()),
          Positioned(
              top: 95.0,
              //right: 80.0,
              left: 24.0,
              child: _buildDotIndicator()),
          Positioned(
              bottom: 180.0, right: 16.0, left: 16.0, child: _buildContent()),
          Positioned(
            bottom: 60.0,
            right: 20.0,
            left: 20.0,
            child: Padding(
              padding: Utils.symmetric(),
              child: GestureDetector(
                onTap: () {
                  if (_currentPage == data(context).length - 1) {
                    //  context.read<WebsiteSetupCubit>().cacheOnBoarding();
                    Navigator.pushNamedAndRemoveUntil(
                        context, RouteNames.loginScreen, (route) => false);
                  } else {
                    _pageController.nextPage(
                        duration: kDuration, curve: Curves.easeInOut);
                  }
                },
                child: Container(
                  height: 48.0,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4.0),
                      color: whiteColor),
                  child: const Center(
                      child: CustomText(
                    text: "Next",
                    color: Color(0xFFE9D634),
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500,
                  )),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildSkipButton() {
    return GestureDetector(
      onTap: () {
        //  context.read<WebsiteSetupCubit>().cacheOnBoarding();
        Navigator.pushNamedAndRemoveUntil(
            context, RouteNames.loginScreen, (route) => false);
      },
      child: Container(
        alignment: Alignment.centerRight,
        margin: Utils.only(right: 20.0),
        child: const CustomText(
          text: "Skip",
          fontWeight: FontWeight.w500,
          fontSize: 18.0,
          color: whiteColor,
        ),
      ),
    );
  }

  Widget _buildDotIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        data(context).length,
        (index) {
          final i = _currentPage == index;
          return AnimatedContainer(
            duration: const Duration(seconds: 1),
            height: Utils.vSize(6.0),
            width: Utils.hSize(i ? 26.0 : 6.0),
            margin: Utils.only(right: 4.0),
            decoration: BoxDecoration(
              color: whiteColor,
              borderRadius: BorderRadius.circular(i ? 50.0 : 5.0),
              //shape: i ? BoxShape.rectangle : BoxShape.circle,
            ),
          );
        },
      ),
    );
  }

  Widget _buildContent() {
    return Padding(
      padding: Utils.symmetric(h: 30.0),
      child: AnimatedSwitcher(
        duration: kDuration,
        transitionBuilder: (Widget child, Animation<double> anim) {
          return FadeTransition(opacity: anim, child: child);
        },
        child: getContent(),
      ),
    );
  }

  Widget getContent() {
    final item = data(context)[_currentPage];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      key: ValueKey('$_currentPage'),
      children: [
        CustomText(
          text: item.title,
          fontSize: 24.0,
          fontFamily: bold700,
          fontWeight: FontWeight.w500,
          textAlign: TextAlign.center,
          color: whiteColor,
        ),
      ],
    );
  }
}
