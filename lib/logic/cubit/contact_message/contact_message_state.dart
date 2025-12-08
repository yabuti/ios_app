import 'package:equatable/equatable.dart';

import '../../../presentation/errors/errors_model.dart';

abstract class ContactMessageState extends Equatable {
  const ContactMessageState();

  @override
  List<Object> get props => [];
}

class ContactMessageInitial extends ContactMessageState {
  const ContactMessageInitial();
}

class ContactMessageStateLoading extends ContactMessageState {
  const ContactMessageStateLoading();
}

class ContactMessageStateSuccess extends ContactMessageState {
  final String message;

  const ContactMessageStateSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class ContactMessageValidateStateError extends ContactMessageState {
  final Errors errors;

  const ContactMessageValidateStateError(this.errors);

  @override
  List<Object> get props => [errors];
}


class ContactMessageStateError extends ContactMessageState {
  final String message;
  final int statusCode;

  const ContactMessageStateError(this.message, this.statusCode);

  @override
  List<Object> get props => [message, statusCode];
}