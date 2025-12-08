// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:carsbnb/logic/cubit/profile/profile_state.dart';
import 'package:equatable/equatable.dart';

class UserModel {
  final int id;
  final String name;

  UserModel({required this.id, required this.name});

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] ?? 0,
      name: map['name'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }
}

class UserResponseModel extends Equatable {
  final String accessToken;
  final String tokenType;
  final int expiresIn;
  final User user; // Non-nullable now
  final String userType;

  const UserResponseModel({
    required this.accessToken,
    required this.tokenType,
    required this.expiresIn,
    required this.user,
    required this.userType,
  });

  UserResponseModel copyWith({
    String? accessToken,
    String? tokenType,
    int? expiresIn,
    User? user,
    String? userType,
  }) {
    return UserResponseModel(
      accessToken: accessToken ?? this.accessToken,
      tokenType: tokenType ?? this.tokenType,
      expiresIn: expiresIn ?? this.expiresIn,
      user: user ?? this.user,
      userType: userType ?? this.userType,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'access_token': accessToken,
      'token_type': tokenType,
      'expires_in': expiresIn,
      'user': user.toMap(),
      'user_type': userType,
    };
  }

  factory UserResponseModel.fromMap(Map<String, dynamic> map) {
    // Helper function to safely convert to int
    int safeInt(dynamic value, [int defaultValue = 0]) {
      if (value == null) return defaultValue;
      if (value is int) return value;
      if (value is String) {
        return int.tryParse(value) ?? defaultValue;
      }
      if (value is double) return value.toInt();
      return defaultValue;
    }

    return UserResponseModel(
      accessToken: map['access_token']?.toString() ?? map['token']?.toString() ?? '',
      tokenType: map['token_type']?.toString() ?? 'Bearer',
      expiresIn: safeInt(map['expires_in']),
      user: map['user'] != null ? User.fromMap(map['user']) : User.init(),
      userType: map['user_type']?.toString() ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserResponseModel.fromJson(String source) =>
      UserResponseModel.fromMap(json.decode(source));

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [accessToken, tokenType, expiresIn, user, userType];
}

class User extends Equatable {
  final int id;
  final String username;
  final String name;
  final String email;
  final String phone;
  final String image;
  final String tempImage;
  final String bannerImage;
  final String bannerTempImage;
  final String status;
  final String isBanned;
  final int isDealer;
  final String designation;
  final String address;
  final int totalCar;
  final ProfileState profileState;

  const User({
    this.id = 0,
    this.username = '',
    this.name = '',
    this.email = '',
    this.phone = '',
    this.image = '',
    this.tempImage = '',
    this.bannerImage = '',
    this.bannerTempImage = '',
    this.status = '',
    this.isBanned = '',
    this.isDealer = 0,
    this.designation = '',
    this.address = '',
    this.totalCar = 0,
    this.profileState = const ProfileInitial(),
  });

  User copyWith({
    int? id,
    String? username,
    String? name,
    String? email,
    String? phone,
    String? image,
    String? tempImage,
    String? bannerImage,
    String? bannerTempImage,
    String? status,
    String? isBanned,
    int? isDealer,
    String? designation,
    String? address,
    int? totalCar,
    ProfileState? profileState,
  }) {
    return User(
      id: id ?? this.id,
      username: username ?? this.username,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      image: image ?? this.image,
      tempImage: tempImage ?? this.tempImage,
      bannerImage: bannerImage ?? this.bannerImage,
      bannerTempImage: bannerTempImage ?? this.bannerTempImage,
      status: status ?? this.status,
      isBanned: isBanned ?? this.isBanned,
      isDealer: isDealer ?? this.isDealer,
      designation: designation ?? this.designation,
      address: address ?? this.address,
      totalCar: totalCar ?? this.totalCar,
      profileState: profileState ?? this.profileState,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'name': name,
      'email': email,
      'phone': phone,
      'image': image,
      'banner_image': bannerImage,
      'status': status,
      'is_banned': isBanned,
      'is_dealer': isDealer,
      'designation': designation,
      'address': address,
      'total_car': totalCar,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    // Helper function to safely convert to int
    int safeInt(dynamic value, [int defaultValue = 0]) {
      if (value == null) return defaultValue;
      if (value is int) return value;
      if (value is String) {
        return int.tryParse(value) ?? defaultValue;
      }
      if (value is double) return value.toInt();
      return defaultValue;
    }

    return User(
      id: safeInt(map['id']),
      username: map['username']?.toString() ?? '',
      name: map['name']?.toString() ?? '',
      email: map['email']?.toString() ?? '',
      phone: map['phone']?.toString() ?? '',
      image: map['image']?.toString() ?? '',
      bannerImage: map['banner_image']?.toString() ?? '',
      status: map['status']?.toString() ?? '',
      isBanned: map['is_banned']?.toString() ?? '',
      isDealer: safeInt(map['is_dealer']),
      designation: map['designation']?.toString() ?? '',
      address: map['address']?.toString() ?? '',
      totalCar: safeInt(map['total_car']),
    );
  }

  static User init() => const User();

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  List<Object> get props => [
        id,
        username,
        name,
        email,
        phone,
        image,
        tempImage,
        bannerImage,
        bannerTempImage,
        status,
        isBanned,
        isDealer,
        designation,
        address,
        totalCar,
        profileState,
      ];

  @override
  bool get stringify => true;
}
