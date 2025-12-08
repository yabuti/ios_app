// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class PaymentInfoModel extends Equatable {
  final Stripe? stripe;
  final Paypal? paypal;
  final Razorpay? razorpay;
  final Flutterwave? flutterwave;
  final Paystack? paystack;
  final Paystack? mollie;
  final Instamojo? instamojo;
  final Bank? bank;
  const PaymentInfoModel({
    this.stripe,
    this.paypal,
    this.razorpay,
    this.flutterwave,
    this.paystack,
    this.mollie,
    this.instamojo,
    this.bank,
  });

  PaymentInfoModel copyWith({
    Stripe? stripe,
    Paypal? paypal,
    Razorpay? razorpay,
    Flutterwave? flutterwave,
    Paystack? paystack,
    Paystack? mollie,
    Instamojo? instamojo,
    Bank? bank,
  }) {
    return PaymentInfoModel(
      stripe: stripe ?? this.stripe,
      paypal: paypal ?? this.paypal,
      razorpay: razorpay ?? this.razorpay,
      flutterwave: flutterwave ?? this.flutterwave,
      paystack: paystack ?? this.paystack,
      mollie: mollie ?? this.mollie,
      instamojo: instamojo ?? this.instamojo,
      bank: bank ?? this.bank,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'stripe': stripe?.toMap(),
      'paypal': paypal?.toMap(),
      'razorpay': razorpay?.toMap(),
      'flutterwave': flutterwave?.toMap(),
      'paystack': paystack?.toMap(),
      'mollie': mollie?.toMap(),
      'instamojo': instamojo?.toMap(),
      'bank': bank?.toMap(),
    };
  }

  factory PaymentInfoModel.fromMap(Map<String, dynamic> map) {
    return PaymentInfoModel(
      stripe: map['stripe'] != null ? Stripe.fromMap(map['stripe'] as Map<String,dynamic>) : null,
      paypal: map['paypal'] != null ? Paypal.fromMap(map['paypal'] as Map<String,dynamic>) : null,
      razorpay: map['razorpay'] != null ? Razorpay.fromMap(map['razorpay'] as Map<String,dynamic>) : null,
      flutterwave: map['flutterwave'] != null ? Flutterwave.fromMap(map['flutterwave'] as Map<String,dynamic>) : null,
      paystack: map['paystack'] != null ? Paystack.fromMap(map['paystack'] as Map<String,dynamic>) : null,
      mollie: map['mollie'] != null ? Paystack.fromMap(map['mollie'] as Map<String,dynamic>) : null,
      instamojo: map['instamojo'] != null ? Instamojo.fromMap(map['instamojo'] as Map<String,dynamic>) : null,
      bank: map['bank'] != null ? Bank.fromMap(map['bank'] as Map<String,dynamic>) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory PaymentInfoModel.fromJson(String source) => PaymentInfoModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      stripe!,
      paypal!,
      razorpay!,
      flutterwave!,
      paystack!,
      mollie!,
      instamojo!,
      bank!,
    ];
  }
}

class Stripe extends Equatable {
  final int id;
  final int status;
  final String stripeKey;
  final String stripeSecret;
  final String createdAt;
  final String updatedAt;
  final String countryCode;
  final String currencyCode;
  final int currencyRate;
  final String image;
  final int currencyId;
  const Stripe({
    required this.id,
    required this.status,
    required this.stripeKey,
    required this.stripeSecret,
    required this.createdAt,
    required this.updatedAt,
    required this.countryCode,
    required this.currencyCode,
    required this.currencyRate,
    required this.image,
    required this.currencyId,
  });

  Stripe copyWith({
    int? id,
    int? status,
    String? stripeKey,
    String? stripeSecret,
    String? createdAt,
    String? updatedAt,
    String? countryCode,
    String? currencyCode,
    int? currencyRate,
    String? image,
    int? currencyId,
  }) {
    return Stripe(
      id: id ?? this.id,
      status: status ?? this.status,
      stripeKey: stripeKey ?? this.stripeKey,
      stripeSecret: stripeSecret ?? this.stripeSecret,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      countryCode: countryCode ?? this.countryCode,
      currencyCode: currencyCode ?? this.currencyCode,
      currencyRate: currencyRate ?? this.currencyRate,
      image: image ?? this.image,
      currencyId: currencyId ?? this.currencyId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'status': status,
      'stripe_key': stripeKey,
      'stripe_secret': stripeSecret,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'country_code': countryCode,
      'currency_code': currencyCode,
      'currency_rate': currencyRate,
      'image': image,
      'currency_id': currencyId,
    };
  }

