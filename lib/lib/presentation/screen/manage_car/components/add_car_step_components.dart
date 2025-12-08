import 'package:flutter/material.dart';

import '../../../../utils/constraints.dart';
import '../../../../widgets/custom_text.dart';


class CustomStepIndicator extends StatelessWidget {
  final int currentStep;
  final int totalSteps;
  final List<String> stepLabels;
  final Function(int) onStepSelected;

  const CustomStepIndicator({
    super.key,
    required this.currentStep,
    required this.totalSteps,
    required this.stepLabels,
    required this.onStepSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          totalSteps,
              (index) => GestureDetector(
                onTap: () {
                  onStepSelected(index + 1);
                },
                child: _StepItem(
                  label: stepLabels[index],
                  isActive: index + 1 == currentStep,
                  isCompleted: index + 1 < currentStep,
                  isFirst: index == 0,
                  isLast: index == totalSteps - 1,
                ),
              ),
        ),
      ),
    );
  }
}

class _StepItem extends StatelessWidget {
  final String label;
  final bool isActive;
  final bool isCompleted;
  final bool isFirst;
  final bool isLast;

  const _StepItem({
    super.key,
    required this.label,
    required this.isActive,
    required this.isCompleted,
    required this.isFirst,
    required this.isLast,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: isLast ? 0 : 0),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          ClipPath(
            clipper: StepClipper(isFirst: isFirst),
            child: Container(
              height: 40,
              width: 110,
              color: isActive
                  ? primaryColor
                  : (isCompleted ? primaryColor : primaryColor.withOpacity(0.3)),
              child: Center(
                child: CustomText(
                  text: label,
                  color: isActive || isCompleted ? Colors.white : Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          // if (isCompleted)
          //   Positioned(
          //     right: -8,
          //     top: 12,
          //     child: Icon(Icons.check_circle, size: 16, color: Colors.green),
          //   ),
        ],
      ),
    );
  }
}

class StepClipper extends CustomClipper<Path> {
  final bool isFirst;

  StepClipper({required this.isFirst});

  @override
  Path getClip(Size size) {
    double arrowWidth = 20.0; // Width of the arrow pointing right
    Path path = Path();

    if (isFirst) {
      // For the first step
      path.moveTo(0, 0);
      path.lineTo(size.width - arrowWidth, 0);
      path.lineTo(size.width, size.height / 2);
      path.lineTo(size.width - arrowWidth, size.height);
      path.lineTo(0, size.height);
      path.close();
    } else {
      // For subsequent steps
      double arrowWidth = 20.0; // Width of the arrow pointing right
      Path path = Path();
      path.moveTo(0, 0);
      path.lineTo(size.width - arrowWidth, 0);
      path.lineTo(size.width, size.height / 2);
      path.lineTo(size.width - arrowWidth, size.height);
      path.lineTo(0, size.height);
      path.lineTo(arrowWidth, size.height / 2);
      path.close();
      return path;
    }

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}