// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'package:carsbnb/data/model/home/home_model.dart';

import '../auth/user_response_model.dart';

class DashboardModel extends Equatable {
  final User? user;
  final List<FeaturedCars>? cars;
  final int totalCar;
  final int totalFeaturedCar;
  final int totalWishlist;
  const DashboardModel({
    this.user,
    this.cars,
    required this.totalCar,
    required this.totalFeaturedCar,
    required this.totalWishlist,
  });

  DashboardModel copyWith({
    User? user,
    List<FeaturedCars>? cars,
    int? totalCar,
    int? totalFeaturedCar,
    int? totalWishlist,
  }) {
    return DashboardModel(
      user: user ?? this.user,
      cars: cars ?? this.cars,
      totalCar: totalCar ?? this.totalCar,
      totalFeaturedCar: totalFeaturedCar ?? this.totalFeaturedCar,
      totalWishlist: totalWishlist ?? this.totalWishlist,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'user': user?.toMap(),
      'cars': cars?.map((x) => x.toMap()).toList(),
      'total_car': totalCar,
      'total_featured_car': totalFeaturedCar,
      'total_wishlist': totalWishlist,
    };
  }

  factory DashboardModel.fromMap(Map<String, dynamic> map) {
    return DashboardModel(
      user: map['user'] != null ? User.fromMap(map['user'] as Map<String,dynamic>) : null,
      cars: map['cars'] != null ? List<FeaturedCars>.from((map['cars'] as List<dynamic>).map<FeaturedCars?>((x) => FeaturedCars.fromMap(x as Map<String,dynamic>),),) : null,
      totalCar: map['total_car'] != null ? int.parse(map['total_car'].toString()) : 0,
      totalFeaturedCar: map['total_featured_car'] != null ? int.parse(map['total_featured_car'].toString()) : 0,
      totalWishlist: map['total_wishlist'] != null ? int.parse(map['total_wishlist'].toString()) : 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory DashboardModel.fromJson(String source) => DashboardModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      user!,
      cars!,
      totalCar,
      totalFeaturedCar,
      totalWishlist,
    ];
  }
}