  factory Stripe.fromMap(Map<String, dynamic> map) {
    return Stripe(
      id: map['id'] ?? 0,
      status: map['status'] ?? 0,
      stripeKey: map['stripe_key'] ?? '',
      stripeSecret: map['stripe_secret'] ?? '',
      createdAt: map['created_at'] ?? '',
      updatedAt: map['updated_at'] ?? '',
      countryCode: map['country_code'] ?? '',
      currencyCode: map['currency_code'] ?? '',
      currencyRate: map['currency_rate'] != null ? int.parse(map['currency_rate'].toString()) :0,
      image: map['image'] ?? '',
      currencyId: map['currency_id'] != null ? int.parse(map['currency_id'].toString()) :0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Stripe.fromJson(String source) => Stripe.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      status,
      stripeKey,
      stripeSecret,
      createdAt,
      updatedAt,
      countryCode,
      currencyCode,
      currencyRate,
      image,
      currencyId,
    ];
  }
}

class Paypal extends Equatable {
  final int id;
  final int status;
  final String accountMode;
  final String clientId;
  final String secretId;
  final String countryCode;
  final String currencyCode;
  final int currencyRate;
  final String image;
  final String createdAt;
  final String updatedAt;
  final int currencyId;
  const Paypal({
    required this.id,
    required this.status,
    required this.accountMode,
    required this.clientId,
    required this.secretId,
    required this.countryCode,
    required this.currencyCode,
    required this.currencyRate,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
    required this.currencyId,
  });

  Paypal copyWith({
    int? id,
    int? status,
    String? accountMode,
    String? clientId,
    String? secretId,
    String? countryCode,
    String? currencyCode,
    int? currencyRate,
    String? image,
    String? createdAt,
    String? updatedAt,
    int? currencyId,
  }) {
    return Paypal(
      id: id ?? this.id,
      status: status ?? this.status,
      accountMode: accountMode ?? this.accountMode,
      clientId: clientId ?? this.clientId,
      secretId: secretId ?? this.secretId,
      countryCode: countryCode ?? this.countryCode,
      currencyCode: currencyCode ?? this.currencyCode,
      currencyRate: currencyRate ?? this.currencyRate,
      image: image ?? this.image,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      currencyId: currencyId ?? this.currencyId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'status': status,
      'account_mode': accountMode,
      'client_id': clientId,
      'secret_id': secretId,
      'country_code': countryCode,
      'currency_code': currencyCode,
      'currency_rate': currencyRate,
      'image': image,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'currency_id': currencyId,
    };
  }

  factory Paypal.fromMap(Map<String, dynamic> map) {
    return Paypal(
      id: map['id'] ?? 0,
      status: map['status'] ?? 0,
      accountMode: map['account_mode'] ?? '',
      clientId: map['client_id'] ?? '',
      secretId: map['secret_id'] ?? '',
      countryCode: map['country_code'] ?? '',
      currencyCode: map['currency_code'] ?? '',
      currencyRate: map['currency_rate'] != null ? int.parse(map['currency_rate'].toString()) : 0,
      image: map['image'] ?? '',
      createdAt: map['created_at'] ?? '',
      updatedAt: map['updated_at'] ?? '',
      currencyId: map['currency_id'] != null ? int.parse(map['currency_id'].toString()) : 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Paypal.fromJson(String source) => Paypal.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      status,
      accountMode,
      clientId,
      secretId,
      countryCode,
      currencyCode,
      currencyRate,
      image,
      createdAt,
      updatedAt,
      currencyId,
    ];
  }
}

class Razorpay extends Equatable {
  final int id;
  final int status;
  final String name;
  final double currencyRate;
  final String countryCode;
  final String currencyCode;
  final String description;
  final String image;
  final String color;
  final String key;
  final String secretKey;
  final String createdAt;
  final String updatedAt;
  final int currencyId;
  const Razorpay({
    required this.id,
    required this.status,
    required this.name,
    required this.currencyRate,
    required this.countryCode,
    required this.currencyCode,
    required this.description,
    required this.image,
    required this.color,
    required this.key,
    required this.secretKey,
    required this.createdAt,
    required this.updatedAt,
    required this.currencyId,
  });

