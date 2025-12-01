// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

import '../car/car_create_data_model.dart';
import '../home/home_model.dart';

class SearchAttributeModel extends Equatable {
  final List<Brands>? brands;
  final List<String?>? condition;
  final List<String?>? purposes;
  final List<CountryModel>? country;
  final List<Features>? features;

  const SearchAttributeModel({
    this.brands,
    this.condition,
    this.purposes,
    this.country,
    this.features,

  });

  SearchAttributeModel copyWith({
    List<Brands>? brands,
    List<String>? condition,
    List<String>? purposes,
    List<CountryModel>? country,
    List<Features>? features,

  }) {
    return SearchAttributeModel(
      brands: brands ?? this.brands,
      condition: condition ?? this.condition,
      purposes: purposes ?? this.purposes,
      country: country ?? this.country,
      features: features ?? this.features,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'brands': brands?.map((x) => x.toMap()).toList(),
      'conditions': condition,
      'purposes': purposes,
      'countries': country?.map((x) => x.toMap()).toList(),
      'features': features?.map((x) => x.toMap()).toList(),

    };
  }

  factory SearchAttributeModel.fromMap(Map<String, dynamic> map) {
    return SearchAttributeModel(
      brands: map['brands'] != null ? List<Brands>.from((map['brands'] as List<dynamic>).map<Brands?>((x) => Brands.fromMap(x as Map<String,dynamic>),),) : null,
      condition: map['conditions'] != null ? List<String?>.from((map['conditions'] as List<dynamic>)) : null,
      purposes: map['purposes'] != null ? List<String?>.from((map['purposes'] as List<dynamic>)) : null,
      country: map['countries'] != null ? List<CountryModel>.from((map['countries'] as List<dynamic>).map<CountryModel?>((x) => CountryModel.fromMap(x as Map<String,dynamic>),),) : null,
      features: map['features'] != null ? List<Features>.from((map['features'] as List<dynamic>).map<Features?>((x) => Features.fromMap(x as Map<String,dynamic>),),) : null,

    );
  }

  String toJson() => json.encode(toMap());

  factory SearchAttributeModel.fromJson(String source) => SearchAttributeModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      brands!,
      condition!,
      purposes!,
      country!,
      features!,
    ];
  }
}

class Features extends Equatable {
  final int id;
  final String createdAt;
  final String updatedAt;
  final String name;
  const Features({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.name,
  });

  Features copyWith({
    int? id,
    String? createdAt,
    String? updatedAt,
    String? name,
  }) {
    return Features(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'name': name,
    };
  }

  factory Features.fromMap(Map<String, dynamic> map) {
    return Features(
      id: map['id'] ?? 0,
      createdAt: map['createdAt'] ?? '',
      updatedAt: map['updatedAt'] ?? '',
      name: map['name'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Features.fromJson(String source) => Features.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [id, createdAt, updatedAt, name];
}

class CountryModel extends Equatable {
  final int id;
  final String name;
  final String code;
  final String createdAt;
  final String updatedAt;
  final int totalListing;
  const CountryModel({
    required this.id,
    required this.name,
    required this.code,
    required this.createdAt,
    required this.updatedAt,
    required this.totalListing,
  });

  CountryModel copyWith({
    int? id,
    String? name,
    String? code,
    String? createdAt,
    String? updatedAt,
    int? totalListing,
  }) {
    return CountryModel(
      id: id ?? this.id,
      name: name ?? this.name,
      code: code ?? this.code,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      totalListing: totalListing ?? this.totalListing,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'code': code,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'total_listing': totalListing,
    };
  }

  factory CountryModel.fromMap(Map<String, dynamic> map) {
    return CountryModel(
      id: map['id'] ?? 0,
      name: map['name'] ?? '',
      code: map['code'] ?? '',
      createdAt: map['createdAt'] ?? '',
      updatedAt: map['updatedAt'] ?? '',
      totalListing: map['total_listing'] != null ? int.parse(map['total_listing'].toString()) : 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory CountryModel.fromJson(String source) => CountryModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      name,
      code,
      createdAt,
      updatedAt,
      totalListing,
    ];
  }
}


class CityModel extends Equatable {
  final List<Cities>? cities;
  const CityModel({
    this.cities,
  });

  CityModel copyWith({
    List<Cities>? cities,
  }) {
    return CityModel(
      cities: cities ?? this.cities,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'cities': cities?.map((x) => x.toMap()).toList(),
    };
  }

  factory CityModel.fromMap(Map<String, dynamic> map) {
    return CityModel(
      cities: map['cities'] != null ? List<Cities>.from((map['cities'] as List<dynamic>).map<Cities?>((x) => Cities.fromMap(x as Map<String,dynamic>),),) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CityModel.fromJson(String source) => CityModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [cities!];
}
