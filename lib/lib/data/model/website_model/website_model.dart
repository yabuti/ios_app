// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class WebsiteModel extends Equatable {
  final Setting? setting;
  final List<LanguageList>? languageList;
  final List<CurrencyList>? currencyList;
  final Map<String, String>? language;
  const WebsiteModel({
    this.setting,
    this.languageList,
    this.currencyList,
    this.language,
  });

  WebsiteModel copyWith({
    Setting? setting,
    List<LanguageList>? languageList,
    List<CurrencyList>? currencyList,
    Map<String, String>? language,
  }) {
    return WebsiteModel(
      setting: setting ?? this.setting,
      languageList: languageList ?? this.languageList,
      currencyList: currencyList ?? this.currencyList,
      language: language ?? this.language,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'setting': setting?.toMap(),
      'language_list': languageList?.map((x) => x.toMap()).toList(),
      'currency_list': currencyList?.map((x) => x.toMap()).toList(),
      'localizations': language,
    };
  }

  factory WebsiteModel.fromMap(Map<String, dynamic> map) {
    return WebsiteModel(
      setting: map['setting'] != null
          ? Setting.fromMap(map['setting'] as Map<String, dynamic>)
          : null,
      languageList: map['language_list'] != null
          ? List<LanguageList>.from(
              (map['language_list'] as List<dynamic>).map<LanguageList?>(
                (x) => LanguageList.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      currencyList: map['currency_list'] != null
          ? List<CurrencyList>.from(
              (map['currency_list'] as List<dynamic>).map<CurrencyList?>(
                (x) => CurrencyList.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      language: map['localizations'] != null
          ? Map<String, String>.from(map['localizations'] as Map)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory WebsiteModel.fromJson(String source) =>
      WebsiteModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [setting, languageList, currencyList, language];
}

class Setting extends Equatable {
  final int id;
  final String logo;
  final String appName;
  final String timezone;
  final String defaultAvatar;
  const Setting({
    required this.id,
    required this.logo,
    required this.appName,
    required this.timezone,
    required this.defaultAvatar,
  });

  Setting copyWith({
    int? id,
    String? logo,
    String? appName,
    String? timezone,
    String? defaultAvatar,
  }) {
    return Setting(
      id: id ?? this.id,
      logo: logo ?? this.logo,
      appName: appName ?? this.appName,
      timezone: timezone ?? this.timezone,
      defaultAvatar: defaultAvatar ?? this.defaultAvatar,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'logo': logo,
      'app_name': appName,
      'timezone': timezone,
      'default_avatar': defaultAvatar,
    };
  }

  factory Setting.fromMap(Map<String, dynamic> map) {
    return Setting(
      id: map['id'] ?? 0,
      logo: map['logo'] ?? '',
      appName: map['app_name'] ?? '',
      timezone: map['timezone'] ?? '',
      defaultAvatar: map['default_avatar'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Setting.fromJson(String source) =>
      Setting.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      logo,
      appName,
      timezone,
      defaultAvatar,
    ];
  }
}

class LanguageList extends Equatable {
  final int id;
  final String langName;
  final String langCode;
  final String isDefault;
  final int status;
  final String langDirection;
  final String createdAt;
  final String updatedAt;
  const LanguageList({
    required this.id,
    required this.langName,
    required this.langCode,
    required this.isDefault,
    required this.status,
    required this.langDirection,
    required this.createdAt,
    required this.updatedAt,
  });

  LanguageList copyWith({
    int? id,
    String? langName,
    String? langCode,
    String? isDefault,
    int? status,
    String? langDirection,
    String? createdAt,
    String? updatedAt,
  }) {
    return LanguageList(
      id: id ?? this.id,
      langName: langName ?? this.langName,
      langCode: langCode ?? this.langCode,
      isDefault: isDefault ?? this.isDefault,
      status: status ?? this.status,
      langDirection: langDirection ?? this.langDirection,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'lang_name': langName,
      'lang_code': langCode,
      'is_default': isDefault,
      'status': status,
      'lang_direction': langDirection,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  factory LanguageList.fromMap(Map<String, dynamic> map) {
    int parseInt(dynamic value) {
      if (value == null) return 0;
      if (value is int) return value;
      if (value is String) {
        value = value.trim();
        if (value.isEmpty || value.toLowerCase() == 'null') return 0;
        return int.tryParse(value) ?? 0;
      }
      return 0;
    }

    return LanguageList(
      id: parseInt(map['id']),
      langName: map['lang_name'] ?? '',
      langCode: map['lang_code'] ?? '',
      isDefault: map['is_default'] ?? '',
      status: parseInt(map['status']),
      langDirection: map['lang_direction'] ?? '',
      createdAt: map['created_at'] ?? '',
      updatedAt: map['updated_at'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory LanguageList.fromJson(String source) =>
      LanguageList.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      langName,
      langCode,
      isDefault,
      status,
      langDirection,
      createdAt,
      updatedAt,
    ];
  }
}

class CurrencyList extends Equatable {
  final int id;
  final String currencyName;
  final String countryCode;
  final String currencyCode;
  final String currencyIcon;
  final String isDefault;
  final double currencyRate;
  final String currencyPosition;
  final String status;
  final String createdAt;
  final String updatedAt;
  const CurrencyList({
    required this.id,
    required this.currencyName,
    required this.countryCode,
    required this.currencyCode,
    required this.currencyIcon,
    required this.isDefault,
    required this.currencyRate,
    required this.currencyPosition,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  CurrencyList copyWith({
    int? id,
    String? currencyName,
    String? countryCode,
    String? currencyCode,
    String? currencyIcon,
    String? isDefault,
    double? currencyRate,
    String? currencyPosition,
    String? status,
    String? createdAt,
    String? updatedAt,
  }) {
    return CurrencyList(
      id: id ?? this.id,
      currencyName: currencyName ?? this.currencyName,
      countryCode: countryCode ?? this.countryCode,
      currencyCode: currencyCode ?? this.currencyCode,
      currencyIcon: currencyIcon ?? this.currencyIcon,
      isDefault: isDefault ?? this.isDefault,
      currencyRate: currencyRate ?? this.currencyRate,
      currencyPosition: currencyPosition ?? this.currencyPosition,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'currency_name': currencyName,
      'country_code': countryCode,
      'currency_code': currencyCode,
      'currency_icon': currencyIcon,
      'is_default': isDefault,
      'currency_rate': currencyRate,
      'currency_position': currencyPosition,
      'status': status,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  factory CurrencyList.fromMap(Map<String, dynamic> map) {
    return CurrencyList(
      id: map['id'] ?? 0,
      currencyName: map['currency_name'] ?? '',
      countryCode: map['country_code'] ?? '',
      currencyCode: map['currency_code'] ?? '',
      currencyIcon: map['currency_icon'] ?? '',
      isDefault: map['is_default'] ?? '',
      currencyRate: map['currency_rate'] != null
          ? double.parse(map['currency_rate'].toString())
          : 0.0,
      currencyPosition: map['currency_position'] ?? '',
      status: map['status'] ?? '',
      createdAt: map['created_at'] ?? '',
      updatedAt: map['updated_at'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory CurrencyList.fromJson(String source) =>
      CurrencyList.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      currencyName,
      countryCode,
      currencyCode,
      currencyIcon,
      isDefault,
      currencyRate,
      currencyPosition,
      status,
      createdAt,
      updatedAt,
    ];
  }
}
