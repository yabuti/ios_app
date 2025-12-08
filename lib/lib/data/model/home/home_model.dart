// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class HomeModel extends Equatable {
  final List<Sliders>? sliders;
  final List<Brands>? brands;
  final List<FeaturedCars>? featuredCars;
  final List<AdsBanners>? adsBanners;
  final List<Dealers>? dealers;
  final JoinDealer? joinDealer;
  final List<FeaturedCars>? latestCars;
  const HomeModel({
    this.sliders,
    this.brands,
    this.featuredCars,
    this.adsBanners,
    this.dealers,
    this.joinDealer,
    this.latestCars,
  });

  HomeModel copyWith({
    List<Sliders>? sliders,
    List<Brands>? brands,
    List<FeaturedCars>? featuredCars,
    List<AdsBanners>? adsBanners,
    List<Dealers>? dealers,
    JoinDealer? joinDealer,
    List<FeaturedCars>? latestCars,
  }) {
    return HomeModel(
      sliders: sliders ?? this.sliders,
      brands: brands ?? this.brands,
      featuredCars: featuredCars ?? this.featuredCars,
      adsBanners: adsBanners ?? this.adsBanners,
      dealers: dealers ?? this.dealers,
      joinDealer: joinDealer ?? this.joinDealer,
      latestCars: latestCars ?? this.latestCars,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'sliders': sliders?.map((x) => x.toMap()).toList(),
      'brands': brands?.map((x) => x.toMap()).toList(),
      'featured_cars': featuredCars?.map((x) => x.toMap()).toList(),
      'ads_banners': adsBanners?.map((x) => x.toMap()).toList(),
      'dealers': dealers?.map((x) => x.toMap()).toList(),
      'join_dealer': joinDealer?.toMap(),
      'latestCars': latestCars?.map((x) => x.toMap()).toList(),
    };
  }

  factory HomeModel.fromMap(Map<String, dynamic> map) {
    return HomeModel(
      sliders: map['sliders'] != null
          ? List<Sliders>.from(
              (map['sliders'] as List<dynamic>).map<Sliders?>(
                (x) => Sliders.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      brands: map['brands'] != null
          ? List<Brands>.from(
              (map['brands'] as List<dynamic>).map<Brands?>(
                (x) => Brands.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      featuredCars: map['featured_cars'] != null
          ? List<FeaturedCars>.from(
              (map['featured_cars'] as List<dynamic>).map<FeaturedCars?>(
                (x) => FeaturedCars.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      adsBanners: map['ads_banners'] != null
          ? List<AdsBanners>.from(
              (map['ads_banners'] as List<dynamic>).map<AdsBanners?>(
                (x) => AdsBanners.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      dealers: map['dealers'] != null
          ? List<Dealers>.from(
              (map['dealers'] as List<dynamic>).map<Dealers?>(
                (x) => Dealers.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      joinDealer: map['join_dealer'] != null
          ? JoinDealer.fromMap(map['join_dealer'] as Map<String, dynamic>)
          : null,
      latestCars: map['latest_cars'] != null
          ? List<FeaturedCars>.from(
              (map['latest_cars'] as List<dynamic>).map<FeaturedCars?>(
                (x) => FeaturedCars.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory HomeModel.fromJson(String source) =>
      HomeModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      sliders!,
      brands!,
      featuredCars!,
      adsBanners!,
      dealers!,
      joinDealer!,
      latestCars!,
    ];
  }
}

class Sliders extends Equatable {
  final int id;
  final String image;
  final String status;
  final String createdAt;
  final String updatedAt;
  const Sliders({
    required this.id,
    required this.image,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  Sliders copyWith({
    int? id,
    String? image,
    String? status,
    String? createdAt,
    String? updatedAt,
  }) {
    return Sliders(
      id: id ?? this.id,
      image: image ?? this.image,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'image': image,
      'status': status,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  factory Sliders.fromMap(Map<String, dynamic> map) {
    return Sliders(
      id: map['id'] ?? 0,
      image: map['image'] ?? '',
      status: map['status'] ?? '',
      createdAt: map['created_at'] ?? '',
      updatedAt: map['updated_at'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Sliders.fromJson(String source) =>
      Sliders.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      image,
      status,
      createdAt,
      updatedAt,
    ];
  }
}

class Brands extends Equatable {
  final int id;
  final String image;
  final String slug;
  final String status;
  final String createdAt;
  final String updatedAt;
  final String name;
  final int totalCar;

  const Brands({
    required this.id,
    required this.image,
    required this.slug,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.name,
    required this.totalCar,
  });

  Brands copyWith({
    int? id,
    String? image,
    String? slug,
    String? status,
    String? createdAt,
    String? updatedAt,
    String? name,
    int? totalCar,
  }) {
    return Brands(
      id: id ?? this.id,
      image: image ?? this.image,
      slug: slug ?? this.slug,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      name: name ?? this.name,
      totalCar: totalCar ?? this.totalCar,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'image': image,
      'slug': slug,
      'status': status,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'name': name,
      'total_car': totalCar,
    };
  }

  factory Brands.fromMap(Map<String, dynamic> map) {
    return Brands(
      id: map['id'] ?? 0,
      image: map['image'] ?? '',
      slug: map['slug'] ?? '',
      status: map['status'] ?? '',
      createdAt: map['created_at'] ?? '',
      updatedAt: map['updated_at'] ?? '',
      name: map['name'] ?? '',
      totalCar: map['total_car'] ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Brands.fromJson(String source) =>
      Brands.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      image,
      slug,
      status,
      createdAt,
      updatedAt,
      name,
      totalCar,
    ];
  }
}

class AdsBanners extends Equatable {
  final int id;
  final String image;
  final String link;
  final String status;
  final String createdAt;
  final String updatedAt;

  const AdsBanners({
    required this.id,
    required this.image,
    required this.link,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  AdsBanners copyWith({
    int? id,
    String? image,
    String? link,
    String? status,
    String? createdAt,
    String? updatedAt,
  }) {
    return AdsBanners(
      id: id ?? this.id,
      image: image ?? this.image,
      link: link ?? this.link,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'image': image,
      'link': link,
      'status': status,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  factory AdsBanners.fromMap(Map<String, dynamic> map) {
    return AdsBanners(
      id: map['id'] ?? 0,
      image: map['image'] ?? '',
      link: map['link'] ?? '',
      status: map['status'] ?? '',
      createdAt: map['created_at'] ?? '',
      updatedAt: map['updated_at'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory AdsBanners.fromJson(String source) =>
      AdsBanners.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      image,
      link,
      status,
      createdAt,
      updatedAt,
    ];
  }
}

class CityModel extends Equatable {
  final List<City>? cities;

  const CityModel({this.cities});

  factory CityModel.fromMap(Map<String, dynamic> map) {
    return CityModel(
      cities: map['cities'] != null
          ? List<City>.from(
              (map['cities'] as List<dynamic>).map(
                (x) => City.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'cities': cities?.map((x) => x.toMap()).toList(),
    };
  }

  String toJson() => json.encode(toMap());

  factory CityModel.fromJson(String source) =>
      CityModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  List<Object?> get props => [cities];
}

class City extends Equatable {
  final int id;
  final String name;

  const City({
    required this.id,
    required this.name,
  });

  factory City.fromMap(Map<String, dynamic> map) {
    return City(
      id: map['id'] != null ? int.parse(map['id'].toString()) : 0,
      name: map['name'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

  @override
  List<Object> get props => [id, name];
}

class FeaturedCars extends Equatable {
  final int id;
  final int agentId;
  final int brandId;
  final int cityId;
  final String thumbImage;
  final String slug;
  final String features;
  final String purpose;
  final String condition;
  final int totalView;
  final String regularPrice;
  final String offerPrice;
  final String videoId;
  final String videoImage;
  final String googleMap;
  final String bodyType;
  final String engineSize;
  final String drive;
  final String interiorColor;
  final String exteriorColor;
  final String year;
  final String mileage;
  final String numberOfSeat;
  final String numberOfOwner;
  final String fuelType;
  final String transmission;
  final String sellerType;
  final String expiredDate;
  final String isFeatured;
  final String status;
  final String approvedByAdmin;
  final String createdAt;
  final String updatedAt;
  final String rentPeriod;
  final int countryId;
  final String acCondation;
  final int totalRides;
  final int carTypeId;
  final int minBookingDate;
  final String allowDuplicateBooking;
  final String title;
  final String description;
  final String videoDescription;
  final String address;
  final String seoTitle;
  final String seoDescription;
  final double averageRating;
  final int totalReview;
  final Brands? brands;

  const FeaturedCars({
    required this.id,
    required this.agentId,
    required this.brandId,
    required this.cityId,
    required this.thumbImage,
    required this.slug,
    required this.features,
    required this.purpose,
    required this.condition,
    required this.totalView,
    required this.regularPrice,
    required this.offerPrice,
    required this.videoId,
    required this.videoImage,
    required this.googleMap,
    required this.bodyType,
    required this.engineSize,
    required this.drive,
    required this.interiorColor,
    required this.exteriorColor,
    required this.year,
    required this.mileage,
    required this.numberOfSeat,
    required this.numberOfOwner,
    required this.fuelType,
    required this.transmission,
    required this.sellerType,
    required this.expiredDate,
    required this.isFeatured,
    required this.status,
    required this.approvedByAdmin,
    required this.createdAt,
    required this.updatedAt,
    required this.rentPeriod,
    required this.countryId,
    required this.acCondation,
    required this.totalRides,
    required this.carTypeId,
    required this.minBookingDate,
    required this.allowDuplicateBooking,
    required this.title,
    required this.description,
    required this.videoDescription,
    required this.address,
    required this.seoTitle,
    required this.seoDescription,
    required this.averageRating,
    required this.totalReview,
    this.brands,
  });

  FeaturedCars copyWith({
    int? id,
    int? agentId,
    int? brandId,
    int? cityId,
    String? thumbImage,
    String? slug,
    String? features,
    String? purpose,
    String? condition,
    int? totalView,
    String? regularPrice,
    String? offerPrice,
    String? videoId,
    String? videoImage,
    String? googleMap,
    String? bodyType,
    String? engineSize,
    String? drive,
    String? interiorColor,
    String? exteriorColor,
    String? year,
    String? mileage,
    String? numberOfSeat,
    String? numberOfOwner,
    String? fuelType,
    String? transmission,
    String? sellerType,
    String? expiredDate,
    String? isFeatured,
    String? status,
    String? approvedByAdmin,
    String? createdAt,
    String? updatedAt,
    String? rentPeriod,
    int? countryId,
    String? acCondation,
    int? totalRides,
    int? carTypeId,
    int? minBookingDate,
    String? allowDuplicateBooking,
    String? title,
    String? description,
    String? videoDescription,
    String? address,
    String? seoTitle,
    String? seoDescription,
    double? averageRating,
    int? totalReview,
    Brands? brands,
  }) {
    return FeaturedCars(
      id: id ?? this.id,
      agentId: agentId ?? this.agentId,
      brandId: brandId ?? this.brandId,
      cityId: cityId ?? this.cityId,
      thumbImage: thumbImage ?? this.thumbImage,
      slug: slug ?? this.slug,
      features: features ?? this.features,
      purpose: purpose ?? this.purpose,
      condition: condition ?? this.condition,
      totalView: totalView ?? this.totalView,
      regularPrice: regularPrice ?? this.regularPrice,
      offerPrice: offerPrice ?? this.offerPrice,
      videoId: videoId ?? this.videoId,
      videoImage: videoImage ?? this.videoImage,
      googleMap: googleMap ?? this.googleMap,
      bodyType: bodyType ?? this.bodyType,
      engineSize: engineSize ?? this.engineSize,
      drive: drive ?? this.drive,
      interiorColor: interiorColor ?? this.interiorColor,
      exteriorColor: exteriorColor ?? this.exteriorColor,
      year: year ?? this.year,
      mileage: mileage ?? this.mileage,
      numberOfSeat: numberOfSeat ?? this.numberOfSeat,
      numberOfOwner: numberOfOwner ?? this.numberOfOwner,
      fuelType: fuelType ?? this.fuelType,
      transmission: transmission ?? this.transmission,
      sellerType: sellerType ?? this.sellerType,
      expiredDate: expiredDate ?? this.expiredDate,
      isFeatured: isFeatured ?? this.isFeatured,
      status: status ?? this.status,
      approvedByAdmin: approvedByAdmin ?? this.approvedByAdmin,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rentPeriod: rentPeriod ?? this.rentPeriod,
      countryId: countryId ?? this.countryId,
      acCondation: acCondation ?? this.acCondation,
      totalRides: totalRides ?? this.totalRides,
      carTypeId: carTypeId ?? this.carTypeId,
      minBookingDate: minBookingDate ?? this.minBookingDate,
      allowDuplicateBooking:
          allowDuplicateBooking ?? this.allowDuplicateBooking,
      title: title ?? this.title,
      description: description ?? this.description,
      videoDescription: videoDescription ?? this.videoDescription,
      address: address ?? this.address,
      seoTitle: seoTitle ?? this.seoTitle,
      seoDescription: seoDescription ?? this.seoDescription,
      averageRating: averageRating ?? this.averageRating,
      totalReview: totalReview ?? this.totalReview,
      brands: brands ?? this.brands,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'agent_id': agentId,
      'brand_id': brandId,
      'city_id': cityId,
      'thumb_image': thumbImage,
      'slug': slug,
      'features': features,
      'purpose': purpose,
      'condition': condition,
      'total_view': totalView,
      'regular_price': regularPrice,
      'offer_price': offerPrice,
      'video_id': videoId,
      'video_image': videoImage,
      'google_map': googleMap,
      'body_type': bodyType,
      'engine_size': engineSize,
      'drive': drive,
      'interior_color': interiorColor,
      'exterior_color': exteriorColor,
      'year': year,
      'mileage': mileage,
      'number_of_seat': numberOfSeat,
      'number_of_owner': numberOfOwner,
      'fuel_type': fuelType,
      'transmission': transmission,
      'seller_type': sellerType,
      'expired_date': expiredDate,
      'is_featured': isFeatured,
      'status': status,
      'approved_by_admin': approvedByAdmin,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'rent_period': rentPeriod,
      'country_id': countryId,
      'ac_condation': acCondation,
      'total_rides': totalRides,
      'car_type_id': carTypeId,
      'min_booking_date': minBookingDate,
      'allow_duplicate_booking': allowDuplicateBooking,
      'title': title,
      'description': description,
      'video_description': videoDescription,
      'address': address,
      'seo_title': seoTitle,
      'seo_description': seoDescription,
      'averageRating': averageRating,
      'TotalReview': totalReview,
      'brand': brands?.toMap(),
    };
  }

  factory FeaturedCars.fromMap(Map<String, dynamic> map) {
    return FeaturedCars(
      id: map['id'] ?? 0,
      agentId:
          map['agent_id'] != null ? int.parse(map['agent_id'].toString()) : 0,
      brandId:
          map['brand_id'] != null ? int.parse(map['brand_id'].toString()) : 0,
      cityId: map['city_id'] != null ? int.parse(map['city_id'].toString()) : 0,
      thumbImage: map['thumb_image'] ?? '',
      slug: map['slug'] ?? '',
      features: map['features'] ?? '',
      purpose: map['purpose'] ?? '',
      condition: map['condition'] ?? '',
      totalView: map['total_view'] != null
          ? int.parse(map['total_view'].toString())
          : 0,
      regularPrice: map['regular_price'] ?? '',
      offerPrice: map['offer_price'] ?? '',
      videoId: map['video_id'] ?? '',
      videoImage: map['video_image'] ?? '',
      googleMap: map['google_map'] ?? '',
      bodyType: map['body_type'] ?? '',
      engineSize: map['engine_size'] ?? '',
      drive: map['drive'] ?? '',
      interiorColor: map['interior_color'] ?? '',
      exteriorColor: map['exterior_color'] ?? '',
      year: map['year'] ?? '',
      mileage: map['mileage'] ?? '',
      numberOfSeat: map['number_of_seat'] ?? '',
      numberOfOwner: map['number_of_owner'] ?? '',
      fuelType: map['fuel_type'] ?? '',
      transmission: map['transmission'] ?? '',
      sellerType: map['seller_type'] ?? '',
      expiredDate: map['expired_date'] ?? '',
      isFeatured: map['is_featured'] ?? '',
      status: map['status'] ?? '',
      approvedByAdmin: map['approved_by_admin'] ?? '',
      createdAt: map['created_at'] ?? '',
      updatedAt: map['updated_at'] ?? '',
      rentPeriod: map['rent_period'] ?? '',
      countryId: map['country_id'] != null
          ? int.parse(map['country_id'].toString())
          : 0,
      acCondation: map['ac_condation'] ?? '',
      totalRides: map['total_rides'] != null
          ? int.parse(map['total_rides'].toString())
          : 0,
      carTypeId: map['car_type_id'] != null
          ? int.parse(map['car_type_id'].toString())
          : 0,
      minBookingDate: map['min_booking_date'] != null
          ? int.parse(map['min_booking_date'].toString())
          : 0,
      allowDuplicateBooking: map['allow_duplicate_booking'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      videoDescription: map['video_description'] ?? '',
      address: map['address'] ?? '',
      seoTitle: map['seo_title'] ?? '',
      seoDescription: map['seo_description'] ?? '',
      averageRating: map['averageRating'] != null
          ? double.parse(map['averageRating'].toString())
          : 0.0,
      totalReview: map['TotalReview'] != null
          ? int.parse(map['TotalReview'].toString())
          : 0,
      brands: map['brand'] != null
          ? Brands.fromMap(map['brand'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory FeaturedCars.fromJson(String source) =>
      FeaturedCars.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      agentId,
      brandId,
      cityId,
      thumbImage,
      slug,
      features,
      purpose,
      condition,
      totalView,
      regularPrice,
      offerPrice,
      videoId,
      videoImage,
      googleMap,
      bodyType,
      engineSize,
      drive,
      interiorColor,
      exteriorColor,
      year,
      mileage,
      numberOfSeat,
      numberOfOwner,
      fuelType,
      transmission,
      sellerType,
      expiredDate,
      isFeatured,
      status,
      approvedByAdmin,
      createdAt,
      updatedAt,
      rentPeriod,
      countryId,
      acCondation,
      totalRides,
      carTypeId,
      minBookingDate,
      allowDuplicateBooking,
      title,
      description,
      videoDescription,
      address,
      seoTitle,
      seoDescription,
      averageRating,
      totalReview,
      // brands!,
    ];
  }
}

class Dealers extends Equatable {
  final int id;
  final String name;
  final String username;
  final String designation;
  final String image;
  final String status;
  final String isBanned;
  final int isDealer;
  final String address;
  final String email;
  final String phone;
  final String kycStatus;
  final int totalCar;
  const Dealers({
    required this.id,
    required this.name,
    required this.username,
    required this.designation,
    required this.image,
    required this.status,
    required this.isBanned,
    required this.isDealer,
    required this.address,
    required this.email,
    required this.phone,
    required this.kycStatus,
    required this.totalCar,
  });

  Dealers copyWith({
    int? id,
    String? name,
    String? username,
    String? designation,
    String? image,
    String? status,
    String? isBanned,
    int? isDealer,
    String? address,
    String? email,
    String? phone,
    String? kycStatus,
    int? totalCar,
  }) {
    return Dealers(
      id: id ?? this.id,
      name: name ?? this.name,
      username: username ?? this.username,
      designation: designation ?? this.designation,
      image: image ?? this.image,
      status: status ?? this.status,
      isBanned: isBanned ?? this.isBanned,
      isDealer: isDealer ?? this.isDealer,
      address: address ?? this.address,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      kycStatus: kycStatus ?? this.kycStatus,
      totalCar: totalCar ?? this.totalCar,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'username': username,
      'designation': designation,
      'image': image,
      'status': status,
      'is_banned': isBanned,
      'is_dealer': isDealer,
      'address': address,
      'email': email,
      'phone': phone,
      'kyc_status': kycStatus,
      'totalCar': totalCar,
    };
  }

  factory Dealers.fromMap(Map<String, dynamic> map) {
    return Dealers(
      id: map['id'] ?? 0,
      name: map['name'] ?? '',
      username: map['username'] ?? '',
      designation: map['designation'] ?? '',
      image: map['image'] ?? '',
      status: map['status'] ?? '',
      isBanned: map['is_banned'] ?? '',
      isDealer:
          map['is_dealer'] != null ? int.parse(map['is_dealer'].toString()) : 0,
      address: map['address'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
      kycStatus: map['kyc_status'] ?? '',
      totalCar:
          map['total_car'] != null ? int.parse(map['total_car'].toString()) : 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Dealers.fromJson(String source) =>
      Dealers.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      name,
      username,
      designation,
      image,
      status,
      isBanned,
      isDealer,
      address,
      email,
      phone,
      kycStatus,
      totalCar,
    ];
  }
}

class JoinDealer extends Equatable {
  final String image;
  final String title;
  final String shortTitle;

  const JoinDealer({
    required this.image,
    required this.title,
    required this.shortTitle,
  });

  JoinDealer copyWith({
    String? image,
    String? title,
    String? shortTitle,
  }) {
    return JoinDealer(
      image: image ?? this.image,
      title: title ?? this.title,
      shortTitle: shortTitle ?? this.shortTitle,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'image': image,
      'title': title,
      'short_title': shortTitle,
    };
  }

  factory JoinDealer.fromMap(Map<String, dynamic> map) {
    return JoinDealer(
      image: map['image'] as String,
      title: map['title'] as String,
      shortTitle: map['short_title'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory JoinDealer.fromJson(String source) =>
      JoinDealer.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [image, title, shortTitle];
}
