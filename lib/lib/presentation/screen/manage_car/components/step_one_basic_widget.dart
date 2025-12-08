import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/dummy_data/dummy_data_model.dart';
import '../../../../data/model/car/car_state_model.dart';
import '../../../../data/model/home/home_model.dart';
import '../../../../logic/cubit/manage_car/getCarCreatedata/car_create_data_cubit.dart';
import '../../../../logic/cubit/manage_car/manage_car_cubit.dart';
import '../../../../logic/cubit/manage_car/manage_car_state.dart';
import '../../../../utils/utils.dart';
import '../../../../widgets/custom_form.dart';
import '../../../../widgets/custom_text.dart';
import '../../../../widgets/fetch_error_text.dart';

class StepOneBasicWidget extends StatefulWidget {
  const StepOneBasicWidget({super.key});

  @override
  State<StepOneBasicWidget> createState() => _StepOneBasicWidgetState();
}

class _StepOneBasicWidgetState extends State<StepOneBasicWidget> {
  late ManageCarCubit mCubit;
  late CarCreateDataCubit cCubit;
  Brands? _brands;
  Condition? _condition;
  @override
  void initState() {
    super.initState();
    mCubit = context.read<ManageCarCubit>();
    cCubit = context.read<CarCreateDataCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      BlocBuilder<ManageCarCubit, CarsStateModel>(
          builder: (context, state) {
            // log(state.toString(),name: "omar_faruk");
            final validate = state.manageCarState;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomForm(
                    label: "Car Name",
                    child: TextFormField(
                      initialValue: state.title,
                      onChanged: (text) {
                        final slug = Utils.convertToSlug(text);
                        mCubit.titleChange(text);
                        mCubit.slugChange(slug);
                        mCubit.slugController.text = slug;
                      },
                      decoration: const InputDecoration(hintText: "car name"),
                    )),
                if (validate is ManageCarAddFormValidate) ...[
                  if (validate.error.title.isNotEmpty)
                    FetchErrorText(text: validate.error.title.first),
                ],
                Utils.verticalSpace(14.0),
                CustomForm(
                    label: "Slug",
                    child: TextFormField(
                      controller: mCubit.slugController,
                      // initialValue: state.slug,
                      onChanged: mCubit.slugChange,
                      decoration: const InputDecoration(hintText: "slug"),
                    )),
                if (validate is ManageCarAddFormValidate) ...[
                  if (validate.error.slug.isNotEmpty)
                    FetchErrorText(text: validate.error.slug.first),
                ]
              ],
            );
          }),
      Utils.verticalSpace(14.0),
      BlocBuilder<ManageCarCubit, CarsStateModel>(
        builder: (context, state) {
          final validate = state.manageCarState;
          // Update the category and subcategory models based on current state
          if (state.brandId.isNotEmpty &&
              cCubit.carCreateDataModel?.brands?.isNotEmpty == true) {
            // Use `orElse` to avoid "No element" error if not found
            _brands = cCubit.carCreateDataModel!.brands!.firstWhere(
                  (e) => e.id.toString() == state.brandId,
              orElse: () => cCubit.carCreateDataModel!.brands!.first,
            );
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (cCubit.carCreateDataModel != null &&
                  cCubit.carCreateDataModel!.brands!.isNotEmpty)
                CustomForm(
                  label: 'Brand ID',
                  bottomSpace: 14.0,
                  child: DropdownButtonFormField<Brands>(
                    hint: const CustomText(text: "Brand ID"),
                    isDense: true,
                    isExpanded: true,
                    initialValue: _brands,
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
                        _brands = value;
                      });
                      mCubit.brandIdChange(value.id.toString());
                    },
                    items: cCubit.carCreateDataModel!.brands!
                        .map<DropdownMenuItem<Brands>>(
                          (Brands value) => DropdownMenuItem<Brands>(
                        value: value,
                        child: CustomText(text: value.name),
                      ),
                    )
                        .toList(),
                  ),
                ),
              if (validate is ManageCarAddFormValidate) ...[
                if (validate.error.brandId.isNotEmpty)
                  FetchErrorText(text: validate.error.brandId.first),
              ]
            ],
          );
        },
      ),
      BlocBuilder<ManageCarCubit, CarsStateModel>(
        builder: (context, state) {
          final validate = state.manageCarState;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomForm(
                label: 'Condition',
                bottomSpace: 14.0,
                child: DropdownButtonFormField<Condition>(
                  hint: const CustomText(text: "Condition"),
                  isDense: true,
                  isExpanded: true,
                  initialValue: _condition,
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
                      _condition = value;
                    });
                    mCubit.conditionChange(value.id.toString());
                  },
                  items: conditionList
                      .map<DropdownMenuItem<Condition>>(
                        (Condition value) => DropdownMenuItem<Condition>(
                      value: value,
                      child: CustomText(text: value.name),
                    ),
                  )
                      .toList(),
                ),
              ),
              if (validate is ManageCarAddFormValidate) ...[
                if (validate.error.condition.isNotEmpty)
                  FetchErrorText(text: validate.error.condition.first),
              ]
            ],
          );
        },
      ),
      BlocBuilder<ManageCarCubit, CarsStateModel>(
          builder: (context, state) {
            final validate = state.manageCarState;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomForm(
                    label: "Regular Price",
                    child: TextFormField(
                      initialValue: state.regularPrice,
                      onChanged: mCubit.regularPriceChange,
                      keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                      inputFormatters: Utils.inputFormatter,
                      decoration:
                      const InputDecoration(hintText: "regular price"),
                    )),
                if (validate is ManageCarAddFormValidate) ...[
                  if (validate.error.regularPrice.isNotEmpty)
                    FetchErrorText(text: validate.error.regularPrice.first),
                ],
                Utils.verticalSpace(14.0),
                CustomForm(
                    label: "Offer Price",
                    child: TextFormField(
                      initialValue: state.offerPrice,
                      onChanged: mCubit.offerPriceChange,
                      keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                      inputFormatters: Utils.inputFormatter,
                      decoration:
                      const InputDecoration(hintText: "offer price"),
                    )),
                if (validate is ManageCarAddFormValidate) ...[
                  if (validate.error.offerPrice.isNotEmpty)
                    FetchErrorText(text: validate.error.offerPrice.first),
                ],
                Utils.verticalSpace(14.0),
                CustomForm(
                    label: "Description",
                    child: TextFormField(
                      initialValue: state.description,
                      onChanged: mCubit.descriptionChange,
                      decoration:
                      const InputDecoration(hintText: "description"),
                      maxLines: 4,
                    )),
                if (validate is ManageCarAddFormValidate) ...[
                  if (validate.error.description.isNotEmpty)
                    FetchErrorText(text: validate.error.description.first),
                ],
                Utils.verticalSpace(14.0),
                CustomForm(
                    label: "SEO title ",
                    child: TextFormField(
                      initialValue: state.seoTitle,
                      onChanged: mCubit.seoTitleChange,
                      decoration: const InputDecoration(hintText: "SEO title "),
                    )),
                if (validate is ManageCarAddFormValidate) ...[
                  if (validate.error.seoTitle.isNotEmpty)
                    FetchErrorText(text: validate.error.seoTitle.first),
                ],
                Utils.verticalSpace(14.0),
                CustomForm(
                    label: "SEO Description ",
                    child: TextFormField(
                      initialValue: state.seoDescription,
                      onChanged: mCubit.seoDescriptionChange,
                      decoration:
                      const InputDecoration(hintText: "SEO Description "),
                    )),
                if (validate is ManageCarAddFormValidate) ...[
                  if (validate.error.seoDescription.isNotEmpty)
                    FetchErrorText(text: validate.error.seoDescription.first),
                ],
                Utils.verticalSpace(14.0),
              ],
            );
          }),
    ],);
  }
}
