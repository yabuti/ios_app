// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'package:carsbnb/data/model/home/home_model.dart';

class CompareListModel extends Equatable {
  final List<CompareList>? compareList;
  const CompareListModel({
    this.compareList,
  });

  CompareListModel copyWith({
    List<CompareList>? compareList,
  }) {
    return CompareListModel(
      compareList: compareList ?? this.compareList,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'compareList': compareList?.map((x) => x.toMap()).toList(),
    };
  }

  factory CompareListModel.fromMap(Map<String, dynamic> map) {
    return CompareListModel(
      compareList: map['compareList'] != null ? List<CompareList>.from((map['compareList'] as List<dynamic>).map<CompareList?>((x) => CompareList.fromMap(x as Map<String,dynamic>),),) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CompareListModel.fromJson(String source) => CompareListModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [compareList!];
}

class CompareList extends Equatable {
  final int id;
  final int userId;
  final int carId;
  final String createdAt;
  final String updatedAt;
  final FeaturedCars? car;
  const CompareList({
    required this.id,
    required this.userId,
    required this.carId,
    required this.createdAt,
    required this.updatedAt,
    this.car,
  });

  CompareList copyWith({
    int? id,
    int? userId,
    int? carId,
    String? createdAt,
    String? updatedAt,
    FeaturedCars? car,
  }) {
    return CompareList(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      carId: carId ?? this.carId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      car: car ?? this.car,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'user_id': userId,
      'car_id': carId,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'car': car?.toMap(),
    };
  }

  factory CompareList.fromMap(Map<String, dynamic> map) {
    return CompareList(
      id: map['id'] ?? 0,
      userId: map['user_id'] != null ? int.parse(map['user_id'].toString()) : 0,
      carId: map['car_id'] != null ? int.parse(map['car_id'].toString()) : 0,
      createdAt: map['created_at'] ?? '',
      updatedAt: map['updated_at'] ?? '',
      car: map['car'] != null ? FeaturedCars.fromMap(map['car'] as Map<String,dynamic>) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CompareList.fromJson(String source) => CompareList.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      userId,
      carId,
      createdAt,
      updatedAt,
      car!,
    ];
  }
}
