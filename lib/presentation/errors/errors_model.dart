import 'dart:convert';

import 'package:equatable/equatable.dart';

class Errors extends Equatable {
  final List<String> name;
  final List<String> age;
  final List<String> gender;
  final List<String> title;
  final List<String> details;
  final List<String> description;
  final List<String> image;
  final List<String> image2;
  final List<String> image3;
  final List<String> image4;
  final List<String> categoryId;
  final List<String> username;
  final List<String> email;
  final List<String> phone;
  final List<String> password;
  final List<String> confirmPassword;
  final List<String> address;
  final List<String> designation;
  final List<String> serviceArea;
  final List<String> country;
  final List<String> state;
  final List<String> city;
  final List<String> companyName;
  final List<String> companyAddress;
  final List<String> companyDescription;
  final List<String> message;
  final List<String> review;
  final List<String> totalFollower;
  final List<String> totalFollowing;
  final List<String> jobDate;
  final List<String> packageFeatures;

  final List<String> shortName;
  final List<String> shopName;
  final List<String> slug;
  final List<String> thumbImage;
  final List<String> videoImage;
  final List<String> galleryImage;
  final List<String> category;
  final List<String> shortDescription;
  final List<String> longDescription;
  final List<String> price;
  final List<String> status;
  final List<String> weight;
  final List<String> quantity;
  final List<String> zipCode;
  final List<String> cityId;
  final List<String> closedAt;
  final List<String> greeting;
  final List<String> aboutMe;

  final List<String> methodId;
  final List<String> withdrawAmount;
  final List<String> accountInfo;
  final List<String> day;
  final List<String> maxPrice;
  final List<String> minPrice;
  final List<String> currentPassword;
  final List<String> newPassword;
  final List<String> comment;
  final List<String> tags;
  final List<String> regularPrice;
  final List<String> offerPrice;
  final List<String> minBookingDate;
  final List<String> bodyType;
  final List<String> engineSize;
  final List<String> drive;
  final List<String> interiorColor;
  final List<String> exteriorColor;
  final List<String> year;
  final List<String> mileage;
  final List<String> numberOfSeat;
  final List<String> fuelType;
  final List<String> transmission;
  final List<String> videoId;
  final List<String> videoDescription;
  final List<String> seoTitle;
  final List<String> seoDescription;
  final List<String> carModel;
  final List<String> cardNumber;
  final List<String> month;
  final List<String> cvc;
  final List<String> tnxInfo;
  final List<String> subject;
  final List<String> brandId;
  final List<String> condition;
  final List<String> sellerType;

  const Errors({
    required this.email,
    required this.username,
    required this.age,
    required this.gender,
    required this.title,
    required this.phone,
    required this.password,
    required this.confirmPassword,
    required this.designation,
    required this.serviceArea,
    required this.country,
    required this.state,
    required this.city,
    required this.address,
    required this.companyName,
    required this.companyAddress,
    required this.companyDescription,
    required this.message,
    required this.review,
    required this.shortName,
    required this.name,
    required this.image,
    required this.image2,
    required this.image3,
    required this.image4,
    required this.details,
    required this.description,
    required this.categoryId,
    required this.shopName,
    required this.slug,
    required this.thumbImage,
    required this.videoImage,
    required this.galleryImage,
    required this.category,
    required this.shortDescription,
    required this.longDescription,
    required this.price,
    required this.status,
    required this.weight,
    required this.quantity,
    required this.zipCode,
    required this.cityId,
    required this.closedAt,
    required this.greeting,
    required this.aboutMe,
    required this.methodId,
    required this.withdrawAmount,
    required this.accountInfo,
    required this.day,
    required this.maxPrice,
    required this.minPrice,
    required this.currentPassword,
    required this.newPassword,
    required this.totalFollower,
    required this.totalFollowing,
    required this.jobDate,
    required this.packageFeatures,
    required this.comment,
    required this.tags,
    required this.regularPrice,
    required this.offerPrice,
    required this.minBookingDate,
    required this.bodyType,
    required this.engineSize,
    required this.drive,
    required this.interiorColor,
    required this.exteriorColor,
    required this.year,
    required this.mileage,
    required this.numberOfSeat,
    required this.fuelType,
    required this.transmission,
    required this.seoTitle,
    required this.seoDescription,
    required this.videoId,
    required this.videoDescription,
    required this.carModel,
    required this.cardNumber,
    required this.month,
    required this.cvc,
    required this.tnxInfo,
    required this.subject,
    required this.brandId,
    required this.condition,
    required this.sellerType,
  });

