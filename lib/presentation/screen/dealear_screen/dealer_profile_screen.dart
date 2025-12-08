import 'package:carsbnb/data/data_provider/remote_url.dart';
import 'package:carsbnb/data/model/home/dealer_details_model.dart';
import 'package:carsbnb/data/model/home/home_model.dart';
import 'package:carsbnb/logic/cubit/dealer_details/dealer_details_cubit.dart';
import 'package:carsbnb/utils/constraints.dart';
import 'package:carsbnb/widgets/circle_image.dart';
import 'package:carsbnb/widgets/custom_image.dart';
import 'package:carsbnb/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../logic/cubit/car_details/car_details_cubit.dart';
import '../../../logic/cubit/contact_dealer/contact_dealer_cubit.dart';
import '../../../logic/cubit/contact_dealer/contact_dealer_state.dart';
import '../../../logic/cubit/dealer_details/dealer_details_state.dart';
import '../../../logic/cubit/language_code_state.dart';
import '../../../utils/k_images.dart';
import '../../../utils/utils.dart';
import '../../../widgets/fetch_error_text.dart';
import '../../../widgets/loading_widget.dart';
import '../details_screen/details_screen.dart';
import '../home/components/popular_card.dart';

class DealerProfileScreen extends StatefulWidget {
  const DealerProfileScreen({super.key, required this.userName});
final String userName;

  @override
  State<DealerProfileScreen> createState() => _DealerProfileScreenState();
}

class _DealerProfileScreenState extends State<DealerProfileScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late DealerDetailsCubit dDCubit;
  late CarDetailsCubit detailsCubit;

  @override
  void initState() {
    super.initState();
    dDCubit = context.read<DealerDetailsCubit>();
    detailsCubit = context.read<CarDetailsCubit>();
    dDCubit.getDealerDetails(widget.userName);
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocListener(
        listeners: [
          BlocListener<ContactDealerCubit, LanguageCodeState>(
            listener: (context, state) {
              final contact = state.contactDealerState;
              if (contact is ContactDealerStateLoading) {
                Utils.loadingDialog(context);
              } else {
                Utils.closeDialog(context);
                if (contact is ContactDealerStateError) {
                  Utils.failureSnackBar(context, contact.message);
                } else if (contact is ContactDealerStateSuccess) {
                  Utils.successSnackBar(context, contact.message);
                  Navigator.pop(context);
                }
              }
            },
          ),
        ],
        child: BlocConsumer<DealerDetailsCubit, LanguageCodeState>(
            listener: (context, state) {
              final details = state.dealerDetailsState;
              if (details is DealerDetailsStateError) {
                if (details.statusCode == 503 || dDCubit.dealerDetailsModel == null) {
                  Utils.failureSnackBar(context, details.message);
                  // detailsCubit.getCarDetails(widget.id);
                }
              }
            }, builder: (context, state) {
          final details = state.dealerDetailsState;
          if (details is DealerDetailsStateLoading) {
            return const LoadingWidget();
          } else if (details is DealerDetailsStateError) {
            if (details.statusCode == 503 || dDCubit.dealerDetailsModel == null) {
              return LoadedDetails(
                data: dDCubit.dealerDetailsModel!,
              );
            } else {
              return FetchErrorText(text: details.message);
            }
          } else if (details is DealerDetailsStateLoaded) {
            return LoadedDetails(
              data: dDCubit.dealerDetailsModel!,
            );
          } else if (dDCubit.dealerDetailsModel != null) {
            return LoadedDetails(
              data: dDCubit.dealerDetailsModel!,
            );
          } else {
            return const FetchErrorText(text: "Something went wrong");
          }
        }
        ),
      ),
      bottomNavigationBar: const ContactDealerWidget(),
    );
  }
}

class LoadedDetails extends StatelessWidget {
  const LoadedDetails({
    super.key, required this.data,

  });

