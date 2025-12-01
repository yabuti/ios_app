import 'package:blackdiamondcar/data/model/home/home_model.dart';
import 'package:blackdiamondcar/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

import '../../../../utils/constraints.dart';
import '../../../../utils/utils.dart';

class DetailsTabContent extends StatefulWidget {
  const DetailsTabContent({super.key, required this.cars});

  final FeaturedCars cars;

  @override
  State<DetailsTabContent> createState() => _DetailsTabContentState();
}

class _DetailsTabContentState extends State<DetailsTabContent> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4.0),
              border: Border.all(color: borderColor)),
          child: Padding(
            padding: Utils.all(value: 10.0),
            child:  Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomText(text: "Description",fontWeight: FontWeight.w500,fontSize: 14.0,),
                Utils.verticalSpace(10.0),
                Container(
                  height: 1,
                  width: double.infinity,
                  color: borderColor,
                ),
                Utils.verticalSpace(10.0),
                 ReadMoreText(
                   Utils.htmlTextConverter(widget.cars.description),
                  trimLength: 195,
                  trimCollapsedText: 'View More',
                  moreStyle:
                      const TextStyle(fontSize: 16.0, color: textColor, height: 1.6),
                  lessStyle:
                      const TextStyle(fontSize: 16.0, color: redColor, height: 1.6),
                  style: const TextStyle(
                    fontSize: 14.0,
                    color: blackColor,
                  ),
                ),
              ],
            ),
          ),
        ),
        Utils.verticalSpace(14.0),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4.0),
              border: Border.all(color: borderColor)),
          child: Padding(
            padding: Utils.all(value: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomText(
                  text: 'Specification',
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                Utils.verticalSpace(10.0),
                Container(
                  height: 1,
                  width: double.infinity,
                  color: borderColor,
                ),
                Utils.verticalSpace(10.0),
                Table(
                  columnWidths: const {
                    2: IntrinsicColumnWidth(), // For label column
                    1: FlexColumnWidth(), // For value column
                  },
                  children: [
                    _buildTableRow("Body Type:", widget.cars.bodyType),
                    _buildTableRow("Engine Size:", widget.cars.engineSize),
                    _buildTableRow("Drive:", widget.cars.drive),
                    _buildTableRow("Exterior Color:", widget.cars.exteriorColor),
                    _buildTableRow("Year:", widget.cars.year),
                    _buildTableRow("AC:", widget.cars.acCondation),
                    _buildTableRow("Mileage:", widget.cars.mileage),
                    _buildTableRow("Car Type:", widget.cars.brands!.name),
                    _buildTableRow("Fuel Type:", widget.cars.fuelType),
                    _buildTableRow("Transmission:",widget.cars.transmission),
                    _buildTableRow("Number of Seats:", widget.cars.numberOfOwner),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  TableRow _buildTableRow(String label, String value) {
    return TableRow(

      children: [
        Padding(
            padding: const EdgeInsets.symmetric(vertical: 6.0),
            child: CustomText(
              text: label,
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: sTextColor,
            )),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 6.0),
          child: Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 14.0,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}
