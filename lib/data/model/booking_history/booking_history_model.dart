// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

import '../cars_details/car_details_model.dart';
import '../home/home_model.dart';

class BookingHistoryModel extends Equatable {
  final int id;
  final int orderId;
  final int userId;
  final int supplierId;
  final int carId;
  final double price;
  final double totalPrice;
  final String pickupLocation;
  final String returnLocation;
  final String pickupDate;
  final String pickupTime;
  final String returnDate;
  final String returnTime;
  final int duration;
  final String paymentMethod;
  final int paymentStatus;
  final String transaction;
  final int status;
  final String createdAt;
  final String updatedAt;
  final double vatAmount;
  final String platformAmount;
  final String bookingNote;
  final String reviewByUser;
  final String reviewByDealer;
  final FeaturedCars? car;
  final Dealer? dealer;
  const BookingHistoryModel({
    required this.id,
    required this.orderId,
    required this.userId,
    required this.supplierId,
    required this.carId,
    required this.price,
    required this.totalPrice,
    required this.pickupLocation,
    required this.returnLocation,
    required this.pickupDate,
    required this.pickupTime,
    required this.returnDate,
    required this.returnTime,
    required this.duration,
    required this.paymentMethod,
    required this.paymentStatus,
    required this.transaction,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.vatAmount,
    required this.platformAmount,
    required this.bookingNote,
    required this.reviewByUser,
    required this.reviewByDealer,
    this.car,
    this.dealer
  });

  BookingHistoryModel copyWith({
    int? id,
    int? orderId,
    int? userId,
    int? supplierId,
    int? carId,
    double? price,
    double? totalPrice,
    String? pickupLocation,
    String? returnLocation,
    String? pickupDate,
    String? pickupTime,
    String? returnDate,
    String? returnTime,
    int? duration,
    String? paymentMethod,
    int? paymentStatus,
    String? transaction,
    int? status,
    String? createdAt,
    String? updatedAt,
    double? vatAmount,
    String? platformAmount,
    String? bookingNote,
    String? reviewByUser,
    String? reviewByDealer,
    FeaturedCars? car,
    Dealer? dealer,
  }) {
    return BookingHistoryModel(
      id: id ?? this.id,
      orderId: orderId ?? this.orderId,
      userId: userId ?? this.userId,
      supplierId: supplierId ?? this.supplierId,
      carId: carId ?? this.carId,
      price: price ?? this.price,
      totalPrice: totalPrice ?? this.totalPrice,
      pickupLocation: pickupLocation ?? this.pickupLocation,
      returnLocation: returnLocation ?? this.returnLocation,
      pickupDate: pickupDate ?? this.pickupDate,
      pickupTime: pickupTime ?? this.pickupTime,
      returnDate: returnDate ?? this.returnDate,
      returnTime: returnTime ?? this.returnTime,
      duration: duration ?? this.duration,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      transaction: transaction ?? this.transaction,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      vatAmount: vatAmount ?? this.vatAmount,
      platformAmount: platformAmount ?? this.platformAmount,
      bookingNote: bookingNote ?? this.bookingNote,
      reviewByUser: reviewByUser ?? this.reviewByUser,
      reviewByDealer: reviewByDealer ?? this.reviewByDealer,
      car: car ?? this.car,
      dealer: dealer ?? this.dealer,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'order_id': orderId,
      'user_id': userId,
      'supplier_id': supplierId,
      'car_id': carId,
      'price': price,
      'total_price': totalPrice,
      'pickup_location': pickupLocation,
      'return_location': returnLocation,
      'pickup_date': pickupDate,
      'pickup_time': pickupTime,
      'return_date': returnDate,
      'return_time': returnTime,
      'duration': duration,
      'payment_method': paymentMethod,
      'payment_status': paymentStatus,
      'transaction': transaction,
      'status': status,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'vat_amount': vatAmount,
      'platform_amount': platformAmount,
      'booking_note': bookingNote,
      'review_by_user': reviewByUser,
      'review_by_dealer': reviewByDealer,
      'car': car?.toMap(),
      'seller': dealer?.toMap(),
    };
  }

  factory BookingHistoryModel.fromMap(Map<String, dynamic> map) {
    return BookingHistoryModel(
      id: map['id'] ?? 0,
      orderId: map['order_id'] ?? 0,
      userId: map['user_id'] ?? 0,
      supplierId: map['supplier_id'] ?? 0,
      carId: map['car_id'] ?? 0,
      price: map['price'] != null ? double.parse(map['price'].toString()) : 0.0,
      totalPrice: map['total_price'] != null ? double.parse(map['total_price'].toString()) : 0.0,
      pickupLocation: map['pickup_location'] ?? '',
      returnLocation: map['return_location'] ?? '',
      pickupDate: map['pickup_date'] ?? '',
      pickupTime: map['pickup_time'] ?? '',
      returnDate: map['return_date'] ?? '',
      returnTime: map['return_time'] ?? '',
      duration: map['duration'] ?? 0,
      paymentMethod: map['payment_method'] ?? '',
      paymentStatus: map['payment_status'] ?? 0,
      transaction: map['transaction'] ?? '',
      status: map['status'] ?? 0,
      createdAt: map['created_at'] ?? '',
      updatedAt: map['updated_at'] ?? '',
      vatAmount: map['vat_amount'] != null ? double.parse(map['vat_amount'].toString()) : 0.0,
      platformAmount: map['platform_amount'] ?? '',
      bookingNote: map['booking_note'] ?? '',
      reviewByUser: map['review_by_user'] ?? '',
      reviewByDealer: map['review_by_dealer'] ?? '',
      car: map['car'] != null
          ? FeaturedCars.fromMap(map['car'] as Map<String, dynamic>)
          : null,
      dealer: map['seller'] != null
          ? Dealer.fromMap(map['seller'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory BookingHistoryModel.fromJson(String source) => BookingHistoryModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      orderId,
      userId,
      supplierId,
      carId,
      price,
      totalPrice,
      pickupLocation,
      returnLocation,
      pickupDate,
      pickupTime,
      returnDate,
      returnTime,
      duration,
      paymentMethod,
      paymentStatus,
      transaction,
      status,
      createdAt,
      updatedAt,
      vatAmount,
      platformAmount,
      bookingNote,
      reviewByUser,
      reviewByDealer,
      car!,
      dealer!

    ];
  }
}