  Razorpay copyWith({
    int? id,
    int? status,
    String? name,
    double? currencyRate,
    String? countryCode,
    String? currencyCode,
    String? description,
    String? image,
    String? color,
    String? key,
    String? secretKey,
    String? createdAt,
    String? updatedAt,
    int? currencyId,
  }) {
    return Razorpay(
      id: id ?? this.id,
      status: status ?? this.status,
      name: name ?? this.name,
      currencyRate: currencyRate ?? this.currencyRate,
      countryCode: countryCode ?? this.countryCode,
      currencyCode: currencyCode ?? this.currencyCode,
      description: description ?? this.description,
      image: image ?? this.image,
      color: color ?? this.color,
      key: key ?? this.key,
      secretKey: secretKey ?? this.secretKey,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      currencyId: currencyId ?? this.currencyId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'status': status,
      'name': name,
      'currency_rate': currencyRate,
      'country_code': countryCode,
      'currency_code': currencyCode,
      'description': description,
      'image': image,
      'color': color,
      'key': key,
      'secret_key': secretKey,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'currency_id': currencyId,
    };
  }

  factory Razorpay.fromMap(Map<String, dynamic> map) {
    return Razorpay(
      id: map['id'] ?? 0,
      status: map['status'] ?? 0,
      name: map['name'] ?? '',
      currencyRate: map['currency_rate'] != null ? double.parse(map['currency_rate'].toString()) : 0.0,
      countryCode: map['country_code'] ?? '',
      currencyCode: map['currency_code'] ?? '',
      description: map['description'] ?? '',
      image: map['image'] ?? '',
      color: map['color'] ?? '',
      key: map['key'] ?? '',
      secretKey: map['secret_key'] ?? '',
      createdAt: map['created_at'] ?? '',
      updatedAt: map['updated_at'] ?? '',
      currencyId: map['currency_id'] != null ? int.parse(map['currency_id'].toString()) : 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Razorpay.fromJson(String source) => Razorpay.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      status,
      name,
      currencyRate,
      countryCode,
      currencyCode,
      description,
      image,
      color,
      key,
      secretKey,
      createdAt,
      updatedAt,
      currencyId,
    ];
  }
}

class Flutterwave extends Equatable {
  final int id;
  final String publicKey;
  final String secretKey;
  final double currencyRate;
  final String countryCode;
  final String currencyCode;
  final String title;
  final String logo;
  final int status;
  final String createdAt;
  final String updatedAt;
  final int currencyId;
  const Flutterwave({
    required this.id,
    required this.publicKey,
    required this.secretKey,
    required this.currencyRate,
    required this.countryCode,
    required this.currencyCode,
    required this.title,
    required this.logo,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.currencyId,
  });

  Flutterwave copyWith({
    int? id,
    String? publicKey,
    String? secretKey,
    double? currencyRate,
    String? countryCode,
    String? currencyCode,
    String? title,
    String? logo,
    int? status,
    String? createdAt,
    String? updatedAt,
    int? currencyId,
  }) {
    return Flutterwave(
      id: id ?? this.id,
      publicKey: publicKey ?? this.publicKey,
      secretKey: secretKey ?? this.secretKey,
      currencyRate: currencyRate ?? this.currencyRate,
      countryCode: countryCode ?? this.countryCode,
      currencyCode: currencyCode ?? this.currencyCode,
      title: title ?? this.title,
      logo: logo ?? this.logo,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      currencyId: currencyId ?? this.currencyId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'public_key': publicKey,
      'secret_key': secretKey,
      'currency_rate': currencyRate,
      'country_code': countryCode,
      'currency_code': currencyCode,
      'title': title,
      'logo': logo,
      'status': status,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'currency_id': currencyId,
    };
  }

  factory Flutterwave.fromMap(Map<String, dynamic> map) {
    return Flutterwave(
      id: map['id'] ?? 0,
      publicKey: map['public_key'] ?? '',
      secretKey: map['secret_key'] ?? '',
      currencyRate: map['currency_rate'] != null ? double.parse( map['currency_rate'].toString()) : 0.0,
      countryCode: map['country_code'] ?? '',
      currencyCode: map['currency_code'] ?? '',
      title: map['title'] ?? '',
      logo: map['logo'] ?? '',
      status: map['status'] != null ? int.parse( map['status'].toString()) : 0,
      createdAt: map['created_at'] ?? '',
      updatedAt: map['updated_at'] ?? '',
      currencyId: map['currency_id'] != null ? int.parse( map['currency_id'].toString()) : 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Flutterwave.fromJson(String source) => Flutterwave.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      publicKey,
      secretKey,
      currencyRate,
      countryCode,
      currencyCode,
      title,
      logo,
      status,
      createdAt,
      updatedAt,
      currencyId,
    ];
  }
}

