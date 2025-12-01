
import 'package:blackdiamondcar/logic/cubit/manage_car/manage_car_cubit.dart';
import 'package:blackdiamondcar/widgets/custom_app_bar.dart';
import 'package:blackdiamondcar/widgets/fetch_error_text.dart';
import 'package:blackdiamondcar/widgets/loading_widget.dart';
import 'package:blackdiamondcar/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/model/car/car_state_model.dart';
import '../../../logic/cubit/all_cars/all_cars_cubit.dart';
import '../../../logic/cubit/manage_car/getCarCreatedata/car_create_data_cubit.dart';
import '../../../logic/cubit/manage_car/manage_car_state.dart';
import '../../../routes/route_names.dart';
import '../../../utils/utils.dart';
import '../../../widgets/custom_text.dart';
import 'components/setp_two_key_widget.dart';
import 'components/add_car_image.dart';
import 'components/add_car_step_components.dart';
import 'components/step_four_address_widget.dart';
import 'components/step_one_basic_widget.dart';
import 'components/video_section.dart';

class AddCarScreen extends StatefulWidget {
  const AddCarScreen({super.key, required this.id});

  final String id;

  @override
  State<AddCarScreen> createState() => _AddCarScreenState();
}

class _AddCarScreenState extends State<AddCarScreen> with WidgetsBindingObserver {
  late ManageCarCubit mCubit;
  late String _carId;
  bool _isKeyboardVisible = false;

  @override
  void initState() {
    super.initState();
    mCubit = context.read<ManageCarCubit>();

    _carId = widget.id;
    // Only load edit data if editing an existing car
    // For new cars, just show the form without loading data
    if (_carId.isNotEmpty) {
      mCubit.getCarEditData(_carId);
    }
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    final bottomInset = WidgetsBinding.instance.window.viewInsets.bottom;
    setState(() {
      _isKeyboardVisible = bottomInset > 0;
    });
  }

  int activeStep = 1;

  void onStepSelected(int step) {
    if (_carId.isNotEmpty) {
      setState(() {
        activeStep = step;
});
    }
  }

  // Subscription check removed - users can add cars without subscription

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          CustomAppBar(title: _carId.isNotEmpty ? "Update Car" : "Add a Car"),
      body: Padding(
        padding: Utils.symmetric(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomStepIndicator(
              currentStep: activeStep,
              totalSteps: 5,
              stepLabels: const [
                "Basic",
                "Key Info",
                "Feature",
                "Address",
                "Gallery"
              ],
              onStepSelected: onStepSelected,
            ),
            const SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: Utils.logout(
                  child: BlocConsumer<ManageCarCubit, CarsStateModel>(
                      listener: (context, state) {
                    final edit = state.manageCarState;
                    if (edit is GetCarEditDataError) {
                      // Only retry on 503 errors
                      if (edit.statusCode == 503) {
                        mCubit.getCarEditData(_carId);
                      }
                      // Don't auto-logout on 401 - just show error
                      // User can manually logout if needed
                    }
                  }, builder: (context, state) {
                    final edit = state.manageCarState;
                    
                    // If adding a new car (empty _carId), just show the form
                    if (_carId.isEmpty) {
                      return LoadedForm(id: _carId, step: activeStep);
                    }
                    
                    // If editing an existing car, wait for data to load
                    if (edit is GetCarEditDataLoading) {
                      return const LoadingWidget();
                    } else if (edit is GetCarEditDataError) {
                      return FetchErrorText(text: edit.message);
                    } else if (edit is GetCarEditDataLoaded) {
                      return LoadedForm(id: _carId, step: activeStep);
                    }
                    
                    // Default: show the form
                    return LoadedForm(id: _carId, step: activeStep);
                  }),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(
          left: 20.0,
          right: 20.0,
          bottom: _isKeyboardVisible ? MediaQuery.of(context).viewInsets.bottom : 10.0,
        ),
        child: BlocConsumer<ManageCarCubit, CarsStateModel>(
            listener: (context, state) {
          final car = state.manageCarState;
          if (car is ManageCarAddStateLoading) {
            print('Opening loading dialog');
            Utils.loadingDialog(context);
          } else {
            Future.delayed(const Duration(seconds: 2), () {
              if (mounted) {
                Utils.closeDialog(context);
              }
            });
            if (car is ManageCarAddStateError) {
              // Show error message directly without subscription check
              Utils.failureSnackBar(context, car.message);
            } else if (car is ManageCarAddStateSuccess) {
              Utils.successSnackBar(context, car.createModelResponse.message);
              mCubit.getCarEditData(car.createModelResponse.car!.id.toString());
              setState(() {
                _carId = car.createModelResponse.car!.id.toString();
                activeStep = 2; // Navigate to step 2
              });
            }
          }
        }, builder: (context, state) {
          return PrimaryButton(
              text: _carId.isNotEmpty
                  ? activeStep == 5 ? "Submit Now" : "Update Now"
                  : activeStep == 5 ? "Submit Now" : "Save & Next",
              onPressed: () {
                if (_carId.isNotEmpty) {
                  if (activeStep == 1) {
                    mCubit.updateBasicCar(_carId);
                  }
                  if (activeStep == 2) {
                    mCubit.keyFeatureUpdateCar(_carId);
                  } else if (activeStep == 3) {
                    mCubit.featureUpdateCar(_carId);
                  } else if (activeStep == 4) {
                    mCubit.addressUpdateCar(_carId);
                  } else if (activeStep == 5) {
                    mCubit.galleryUpdateCar(_carId);
                  }
                } else {
                  if (activeStep == 1) {
                    mCubit.addCar();
                    mCubit.clearStep2Fields(); // Clear step 2 fields
                  }
                }
              });
        }),
      ),
    );
  }
}

