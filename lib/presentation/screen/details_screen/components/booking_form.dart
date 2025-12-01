import 'package:blackdiamondcar/utils/constraints.dart';
import 'package:blackdiamondcar/widgets/custom_app_bar.dart';
import 'package:blackdiamondcar/widgets/custom_text.dart';
import 'package:flutter/material.dart';

import '../../../../data/dummy_data.dart';
import '../../../../utils/utils.dart';
import '../../../../widgets/custom_form.dart';
import '../../../../widgets/primary_button.dart';

class BookingForm extends StatelessWidget {
  const BookingForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Car Booking"),
      body: Padding(
        padding: Utils.symmetric(),
        child: Column(children: [
          Container(
            height: 40.0,
            width: double.infinity,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(4.0),
                topRight: Radius.circular(4.0),
              ),
              color: Color(0xFFE8EFFF)
            ),
            child: const Center(child: CustomText(text: "Booking Form", fontWeight: FontWeight.w600,fontSize: 14,)),
          ),
          Container(
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(4.0),
                  bottomLeft: Radius.circular(4.0),
                ),
                color: whiteColor
            ),
            child: Padding(
              padding: Utils.symmetric(),
              child: Column(children: [
                Utils.verticalSpace(14.0),
                CustomForm(
                  label: 'Pickup Location',
                  child: DropdownButtonFormField<DummyCategoryModel>(
                    hint: const CustomText(text: "Category"),
                    isDense: true,
                    isExpanded: true,
                    // value: _categories!,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    decoration: InputDecoration(
                      isDense: true,
                      border: OutlineInputBorder(
                        borderRadius:
                        BorderRadius.all(Radius.circular(Utils.radius(10.0))),
                      ),
                    ),
                    onTap: () => Utils.closeKeyBoard(context),
                    onChanged: (value) {
                      if (value == null) return;
                      //serviceCubit.changeCategoryId(value.id.toString());
                    },
                    items: locationList
                        .map<DropdownMenuItem<DummyCategoryModel>>(
                            (DummyCategoryModel value) =>
                            DropdownMenuItem<DummyCategoryModel>(
                                value: value,
                                child: CustomText(
                                  text: value.name,
                                  fontFamily: bold700,
                                  fontSize: 16.0,
                                )))
                        .toList(),
                  ),
                ),
                Utils.verticalSpace(12.0),
                CustomForm(
                  label: 'Dropoff Location',
                  child: DropdownButtonFormField<DummyCategoryModel>(
                    hint: const CustomText(text: "Category"),
                    isDense: true,
                    isExpanded: true,
                    // value: _categories!,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    decoration: InputDecoration(
                      isDense: true,
                      border: OutlineInputBorder(
                        borderRadius:
                        BorderRadius.all(Radius.circular(Utils.radius(10.0))),
                      ),
                    ),
                    onTap: () => Utils.closeKeyBoard(context),
                    onChanged: (value) {
                      if (value == null) return;
                      //serviceCubit.changeCategoryId(value.id.toString());
                    },
                    items: locationList
                        .map<DropdownMenuItem<DummyCategoryModel>>(
                            (DummyCategoryModel value) =>
                            DropdownMenuItem<DummyCategoryModel>(
                                value: value,
                                child: CustomText(
                                  text: value.name,
                                  fontFamily: bold700,
                                  fontSize: 16.0,
                                )))
                        .toList(),
                  ),
                ),
                Utils.verticalSpace(12.0),
                CustomForm(
                    label: 'Booking Note',
                    child: TextFormField(
                      decoration: const InputDecoration(
                        hintText: 'Write something',
                      ),
                      maxLines: 4,
                      keyboardType: TextInputType.emailAddress,
                    )),
                Utils.verticalSpace(14.0),
              ],),
            ),
          )
        ],),
      ),
      bottomNavigationBar: Padding(
        padding: Utils.symmetric(h: 20.0, v: 10.0),
        child: PrimaryButton(
          text: 'Booking Now',
          onPressed: ()  {
           // Navigator.pushNamed(context, RouteNames.paymentScreen);
          },
        ),
      ),
    );
  }
}
