import 'package:carsbnb/data/data_provider/remote_url.dart';
import 'package:carsbnb/data/model/home/home_model.dart';
import 'package:carsbnb/logic/cubit/compare/compare_list_state.dart';
import 'package:carsbnb/logic/cubit/language_code_state.dart';
import 'package:carsbnb/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/model/compare/compare_list_model.dart';
import '../../../logic/cubit/compare/compare_list_cubit.dart';
import '../../../utils/constraints.dart';
import '../../../utils/utils.dart';
import '../../../widgets/custom_image.dart';
import '../../../widgets/custom_text.dart';
import '../../../widgets/fetch_error_text.dart';

class CompareScreen extends StatefulWidget {
  const CompareScreen({super.key});

  @override
  State<CompareScreen> createState() => _CompareScreenState();
}

class _CompareScreenState extends State<CompareScreen> {
  late CompareCubit compareCubit;

  @override
  void initState() {
    super.initState();
    compareCubit = context.read<CompareCubit>();
    compareCubit.getCompareList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Compare Screen"),
      body: MultiBlocListener(
        listeners: [
          BlocListener<CompareCubit, LanguageCodeState>(
            listener: (context, state) {
              final contact = state.compareListState;
              if (contact is AddCompareStateLoading) {
                Utils.loadingDialog(context);
              } else {
                Utils.closeDialog(context);
                if (contact is AddCompareStateError) {
                  Utils.failureSnackBar(context, contact.message);
                } else if (contact is RemoveCompareSuccess) {
                  Utils.successSnackBar(context, contact.message);
                 compareCubit.getCompareList();
                }
              }
            },
          ),
        ],
        child: BlocConsumer<CompareCubit, LanguageCodeState>(
          listener: (context, state) {
            final compare = state.compareListState;
            if (compare is GetCompareListStateError) {
              if (compare.statusCode == 503 ||
                  compareCubit.compareListModel == null) {
                Utils.failureSnackBar(context, compare.message);
              }
              if (compare.statusCode == 401) {
                Utils.logoutFunction(context);
              }
            }
          },
          builder: (context, state) {
            final compare = state.compareListState;
            if (compare is GetCompareListStateLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (compare is GetCompareListStateError) {
              if (compare.statusCode == 503 ||
                  compareCubit.compareListModel != null) {
                return LoadedCompareList(cars: compareCubit.compareListModel!.compareList!,);
              }else {
                return FetchErrorText(text: compare.message);
              }
            } else if (compare is GetCompareListStateLoaded) {
             // final cars = compareCubit.compareListModel!.compareList!.map((e) => e.car).toList();
              return LoadedCompareList(cars: compareCubit.compareListModel!.compareList!,);
            }
            if (compareCubit.compareListModel != null) {
              return LoadedCompareList(cars: compareCubit.compareListModel!.compareList!,);
            }
            else {
              return const FetchErrorText(text: 'Something went wrong');
            }
          }
        ),
      ),
    );
  }


}


class LoadedCompareList extends StatefulWidget {
  const LoadedCompareList({super.key, required this.cars});

  final List<CompareList> cars ;

  @override
  State<LoadedCompareList> createState() => _LoadedCompareListState();
}

