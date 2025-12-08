// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'package:carsbnb/data/model/car/car_create_data_model.dart';
import 'package:carsbnb/data/model/home/home_model.dart';

import '../search_attribute/search_attribute_model.dart';

class CarEditDataModel extends Equatable {
  final List<Brands>? brands;
  final List<Features>? features;
  final List<CountryModel>? countries;
  final List<Cities>? cities;
  final FeaturedCars? car;
  final CarTranslate? carTranslate;
  const CarEditDataModel({
    this.brands,
    this.features,
    this.countries,
    this.cities,
    this.car,
    this.carTranslate,
  });

  CarEditDataModel copyWith({
    List<Brands>? brands,
    List<Features>? features,
    List<CountryModel>? countries,
    List<Cities>? cities,
    FeaturedCars? car,
    CarTranslate? carTranslate,
  }) {
    return CarEditDataModel(
      brands: brands ?? this.brands,
      features: features ?? this.features,
      countries: countries ?? this.countries,
      cities: cities ?? this.cities,
      car: car ?? this.car,
      carTranslate: carTranslate ?? this.carTranslate,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'brands': brands?.map((x) => x.toMap()).toList(),
      'features': features?.map((x) => x.toMap()).toList(),
      'countries': countries?.map((x) => x.toMap()).toList(),
      'cities': cities?.map((x) => x.toMap()).toList(),
      'car': car?.toMap(),
      'car_translate': carTranslate?.toMap(),
    };
  }

  factory CarEditDataModel.fromMap(Map<String, dynamic> map) {
    return CarEditDataModel(
      brands: map['brands'] != null ? List<Brands>.from((map['brands'] as List<dynamic>).map<Brands?>((x) => Brands.fromMap(x as Map<String,dynamic>),),) : null,
      features: map['features'] != null ? List<Features>.from((map['features'] as List<dynamic>).map<Features?>((x) => Features.fromMap(x as Map<String,dynamic>),),) : null,
      countries: map['countries'] != null ? List<CountryModel>.from((map['countries'] as List<dynamic>).map<CountryModel?>((x) => CountryModel.fromMap(x as Map<String,dynamic>),),) : null,
      cities: map['cities'] != null ? List<Cities>.from((map['cities'] as List<dynamic>).map<Cities?>((x) => Cities.fromMap(x as Map<String,dynamic>),),) : null,
      car: map['car'] != null ? FeaturedCars.fromMap(map['car'] as Map<String,dynamic>) : null,
      carTranslate: map['car_translate'] != null ? CarTranslate.fromMap(map['car_translate'] as Map<String,dynamic>) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CarEditDataModel.fromJson(String source) => CarEditDataModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      brands!,
      features!,
      countries!,
      cities!,
      car!,
      carTranslate!,
    ];
  }
}


class CarTranslate extends Equatable {
  final int id;
  final int carId;
  final String langCode;
  final String title;
  final String description;
  final String videoDescription;
  final String address;
  final String seoTitle;
  final String seoDescription;
  final String createdAt;
  final String updatedAt;
  const CarTranslate({
    required this.id,
    required this.carId,
    required this.langCode,
    required this.title,
    required this.description,
    required this.videoDescription,
    required this.address,
    required this.seoTitle,
    required this.seoDescription,
    required this.createdAt,
    required this.updatedAt,
  });

  CarTranslate copyWith({
    int? id,
    int? carId,
    String? langCode,
    String? title,
    String? description,
    String? videoDescription,
    String? address,
    String? seoTitle,
    String? seoDescription,
    String? createdAt,
    String? updatedAt,
  }) {
    return CarTranslate(
      id: id ?? this.id,
      carId: carId ?? this.carId,
      langCode: langCode ?? this.langCode,
      title: title ?? this.title,
      description: description ?? this.description,
      videoDescription: videoDescription ?? this.videoDescription,
      address: address ?? this.address,
      seoTitle: seoTitle ?? this.seoTitle,
      seoDescription: seoDescription ?? this.seoDescription,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'car_id': carId,
      'lang_code': langCode,
      'title': title,
      'description': description,
      'video_description': videoDescription,
      'address': address,
      'seoTitle': seoTitle,
      'seoDescription': seoDescription,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory CarTranslate.fromMap(Map<String, dynamic> map) {
    return CarTranslate(
      id: map['id'] is int ? map['id'] : int.tryParse(map['id']?.toString() ?? '0') ?? 0,
      carId: map['car_id'] is int ? map['car_id'] : int.tryParse(map['car_id']?.toString() ?? '0') ?? 0,
      langCode: map['lang_code']?.toString() ?? '',
      title: map['title']?.toString() ?? '',
      description: map['description']?.toString() ?? '',
      videoDescription: map['video_description']?.toString() ?? '',
      address: map['address']?.toString() ?? '',
      seoTitle: map['seoTitle']?.toString() ?? map['seo_title']?.toString() ?? '',
      seoDescription: map['seoDescription']?.toString() ?? map['seo_description']?.toString() ?? '',
      createdAt: map['createdAt']?.toString() ?? map['created_at']?.toString() ?? '',
      updatedAt: map['updatedAt']?.toString() ?? map['updated_at']?.toString() ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory CarTranslate.fromJson(String source) => CarTranslate.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      carId,
      langCode,
      title,
      description,
      videoDescription,
      address,
      seoTitle,
      seoDescription,
      createdAt,
      updatedAt,
    ];
  }
}
