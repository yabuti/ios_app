import 'package:equatable/equatable.dart';
import '../../../data/model/car/create_model_response.dart';
import '../../../data/model/car/getCarEditDataModel.dart';
import '../../../presentation/errors/errors_model.dart';

abstract class ManageCarState extends Equatable {
  const ManageCarState();

  @override
  List<Object> get props => [];
}

class ManageCarInitial extends ManageCarState {
  const ManageCarInitial();

  @override
  List<Object> get props => [];
}

class ManageCarAddStateLoading extends ManageCarState {}

class ManageCarAddStateSuccess extends ManageCarState {
  final CreateModelResponse createModelResponse;

  const ManageCarAddStateSuccess(this.createModelResponse);

  @override
  List<Object> get props => [createModelResponse];
}


class ManageCarAddStateError extends ManageCarState {
  final String message;
  final int statusCode;

  const ManageCarAddStateError(this.message, this.statusCode);

  @override
  List<Object> get props => [message, statusCode];
}

class ManageCarAddFormValidate extends ManageCarState {
  final Errors error;

  const ManageCarAddFormValidate(this.error);

  @override
  List<Object> get props => [error];
}


/// get car create data


// class GetCarCreateDataLoading extends ManageCarState{}
//
// class GetCarCreateDataLoaded extends ManageCarState {
//   final CarCreateDataModel carCreateDataModel;
//
//   const GetCarCreateDataLoaded(this.carCreateDataModel);
//
//   @override
//   List<Object> get props => [carCreateDataModel];
// }
//
// class GetCarCreateDataError extends ManageCarState {
//   final String message;
//   final int statusCode;
//
//   const GetCarCreateDataError(this.message, this.statusCode);
//
//   @override
//   List<Object> get props => [message, statusCode];
// }


/// get car Edit data


class GetCarEditDataLoading extends ManageCarState{}

class GetCarEditDataLoaded extends ManageCarState {
  final CarEditDataModel carEditDataModel;

  const GetCarEditDataLoaded(this.carEditDataModel);

  @override
  List<Object> get props => [carEditDataModel];
}

class GetCarEditDataError extends ManageCarState {
  final String message;
  final int statusCode;

  const GetCarEditDataError(this.message, this.statusCode);

  @override
  List<Object> get props => [message, statusCode];
}