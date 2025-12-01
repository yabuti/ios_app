// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../../../data/dummy_data/dummy_data_model.dart';
// import '../../../../logic/cubit/all_cars/all_cars_cubit.dart';
// import '../../../../utils/constraints.dart';
// import '../../../../utils/utils.dart';
// import '../../../../widgets/custom_text.dart';
//
// class CapacitySelector extends StatefulWidget {
//
//   const CapacitySelector({super.key, });
//
//   @override
//   _CapacitySelectorState createState() => _CapacitySelectorState();
// }
//
// class _CapacitySelectorState extends State<CapacitySelector> {
//   final List<int> _selectedCapacityIds = []; // Track selected capacity IDs
//
//   @override
//   Widget build(BuildContext context) {
//
//     final selectedCarTypeIds = _selectedCapacityIds.map((index) => capacityList[index].id.toString()).toList();
//
//     // Pass the selected car type IDs to the Cubit
//     context.read<AllCarsCubit>().seatChange(selectedCarTypeIds);
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const CustomText(text: "Capacity",fontSize: 16.0,fontWeight: FontWeight.w400,),
//         Utils.verticalSpace(10.0),
//         SingleChildScrollView(
//           scrollDirection: Axis.horizontal,
//           child: Row(
//             children: [
//               ...List.generate(capacityList.length, (index) {
//                 final capacity = capacityList[index];
//                 final isSelected = _selectedCapacityIds.contains(index);
//
//                 // Determine background color
//                 final backgroundColor = isSelected
//                     ? primaryColor
//                     : (index == 0 ? Colors.transparent : Colors.white);
//
//                 return GestureDetector(
//                   onTap: () {
//                     setState(() {
//                       if (isSelected) {
//                         // Deselect the capacity if already selected
//                         _selectedCapacityIds.remove(index);
//                       } else {
//                         // Select the capacity
//                         _selectedCapacityIds.add(index);
//                       }
//
//                       final updatedCapacityIds = _selectedCapacityIds.map((i) => capacityList[i].id.toString()).toList();
//                       context.read<AllCarsCubit>().seatChange(updatedCapacityIds);
//                     });
//                   },
//                   child: Padding(
//                     padding: Utils.only(right: 10.0),
//                     child: Container(
//                       padding: Utils.symmetric(h: 10.0, v: 5.0),
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(45.0),
//                         color: backgroundColor, // Dynamic background color
//                         border: Border.all(
//                           color: borderColor
//                         )
//                       ),
//                       child: CustomText(
//                         text: capacity.name,
//                         color: isSelected ? whiteColor : Colors.black, // Text color
//                       ),
//                     ),
//                   ),
//                 );
//               }),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }
