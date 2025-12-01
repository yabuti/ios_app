import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/model/car/car_state_model.dart';
import '../../../../data/model/search_attribute/search_attribute_model.dart';
import '../../../../logic/cubit/all_cars/all_cars_cubit.dart';
import '../../../../logic/cubit/manage_car/manage_car_cubit.dart';
import '../../../../logic/cubit/manage_car/manage_car_state.dart';
import '../../../../utils/utils.dart';
import '../../../../widgets/custom_form.dart';
import '../../../../widgets/custom_text.dart';
import '../../../../widgets/fetch_error_text.dart';
import 'package:blackdiamondcar/data/model/home/home_model.dart' as home_model;

class StepFourAddressWidget extends StatefulWidget {
  const StepFourAddressWidget({super.key});

  @override
  State<StepFourAddressWidget> createState() => _StepFourAddressWidgetState();
}

class _StepFourAddressWidgetState extends State<StepFourAddressWidget> {
  late AllCarsCubit carsCubit;
  CountryModel? _countryModel;
  home_model.City? _cities; // at class level

  @override
  void initState() {
    super.initState();
    carsCubit = context.read<AllCarsCubit>();
  }

  @override
  Widget build(BuildContext context) {
    final mCubit = context.read<ManageCarCubit>();
    return Column(
      children: [
        BlocBuilder<ManageCarCubit, CarsStateModel>(
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (mCubit.carEditDataModel != null &&
                    mCubit.carEditDataModel!.countries!.isNotEmpty)
                  CustomForm(
                    label: 'Country',
                    bottomSpace: 14.0,
                    child: DropdownButtonFormField<CountryModel>(
                      hint: const CustomText(text: "country"),
                      isDense: true,
                      isExpanded: true,
                      value: _countryModel,
                      icon: const Icon(Icons.keyboard_arrow_down),
                      decoration: InputDecoration(
                        isDense: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                              Radius.circular(Utils.radius(10.0))),
                        ),
                        contentPadding:
                            const EdgeInsets.fromLTRB(16.0, 20.0, 20.0, 10.0),
                      ),
                      onTap: () => Utils.closeKeyBoard(context),
                      onChanged: (value) {
                        if (value == null) return;
                        setState(() {
                          _countryModel = value;
                          _cities = null; // Reset city model
                        });
                        mCubit.countryIdChange(value.id.toString());
                        carsCubit.getCity(value.id.toString());
                      },
                      items: mCubit.carEditDataModel!.countries!
                          .map<DropdownMenuItem<CountryModel>>(
                            (CountryModel value) =>
                                DropdownMenuItem<CountryModel>(
                              value: value,
                              child: CustomText(text: value.name),
                            ),
                          )
                          .toList(),
                    ),
                  ),
              ],
            );
          },
        ),
        BlocBuilder<ManageCarCubit, CarsStateModel>(
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (carsCubit.cityModel != null &&
                    carsCubit.cityModel!.cities!.isNotEmpty)
                  CustomForm(
                    label: 'Select Your City',
                    bottomSpace: 14.0,
                    child: DropdownButtonFormField<home_model.City>(
                      hint: const CustomText(text: "City"),
                      isDense: true,
                      isExpanded: true,
                      value:
                          _cities, // _cities must be of type home_model.City?
                      icon: const Icon(Icons.keyboard_arrow_down),
                      decoration: InputDecoration(
                        isDense: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                              Radius.circular(Utils.radius(10.0))),
                        ),
                        contentPadding:
                            const EdgeInsets.fromLTRB(16.0, 20.0, 20.0, 10.0),
                      ),
                      onTap: () => Utils.closeKeyBoard(context),
                      onChanged: (home_model.City? value) {
                        if (value == null) return;
                        setState(() {
                          _cities =
                              value; // _cities must also be home_model.City?
                        });
                        carsCubit.locationChange(
                            value.id.toString()); // call cubit method
                      },
                      items: carsCubit.cityModel!.cities!
                          .map<DropdownMenuItem<home_model.City>>(
                            (home_model.City value) =>
                                DropdownMenuItem<home_model.City>(
                              value: value,
                              child: CustomText(text: value.name),
                            ),
                          )
                          .toList(),
                    ),
                  ),
              ],
            );
          },
        ),
        BlocBuilder<ManageCarCubit, CarsStateModel>(builder: (context, state) {
          final validate = state.manageCarState;
          return Column(
            children: [
              CustomForm(
                  label: "Address ",
                  child: TextFormField(
                    initialValue: state.address,
                    onChanged: mCubit.addressChange,
                    decoration: const InputDecoration(hintText: "Address "),
                  )),
            ],
          );
        }),
        Utils.verticalSpace(14.0),
        BlocBuilder<ManageCarCubit, CarsStateModel>(builder: (context, state) {
          final validate = state.manageCarState;
          return Column(
            children: [
              CustomForm(
                  label: "Google Map Embed Link ",
                  child: TextFormField(
                    initialValue: state.googleMap,
                    onChanged: mCubit.googleMapChange,
                    decoration:
                        const InputDecoration(hintText: "google embed code "),
                  )),
              if (validate is ManageCarAddFormValidate) ...[
                if (validate.error.address.isNotEmpty)
                  FetchErrorText(text: validate.error.address.first),
              ]
            ],
          );
        }),
      ],
    );
  }
}
