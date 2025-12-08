import 'package:carsbnb/logic/cubit/profile/profile_cubit.dart';
import 'package:carsbnb/presentation/screen/more_screen/components/profile_picture_view.dart';
import 'package:carsbnb/widgets/custom_app_bar.dart';
import 'package:carsbnb/widgets/custom_form.dart';
import 'package:carsbnb/widgets/custom_text.dart';
import 'package:carsbnb/widgets/loading_widget.dart';
import 'package:carsbnb/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import '../../../../data/model/auth/user_response_model.dart';
import '../../../../logic/cubit/profile/profile_state.dart';
import '../../../../utils/utils.dart';
import '../../../../widgets/fetch_error_text.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late ProfileCubit pCubit;

  @override
  void initState() {
    super.initState();
    pCubit = context.read<ProfileCubit>();
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Profile Setting"),
      body: ListView(
        padding: Utils.symmetric(),
        children: [
          BlocBuilder<ProfileCubit, User>(builder: (context, state) {
            final validate = state.profileState;
            return Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomForm(
                      label: "Full Name",
                      child: TextFormField(
                        initialValue: state.name,
                        onChanged: pCubit.nameChange,
                        decoration:
                            const InputDecoration(hintText: "full name"),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(
                            errorText: 'Please enter an Car Name',
                          ),
                        ]),
                      )),
                  if (validate is UpdateProfileStateFormValidate) ...[
                    if (validate.errors.name.isNotEmpty)
                      FetchErrorText(text: validate.errors.name.first),
                  ]
                ],
              ),
            );
          }),
          Utils.verticalSpace(14.0),
          BlocBuilder<ProfileCubit, User>(builder: (context, state) {
            final validate = state.profileState;
            return Column(
              children: [
                CustomForm(
                    label: "Phone",
                    child: TextFormField(
                      initialValue: state.phone,
                      onChanged: pCubit.phoneChange,
                      decoration: const InputDecoration(hintText: "phone"),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(
                          errorText: 'Please enter an phone number',
                        ),
                      ]),
                    )),
                if (validate is UpdateProfileStateFormValidate) ...[
                  if (validate.errors.phone.isNotEmpty)
                    FetchErrorText(text: validate.errors.phone.first),
                ]
              ],
            );
          }),
          Utils.verticalSpace(14.0),
          BlocBuilder<ProfileCubit, User>(builder: (context, state) {
            final validate = state.profileState;
            return Column(
              children: [
                CustomForm(
                    label: "Designation",
                    child: TextFormField(
                      initialValue: state.designation,
                      onChanged: pCubit.designationChange,
                      decoration:
                          const InputDecoration(hintText: "designation"),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(
                          errorText: 'Please enter an designation',
                        ),
                      ]),
                    )),
                if (validate is UpdateProfileStateFormValidate) ...[
                  if (validate.errors.designation.isNotEmpty)
                    FetchErrorText(text: validate.errors.designation.first),
                ]
              ],
            );
          }),
          Utils.verticalSpace(14.0),
          BlocBuilder<ProfileCubit, User>(builder: (context, state) {
            final validate = state.profileState;
            return Column(
              children: [
                CustomForm(
                    label: "Address",
                    child: TextFormField(
                      initialValue: state.address,
                      onChanged: pCubit.addressChange,
                      decoration: const InputDecoration(hintText: "address"),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(
                          errorText: 'Please enter an address',
                        ),
                      ]),
                    )),
                if (validate is UpdateProfileStateFormValidate) ...[
                  if (validate.errors.address.isNotEmpty)
                    FetchErrorText(text: validate.errors.address.first),
                ]
              ],
            );
          }),
          Utils.verticalSpace(20.0),
          const ProfilePictureView(),
          Utils.verticalSpace(20.0),
          const CustomText(
            text: "Banner Image",
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          Utils.verticalSpace(10.0),
          const ProfileBannerView(),
          Utils.verticalSpace(10.0),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: Utils.symmetric(v: 10.0),
        child: _submitButton(context),
      ),
    );
  }

  Widget _submitButton(BuildContext context) {
    final pCubit = context.read<ProfileCubit>();
    return BlocConsumer<ProfileCubit, User>(listener: (context, state) {
      final profile = state.profileState;
      // if (profile is UpdateProfileStateLoading) {
      //   Utils.loadingDialog(context);
      // } else {
      //   Future.delayed(const Duration(seconds: 1), () {
      //     if (mounted) {
      //       // Check if the widget is still mounted
      //       Utils.closeDialog(context); // Close the dialog after 2 seconds
      //     }
      //   });
        if (profile is UpdateProfileStateError) {
          Utils.failureSnackBar(context, profile.message);
        } else if (profile is UpdateProfileStateLoaded) {
          Utils.successSnackBar(context, profile.message);
          Navigator.pop(context);
          // Future.delayed(Duration(seconds: 1), () {
          //   Navigator.of(context).pop(true);
          // });
        }
     // }
    }, builder: (context, state) {
      final profile = state.profileState;
      if (profile is UpdateProfileStateLoading) {
        return const LoadingWidget();
      }
      return PrimaryButton(
          text: "Update Now",
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              pCubit.updateUserInfo();
              pCubit.getProfileInfo();
            }
          });
    });
  }
}