class Paystack extends Equatable {
  final int id;
  final String mollieKey;
  final int mollieStatus;
  final double mollieCurrencyRate;
  final String paystackPublicKey;
  final String paystackSecretKey;
  final double paystackCurrencyRate;
  final int paystackStatus;
  final String mollieCountryCode;
  final String mollieCurrencyCode;
  final String paystackCountryCode;
  final String paystackCurrencyCode;
  final String mollieImage;
  final String paystackImage;
  final String createdAt;
  final String updatedAt;
  final int paystackCurrencyId;
  final int mollieCurrencyId;
  const Paystack({
    required this.id,
    required this.mollieKey,
    required this.mollieStatus,
    required this.mollieCurrencyRate,
    required this.paystackPublicKey,
    required this.paystackSecretKey,
    required this.paystackCurrencyRate,
    required this.paystackStatus,
    required this.mollieCountryCode,
    required this.mollieCurrencyCode,
    required this.paystackCountryCode,
    required this.paystackCurrencyCode,
    required this.mollieImage,
    required this.paystackImage,
    required this.createdAt,
    required this.updatedAt,
    required this.paystackCurrencyId,
    required this.mollieCurrencyId,
  });

  Paystack copyWith({
    int? id,
    String? mollieKey,
    int? mollieStatus,
    double? mollieCurrencyRate,
    String? paystackPublicKey,
    String? paystackSecretKey,
    double? paystackCurrencyRate,
    int? paystackStatus,
    String? mollieCountryCode,
    String? mollieCurrencyCode,
    String? paystackCountryCode,
    String? paystackCurrencyCode,
    String? mollieImage,
    String? paystackImage,
    String? createdAt,
    String? updatedAt,
    int? paystackCurrencyId,
    int? mollieCurrencyId,
  }) {
    return Paystack(
      id: id ?? this.id,
      mollieKey: mollieKey ?? this.mollieKey,
      mollieStatus: mollieStatus ?? this.mollieStatus,
      mollieCurrencyRate: mollieCurrencyRate ?? this.mollieCurrencyRate,
      paystackPublicKey: paystackPublicKey ?? this.paystackPublicKey,
      paystackSecretKey: paystackSecretKey ?? this.paystackSecretKey,
      paystackCurrencyRate: paystackCurrencyRate ?? this.paystackCurrencyRate,
      paystackStatus: paystackStatus ?? this.paystackStatus,
      mollieCountryCode: mollieCountryCode ?? this.mollieCountryCode,
      mollieCurrencyCode: mollieCurrencyCode ?? this.mollieCurrencyCode,
      paystackCountryCode: paystackCountryCode ?? this.paystackCountryCode,
      paystackCurrencyCode: paystackCurrencyCode ?? this.paystackCurrencyCode,
      mollieImage: mollieImage ?? this.mollieImage,
      paystackImage: paystackImage ?? this.paystackImage,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      paystackCurrencyId: paystackCurrencyId ?? this.paystackCurrencyId,
      mollieCurrencyId: mollieCurrencyId ?? this.mollieCurrencyId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'mollie_key': mollieKey,
      'mollie_status': mollieStatus,
      'mollie_currency_rate': mollieCurrencyRate,
      'paystack_public_key': paystackPublicKey,
      'paystack_secret_key': paystackSecretKey,
      'paystack_currency_rate': paystackCurrencyRate,
      'paystack_status': paystackStatus,
      'mollie_country_code': mollieCountryCode,
      'mollie_currency_code': mollieCurrencyCode,
      'paystack_country_code': paystackCountryCode,
      'paystack_currency_code': paystackCurrencyCode,
      'mollie_image': mollieImage,
      'paystack_image': paystackImage,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'paystack_currency_id': paystackCurrencyId,
      'mollie_currency_id': mollieCurrencyId,
    };
  }

