import 'dart:convert';
import 'package:carsbnb/logic/cubit/manage_car/manage_car_state.dart';
import 'package:equatable/equatable.dart';

class CarsStateModel extends Equatable {
  final String agentId;
  final String brandId;
  final String cityId;
  final String thumbImage;
  final String tempImage;
  final String tempVideoImage;
  final String slug;
  final List<String>? features;
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
  final String countryId;
  final String acCondation;
  final int totalRides;
  final String carTypeId;
  final String minBookingDate;
  final String allowDuplicateBooking;
  final String title;
  final String description;
  final String videoDescription;
  final String address;
  final String seoTitle;
  final String seoDescription;
  final double averageRating;
  final int totalReview;
  final String translateId;
  final String carModel;
  final List<String>? galleryImages;
  final ManageCarState manageCarState;

  const CarsStateModel({
    this.agentId = '',
    this.brandId = '',
    this.cityId = '',
    this.thumbImage = '',
    this.tempImage = '',
    this.slug = '',
    this.features = const [],
    this.purpose = '',
    this.condition = '',
    this.totalView = 0,
    this.regularPrice = '',
    this.offerPrice = '',
    this.videoId = '',
    this.videoImage = '',
    this.tempVideoImage = '',
    this.googleMap = '',
    this.bodyType = '',
    this.engineSize = '',
    this.drive = '',
    this.interiorColor = '',
    this.exteriorColor = '',
    this.year = '',
    this.mileage = '',
    this.numberOfSeat = '',
    this.numberOfOwner = '',
    this.fuelType = '',
    this.transmission = '',
    this.sellerType = '',
    this.expiredDate = '',
    this.isFeatured = '',
    this.status = '',
    this.approvedByAdmin = '',
    this.createdAt = '',
    this.updatedAt = '',
    this.rentPeriod = '',
    this.countryId = '',
    this.acCondation = '',
    this.totalRides = 0,
    this.carTypeId = '',
    this.minBookingDate = '',
    this.allowDuplicateBooking = '',
    this.title = '',
    this.description = '',
    this.videoDescription = '',
    this.address = '',
    this.seoTitle = '',
    this.seoDescription = '',
    this.averageRating = 0,
    this.totalReview = 0,
    this.translateId = '',
    this.carModel = '',
    this.galleryImages = const [],
    this.manageCarState = const ManageCarInitial(),
  });

  CarsStateModel copyWith({
    String? agentId,
    String? brandId,
    String? cityId,
    String? thumbImage,
    String? tempImage,
    String? slug,
    List<String>? features,
    String? purpose,
    String? condition,
    int? totalView,
    String? regularPrice,
    String? offerPrice,
    String? videoId,
    String? videoImage,
    String? tempVideoImage,
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
    String? countryId,
    String? acCondation,
    int? totalRides,
    String? carTypeId,
    String? minBookingDate,
    String? allowDuplicateBooking,
    String? title,
    String? description,
    String? videoDescription,
    String? address,
    String? seoTitle,
    String? seoDescription,
    double? averageRating,
    int? totalReview,
    String? translateId,
    String? carModel,
    List<String>? galleryImages,
    ManageCarState? manageCarState,
  }) {
    return CarsStateModel(
      agentId: agentId ?? this.agentId,
      brandId: brandId ?? this.brandId,
      cityId: cityId ?? this.cityId,
      thumbImage: thumbImage ?? this.thumbImage,
      tempImage: tempImage ?? this.tempImage,
      slug: slug ?? this.slug,
      features: features ?? this.features,
      purpose: purpose ?? this.purpose,
      condition: condition ?? this.condition,
      totalView: totalView ?? this.totalView,
      regularPrice: regularPrice ?? this.regularPrice,
      offerPrice: offerPrice ?? this.offerPrice,
      videoId: videoId ?? this.videoId,
      videoImage: videoImage ?? this.videoImage,
      tempVideoImage: tempVideoImage ?? this.tempVideoImage,
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
      manageCarState: manageCarState ?? this.manageCarState,
      translateId: translateId ?? this.translateId,
      carModel: carModel ?? this.carModel,
      galleryImages: galleryImages ?? this.galleryImages,
    );
  }