  Errors copyWith({
    List<String>? email,
    List<String>? phone,
    List<String>? age,
    List<String>? gender,
    List<String>? password,
    List<String>? confirmPassword,
    List<String>? designation,
    List<String>? serviceArea,
    List<String>? username,
    List<String>? title,
    List<String>? country,
    List<String>? state,
    List<String>? city,
    List<String>? companyName,
    List<String>? companyAddress,
    List<String>? companyDescription,
    List<String>? message,
    List<String>? review,
    List<String>? shortName,
    List<String>? name,
    List<String>? image,
    List<String>? image2,
    List<String>? image3,
    List<String>? image4,
    List<String>? details,
    List<String>? description,
    List<String>? categoryId,
    List<String>? shopName,
    List<String>? slug,
    List<String>? thumbImage,
    List<String>? videoImage,
    List<String>? galleryImage,
    List<String>? category,
    List<String>? shortDescription,
    List<String>? longDescription,
    List<String>? price,
    List<String>? status,
    List<String>? weight,
    List<String>? quantity,
    List<String>? zipCode,
    List<String>? cityId,
    List<String>? closedAt,
    List<String>? greeting,
    List<String>? aboutMe,
    List<String>? methodId,
    List<String>? withdrawAmount,
    List<String>? address,
    List<String>? accountInfo,
    List<String>? day,
    List<String>? maxPrice,
    List<String>? minPrice,
    List<String>? currentPassword,
    List<String>? newPassword,
    List<String>? totalFollower,
    List<String>? totalFollowing,
    List<String>? jobDate,
    List<String>? packageFeatures,
    List<String>? comment,
    List<String>? tags,
    List<String>? regularPrice,
    List<String>? offerPrice,
    List<String>? minBookingDate,
    List<String>? bodyType,
    List<String>? engineSize,
    List<String>? drive,
    List<String>? interiorColor,
    List<String>? exteriorColor,
    List<String>? year,
    List<String>? mileage,
    List<String>? numberOfSeat,
    List<String>? fuelType,
    List<String>? transmission,
    List<String>? seoTitle,
    List<String>? seoDescription,
    List<String>? videoId,
    List<String>? videoDescription,
    List<String>? carModel,
    List<String>? cardNumber,
    List<String>? month,
    List<String>? cvc,
    List<String>? tnxInfo,
    List<String>? subject,
    List<String>? brandId,
    List<String>? condition,
    List<String>? sellerType,
  }) {
    return Errors(
      email: email ?? this.email,
      phone: phone ?? this.phone,
      age: age ?? this.age,
      gender: gender ?? this.gender,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      username: username ?? this.username,
      title: title ?? this.title,
      designation: designation ?? this.designation,
      serviceArea: serviceArea ?? this.serviceArea,
      country: country ?? this.country,
      state: state ?? this.state,
      city: city ?? this.city,
      companyName: companyName ?? this.companyName,
      companyAddress: companyAddress ?? this.companyAddress,
      companyDescription: companyDescription ?? this.companyDescription,
      address: address ?? this.address,
      message: message ?? this.message,
      review: review ?? this.review,
      name: name ?? this.name,
      image: image ?? this.image,
      image2: image2 ?? this.image2,
      image3: image3 ?? this.image3,
      image4: image4 ?? this.image4,
      details: details ?? this.details,
      description: description ?? this.description,
      categoryId: categoryId ?? this.categoryId,
      shopName: shopName ?? this.shopName,
      shortName: shortName ?? this.shortName,
      thumbImage: thumbImage ?? this.thumbImage,
      videoImage: videoImage ?? this.videoImage,
      galleryImage: galleryImage ?? this.galleryImage,
      slug: slug ?? this.slug,
      category: category ?? this.category,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      shortDescription: shortDescription ?? this.shortDescription,
      longDescription: longDescription ?? this.longDescription,
      status: status ?? this.status,
      weight: weight ?? this.weight,
      zipCode: zipCode ?? this.zipCode,
      cityId: cityId ?? this.cityId,
      closedAt: closedAt ?? this.closedAt,
      greeting: greeting ?? this.greeting,
      aboutMe: aboutMe ?? this.aboutMe,
      methodId: methodId ?? this.methodId,
      withdrawAmount: withdrawAmount ?? this.withdrawAmount,
      accountInfo: accountInfo ?? this.accountInfo,
      day: day ?? this.day,
      maxPrice: maxPrice ?? this.maxPrice,
      minPrice: minPrice ?? this.minPrice,
      currentPassword: currentPassword ?? this.currentPassword,
      newPassword: newPassword ?? this.newPassword,
      totalFollower: totalFollower ?? this.totalFollower,
      totalFollowing: totalFollowing ?? this.totalFollowing,
      jobDate: jobDate ?? this.jobDate,
      packageFeatures: packageFeatures ?? this.packageFeatures,
      comment: comment ?? this.comment,
      tags: tags ?? this.tags,
      regularPrice: regularPrice ?? this.regularPrice,
      offerPrice: offerPrice ?? this.offerPrice,
      minBookingDate: minBookingDate ?? this.minBookingDate,
      bodyType: bodyType ?? this.bodyType,
      engineSize: engineSize ?? this.engineSize,
      drive: drive ?? this.drive,
      interiorColor: interiorColor ?? this.interiorColor,
      exteriorColor: exteriorColor ?? this.exteriorColor,
      year: year ?? this.year,
      mileage: mileage ?? this.mileage,
      numberOfSeat: numberOfSeat ?? this.numberOfSeat,
      fuelType: fuelType ?? this.fuelType,
      transmission: transmission ?? this.transmission,
      seoTitle: seoTitle ?? this.seoTitle,
      seoDescription: seoDescription ?? this.seoDescription,
      videoId: videoId ?? this.videoId,
      videoDescription: videoDescription ?? this.videoDescription,
      carModel: carModel ?? this.carModel,
      cardNumber: cardNumber ?? this.cardNumber,
      month: month ?? this.month,
      cvc: cvc ?? this.cvc,
      tnxInfo: tnxInfo ?? this.tnxInfo,
      subject: subject ?? this.subject,
      brandId: brandId ?? this.brandId,
      condition: condition ?? this.condition,
      sellerType: sellerType ?? this.sellerType,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'title': title,
      'age': age,
      'gender': gender,
      'image': image,
      'image2': image2,
      'image3': image3,
      'image4': image4,
      'details': details,
      'description': description,
      'category_id': categoryId,
      'username': username,
      'email': email,
      'phone': phone,
      'password': password,
      'password_confirmation': confirmPassword,
      'designation': designation,
      'address': address,
      'service_area': serviceArea,
      'country': country,
      'state': state,
      'city': city,
      'company_name': companyName,
      'company_address': companyAddress,
      'company_description': companyDescription,
      'message': message,
      'review': review,
      'shop_name': shopName,
      'short_name': shortName,
      'thumb_image': thumbImage,
      'video_image': videoImage,
      'slug': slug,
      'category': category,
      'price': price,
      'quantity': quantity,
      'short_description': shortDescription,
      'long_description': longDescription,
      'status': status,
      'weight': weight,
      'zip_code': weight,
      'city_id': cityId,
      'closed_at': closedAt,
      'greeting_msg': greeting,
      'method_id': methodId,
      'withdraw_amount': withdrawAmount,
      'account_info': accountInfo,
      'day': day,
      'start_time': maxPrice,
      'end_time': minPrice,
      'current_password': currentPassword,
      'new_password': newPassword,
      'total_follower': totalFollower,
      'total_following': totalFollowing,
      'job_date': jobDate,
      'package_features': packageFeatures,
      'comment': comment,
      'tags': tags,
      'regular_price': regularPrice,
      'offer_price': offerPrice,
      'min_booking_date': minBookingDate,
      'body_type': bodyType,
      'engine_size': engineSize,
      'drive': drive,
      'interior_color': interiorColor,
      'exterior_color': exteriorColor,
      'year': year,
      'mileage': mileage,
      'number_of_seat': numberOfSeat,
      'fuel_type': fuelType,
      'transmission': transmission,
      'seo_title': seoTitle,
      'seo_description': seoDescription,
      'video_id': videoId,
      'video_description': videoDescription,
      'car_model': carModel,
      'card_number': cardNumber,
      'month': month,
      'cvc': cvc,
      'tnx_info': tnxInfo,
      'subject': subject,
      'brand_id': brandId,
      'condition': condition,
      'seller_type': sellerType,
    };
  }