class LoadedForm extends StatefulWidget {
  const LoadedForm({super.key, required this.id, required this.step});

  final String id;
  final int step;

  @override
  State<LoadedForm> createState() => _LoadedFormState();
}

class _LoadedFormState extends State<LoadedForm> {
  late ManageCarCubit mCubit;
  late CarCreateDataCubit cCubit;
  late AllCarsCubit carsCubit;

  @override
  void initState() {
    super.initState();
    mCubit = context.read<ManageCarCubit>();
    cCubit = context.read<CarCreateDataCubit>();
    carsCubit = context.read<AllCarsCubit>();
  }

  final List<int> _selectedIndices = [];
  @override
  Widget build(BuildContext context) {
    if (widget.id.isNotEmpty) {
      mCubit.translateIdChange(
          mCubit.carEditDataModel?.carTranslate?.id.toString() ?? '');
    }
    final featureList = mCubit.carEditDataModel?.features ?? [];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.step == 1) ...[
          const StepOneBasicWidget(),

        ] else if (widget.step == 2) ...[
          const StepTwoKeyWidget()
        ] else if (widget.step == 3) ...[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomText(
                text: "Select Feature",
                fontSize: 16.0,
                fontWeight: FontWeight.w400,
              ),
              Utils.verticalSpace(10.0),
              SizedBox(
                height: MediaQuery.of(context).size.height *
                    0.65, // Set a fixed height to enable scrolling
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: featureList.length,
                  itemBuilder: (context, index) {
                    final featureName = featureList[index];

                    // Determine selection state
                    final isSelected = _selectedIndices.contains(index);

                    return CheckboxListTile(
                      title: CustomText(text: featureName.name),
                      value: isSelected,
                      onChanged: (bool? value) {
                        setState(() {
                          if (value == true) {
                            _selectedIndices.add(index); // Select
                          } else {
                            _selectedIndices.remove(index); // Deselect
                          }

                          // Get selected feature names based on _selectedIndices
                          final selectedFeatureNames = _selectedIndices
                              .map((i) => featureList[i]
                                  .name) // Map indices to feature names
                              .where(
                                  (name) => name != null) // Exclude null values
                              .toList();

                          // Pass selected feature names to the Cubit
                          mCubit.featureIdChange(
                              selectedFeatureNames.cast<String>());
                        });
                      },
                    );
                  },
                ),
              ),
            ],
          )
        ] else if (widget.step == 4) ...[
          const StepFourAddressWidget(),
        ] else if (widget.step == 5) ...[
          const AddCarImage(),
          Utils.verticalSpace(50.0),
          const GalleryCarImage(),
          const AddVideoImage(),
          Utils.verticalSpace(20.0),
        ],
      ],
    );
  }
}
