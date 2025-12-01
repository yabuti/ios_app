// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:equatable/equatable.dart';

import '../home/home_model.dart';

class CarCreateDataModel extends Equatable {
 final List<Brands>? brands;
 final List<Cities>? cities;
 final List<CarType>? carType;
  const CarCreateDataModel({
    this.brands,
    this.cities,
    this.carType,
  });

  CarCreateDataModel copyWith({
    List<Brands>? brands,
    List<Cities>? cities,
    List<CarType>? carType,
  }) {
    return CarCreateDataModel(
      brands: brands ?? this.brands,
      cities: cities ?? this.cities,
      carType: carType ?? this.carType,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'brands': brands?.map((x) => x.toMap()).toList(),
      'cities': cities?.map((x) => x.toMap()).toList(),
      'car_type': carType?.map((x) => x.toMap()).toList(),
    };
  }

  factory CarCreateDataModel.fromMap(Map<String, dynamic> map) {
    return CarCreateDataModel(
      brands: map['brands'] != null ? List<Brands>.from((map['brands'] as List<dynamic>).map<Brands?>((x) => Brands.fromMap(x as Map<String,dynamic>),),) : null,
      cities: map['cities'] != null ? List<Cities>.from((map['cities'] as List<dynamic>).map<Cities?>((x) => Cities.fromMap(x as Map<String,dynamic>),),) : null,
      carType: map['car_type'] != null ? List<CarType>.from((map['car_type'] as List<dynamic>).map<CarType?>((x) => CarType.fromMap(x as Map<String,dynamic>),),) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CarCreateDataModel.fromJson(String source) => CarCreateDataModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [brands!, cities!, carType!];
}


// class Brands extends Equatable {
//   final int id;
//   final String image;
//   final String slug;
//   final String status;
//   final String createdAt;
//   final String updatedAt;
//   final String name;
//   final int totalCar;
//   const Brands({
//     required this.id,
//     required this.image,
//     required this.slug,
//     required this.status,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.name,
//     required this.totalCar,
//   });
//
//   Brands copyWith({
//     int? id,
//     String? image,
//     String? slug,
//     String? status,
//     String? createdAt,
//     String? updatedAt,
//     String? name,
//     int? totalCar,
//   }) {
//     return Brands(
//       id: id ?? this.id,
//       image: image ?? this.image,
//       slug: slug ?? this.slug,
//       status: status ?? this.status,
//       createdAt: createdAt ?? this.createdAt,
//       updatedAt: updatedAt ?? this.updatedAt,
//       name: name ?? this.name,
//       totalCar: totalCar ?? this.totalCar,
//     );
//   }
//
//   Map<String, dynamic> toMap() {
//     return <String, dynamic>{
//       'id': id,
//       'image': image,
//       'slug': slug,
//       'status': status,
//       'created_at': createdAt,
//       'updated_at': updatedAt,
//       'name': name,
//       'total_car': totalCar,
//     };
//   }
//
//   factory Brands.fromMap(Map<String, dynamic> map) {
//     return Brands(
//       id: map['id'] ?? 0,
//       image: map['image'] ?? '',
//       slug: map['slug'] ?? '',
//       status: map['status'] ?? '',
//       createdAt: map['created_at'] ?? '',
//       updatedAt: map['updated_at'] ?? '',
//       name: map['name'] ?? '',
//       totalCar: map['total_car'] ?? 0,
//     );
//   }
//
//   String toJson() => json.encode(toMap());
//
//   factory Brands.fromJson(String source) => Brands.fromMap(json.decode(source) as Map<String, dynamic>);
//
//   @override
//   bool get stringify => true;
//
//   @override
//   List<Object> get props {
//     return [
//       id,
//       image,
//       slug,
//       status,
//       createdAt,
//       updatedAt,
//       name,
//       totalCar,
//     ];
//   }
// }

class Cities extends Equatable {
  final int id;
  final String createdAt;
  final String updatedAt;
  final int countryId;
  final String name;
  final int totalCar;
  const Cities({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.countryId,
    required this.name,
    required this.totalCar,
  });

  Cities copyWith({
    int? id,
    String? createdAt,
    String? updatedAt,
    int? countryId,
    String? name,
    int? totalCar,
  }) {
    return Cities(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      countryId: countryId ?? this.countryId,
      name: name ?? this.name,
      totalCar: totalCar ?? this.totalCar,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'country_id': countryId,
      'name': name,
      'total_car': totalCar,
    };
  }

  factory Cities.fromMap(Map<String, dynamic> map) {
    return Cities(
      id: map['id'] ?? 0,
      createdAt: map['created_at'] ?? '',
      updatedAt: map['updated_at'] ?? '',
      countryId: map['country_id'] ?? 0,
      name: map['name'] ?? '',
      totalCar: map['total_car'] ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Cities.fromJson(String source) => Cities.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      createdAt,
      updatedAt,
      countryId,
      name,
      totalCar,
    ];
  }
}

class CarType extends Equatable {
  final int id;
  final String slug;
  final String status;
  final String createdAt;
  final String updatedAt;
  final String name;
  const CarType({
    required this.id,
    required this.slug,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.name,
  });

  CarType copyWith({
    int? id,
    String? slug,
    String? status,
    String? createdAt,
    String? updatedAt,
    String? name,
  }) {
    return CarType(
      id: id ?? this.id,
      slug: slug ?? this.slug,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'slug': slug,
      'status': status,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'name': name,
    };
  }

  factory CarType.fromMap(Map<String, dynamic> map) {
    return CarType(
      id: map['id'] ?? 0,
      slug: map['slug'] ?? '',
      status: map['status'] ?? '',
      createdAt: map['created_at'] ?? '',
      updatedAt: map['updated_at'] ?? '',
      name: map['name'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory CarType.fromJson(String source) => CarType.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      slug,
      status,
      createdAt,
      updatedAt,
      name,
    ];
  }
}