  factory Errors.fromMap(Map<String, dynamic> map) {
    List<String> galleryErrors = [];

    map.forEach((key, value) {
      if (key.startsWith('image_galleries.') && value is List) {
        galleryErrors.addAll(List<String>.from(value));
      }
    });
    return Errors(
      username: map['username'] != null
          ? List<String>.from(map['username'].map((x) => x))
          : [],
      title: map['title'] != null
          ? List<String>.from(map['title'].map((x) => x))
          : [],
      email: map['email'] != null
          ? List<String>.from(map['email'].map((x) => x))
          : [],
      phone: map['phone'] != null
          ? List<String>.from(map['phone'].map((x) => x))
          : [],
      age:
          map['age'] != null ? List<String>.from(map['age'].map((x) => x)) : [],
      gender: map['gender'] != null
          ? List<String>.from(map['gender'].map((x) => x))
          : [],
      password: map['password'] != null
          ? List<String>.from(map['password'].map((x) => x))
          : [],
      confirmPassword: map['password_confirmation'] != null
          ? List<String>.from(map['password_confirmation'].map((x) => x))
          : [],
      address: map['address'] != null
          ? List<String>.from(map['address'].map((x) => x))
          : [],
      serviceArea: map['service_area'] != null
          ? List<String>.from(map['service_area'].map((x) => x))
          : [],
      designation: map['designation'] != null
          ? List<String>.from(map['designation'].map((x) => x))
          : [],
      country: map['country'] != null
          ? List<String>.from(map['country'].map((x) => x))
          : [],
      state: map['state'] != null
          ? List<String>.from(map['state'].map((x) => x))
          : [],
      city: map['city'] != null
          ? List<String>.from(map['city'].map((x) => x))
          : [],
      companyName: map['company_name'] != null
          ? List<String>.from(map['company_name'].map((x) => x))
          : [],
      companyAddress: map['company_address'] != null
          ? List<String>.from(map['company_address'].map((x) => x))
          : [],
      companyDescription: map['company_description'] != null
          ? List<String>.from(map['company_description'].map((x) => x))
          : [],
      message: map['message'] != null
          ? List<String>.from(map['message'].map((x) => x))
          : [],
      review: map['review'] != null
          ? List<String>.from(map['review'].map((x) => x))
          : [],
      name: map['name'] != null
          ? List<String>.from(map['name'].map((x) => x))
          : [],
      image: map['image'] != null
          ? List<String>.from(map['image'].map((x) => x))
          : [],
      image2: map['image2'] != null
          ? List<String>.from(map['image2'].map((x) => x))
          : [],
      image3: map['image3'] != null
          ? List<String>.from(map['image3'].map((x) => x))
          : [],
      image4: map['image4'] != null
          ? List<String>.from(map['image4'].map((x) => x))
          : [],
      details: map['details'] != null
          ? List<String>.from(map['details'].map((x) => x))
          : [],
      description: map['description'] != null
          ? List<String>.from(map['description'].map((x) => x))
          : [],
      categoryId: map['category_id'] != null
          ? List<String>.from(map['category_id'].map((x) => x))
          : [],
      shopName: map['shop_name'] != null
          ? List<String>.from(map['shop_name'].map((x) => x))
          : [],
      shortName: map['short_name'] != null
          ? List<String>.from(map['short_name'].map((x) => x))
          : [],
      thumbImage: map['thumb_image'] != null
          ? List<String>.from(map['thumb_image'].map((x) => x))
          : [],
      videoImage: map['video_image'] != null
          ? List<String>.from(map['video_image'].map((x) => x))
          : [],
      galleryImage: galleryErrors,
      slug: map['slug'] != null
          ? List<String>.from(map['slug'].map((x) => x))
          : [],
      category: map['category'] != null
          ? List<String>.from(map['category'].map((x) => x))
          : [],
      price: map['price'] != null
          ? List<String>.from(map['price'].map((x) => x))
          : [],
      quantity: map['quantity'] != null
          ? List<String>.from(map['quantity'].map((x) => x))
          : [],
      shortDescription: map['short_description'] != null
          ? List<String>.from(map['short_description'].map((x) => x))
          : [],
      longDescription: map['long_description'] != null
          ? List<String>.from(map['long_description'].map((x) => x))
          : [],
      status: map['status'] != null
          ? List<String>.from(map['status'].map((x) => x))
          : [],
      weight: map['weight'] != null
          ? List<String>.from(map['weight'].map((x) => x))
          : [],
      zipCode: map['zip_code'] != null
          ? List<String>.from(map['zip_code'].map((x) => x))
          : [],
      cityId: map['city_id'] != null
          ? List<String>.from(map['city_id'].map((x) => x))
          : [],
      closedAt: map['closed_at'] != null
          ? List<String>.from(map['closed_at'].map((x) => x))
          : [],
      greeting: map['greeting_msg'] != null
          ? List<String>.from(map['greeting_msg'].map((x) => x))
          : [],
      aboutMe: map['about_me'] != null
          ? List<String>.from(map['about_me'].map((x) => x))
          : [],
      methodId: map['method_id'] != null
          ? List<String>.from(map['method_id'].map((x) => x))
          : [],
      withdrawAmount: map['withdraw_amount'] != null
          ? List<String>.from(map['withdraw_amount'].map((x) => x))
          : [],
      accountInfo: map['account_info'] != null
          ? List<String>.from(map['account_info'].map((x) => x))
          : [],
      day:
          map['day'] != null ? List<String>.from(map['day'].map((x) => x)) : [],
      maxPrice: map['max_price'] != null
          ? List<String>.from(map['max_price'].map((x) => x))
          : [],
      minPrice: map['min_price'] != null
          ? List<String>.from(map['min_price'].map((x) => x))
          : [],
      currentPassword: map['current_password'] != null
          ? List<String>.from(map['current_password'].map((x) => x))
          : [],
      newPassword: map['new_password'] != null
          ? List<String>.from(map['new_password'].map((x) => x))
          : [],
      totalFollower: map['total_follower'] != null
          ? List<String>.from(map['total_follower'].map((x) => x))
          : [],
      totalFollowing: map['total_following'] != null
          ? List<String>.from(map['total_following'].map((x) => x))
          : [],
      jobDate: map['job_date'] != null
          ? List<String>.from(map['job_date'].map((x) => x))
          : [],
      packageFeatures: map['package_features'] != null
          ? List<String>.from(map['package_features'].map((x) => x))
          : [],
      comment: map['comment'] != null
          ? List<String>.from(map['comment'].map((x) => x))
          : [],
      tags: map['tags'] != null
          ? List<String>.from(map['tags'].map((x) => x))
          : [],
      regularPrice: map['regular_price'] != null
          ? List<String>.from(map['regular_price'].map((x) => x))
          : [],
      offerPrice: map['offer_price'] != null
          ? List<String>.from(map['offer_price'].map((x) => x))
          : [],
      minBookingDate: map['min_booking_date'] != null
          ? List<String>.from(map['min_booking_date'].map((x) => x))
          : [],
      bodyType: map['body_type'] != null
          ? List<String>.from(map['body_type'].map((x) => x))
          : [],
      engineSize: map['engine_size'] != null
          ? List<String>.from(map['engine_size'].map((x) => x))
          : [],
      drive: map['drive'] != null
          ? List<String>.from(map['drive'].map((x) => x))
          : [],
      interiorColor: map['interior_color'] != null
          ? List<String>.from(map['interior_color'].map((x) => x))
          : [],
      exteriorColor: map['exterior_color'] != null
          ? List<String>.from(map['exterior_color'].map((x) => x))
          : [],
      year: map['year'] != null
          ? List<String>.from(map['year'].map((x) => x))
          : [],
      mileage: map['mileage'] != null
          ? List<String>.from(map['mileage'].map((x) => x))
          : [],
      numberOfSeat: map['number_of_seat'] != null
          ? List<String>.from(map['number_of_seat'].map((x) => x))
          : [],
      fuelType: map['fuel_type'] != null
          ? List<String>.from(map['fuel_type'].map((x) => x))
          : [],
      transmission: map['transmission'] != null
          ? List<String>.from(map['transmission'].map((x) => x))
          : [],
      seoTitle: map['seo_title'] != null
          ? List<String>.from(map['seo_title'].map((x) => x))
          : [],
      seoDescription: map['seo_description'] != null
          ? List<String>.from(map['seo_description'].map((x) => x))
          : [],
      videoId: map['video_id'] != null
          ? List<String>.from(map['video_id'].map((x) => x))
          : [],
      videoDescription: map['video_description'] != null
          ? List<String>.from(map['video_description'].map((x) => x))
          : [],
      carModel: map['car_model'] != null
          ? List<String>.from(map['car_model'].map((x) => x))
          : [],
      cardNumber: map['card_number'] != null
          ? List<String>.from(map['card_number'].map((x) => x))
          : [],
      month: map['month'] != null
          ? List<String>.from(map['month'].map((x) => x))
          : [],
      cvc:
          map['cvc'] != null ? List<String>.from(map['cvc'].map((x) => x)) : [],
      tnxInfo: map['tnx_info'] != null
          ? List<String>.from(map['tnx_info'].map((x) => x))
          : [],
      subject: map['subject'] != null
          ? List<String>.from(map['subject'].map((x) => x))
          : [],
      brandId: map['brand_id'] != null
          ? List<String>.from(map['brand_id'].map((x) => x))
          : [],
      condition: map['condition'] != null
          ? List<String>.from(map['condition'].map((x) => x))
          : [],
      sellerType: map['seller_type'] != null
          ? List<String>.from(map['seller_type'].map((x) => x))
          : [],
    );
  }