class _LoadedCompareListState extends State<LoadedCompareList> {
  late CompareCubit compareCubit;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    compareCubit = context.read<CompareCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Utils.symmetric(),
      child: SingleChildScrollView(
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildCarCard(context, widget.cars.isNotEmpty ? widget.cars[0].car : null),
              Utils.horizontalSpace(4.0),
              _buildCarCard(context, widget.cars.length > 1 ? widget.cars[1].car : null),
            ],
          ),
          Utils.verticalSpace(20.0),
          Container(
            padding: Utils.symmetric(v: 8.0),
            width: double.infinity,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0),
                ),
                color: Color(0xFFF3F7FC)),
            child: const CustomText(
              text: "Description Overview",
              fontSize: 18.0,
              fontWeight: FontWeight.w600,
              textAlign: TextAlign.center,
            ),
          ),
          Utils.verticalSpace(20.0),
          _buildComparisonRow("Purpose", widget.cars.isNotEmpty ? widget.cars[0].car!.purpose : "", widget.cars.length > 1 ? widget.cars[1].car!.purpose : ""),
          _buildComparisonRow("Condition", widget.cars.isNotEmpty ? widget.cars[0].car!.condition : "", widget.cars.length > 1 ? widget.cars[1].car!.condition : ""),
          _buildComparisonRow("Body Type", widget.cars.isNotEmpty ? widget.cars[0].car!.bodyType : "", widget.cars.length > 1 ? widget.cars[1].car!.bodyType : ""),
          _buildComparisonRow("Engine Size", widget.cars.isNotEmpty ? widget.cars[0].car!.engineSize : "", widget.cars.length > 1 ? widget.cars[1].car!.engineSize : ""),
          _buildComparisonRow("Drive", widget.cars.isNotEmpty ? widget.cars[0].car!.drive : "", widget.cars.length > 1 ? widget.cars[1].car!.drive : ""),
          _buildComparisonRow("Interior Color", widget.cars.isNotEmpty ? widget.cars[0].car!.interiorColor : "", widget.cars.length > 1 ? widget.cars[1].car!.interiorColor : ""),
          _buildComparisonRow("Exterior Color", widget.cars.isNotEmpty ? widget.cars[0].car!.exteriorColor : "", widget.cars.length > 1 ? widget.cars[1].car!.exteriorColor : ""),
          _buildComparisonRow("Year", widget.cars.isNotEmpty ? widget.cars[0].car!.year : "", widget.cars.length > 1 ? widget.cars[1].car!.year : ""),
          _buildComparisonRow("Mileage", widget.cars.isNotEmpty ? widget.cars[0].car!.mileage : "", widget.cars.length > 1 ? widget.cars[1].car!.mileage : ""),
          _buildComparisonRow("Fuel Type", widget.cars.isNotEmpty ? widget.cars[0].car!.fuelType : "", widget.cars.length > 1 ? widget.cars[1].car!.fuelType : ""),
          _buildComparisonRow("Transmission", widget.cars.isNotEmpty ? widget.cars[0].car!.transmission : "", widget.cars.length > 1 ? widget.cars[1].car!.transmission : ""),
          _buildComparisonRow("Seller Type", widget.cars.isNotEmpty ? widget.cars[0].car!.sellerType : "", widget.cars.length > 1 ? widget.cars[1].car!.sellerType : ""),
          // Add more comparison rows as needed
        ]),
      ),
    );
  }


  Widget _buildCarCard(BuildContext context, FeaturedCars? car) {
    return Container(
      height: 240,
      width: 180,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: whiteColor,
        border: Border.all(color: borderColor),
      ),
      child: car != null ? Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                height: 126,
                width: double.infinity,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8.0),
                    topRight: Radius.circular(8.0),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8.0),
                    topRight: Radius.circular(8.0),
                  ),
                  child: CustomImage(
                    path: RemoteUrls.imageUrl(car.thumbImage),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                right: 10.0,
                top: 10.0,
                child: GestureDetector(
                  onTap: () {
                    compareCubit.removeCompareList(car.id.toString());
                    compareCubit.getCompareList();
                  },
                  child: Container(
                      padding: Utils.all(value: 8.0),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.red,
                      ),
                      child: const Icon(
                        Icons.close,
                        color: whiteColor,
                        size: 20.0,
                      )),
                ),
              ),
            ],
          ),
          Padding(
            padding: Utils.symmetric(h: 10.0, v: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: car.title,
                  fontWeight: FontWeight.w500,
                  maxLine: 2,
                ),
                Utils.verticalSpace(10.0),
                CustomText(
                  text: Utils.formatAmount(context, car.regularPrice),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: textColor,
                ),
              ],
            ),
          ),
        ],
      ) : const Center(
        child: CustomText(
          text: "No car selected",
          fontWeight: FontWeight.w500,
          color: textColor,
        ),
      ),
    );
  }

  Widget _buildComparisonRow(String feature, String value1, String value2) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(text: feature, fontWeight: FontWeight.bold),
            CustomText(text: value1),
            CustomText(text: value2),
          ],
        ),
        Utils.verticalSpace(10.0),
        Utils.horizontalLine(),
        Utils.verticalSpace(10.0),
      ],
    );
  }
}

