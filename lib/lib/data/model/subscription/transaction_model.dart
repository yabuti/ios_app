// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class TransactionModel extends Equatable {
  final int id;
  final String orderId;
  final int userId;
  final int subscriptionPlanId;
  final String planName;
  final String planPrice;
  final String expirationDate;
  final String expiration;
  final String maxCar;
  final String featuredCar;
  final String status;
  final String paymentMethod;
  final String paymentStatus;
  final String transaction;
  final String createdAt;
  final String updatedAt;
  const TransactionModel({
    required this.id,
    required this.orderId,
    required this.userId,
    required this.subscriptionPlanId,
    required this.planName,
    required this.planPrice,
    required this.expirationDate,
    required this.expiration,
    required this.maxCar,
    required this.featuredCar,
    required this.status,
    required this.paymentMethod,
    required this.paymentStatus,
    required this.transaction,
    required this.createdAt,
    required this.updatedAt,
  });

  TransactionModel copyWith({
    int? id,
    String? orderId,
    int? userId,
    int? subscriptionPlanId,
    String? planName,
    String? planPrice,
    String? expirationDate,
    String? expiration,
    String? maxCar,
    String? featuredCar,
    String? status,
    String? paymentMethod,
    String? paymentStatus,
    String? transaction,
    String? createdAt,
    String? updatedAt,
  }) {
    return TransactionModel(
      id: id ?? this.id,
      orderId: orderId ?? this.orderId,
      userId: userId ?? this.userId,
      subscriptionPlanId: subscriptionPlanId ?? this.subscriptionPlanId,
      planName: planName ?? this.planName,
      planPrice: planPrice ?? this.planPrice,
      expirationDate: expirationDate ?? this.expirationDate,
      expiration: expiration ?? this.expiration,
      maxCar: maxCar ?? this.maxCar,
      featuredCar: featuredCar ?? this.featuredCar,
      status: status ?? this.status,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      transaction: transaction ?? this.transaction,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'order_id': orderId,
      'user_id': userId,
      'subscription_plan_id': subscriptionPlanId,
      'plan_name': planName,
      'plan_price': planPrice,
      'expiration_date': expirationDate,
      'expiration': expiration,
      'max_car': maxCar,
      'featured_car': featuredCar,
      'status': status,
      'payment_method': paymentMethod,
      'payment_status': paymentStatus,
      'transaction': transaction,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  factory TransactionModel.fromMap(Map<String, dynamic> map) {
    return TransactionModel(
      id: map['id'] ?? 0,
      orderId: map['order_id'] ?? '',
      userId: map['user_id'] != null ? int.parse(map['user_id'].toString()) : 0,
      subscriptionPlanId: map['subscription_plan_id'] != null ? int.parse(map['subscription_plan_id'].toString()) : 0,
      planName: map['plan_name'] ?? '',
      planPrice: map['plan_price'] ?? '',
      expirationDate: map['expiration_date'] ?? '',
      expiration: map['expiration'] ?? '',
      maxCar: map['max_car'] ?? '',
      featuredCar: map['featured_car'] ?? '',
      status: map['status'] ?? '',
      paymentMethod: map['payment_method'] ?? '',
      paymentStatus: map['payment_status'] ?? '',
      transaction: map['transaction'] ?? '',
      createdAt: map['created_at'] ?? '',
      updatedAt: map['updated_at'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory TransactionModel.fromJson(String source) => TransactionModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      orderId,
      userId,
      subscriptionPlanId,
      planName,
      planPrice,
      expirationDate,
      expiration,
      maxCar,
      featuredCar,
      status,
      paymentMethod,
      paymentStatus,
      transaction,
      createdAt,
      updatedAt,
    ];
  }
}
