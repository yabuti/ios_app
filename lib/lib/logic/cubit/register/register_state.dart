import 'package:equatable/equatable.dart';
import '../../../presentation/errors/errors_model.dart';

abstract class RegisterState extends Equatable {
  const RegisterState();

  @override
  List<Object> get props => [];
}

class RegisterInitial extends RegisterState {
  const RegisterInitial();
}

class RegisterStateLoading extends RegisterState {}

class RegisterStateSuccess extends RegisterState {
  final String message;
  const RegisterStateSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class RegisterValidateStateError extends RegisterState {
  final Errors errors;
  const RegisterValidateStateError(this.errors);

  @override
  List<Object> get props => [errors];
}

class RegisterStateError extends RegisterState {
  final String message;
  final int statusCode;
  const RegisterStateError(this.message, this.statusCode);

  @override
  List<Object> get props => [message, statusCode];
}

// OTP related states
class RegisterOtpStateLoading extends RegisterState {}

class RegisterOtpStateSuccess extends RegisterState {
  final String message;
  const RegisterOtpStateSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class RegisterOtpStateError extends RegisterState {
  final String message;
  final int statusCode;
  const RegisterOtpStateError(this.message, this.statusCode);

  @override
  List<Object> get props => [message, statusCode];
}
