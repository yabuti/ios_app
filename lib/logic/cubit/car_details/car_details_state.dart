import 'package:blackdiamondcar/data/model/cars_details/car_details_model.dart';
import 'package:equatable/equatable.dart';


abstract class CarDetailsState extends Equatable {
  const CarDetailsState();

  @override
  List<Object> get props => [];
}
class CarDetailsInitial extends CarDetailsState {
  const CarDetailsInitial();

  @override
  List<Object> get props => [];
}

class CarDetailsStateLoading extends CarDetailsState {}

class CarDetailsStateLoaded extends CarDetailsState {
  final CarDetailsModel carDetailsModel;

  const CarDetailsStateLoaded(this.carDetailsModel);

  @override
  List<Object> get props => [carDetailsModel];
}

class CarDetailsStateError extends CarDetailsState {
  final String message;
  final int statusCode;

  const CarDetailsStateError(this.message, this.statusCode);

  @override
  List<Object> get props => [message, statusCode];
}

