// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:carsbnb/data/model/home/home_model.dart';
import 'package:equatable/equatable.dart';

class ReviewListModel extends Equatable {
  final int id;
  final int userId;
  final int agentId;
  final int carId;
  final int rating;
  final String comment;
  final String status;
  final String createdAt;
  final String updatedAt;
  final String ratedBy;
  final String bookingId;
  final FeaturedCars? cars;

  const ReviewListModel({
    required this.id,
    required this.userId,
    required this.agentId,
    required this.carId,
    required this.rating,
    required this.comment,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.ratedBy,
    required this.bookingId,
    this.cars,
  });

  ReviewListModel copyWith({
    int? id,
    int? userId,
    int? agentId,
    int? carId,
    int? rating,
    String? comment,
    String? status,
    String? createdAt,
    String? updatedAt,
    String? ratedBy,
    String? bookingId,
    FeaturedCars? cars,
  }) {
    return ReviewListModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      agentId: agentId ?? this.agentId,
      carId: carId ?? this.carId,
      rating: rating ?? this.rating,
      comment: comment ?? this.comment,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      ratedBy: ratedBy ?? this.ratedBy,
      bookingId: bookingId ?? this.bookingId,
      cars: cars ?? this.cars,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'user_id': userId,
      'agent_id': agentId,
      'car_id': carId,
      'rating': rating,
      'comment': comment,
      'status': status,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'rated_by': ratedBy,
      'booking_id': bookingId,
      'car': cars?.toMap(),
    };
  }

  factory ReviewListModel.fromMap(Map<String, dynamic> map) {
    return ReviewListModel(
      id: map['id'] ?? 0,
      userId: map['user_id'] != null ? int.parse(map['user_id'].toString()) : 0,
      agentId:
          map['agent_id'] != null ? int.parse(map['agent_id'].toString()) : 0,
      carId: map['car_id'] != null ? int.parse(map['car_id'].toString()) : 0,
      rating: map['rating'] != null ? int.parse(map['rating'].toString()) : 0,
      comment: map['comment'] ?? '',
      status: map['status'] ?? '',
      createdAt: map['created_at'] ?? '',
      updatedAt: map['updated_at'] ?? '',
      ratedBy: map['rated_by'] ?? '',
      bookingId: map['booking_id'] ?? '',
      cars: map['car'] != null
          ? FeaturedCars.fromMap(map['car'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ReviewListModel.fromJson(String source) =>
      ReviewListModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      userId,
      agentId,
      carId,
      rating,
      comment,
      status,
      createdAt,
      updatedAt,
      ratedBy,
      bookingId,
      cars!,
    ];
  }
}

class Dealer extends Equatable {
  final int id;
  final String image;
  final String email;
  final String name;
  final String designation;
  final int totalCar;

  const Dealer({
    required this.id,
    required this.image,
    required this.email,
    required this.name,
    required this.designation,
    required this.totalCar,
  });

  Dealer copyWith({
    int? id,
    String? image,
    String? email,
    String? name,
    String? designation,
    int? totalCar,
  }) {
    return Dealer(
      id: id ?? this.id,
      image: image ?? this.image,
      email: email ?? this.email,
      name: name ?? this.name,
      designation: designation ?? this.designation,
      totalCar: totalCar ?? this.totalCar,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'image': image,
      'email': email,
      'name': name,
      'designation': designation,
      'total_car': totalCar,
    };
  }

  factory Dealer.fromMap(Map<String, dynamic> map) {
    return Dealer(
      id: map['id'] ?? 0,
      image: map['image'] ?? '',
      email: map['email'] ?? '',
      name: map['name'] ?? '',
      designation: map['designation'] ?? '',
      totalCar:
          map['total_car'] != null ? int.parse(map['total_car'].toString()) : 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Dealer.fromJson(String source) =>
      Dealer.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      image,
      email,
      name,
      designation,
      totalCar,
    ];
  }
}
