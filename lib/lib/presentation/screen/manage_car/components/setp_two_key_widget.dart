import 'package:carsbnb/data/model/car/car_state_model.dart';
import 'package:carsbnb/logic/cubit/manage_car/manage_car_cubit.dart';
import 'package:carsbnb/logic/cubit/manage_car/manage_car_state.dart';
import 'package:carsbnb/utils/utils.dart';
import 'package:carsbnb/widgets/custom_form.dart';
import 'package:carsbnb/widgets/fetch_error_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/dummy_data/dummy_data_model.dart';
import '../../../../widgets/custom_text.dart';

class StepTwoKeyWidget extends StatefulWidget {
  const StepTwoKeyWidget({super.key});

  @override
  State<StepTwoKeyWidget> createState() => _StepTwoKeyWidgetState();
}

class _StepTwoKeyWidgetState extends State<StepTwoKeyWidget> {


  SellerType? _sellerType;
  @override
  Widget build(BuildContext context) {
    final mCubit = context.read<ManageCarCubit>();
    return Column(
      children: [
        BlocBuilder<ManageCarCubit, CarsStateModel>(
          builder: (context, state) {
            final validate = state.manageCarState;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomForm(
                  label: 'Seller Type',
                  bottomSpace: 14.0,
                  child: DropdownButtonFormField<SellerType>(
                    hint: const CustomText(text: "Seller Type"),
                    isDense: true,
                    isExpanded: true,
                    initialValue: _sellerType,
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
                        _sellerType = value;
                      });
                      mCubit.sellerTypeChange(value.id.toString());
                    },
                    items: sellerList
                        .map<DropdownMenuItem<SellerType>>(
                          (SellerType value) => DropdownMenuItem<SellerType>(
                        value: value,
                        child: CustomText(text: value.name),
                      ),
                    )
                        .toList(),
                  ),
                ),
                if (validate is ManageCarAddFormValidate) ...[
                  if (validate.error.sellerType.isNotEmpty)
                    FetchErrorText(text: validate.error.sellerType.first),
                ],
                CustomForm(
                    label: "Body Type",
                    child: TextFormField(
                      initialValue: state.bodyType,
                      onChanged: mCubit.bodyTypeChange,
                      decoration: const InputDecoration(hintText: "body type"),

                    )),
                if (validate is ManageCarAddFormValidate) ...[
                  if (validate.error.bodyType.isNotEmpty)
                    FetchErrorText(text: validate.error.bodyType.first),
                ],
                Utils.verticalSpace(14.0),
                CustomForm(
                    label: "Engine Size",
                    child: TextFormField(
                      initialValue: state.engineSize,
                      onChanged: mCubit.engineSizeChange,
                      decoration:
                      const InputDecoration(hintText: "engine Size"),

                    )),
                if (validate is ManageCarAddFormValidate) ...[
                  if (validate.error.engineSize.isNotEmpty)
                    FetchErrorText(text: validate.error.engineSize.first),
                ],
                Utils.verticalSpace(14.0),
                CustomForm(
                    label: "Drive",
                    child: TextFormField(
                      initialValue: state.drive,
                      onChanged: mCubit.driveChange,
                      decoration: const InputDecoration(hintText: "drive"),

                    )),
                if (validate is ManageCarAddFormValidate) ...[
                  if (validate.error.drive.isNotEmpty)
                    FetchErrorText(text: validate.error.drive.first),
                ],
                Utils.verticalSpace(14.0),
                CustomForm(
                    label: "Interior Color",
                    child: TextFormField(
                      initialValue: state.interiorColor,
                      onChanged: mCubit.interiorColorChange,
                      decoration:
                      const InputDecoration(hintText: "Interior Color"),

                    )),
                if (validate is ManageCarAddFormValidate) ...[
                  if (validate.error.interiorColor.isNotEmpty)
                    FetchErrorText(text: validate.error.interiorColor.first),
                ],
                Utils.verticalSpace(14.0),
                CustomForm(
                    label: "Exterior Color",
                    child: TextFormField(
                      initialValue: state.exteriorColor,
                      onChanged: mCubit.exteriorColorChange,
                      decoration:
                      const InputDecoration(hintText: "Exterior Color"),

                    )),
                if (validate is ManageCarAddFormValidate) ...[
                  if (validate.error.exteriorColor.isNotEmpty)
                    FetchErrorText(text: validate.error.exteriorColor.first),
                ],
                Utils.verticalSpace(14.0),
                CustomForm(
                    label: "Year",
                    child: TextFormField(
                      key: const ValueKey("year-filed"),
                      initialValue: state.year,
                      onChanged: mCubit.yearChange,
                      decoration: const InputDecoration(hintText: "Year"),
                    )),
                if (validate is ManageCarAddFormValidate) ...[
                  if (validate.error.year.isNotEmpty)
                    FetchErrorText(text: validate.error.year.first),
                ],
                Utils.verticalSpace(14.0),
                CustomForm(
                    label: "Mileage",
                    child: TextFormField(
                      initialValue: state.mileage,
                      onChanged: mCubit.mileageChange,
                      decoration: const InputDecoration(hintText: "Mileage"),
                    )),
                if (validate is ManageCarAddFormValidate) ...[
                  if (validate.error.mileage.isNotEmpty)
                    FetchErrorText(text: validate.error.mileage.first),
                ],
                Utils.verticalSpace(14.0),
                CustomForm(
                    label: "Number of Owner",
                    child: TextFormField(
                      initialValue: state.numberOfOwner,
                      onChanged: mCubit.numberOfOwnerChange,
                      decoration:
                      const InputDecoration(hintText: "Number of Owner"),
                    )),
                if (validate is ManageCarAddFormValidate) ...[
                  if (validate.error.numberOfSeat.isNotEmpty)
                    FetchErrorText(text: validate.error.numberOfSeat.first),
                ],
                Utils.verticalSpace(14.0),
                CustomForm(
                    label: "Fuel Type",
                    child: TextFormField(
                      initialValue: state.fuelType,
                      onChanged: mCubit.fuelTypeChange,
                      decoration: const InputDecoration(hintText: "Fuel Type"),
                    )),
                if (validate is ManageCarAddFormValidate) ...[
                  if (validate.error.fuelType.isNotEmpty)
                    FetchErrorText(text: validate.error.fuelType.first),
                ],
                Utils.verticalSpace(14.0),
                CustomForm(
                    label: "Transmission",
                    child: TextFormField(
                      initialValue: state.transmission,
                      onChanged: mCubit.transmissionChange,
                      decoration:
                      const InputDecoration(hintText: "Transmission"),
                    )),
                if (validate is ManageCarAddFormValidate) ...[
                  if (validate.error.transmission.isNotEmpty)
                    FetchErrorText(text: validate.error.transmission.first),
                ],
                Utils.verticalSpace(14.0),

              ],
            );
          },
        ),

      ],
    );
  }
}
