// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable

import 'package:blackdiamondcar/logic/cubit/all_cars/all_cars_state.dart';
import 'package:equatable/equatable.dart';

class CarSearchStateModel extends Equatable {
  final String search;
  final String location;
  final String countryId;
  final String brands;
  final String city;
  final List<String> carTypes;
  final List<String> seats;
  final List<String> condition;
  final List<String> purpose;
  final List<String> feature;
  final List<String> ratings;
  final String offer;
  final String languageCode;
  int initialPage;
  bool isListEmpty;
  int currentIndex;
  final AllCarsState allCarsState;
   CarSearchStateModel({
    required this.search,
    required this.location,
    required this.countryId,
    required this.brands,
    required this.city,
    required this.carTypes,
    required this.seats,
    required this.condition,
    required this.purpose,
    required this.feature,
    required this.ratings,
    required this.offer,
    this.languageCode = '',
    this.initialPage = 1,
    this.currentIndex = 0,
    this.isListEmpty = false,
     this.allCarsState = const AllCarsInitial(),
  });

  CarSearchStateModel copyWith({
    String? search,
    String? location,
    String? countryId,
    String? brands,
    String? city,
    List<String>? carTypes,
    List<String>? seats,
    List<String>? condition,
    List<String>? purpose,
    List<String>? feature,
    List<String>? ratings,
    String? offer,
    String? languageCode,
    int? initialPage,
    int? currentIndex,
    bool? isListEmpty,
    AllCarsState? allCarsState,
  }) {
    return CarSearchStateModel(
      search: search ?? this.search,
      location: location ?? this.location,
      countryId: countryId ?? this.countryId,
      brands: brands ?? this.brands,
      city: city ?? this.city,
      carTypes: carTypes ?? this.carTypes,
      seats: seats ?? this.seats,
      condition: condition ?? this.condition,
      purpose: purpose ?? this.purpose,
      feature: feature ?? this.feature,
      ratings: ratings ?? this.ratings,
      offer: offer ?? this.offer,
      languageCode: languageCode ?? this.languageCode,
      initialPage: initialPage ?? this.initialPage,
      currentIndex: currentIndex ?? this.currentIndex,
      isListEmpty: isListEmpty ?? this.isListEmpty,
      allCarsState: allCarsState ?? this.allCarsState,
    );
  }

  factory CarSearchStateModel.init() {
    return CarSearchStateModel(
        search: '',
        location: '',
        countryId: '',
        brands: '',
        city: '',
        carTypes:const [],
        seats: const [],
        condition: const [],
        purpose: const [],
        feature: const [],
        ratings: const [],
        offer: '',
        initialPage: 1,
        isListEmpty: false,
        allCarsState: const AllCarsInitial()
    );
  }

  factory CarSearchStateModel.reset() {
    return CarSearchStateModel(
        search: '',
        location: '',
        countryId: '',
        brands: '',
        city: '',
        carTypes: const [],
        seats: const [],
        condition: const [],
        purpose: const [],
        feature: const [],
        ratings: const [],
        offer: '',
        initialPage: 1,
        isListEmpty: false,
        allCarsState: const AllCarsInitial()
    );
  }

  // Map<String, dynamic> toMap() {
  //   return <String, dynamic>{
  //     'search': search,
  //     'location': location,
  //     'brands': brands,
  //     'carTypes': carTypes,
  //     'seats': seats,
  //     'colors': colors,
  //     'ratings': ratings,
  //     'offer': offer,
  //   };
  // }
  //
  // factory HomeDataStateModel.fromMap(Map<String, dynamic> map) {
  //   return HomeDataStateModel(
  //     search: map['search'] as String,
  //     location: map['location'] as String,
  //     brands: map['brands'] as String,
  //     carTypes: map['carTypes'] as String,
  //     seats: map['seats'] as String,
  //     colors: map['colors'] as String,
  //     ratings: map['ratings'] as String,
  //     offer: map['offer'] as String,
  //   );
  // }
  //
  // String toJson() => json.encode(toMap());
  //
  // factory HomeDataStateModel.fromJson(String source) => HomeDataStateModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      search,
      location,
      countryId,
      brands,
      city,
      carTypes,
      seats,
      condition,
      purpose,
      feature,
      ratings,
      offer,
      languageCode,
      initialPage,
      isListEmpty,
      currentIndex,
      allCarsState,
    ];
  }
}
