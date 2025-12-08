// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'package:carsbnb/data/model/home/home_model.dart';

import 'getCarEditDataModel.dart';

class CreateModelResponse extends Equatable {
  final String message;
  final FeaturedCars? car;
  final CarTranslate? carTranslate;
  const CreateModelResponse({
    required this.message,
    this.car,
    this.carTranslate,
  });

  CreateModelResponse copyWith({
    String? message,
    FeaturedCars? car,
    CarTranslate? carTranslate,
  }) {
    return CreateModelResponse(
      message: message ?? this.message,
      car: car ?? this.car,
      carTranslate: carTranslate ?? this.carTranslate,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'message': message,
      'car': car?.toMap(),
      'car_translate': carTranslate?.toMap(),
    };
  }

  factory CreateModelResponse.fromMap(Map<String, dynamic> map) {
    return CreateModelResponse(
      message: map['message'] ?? '',
      car: map['car'] != null ? FeaturedCars.fromMap(map['car'] as Map<String,dynamic>) : null,
      carTranslate: map['car_translate'] != null ? CarTranslate.fromMap(map['car_translate'] as Map<String,dynamic>) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CreateModelResponse.fromJson(String source) => CreateModelResponse.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [message, car, carTranslate];
}
