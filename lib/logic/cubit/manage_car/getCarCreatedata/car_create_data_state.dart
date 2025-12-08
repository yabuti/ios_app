import 'package:equatable/equatable.dart';

import '../../../../data/model/car/car_create_data_model.dart';

abstract class CarCreateDataState extends Equatable {
  const CarCreateDataState();

  @override
  List<Object> get props => [];
}

class CarCreateDataInitial extends CarCreateDataState {
  const CarCreateDataInitial();

  @override
  List<Object> get props => [];
}

class GetCarCreateDataLoading extends CarCreateDataState{}

class GetCarCreateDataLoaded extends CarCreateDataState {
  final CarCreateDataModel carCreateDataModel;

  const GetCarCreateDataLoaded(this.carCreateDataModel);

  @override
  List<Object> get props => [carCreateDataModel];
}

class GetCarCreateDataError extends CarCreateDataState {
  final String message;
  final int statusCode;

  const GetCarCreateDataError(this.message, this.statusCode);

  @override
  List<Object> get props => [message, statusCode];
}