  factory Paystack.fromMap(Map<String, dynamic> map) {
    return Paystack(
      id: map['id'] as int,
      mollieKey: map['mollie_key'] ?? '',
      mollieStatus: map['mollie_status'] != null ? int.parse(map['mollie_status'].toString()) : 0,
      mollieCurrencyRate: map['mollie_currency_rate'] != null ? double.parse(map['mollie_currency_rate'].toString()) : 0.0,
      paystackPublicKey: map['paystack_public_key'] ?? '',
      paystackSecretKey: map['paystack_secret_key'] ?? '',
      paystackCurrencyRate: map['paystack_currency_rate'] != null ? double.parse(map['paystack_currency_rate'].toString()) : 0.0,
      paystackStatus: map['paystack_status'] != null ? int.parse(map['paystack_status'].toString()) : 0,
      mollieCountryCode: map['mollie_country_code'] ?? '',
      mollieCurrencyCode: map['mollie_currency_code'] ?? '',
      paystackCountryCode: map['paystack_country_code'] ?? '',
      paystackCurrencyCode: map['paystack_currency_code'] ?? '',
      mollieImage: map['mollie_image'] ?? '',
      paystackImage: map['paystack_image'] ?? '',
      createdAt: map['created_at'] ?? '',
      updatedAt: map['updated_at'] ?? '',
      paystackCurrencyId: map['paystack_currency_id'] != null ? int.parse(map['paystack_currency_id'].toString()) : 0,
      mollieCurrencyId: map['mollie_currency_id'] != null ? int.parse(map['mollie_currency_id'].toString()) : 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Paystack.fromJson(String source) => Paystack.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      mollieKey,
      mollieStatus,
      mollieCurrencyRate,
      paystackPublicKey,
      paystackSecretKey,
      paystackCurrencyRate,
      paystackStatus,
      mollieCountryCode,
      mollieCurrencyCode,
      paystackCountryCode,
      paystackCurrencyCode,
      mollieImage,
      paystackImage,
      createdAt,
      updatedAt,
      paystackCurrencyId,
      mollieCurrencyId,
    ];
  }
}

class Instamojo extends Equatable {
  final int id;
  final String apiKey;
  final String authToken;
  final String currencyRate;
  final String accountMode;
  final int status;
  final String image;
  final String createdAt;
  final String updatedAt;
  final int currencyId;
  const Instamojo({
    required this.id,
    required this.apiKey,
    required this.authToken,
    required this.currencyRate,
    required this.accountMode,
    required this.status,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
    required this.currencyId,
  });

  Instamojo copyWith({
    int? id,
    String? apiKey,
    String? authToken,
    String? currencyRate,
    String? accountMode,
    int? status,
    String? image,
    String? createdAt,
    String? updatedAt,
    int? currencyId,
  }) {
    return Instamojo(
      id: id ?? this.id,
      apiKey: apiKey ?? this.apiKey,
      authToken: authToken ?? this.authToken,
      currencyRate: currencyRate ?? this.currencyRate,
      accountMode: accountMode ?? this.accountMode,
      status: status ?? this.status,
      image: image ?? this.image,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      currencyId: currencyId ?? this.currencyId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'api_key': apiKey,
      'auth_token': authToken,
      'currency_rate': currencyRate,
      'account_mode': accountMode,
      'status': status,
      'image': image,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'currency_id': currencyId,
    };
  }

  factory Instamojo.fromMap(Map<String, dynamic> map) {
    return Instamojo(
      id: map['id'] ?? 0,
      apiKey: map['api_key'] ?? '',
      authToken: map['auth_token'] ?? '',
      currencyRate: map['currency_rate'] ?? '',
      accountMode: map['account_mode'] ?? '',
      status: map['status'] != null ? int.parse(map['status'].toString()) : 0,
      image: map['image'] ?? '',
      createdAt: map['created_at'] ?? '',
      updatedAt: map['updated_at'] ?? '',
      currencyId: map['currency_id'] != null ? int.parse(map['currency_id'].toString()) : 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Instamojo.fromJson(String source) => Instamojo.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      apiKey,
      authToken,
      currencyRate,
      accountMode,
      status,
      image,
      createdAt,
      updatedAt,
      currencyId,
    ];
  }
}

class Bank extends Equatable {
  final int id;
  final int status;
  final String accountInfo;
  final String image;
  final String createdAt;
  final String updatedAt;
  const Bank({
    required this.id,
    required this.status,
    required this.accountInfo,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
  });

  Bank copyWith({
    int? id,
    int? status,
    String? accountInfo,
    String? image,
    String? createdAt,
    String? updatedAt,
  }) {
    return Bank(
      id: id ?? this.id,
      status: status ?? this.status,
      accountInfo: accountInfo ?? this.accountInfo,
      image: image ?? this.image,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'status': status,
      'account_info': accountInfo,
      'image': image,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  factory Bank.fromMap(Map<String, dynamic> map) {
    return Bank(
      id: map['id'] ?? 0,
      status: map['status'] != null ? int.parse(map['status'].toString()) : 0,
      accountInfo: map['account_info'] ?? '',
      image: map['image'] ?? '',
      createdAt: map['created_at'] ?? '',
      updatedAt: map['updated_at'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Bank.fromJson(String source) => Bank.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      status,
      accountInfo,
      image,
      createdAt,
      updatedAt,
    ];
  }
}