  String toJson() => json.encode(toMap());

  factory Errors.fromJson(String source) =>
      Errors.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [
        name,
        title,
        age,
        gender,
        image,
        image2,
        image3,
        image4,
        categoryId,
        details,
        description,
        shopName,
        email,
        phone,
        country,
        state,
        city,
        shortName,
        thumbImage,
        videoImage,
        galleryImage,
        slug,
        category,
        price,
        quantity,
        shortDescription,
        longDescription,
        status,
        weight,
        zipCode,
        cityId,
        closedAt,
        greeting,
        aboutMe,
        methodId,
        withdrawAmount,
        accountInfo,
        designation,
        day,
        maxPrice,
        minPrice,
        username,
        email,
        phone,
        totalFollower,
        totalFollowing,
        jobDate,
        packageFeatures,
        serviceArea,
        designation,
        country,
        state,
        city,
        companyName,
        companyAddress,
        companyDescription,
        message,
        slug,
        price,
        currentPassword,
        newPassword,
        confirmPassword,
        comment,
        tags,
        regularPrice,
        offerPrice,
        minBookingDate,
        bodyType,
        engineSize,
        drive,
        interiorColor,
        exteriorColor,
        year,
        mileage,
        numberOfSeat,
        fuelType,
        transmission,
        seoTitle,
        seoDescription,
        videoId,
        videoDescription,
        carModel,
        cardNumber,
        month,
        cvc,
        tnxInfo,
        subject,
        brandId,
        condition,
        sellerType,
      ];
}
