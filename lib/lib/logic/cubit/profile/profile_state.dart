import 'package:equatable/equatable.dart';

import '../../../data/model/auth/user_response_model.dart';
import '../../../presentation/errors/errors_model.dart';

class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileInitial extends ProfileState {
  const ProfileInitial();

  @override
  List<Object> get props => [];
}

class GetProfileDataStateLoading extends ProfileState {}

class GetProfileDataStateLoaded extends ProfileState {
  final User user;

  const GetProfileDataStateLoaded(this.user);

  @override
  List<Object> get props => [user];
}

class GetProfileDataStateError extends ProfileState {
  final String message;
  final int statusCode;

  const GetProfileDataStateError(this.message, this.statusCode);

  @override
  List<Object> get props => [message, statusCode];
}



class UpdateProfileStateLoading extends ProfileState {}

class UpdateProfileStateLoaded extends ProfileState {
  final String message;

  const UpdateProfileStateLoaded(this.message);

  @override
  List<Object> get props => [message];
}

class UpdateProfileStateError extends ProfileState {
  final String message;
  final int statusCode;

  const UpdateProfileStateError(this.message, this.statusCode);

  @override
  List<Object> get props => [message, statusCode];
}


class UpdateProfileStateFormValidate extends ProfileState {
  final Errors errors;

  const UpdateProfileStateFormValidate(this.errors);

  @override
  List<Object> get props => [errors];
}