import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../logic/cubit/all_cars/all_cars_cubit.dart';
import '../../../../utils/constraints.dart';
import '../../../../utils/utils.dart';
import '../../../../widgets/custom_text.dart';

class PurposeSelector extends StatefulWidget {
  final AllCarsCubit carsCubit;

  const PurposeSelector({super.key, required this.carsCubit});

  @override
  _PurposeSelectorState createState() => _PurposeSelectorState();
}

class _PurposeSelectorState extends State<PurposeSelector> {
  final List<int> _selectedIndices = []; // Track selected indices

  @override
  Widget build(BuildContext context) {
    final carsCubit = widget.carsCubit;
    final purposeList = carsCubit.searchAttributeModel!.purposes!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CustomText(
          text: "Select Purpose",
          fontSize: 16.0,
          fontWeight: FontWeight.w400,
        ),
        Utils.verticalSpace(10.0),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              ...List.generate(purposeList.length, (index) {
                final purposeName = purposeList[index];

                // Skip null color values
                if (purposeName == null) return const SizedBox.shrink();

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

                      // Get selected colors based on _selectedIndices
                      final selectedColors = _selectedIndices
                          .map((i) => purposeList[i]) // Map indices to color names
                          .where((color) => color != null) // Exclude null values
                          .toList();

                      // Pass selected colors to the Cubit
                      context.read<AllCarsCubit>().purposeChange(
                          selectedColors.cast<String>()); // Safe cast to List<String>
                    });
                  },
                  child: Padding(
                    padding: Utils.only(right: 10.0),
                    child: Container(
                      padding: Utils.symmetric(h: 10.0, v: 6.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(45.0),
                        color: backgroundColor,
                        border: Border.all(color: borderColor),
                      ),
                      child: CustomText(
                        text: purposeName, // Show color name
                        color: isSelected ? whiteColor : Colors.black,
                      ),
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ],
    );
  }
}