  final DealerDetailsModel data;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            fit: StackFit.loose,
            clipBehavior: Clip.none,
            children: [
                CustomImage(
                path: RemoteUrls.imageUrl(data.dealer!.bannerImage.isNotEmpty ? data.dealer!.bannerImage: data.dealer!.image),
                width: double.infinity,
                height: height * 0.2,
                fit: BoxFit.cover,
              ),
              Positioned(
                  top: height * 0.05,
                  left: 14.0,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const CustomImage(
                      path: KImages.arrowLeft,
                      color: whiteColor,
                    ),
                  )),
              Positioned(
                  top: height * 0.164,
                  left: 20.0,
                  child:  CircleImage(
                    image: RemoteUrls.imageUrl(data.dealer!.image),
                    size: 60.0,
                  ))
            ],
          ),
          Padding(
            padding: Utils.symmetric(),
            child: Container(
              decoration: const BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Color(0x0A000012),
                    blurRadius: 30,
                    offset: Offset(0, 2),
                    spreadRadius: 0,
                  )
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Utils.verticalSpace(40.0),
                  Utils.horizontalLine(),
                  Utils.verticalSpace(10.0),
                   Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        text: data.dealer!.name,
                        fontWeight: FontWeight.w600,
                        fontSize: 18.0,
                      ),
                      CustomText(text: "Total cars  ${data.dealer!.totalCar.toString()}"),
                    ],
                  ),
                  Utils.verticalSpace(10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const CustomText(
                        text: "Member Since 2023",
                        fontWeight: FontWeight.w600,
                        fontSize: 12.0,
                        color: Color(0xFF6B6C6C),
                      ),
                      Row(
                        children: [
                          ...List.generate(5, (index) {
                            return Padding(
                              padding: Utils.only(right: 5.5),
                              child: CustomImage(
                                path: index < data.totalDealerRating ? KImages.starIcon : KImages.starOutLine,
                                height: 12.0,
                                width: 12.0,
                              ),
                            );
                          }),
                          Utils.horizontalSpace(6.0),
                           CustomText(
                            text: data.totalDealerRating.toString(),
                            color: const Color(0xFF6B6C6C),
                          )
                        ],
                      )
                    ],
                  ),
                  Utils.verticalSpace(10.0),
                  Utils.horizontalLine(),
                  Utils.verticalSpace(10.0),
                   Info(
                    icon: KImages.call,
                    text: data.dealer!.phone,
                  ),
                   Info(
                    icon: KImages.mail,
                    text: data.dealer!.email,
                  ),
                   Info(
                    icon: KImages.locationsIcon,
                    text: data.dealer!.address,
                  ),
                  Utils.verticalSpace(10.0),
                  CarTabContent(cars: data.cars!), // Pass the car list to CarTabContent
                  Utils.verticalSpace(10.0),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Info extends StatelessWidget {
  const Info({
    super.key,
    required this.icon,
    required this.text,
  });

  final String icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Utils.only(bottom: 8.0),
      child: Row(
        children: [
          CustomImage(path: icon),
          Utils.horizontalSpace(10.0),
          CustomText(
            text: text,
            color: const Color(0xFF6B6C6C),
          ),
        ],
      ),
    );
  }
}

class CarTabContent extends StatefulWidget implements PreferredSizeWidget {
  const CarTabContent({super.key, required this.cars});

  final List<FeaturedCars> cars;

  @override
  State<CarTabContent> createState() => _CarTabContentState();

  @override
  Size get preferredSize => Size.fromHeight(Utils.vSize(40.0));
}

class _CarTabContentState extends State<CarTabContent> {
  int _currentIndex = 0; // Add this variable to manually set the active tab

  @override
  Widget build(BuildContext context) {
    List<String> orderTabItems = [
      (Utils.translatedText(context, 'All Car')),
      (Utils.translatedText(context, 'New Car')),
      (Utils.translatedText(context, 'Used Car')),
    ];

    List<FeaturedCars> allCars = widget.cars;
    List<FeaturedCars> newCars = widget.cars.where((car) => car.condition == 'New').toList();
    List<FeaturedCars> usedCars = widget.cars.where((car) => car.condition == 'Used').toList();

    List<FeaturedCars> getCurrentCarList() {
      switch (_currentIndex) {
        case 1:
          return newCars;
        case 2:
          return usedCars;
        default:
          return allCars;
      }
    }

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: List.generate(
            orderTabItems.length,
            (index) {
              final active = _currentIndex == index; // Use _currentIndex to check active tab
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _currentIndex = index; // Update _currentIndex on tap
                  });
                },
                child: AnimatedContainer(
                  duration: const Duration(seconds: 0),
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: borderColor,
                        width: 1,
                        style: BorderStyle.solid),
                    color: active ? primaryColor : Colors.transparent,
                    borderRadius: Utils.borderRadius(r: 25.0),
                  ),
                  padding: Utils.symmetric(v: 14.0, h: 18.0),
                  margin: Utils.only(
                      left: index == 0 ? 0.0 : 18.0, top: 10.0),
                  child: CustomText(
                    text: orderTabItems[index],
                    fontSize: 12.0,
                    fontWeight: FontWeight.w400,
                    color: active ? whiteColor : blackColor,
                  ),
                ),
              );
            },
          ),
        ),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0,
            childAspectRatio: 0.68,
          ),
          itemCount: getCurrentCarList().length,
          itemBuilder: (BuildContext context, int index) {
            final cars = getCurrentCarList()[index];
            return PopularCarCard(
              cars: cars, // Use actual car data
            );
          },
        ),
      ],
    );
  }
}