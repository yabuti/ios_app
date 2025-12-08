// // ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'dart:convert';
// import 'package:equatable/equatable.dart';
// import '../home/home_model.dart';
//
// class BookingRequestModel extends Equatable {
//   final int id;
//   final int orderId;
//   final int userId;
//   final int supplierId;
//   final int carId;
//   final String price;
//   final String totalPrice;
//   final String pickupLocation;
//   final String returnLocation;
//   final String pickupDate;
//   final String pickupTime;
//   final String returnDate;
//   final String returnTime;
//   final int duration;
//   final String paymentMethod;
//   final int paymentStatus;
//   final String transaction;
//   final int status;
//   final String createdAt;
//   final String updatedAt;
//   final String vatAmount;
//   final String platformAmount;
//   final String bookingNote;
//   final FeaturedCars? car;
//   final Seller? seller;
//   final String reviewByUser;
//   final String reviewByDealer;
//
//   const BookingRequestModel({
//     required this.id,
//     required this.orderId,
//     required this.userId,
//     required this.supplierId,
//     required this.carId,
//     required this.price,
//     required this.totalPrice,
//     required this.pickupLocation,
//     required this.returnLocation,
//     required this.pickupDate,
//     required this.pickupTime,
//     required this.returnDate,
//     required this.returnTime,
//     required this.duration,
//     required this.paymentMethod,
//     required this.paymentStatus,
//     required this.transaction,
//     required this.status,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.vatAmount,
//     required this.platformAmount,
//     required this.bookingNote,
//     this.car,
//     this.seller,
//     required this.reviewByUser,
//     required this.reviewByDealer,
//   });
//
//   BookingRequestModel copyWith({
//     int? id,
//     int? orderId,
//     int? userId,
//     int? supplierId,
//     int? carId,
//     String? price,
//     String? totalPrice,
//     String? pickupLocation,
//     String? returnLocation,
//     String? pickupDate,
//     String? pickupTime,
//     String? returnDate,
//     String? returnTime,
//     int? duration,
//     String? paymentMethod,
//     int? paymentStatus,
//     String? transaction,
//     int? status,
//     String? createdAt,
//     String? updatedAt,
//     String? vatAmount,
//     String? platformAmount,
//     String? bookingNote,
//     FeaturedCars? car,
//     Seller? seller,
//     String? reviewByUser,
//     String? reviewByDealer,
//   }) {
//     return BookingRequestModel(
//       id: id ?? this.id,
//       orderId: orderId ?? this.orderId,
//       userId: userId ?? this.userId,
//       supplierId: supplierId ?? this.supplierId,
//       carId: carId ?? this.carId,
//       price: price ?? this.price,
//       totalPrice: totalPrice ?? this.totalPrice,
//       pickupLocation: pickupLocation ?? this.pickupLocation,
//       returnLocation: returnLocation ?? this.returnLocation,
//       pickupDate: pickupDate ?? this.pickupDate,
//       pickupTime: pickupTime ?? this.pickupTime,
//       returnDate: returnDate ?? this.returnDate,
//       returnTime: returnTime ?? this.returnTime,
//       duration: duration ?? this.duration,
//       paymentMethod: paymentMethod ?? this.paymentMethod,
//       paymentStatus: paymentStatus ?? this.paymentStatus,
//       transaction: transaction ?? this.transaction,
//       status: status ?? this.status,
//       createdAt: createdAt ?? this.createdAt,
//       updatedAt: updatedAt ?? this.updatedAt,
//       vatAmount: vatAmount ?? this.vatAmount,
//       platformAmount: platformAmount ?? this.platformAmount,
//       bookingNote: bookingNote ?? this.bookingNote,
//       car: car ?? this.car,
//       seller: seller ?? this.seller,
//       reviewByUser: reviewByUser ?? this.reviewByUser,
//       reviewByDealer: reviewByDealer ?? this.reviewByDealer,
//     );
//   }
//
//   Map<String, dynamic> toMap() {
//     return <String, dynamic>{
//       'id': id,
//       'order_id': orderId,
//       'user_id': userId,
//       'supplier_id': supplierId,
//       'car_id': carId,
//       'price': price,
//       'total_price': totalPrice,
//       'pickup_location': pickupLocation,
//       'return_location': returnLocation,
//       'pickup_date': pickupDate,
//       'pickup_time': pickupTime,
//       'return_date': returnDate,
//       'return_time': returnTime,
//       'duration': duration,
//       'payment_method': paymentMethod,
//       'payment_status': paymentStatus,
//       'transaction': transaction,
//       'status': status,
//       'created_at': createdAt,
//       'updated_at': updatedAt,
//       'vat_amount': vatAmount,
//       'platform_amount': platformAmount,
//       'booking_note': bookingNote,
//       'car': car?.toMap(),
//       'seller': seller?.toMap(),
//       'review_by_user': reviewByUser,
//       'review_by_dealer': reviewByDealer,
//     };
//   }
//
//   factory BookingRequestModel.fromMap(Map<String, dynamic> map) {
//     return BookingRequestModel(
//       id: map['id'] ?? 0,
//       orderId: map['order_id'] ?? 0,
//       userId: map['user_id'] ?? 0,
//       supplierId: map['supplier_id'] ?? 0,
//       carId: map['car_id'] ?? 0,
//       price: map['price'] ?? '',
//       totalPrice: map['total_price'] ?? '',
//       pickupLocation: map['pickup_location'] ?? '',
//       returnLocation: map['return_location'] ?? '',
//       pickupDate: map['pickup_date'] ?? '',
//       pickupTime: map['pickup_time'] ?? '',
//       returnDate: map['return_date'] ?? '',
//       returnTime: map['return_time'] ?? '',
//       duration: map['duration'] ?? 0,
//       paymentMethod: map['payment_method'] ?? '',
//       paymentStatus: map['payment_status'] ?? 0,
//       transaction: map['transaction'] ?? '',
//       status: map['status'] ?? 0,
//       createdAt: map['created_at'] ?? '',
//       updatedAt: map['updated_at'] ?? '',
//       vatAmount: map['vat_amount'] ?? '',
//       platformAmount: map['platform_amount'] ?? '',
//       bookingNote: map['booking_note'] ?? '',
//       car: map['car'] != null
//           ? FeaturedCars.fromMap(map['car'] as Map<String, dynamic>)
//           : null,
//       seller: map['seller'] != null
//           ? Seller.fromMap(map['seller'] as Map<String, dynamic>)
//           : null,
//       reviewByUser: map['review_by_user'] ?? '',
//       reviewByDealer: map['review_by_dealer'] ?? '',
//     );
//   }
//
//   String toJson() => json.encode(toMap());
//
//   factory BookingRequestModel.fromJson(String source) =>
//       BookingRequestModel.fromMap(json.decode(source) as Map<String, dynamic>);
//
//   @override
//   bool get stringify => true;
//
//   @override
//   List<Object> get props {
//     return [
//       id,
//       orderId,
//       userId,
//       supplierId,
//       carId,
//       price,
//       totalPrice,
//       pickupLocation,
//       returnLocation,
//       pickupDate,
//       pickupTime,
//       returnDate,
//       returnTime,
//       duration,
//       paymentMethod,
//       paymentStatus,
//       transaction,
//       status,
//       createdAt,
//       updatedAt,
//       vatAmount,
//       platformAmount,
//       bookingNote,
//       car!,
//       seller!,
//       reviewByUser,
//       reviewByDealer,
//     ];
//   }
// }
//
// class Seller extends Equatable {
//   final int id;
//   final String name;
//   final String phone;
//   final String username;
//   final String address;
//   final String country;
//   final String designation;
//   final String aboutMe;
//   final String googleMap;
//   final String sunday;
//   final String monday;
//   final String tuesday;
//   final String wednesday;
//   final String thursday;
//   final String friday;
//   final String saturday;
//   final String email;
//   final String emailVerifiedAt;
//   final String forgetPasswordToken;
//   final String status;
//   final String isBanned;
//   final String image;
//   final String facebook;
//   final String twitter;
//   final String instagram;
//   final String linkedin;
//   final String createdAt;
//   final String updatedAt;
//   final String provider;
//   final String providerId;
//   final int isDealer;
//   final String verificationOtp;
//   final String forgetPasswordOtp;
//   final int totalCar;
//
//   const Seller({
//     required this.id,
//     required this.name,
//     required this.phone,
//     required this.username,
//     required this.address,
//     required this.country,
//     required this.designation,
//     required this.aboutMe,
//     required this.googleMap,
//     required this.sunday,
//     required this.monday,
//     required this.tuesday,
//     required this.wednesday,
//     required this.thursday,
//     required this.friday,
//     required this.saturday,
//     required this.email,
//     required this.emailVerifiedAt,
//     required this.forgetPasswordToken,
//     required this.status,
//     required this.isBanned,
//     required this.image,
//     required this.facebook,
//     required this.twitter,
//     required this.instagram,
//     required this.linkedin,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.provider,
//     required this.providerId,
//     required this.isDealer,
//     required this.verificationOtp,
//     required this.forgetPasswordOtp,
//     required this.totalCar,
//   });
//
//   Seller copyWith({
//     int? id,
//     String? name,
//     String? phone,
//     String? username,
//     String? address,
//     String? country,
//     String? designation,
//     String? aboutMe,
//     String? googleMap,
//     String? sunday,
//     String? monday,
//     String? tuesday,
//     String? wednesday,
//     String? thursday,
//     String? friday,
//     String? saturday,
//     String? email,
//     String? emailVerifiedAt,
//     String? forgetPasswordToken,
//     String? status,
//     String? isBanned,
//     String? image,
//     String? facebook,
//     String? twitter,
//     String? instagram,
//     String? linkedin,
//     String? createdAt,
//     String? updatedAt,
//     String? provider,
//     String? providerId,
//     int? isDealer,
//     String? verificationOtp,
//     String? forgetPasswordOtp,
//     int? totalCar,
//   }) {
//     return Seller(
//       id: id ?? this.id,
//       name: name ?? this.name,
//       phone: phone ?? this.phone,
//       username: username ?? this.username,
//       address: address ?? this.address,
//       country: country ?? this.country,
//       designation: designation ?? this.designation,
//       aboutMe: aboutMe ?? this.aboutMe,
//       googleMap: googleMap ?? this.googleMap,
//       sunday: sunday ?? this.sunday,
//       monday: monday ?? this.monday,
//       tuesday: tuesday ?? this.tuesday,
//       wednesday: wednesday ?? this.wednesday,
//       thursday: thursday ?? this.thursday,
//       friday: friday ?? this.friday,
//       saturday: saturday ?? this.saturday,
//       email: email ?? this.email,
//       emailVerifiedAt: emailVerifiedAt ?? this.emailVerifiedAt,
//       forgetPasswordToken: forgetPasswordToken ?? this.forgetPasswordToken,
//       status: status ?? this.status,
//       isBanned: isBanned ?? this.isBanned,
//       image: image ?? this.image,
//       facebook: facebook ?? this.facebook,
//       twitter: twitter ?? this.twitter,
//       instagram: instagram ?? this.instagram,
//       linkedin: linkedin ?? this.linkedin,
//       createdAt: createdAt ?? this.createdAt,
//       updatedAt: updatedAt ?? this.updatedAt,
//       provider: provider ?? this.provider,
//       providerId: providerId ?? this.providerId,
//       isDealer: isDealer ?? this.isDealer,
//       verificationOtp: verificationOtp ?? this.verificationOtp,
//       forgetPasswordOtp: forgetPasswordOtp ?? this.forgetPasswordOtp,
//       totalCar: totalCar ?? this.totalCar,
//     );
//   }
//
//   Map<String, dynamic> toMap() {
//     return <String, dynamic>{
//       'id': id,
//       'name': name,
//       'phone': phone,
//       'username': username,
//       'address': address,
//       'country': country,
//       'designation': designation,
//       'about_me': aboutMe,
//       'google_map': googleMap,
//       'sunday': sunday,
//       'monday': monday,
//       'tuesday': tuesday,
//       'wednesday': wednesday,
//       'thursday': thursday,
//       'friday': friday,
//       'saturday': saturday,
//       'email': email,
//       'email_verified_at': emailVerifiedAt,
//       'forget_password_token': forgetPasswordToken,
//       'status': status,
//       'is_banned': isBanned,
//       'image': image,
//       'facebook': facebook,
//       'twitter': twitter,
//       'instagram': instagram,
//       'linkedin': linkedin,
//       'created_at': createdAt,
//       'updated_at': updatedAt,
//       'provider': provider,
//       'provider_id': providerId,
//       'is_dealer': isDealer,
//       'verification_otp': verificationOtp,
//       'forget_password_otp': forgetPasswordOtp,
//       'total_car': totalCar,
//     };
//   }
//
//   factory Seller.fromMap(Map<String, dynamic> map) {
//     return Seller(
//       id: map['id'] ?? 0,
//       name: map['name'] ?? '',
//       phone: map['phone'] ?? '',
//       username: map['username'] ?? '',
//       address: map['address'] ?? '',
//       country: map['country'] ?? '',
//       designation: map['designation'] ?? '',
//       aboutMe: map['about_me'] ?? '',
//       googleMap: map['google_map'] ?? '',
//       sunday: map['sunday'] ?? '',
//       monday: map['monday'] ?? '',
//       tuesday: map['tuesday'] ?? '',
//       wednesday: map['wednesday'] ?? '',
//       thursday: map['thursday'] ?? '',
//       friday: map['friday'] ?? '',
//       saturday: map['saturday'] ?? '',
//       email: map['email'] ?? '',
//       emailVerifiedAt: map['email_verified_at'] ?? '',
//       forgetPasswordToken: map['forget_password_token'] ?? '',
//       status: map['status'] ?? '',
//       isBanned: map['is_banned'] ?? '',
//       image: map['image'] ?? '',
//       facebook: map['facebook'] ?? '',
//       twitter: map['twitter'] ?? '',
//       instagram: map['instagram'] ?? '',
//       linkedin: map['linkedin'] ?? '',
//       createdAt: map['created_at'] ?? '',
//       updatedAt: map['updated_at'] ?? '',
//       provider: map['provider'] ?? '',
//       providerId: map['provider_id'] ?? '',
//       isDealer: map['is_dealer'] ?? 0,
//       verificationOtp: map['verification_otp'] ?? '',
//       forgetPasswordOtp: map['forget_password_otp'] ?? '',
//       totalCar: map['total_car'] ?? 0,
//     );
//   }
//
//   String toJson() => json.encode(toMap());
//
//   factory Seller.fromJson(String source) =>
//       Seller.fromMap(json.decode(source) as Map<String, dynamic>);
//
//   @override
//   bool get stringify => true;
//
//   @override
//   List<Object> get props {
//     return [
//       id,
//       name,
//       phone,
//       username,
//       address,
//       country,
//       designation,
//       aboutMe,
//       googleMap,
//       sunday,
//       monday,
//       tuesday,
//       wednesday,
//       thursday,
//       friday,
//       saturday,
//       email,
//       emailVerifiedAt,
//       forgetPasswordToken,
//       status,
//       isBanned,
//       image,
//       facebook,
//       twitter,
//       instagram,
//       linkedin,
//       createdAt,
//       updatedAt,
//       provider,
//       providerId,
//       isDealer,
//       verificationOtp,
//       forgetPasswordOtp,
//       totalCar,
//     ];
//   }
// }