  Map<String, String> toMap() {
    final map = <String, String>{
      'agent_id': agentId,
      'brand_id': brandId,
      'city_id': cityId,
      'thumb_image': thumbImage,
      'slug': slug,
      'features': features?.join(',') ?? '',
      'purpose': purpose,
      'condition': condition,
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
      'car_type_id': carTypeId,
      'min_booking_date': minBookingDate,
      'allow_duplicate_booking': allowDuplicateBooking,
      'title': title,
      'description': description,
      'video_description': videoDescription,
      'address': address,
      'seo_title': seoTitle,
      'seo_description': seoDescription,
      'translate_id': translateId,
      'car_model': carModel,
    };

    // Add gallery images as an array if not empty
    if (galleryImages != null && galleryImages!.isNotEmpty) {
      for (int i = 0; i < galleryImages!.length; i++) {
        map['file[$i]'] = galleryImages![i];
      }
    }

    return map;
  }

  factory CarsStateModel.fromMap(Map<String, dynamic> map) {
    return CarsStateModel(
      agentId: map['agent_id'] ?? 0,
      brandId: map['brand_id'] ?? 0,
      cityId: map['city_id'] ?? 0,
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
      countryId: map['country_id'] ?? '',
      acCondation: map['ac_condation'] ?? '',
      totalRides: map['total_rides'] != null
          ? int.parse(map['total_rides'].toString())
          : 0,
      carTypeId: map['car_type_id'] ?? '',
      minBookingDate: map['min_booking_date'] ?? '',
      allowDuplicateBooking: map['allow_duplicate_booking'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      videoDescription: map['video_description'] ?? '',
      address: map['address'] ?? '',
      seoTitle: map['seo_title'] ?? '',
      seoDescription: map['seo_description'] ?? '',
      translateId: map['translate_id'] ?? '',
      averageRating: map['averageRating'] != null
          ? double.parse(map['averageRating'].toString())
          : 0.0,
      totalReview: map['TotalReview'] != null
          ? int.parse(map['TotalReview'].toString())
          : 0,
    );
  }

  static CarsStateModel init() {
    return const CarsStateModel(
      agentId: '',
      brandId: '',
      cityId: '',
      thumbImage: '',
      tempImage: '',
      slug: '',
      features: [],
      purpose: '',
      condition: '',
      totalView: 0,
      regularPrice: '',
      offerPrice: '',
      videoId: '',
      videoImage: '',
      tempVideoImage: '',
      googleMap: '',
      bodyType: '',
      engineSize: '',
      drive: '',
      interiorColor: '',
      exteriorColor: '',
      year: '',
      mileage: '',
      numberOfSeat: '',
      numberOfOwner: '',
      fuelType: '',
      transmission: '',
      sellerType: '',
      expiredDate: '',
      isFeatured: '',
      status: '',
      approvedByAdmin: '',
      createdAt: '',
      updatedAt: '',
      rentPeriod: '',
      countryId: '',
      acCondation: '',
      totalRides: 0,
      carTypeId: '',
      minBookingDate: '',
      allowDuplicateBooking: '',
      title: '',
      description: '',
      videoDescription: '',
      address: '',
      seoTitle: '',
      seoDescription: '',
      averageRating: 0,
      totalReview: 0,
      translateId: '',
      carModel: '',
      manageCarState: ManageCarInitial(),
    );
  }

  static CarsStateModel reset() {
    return const CarsStateModel(
      agentId: '',
      brandId: '',
      cityId: '',
      thumbImage: '',
      tempImage: '',
      slug: '',
      features: [],
      purpose: '',
      condition: '',
      totalView: 0,
      regularPrice: '',
      offerPrice: '',
      videoId: '',
      videoImage: '',
      tempVideoImage: '',
      googleMap: '',
      bodyType: '',
      engineSize: '',
      drive: '',
      interiorColor: '',
      exteriorColor: '',
      year: '',
      mileage: '',
      numberOfSeat: '',
      numberOfOwner: '',
      fuelType: '',
      transmission: '',
      sellerType: '',
      expiredDate: '',
      isFeatured: '',
      status: '',
      approvedByAdmin: '',
      createdAt: '',
      updatedAt: '',
      rentPeriod: '',
      countryId: '',
      acCondation: '',
      totalRides: 0,
      carTypeId: '',
      minBookingDate: '',
      allowDuplicateBooking: '',
      title: '',
      description: '',
      videoDescription: '',
      address: '',
      seoTitle: '',
      seoDescription: '',
      averageRating: 0,
      totalReview: 0,
      translateId: '',
      carModel: '',
      manageCarState: ManageCarInitial(),
    );
  }

  String toJson() => json.encode(toMap());

  factory CarsStateModel.fromJson(String source) =>
      CarsStateModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      agentId,
      brandId,
      cityId,
      thumbImage,
      tempImage,
      slug,
      features!,
      purpose,
      condition,
      totalView,
      regularPrice,
      offerPrice,
      videoId,
      videoImage,
      tempVideoImage,
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
      translateId,
      carModel,
      galleryImages,
      manageCarState,
    ];
  }
}
