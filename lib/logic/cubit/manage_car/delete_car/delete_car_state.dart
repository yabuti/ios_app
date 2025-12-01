import 'package:equatable/equatable.dart';


 class DeleteCarState extends Equatable {
  const DeleteCarState();

  @override
  List<Object> get props => [];
}

class DeleteCarInitial extends DeleteCarState {
  const DeleteCarInitial();

  @override
  List<Object> get props => [];
}

class DeleteCarStateLoading extends DeleteCarState {}

class DeleteCarStateSuccess extends DeleteCarState {
  final String message;

  const DeleteCarStateSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class DeleteCarStateError extends DeleteCarState {
  final String message;
  final int statusCode;

  const DeleteCarStateError(this.message, this.statusCode);

  @override
  List<Object> get props => [message, statusCode];
}