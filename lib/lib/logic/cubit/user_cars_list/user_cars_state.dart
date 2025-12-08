import 'package:equatable/equatable.dart';

import '../../../data/model/home/home_model.dart';

abstract class UserCarsListState extends Equatable {
  const UserCarsListState();

  @override
  List<Object> get props => [];
}

class UserCarsInitial extends UserCarsListState {
  const UserCarsInitial();

  @override
  List<Object> get props => [];
}

class UserCarsListStateLoading extends UserCarsListState {}

class UserCarsListStateLoaded extends UserCarsListState {
  final List<FeaturedCars> allCars;

  const UserCarsListStateLoaded(this.allCars);

  @override
  List<Object> get props => [allCars];
}

class UserCarsListStateMoreLoaded extends UserCarsListState {
  final List<FeaturedCars> allCars;

  const UserCarsListStateMoreLoaded(this.allCars);

  @override
  List<Object> get props => [allCars];
}

class UserCarsListStateError extends UserCarsListState {
  final String message;
  final int statusCode;

  const UserCarsListStateError(this.message, this.statusCode);

  @override
  List<Object> get props => [message, statusCode];
}
