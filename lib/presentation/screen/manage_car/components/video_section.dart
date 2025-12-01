import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../../../../data/data_provider/remote_url.dart';
import '../../../../data/model/car/car_state_model.dart';
import '../../../../logic/cubit/manage_car/manage_car_cubit.dart';
import '../../../../logic/cubit/manage_car/manage_car_state.dart';
import '../../../../utils/constraints.dart';
import '../../../../utils/utils.dart';
import '../../../../widgets/custom_form.dart';
import '../../../../widgets/custom_image.dart';
import '../../../../widgets/custom_text.dart';
import '../../../../widgets/fetch_error_text.dart';

class AddVideoImage extends StatelessWidget {
  const AddVideoImage({super.key});

  @override
  Widget build(BuildContext context) {
    final mCubit = context.read<ManageCarCubit>();
    return Column(
      children: [
        BlocBuilder<ManageCarCubit, CarsStateModel>(
          builder: (context, state) {
            final existImage = mCubit.state.tempVideoImage.isNotEmpty
                ? RemoteUrls.imageUrl(mCubit.state.tempVideoImage)
                : state.tempVideoImage;

            final pickImage =
                state.videoImage.isNotEmpty ? state.videoImage : existImage;

            // print('pickImage:$pickImage');
            // print('tempImage:${state.tempImage}');
            final edit = state.manageCarState;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    padding: Utils.symmetric(v: 16.0, h: 0.0),
                    width: double.infinity,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: const Color(0xFFE9EDFF)),
                    child: const CustomText(
                      text: "Video Image",
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                    )),
                Utils.verticalSpace(20.0),
                if (state.videoImage.isEmpty &&
                    state.tempVideoImage.isEmpty) ...[
                  GestureDetector(
                    onTap: () async {
                      final image = await Utils.pickSingleImage();
                      if (image != null && image.isNotEmpty) {
                        mCubit.videoImageChange(image);
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: whiteColor,
                        borderRadius: Utils.borderRadius(),
                      ),
                      child: Center(
                        child: DottedBorder(
                          padding: Utils.symmetric(v: 24.0),
                          borderType: BorderType.RRect,
                          radius: Radius.circular(Utils.radius(10.0)),
                          color: primaryColor,
                          dashPattern: const [6, 3],
                          strokeCap: StrokeCap.square,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.image_outlined,
                                color: primaryColor,
                              ),
                              Utils.verticalSpace(5.0),
                              const CustomText(
                                text: "Choose Image",
                                fontSize: 16.0,
                                fontWeight: FontWeight.w500,
                                color: primaryColor,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ] else ...[
                  Stack(
                    children: [
                      Container(
                        height: Utils.hSize(180.0),
                        margin: Utils.symmetric(v: 16.0, h: 0.0),
                        width: double.infinity,
                        child: ClipRRect(
                          borderRadius: Utils.borderRadius(),
                          child: CustomImage(
                            path: pickImage,
                            isFile: state.videoImage.isNotEmpty,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        right: 10,
                        top: 20,
                        child: InkWell(
                          onTap: () async {
                            final image = await Utils.pickSingleImage();
                            if (image != null && image.isNotEmpty) {
                              mCubit.videoImageChange(image);
                            }
                          },
                          child: const CircleAvatar(
                            maxRadius: 16.0,
                            backgroundColor: Color(0xFFE9D634),
                            child: Icon(Icons.edit,
                                color: Colors.white, size: 20.0),
                          ),
                        ),
                      )
                    ],
                  )
                ],
                if (edit is ManageCarAddFormValidate) ...[
                  if (edit.error.videoImage.isNotEmpty)
                    FetchErrorText(text: edit.error.videoImage.first),
                ]
              ],
            );
          },
        ),
        Utils.verticalSpace(20.0),
        BlocBuilder<ManageCarCubit, CarsStateModel>(builder: (context, state) {
          final validate = state.manageCarState;
          return Column(
            children: [
              CustomForm(
                  label: "Youtube Video Id",
                  child: TextFormField(
                    initialValue: state.videoId,
                    onChanged: mCubit.videoIdChange,
                    decoration:
                        const InputDecoration(hintText: "Youtube Video Id"),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(
                        errorText: 'Please enter  Youtube Video Id',
                      ),
                    ]),
                  )),
              if (validate is ManageCarAddFormValidate) ...[
                if (validate.error.videoId.isNotEmpty)
                  FetchErrorText(text: validate.error.videoId.first),
              ]
            ],
          );
        }),
        Utils.verticalSpace(10.0),
        BlocBuilder<ManageCarCubit, CarsStateModel>(builder: (context, state) {
          final validate = state.manageCarState;
          return Column(
            children: [
              CustomForm(
                  label: "Video Description",
                  child: TextFormField(
                    initialValue: state.videoDescription,
                    onChanged: mCubit.videoDescriptionChange,
                    decoration: const InputDecoration(hintText: "description"),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(
                        errorText: 'Please enter Video description',
                      ),
                    ]),
                  )),
              if (validate is ManageCarAddFormValidate) ...[
                if (validate.error.videoId.isNotEmpty)
                  FetchErrorText(text: validate.error.videoId.first),
              ]
            ],
          );
        }),
      ],
    );
  }
}
