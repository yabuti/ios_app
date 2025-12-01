// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:blackdiamondcar/data/model/home/home_model.dart';
import '../cars_details/car_details_model.dart';

class DealerDetailsModel extends Equatable {
  final Dealer? dealer;
  final List<FeaturedCars>? cars;
  final int totalDealerRating;
  const DealerDetailsModel({
    this.dealer,
    this.cars,
    required this.totalDealerRating,
  });

  DealerDetailsModel copyWith({
    Dealer? dealer,
    List<FeaturedCars>? cars,
    int? totalDealerRating,
  }) {
    return DealerDetailsModel(
      dealer: dealer ?? this.dealer,
      cars: cars ?? this.cars,
      totalDealerRating: totalDealerRating ?? this.totalDealerRating,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'dealer': dealer?.toMap(),
      'cars': cars?.map((x) => x.toMap()).toList(),
      'total_dealer_rating': totalDealerRating,
    };
  }

  factory DealerDetailsModel.fromMap(Map<String, dynamic> map) {
    return DealerDetailsModel(
      dealer: map['dealer'] != null ? Dealer.fromMap(map['dealer'] as Map<String,dynamic>) : null,
      cars: map['cars'] != null ? List<FeaturedCars>.from((map['cars']['data'] as List<dynamic>).map<FeaturedCars?>((x) => FeaturedCars.fromMap(x as Map<String,dynamic>),),) : null,
      totalDealerRating: map['total_dealer_rating'] != null ? int.parse(map['total_dealer_rating'].toString()) : 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory DealerDetailsModel.fromJson(String source) => DealerDetailsModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [dealer!, cars!, totalDealerRating];
}
