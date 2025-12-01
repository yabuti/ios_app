part of 'forgot_password_cubit.dart';

abstract class ForgotPasswordState extends Equatable {
  const ForgotPasswordState();

  @override
  List<Object> get props => [];
}

class ForgotPasswordStateInitial extends ForgotPasswordState {
  const ForgotPasswordStateInitial();
  @override
  List<Object> get props => [];
}

class ForgotPasswordStateLoading extends ForgotPasswordState {
  const ForgotPasswordStateLoading();
  @override
  List<Object> get props => [];
}

class ChangePasswordStateLoading extends ForgotPasswordState {
  const ChangePasswordStateLoading();
  @override
  List<Object> get props => [];
}

class ForgotPasswordStateError extends ForgotPasswordState {
  const ForgotPasswordStateError(this.message, this.statusCode);

  final String message;
  final int statusCode;

  @override
  List<Object> get props => [message, statusCode];
}

class ChangePasswordStateError extends ForgotPasswordState {
  const ChangePasswordStateError(this.message, this.statusCode);

  final String message;
  final int statusCode;

  @override
  List<Object> get props => [message, statusCode];
}

class ForgotPasswordFormValidateError extends ForgotPasswordState {
  const ForgotPasswordFormValidateError(this.errors);

  final Errors errors;

  @override
  List<Object> get props => [errors];
}

class ChangePasswordFormValidateError extends ForgotPasswordState {
  const ChangePasswordFormValidateError(this.errors);

  final Errors errors;

  @override
  List<Object> get props => [errors];
}


class ForgotPasswordStateLoaded extends ForgotPasswordState {
  const ForgotPasswordStateLoaded(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}

class PasswordStateUpdated extends ForgotPasswordState {
  const PasswordStateUpdated(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}

class ChangePasswordStateUpdated extends ForgotPasswordState {
  const ChangePasswordStateUpdated(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}

class PasswordStateUpdatedError extends ForgotPasswordState {
  const PasswordStateUpdatedError(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}

class VerifyingForgotPasswordCodeLoaded extends ForgotPasswordState {
  const VerifyingForgotPasswordCodeLoaded();

  @override
  List<Object> get props => [];
}

class VerifyingForgotPasswordLoading extends ForgotPasswordState {
  const VerifyingForgotPasswordLoading();

  @override
  List<Object> get props => [];
}

class VerifyingForgotPasswordError extends ForgotPasswordState {
  const VerifyingForgotPasswordError(this.message);

  final String message;
  @override
  List<Object> get props => [message];
}

class VerifyingForgotPasswordLoaded extends ForgotPasswordState {
  const VerifyingForgotPasswordLoaded(this.message,);

  final String message;
 // final String success;
  @override
  List<Object> get props => [message];
}

// class ForgotShowConfirmPassword extends ForgotPasswordState {
//   final bool isVisible;
//   const ForgotShowConfirmPassword(this.isVisible);
//
//   @override
//   List<Object> get props => [isVisible];
// }


class SetPasswordStateLoading extends ForgotPasswordState {
  const SetPasswordStateLoading();
  @override
  List<Object> get props => [];
}

class SetForgotPasswordLoaded extends ForgotPasswordState {
  const SetForgotPasswordLoaded(this.message,);

  final String message;
  @override
  List<Object> get props => [message];
}

class SetPasswordStateError extends ForgotPasswordState {
  const SetPasswordStateError(this.message, this.statusCode);

  final String message;
  final int statusCode;

  @override
  List<Object> get props => [message, statusCode];
}

class SetPasswordFormValidateError extends ForgotPasswordState {
  const SetPasswordFormValidateError(this.errors);

  final Errors errors;

  @override
  List<Object> get props => [errors];
}


//
// class SetPasswordStateLoading extends ForgotPasswordState {
//   const SetPasswordStateLoading();
//   @override
//   List<Object> get props => [];
// }


/// Update Password

class UpdatePasswordStateLoading extends ForgotPasswordState {
  const UpdatePasswordStateLoading();
  @override
  List<Object> get props => [];
}

class UpdatePasswordStateLoaded extends ForgotPasswordState {
  const UpdatePasswordStateLoaded(this.message,);

  final String message;
  @override
  List<Object> get props => [message];
}

class UpdatePasswordStateError extends ForgotPasswordState {
  const UpdatePasswordStateError(this.message, this.statusCode);

  final String message;
  final int statusCode;

  @override
  List<Object> get props => [message, statusCode];
}

class UpdatePasswordFormValidateError extends ForgotPasswordState {
  const UpdatePasswordFormValidateError(this.errors);

  final Errors errors;

  @override
  List<Object> get props => [errors];
}