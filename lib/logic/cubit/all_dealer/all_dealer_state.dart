import 'package:carsbnb/data/model/home/home_model.dart' as home;
import 'package:equatable/equatable.dart';

abstract class AllDealerState extends Equatable {
  const AllDealerState();

  @override
  List<Object> get props => [];
}

class AllDealerInitial extends AllDealerState {
  const AllDealerInitial();

  @override
  List<Object> get props => [];
}

class AllDealerStateLoading extends AllDealerState {}

class AllDealerStateLoaded extends AllDealerState {
  final List<home.Dealers> allDealer;

  const AllDealerStateLoaded(this.allDealer);

  @override
  List<Object> get props => [allDealer];
}

class AllDealerStateMoreLoaded extends AllDealerState {
  final List<home.Dealers> allDealer;

  const AllDealerStateMoreLoaded(this.allDealer);

  @override
  List<Object> get props => [allDealer];
}

class AllDealerStateError extends AllDealerState {
  final String message;
  final int statusCode;

  const AllDealerStateError(this.message, this.statusCode);

  @override
  List<Object> get props => [message, statusCode];
}

class GetDealerCityStateLoading extends AllDealerState {}

class GetDealerCityStateLoaded extends AllDealerState {
  final home.CityModel city;

  const GetDealerCityStateLoaded(this.city);

  @override
  List<Object> get props => [city];
}

class GetDealerCityStateError extends AllDealerState {
  final String message;
  final int statusCode;

  const GetDealerCityStateError(this.message, this.statusCode);

  @override
  List<Object> get props => [message, statusCode];
}
