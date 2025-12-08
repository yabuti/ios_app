import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../logic/cubit/all_cars/all_cars_cubit.dart';
import '../../../../utils/constraints.dart';
import '../../../../utils/utils.dart';
import '../../../../widgets/custom_text.dart';

class FeatureSelector extends StatefulWidget {
  final AllCarsCubit carsCubit;

  const FeatureSelector({super.key, required this.carsCubit});

  @override
  _FeatureSelectorState createState() => _FeatureSelectorState();
}

class _FeatureSelectorState extends State<FeatureSelector> {
  final List<int> _selectedIndices = []; // Track selected indices

  @override
  Widget build(BuildContext context) {
    final carsCubit = widget.carsCubit;
    final featureList = carsCubit.searchAttributeModel!.features!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CustomText(
          text: "Select Feature",
          fontSize: 16.0,
          fontWeight: FontWeight.w400,
        ),
        Utils.verticalSpace(10.0),
        Wrap(
          spacing: 10.0,
          runSpacing: 10.0,
          children: List.generate(featureList.length, (index) {
            final featureName = featureList[index];

            // Determine selection state and background color
            final isSelected = _selectedIndices.contains(index);
            final backgroundColor = isSelected
                ? primaryColor
                : (index == 0 ? Colors.transparent : Colors.white);

            return GestureDetector(
              onTap: () {
                setState(() {
                  if (isSelected) {
                    _selectedIndices.remove(index); // Deselect
                  } else {
                    _selectedIndices.add(index); // Select
                  }

                  // Get selected feature names based on _selectedIndices
                  final selectedFeatureNames = _selectedIndices
                      .map((i) => featureList[i].name) // Map indices to feature names
                      .where((name) => name != null) // Exclude null values
                      .toList();

                  // Pass selected feature names to the Cubit
                  context.read<AllCarsCubit>().featureChange(selectedFeatureNames.cast<String>());
                });
              },
              child: Container(
                padding: Utils.symmetric(h: 10.0, v: 6.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(45.0),
                  color: backgroundColor,
                  border: Border.all(color: borderColor),
                ),
                child: CustomText(
                  text: featureName.name,
                  color: isSelected ? whiteColor : Colors.black,
                ),
              ),
            );
          }),
        ),
      ],
    );
  }
}

