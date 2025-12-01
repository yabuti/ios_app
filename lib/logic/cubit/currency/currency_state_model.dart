import 'dart:convert';

import 'package:blackdiamondcar/data/model/website_model/website_model.dart';
import 'package:equatable/equatable.dart';

import 'currency_cubit.dart';

class CurrencyStateModel extends Equatable {
  final List<CurrencyList> currencies;
  final List<LanguageList> languages;
  final String currencyCode;
  final CurrencyState currencyState;

  const CurrencyStateModel({
    required this.currencies,
    required this.languages,
     this.currencyCode ='',
    this.currencyState = const CurrencyInitial(),
  });

  CurrencyStateModel copyWith({
    List<CurrencyList>? currencies,
    List<LanguageList>? languages,
    String? currencyCode,
    CurrencyState? currencyState,
  }) {
    return CurrencyStateModel(
      currencies: currencies ?? this.currencies,
      languages: languages ?? this.languages,
      currencyCode: currencyCode ?? this.currencyCode,
      currencyState: currencyState ?? this.currencyState,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'currencies': currencies.map((x) => x.toMap()).toList(),
      'languages': languages.map((x) => x.toMap()).toList(),
    };
  }

  factory CurrencyStateModel.fromMap(Map<String, dynamic> map) {
    return CurrencyStateModel(
      currencies: List<CurrencyList>.from(
        (map['currencies'] as List<dynamic>).map<CurrencyList>(
          (x) => CurrencyList.fromMap(x as Map<String, dynamic>),
        ),
      ),
      languages: List<LanguageList>.from(
        (map['languages'] as List<dynamic>).map<LanguageList>(
          (x) => LanguageList.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory CurrencyStateModel.fromJson(String source) =>
      CurrencyStateModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  static CurrencyStateModel init() {
    return const CurrencyStateModel(
      currencies: <CurrencyList>[],
      languages: <LanguageList>[],
      currencyState: CurrencyInitial(),
    );
  }

  @override
  List<Object> get props => [currencies, currencyState,languages, currencyCode];
}
