import 'package:equatable/equatable.dart';

import '../../../presentation/errors/errors_model.dart';

abstract class ContactDealerState extends Equatable {
  const ContactDealerState();

  @override
  List<Object> get props => [];
}

class ContactDealerInitial extends ContactDealerState {
  const ContactDealerInitial();
}

class ContactDealerStateLoading extends ContactDealerState {
  const ContactDealerStateLoading();
}

class ContactDealerStateSuccess extends ContactDealerState {
  final String message;

  const ContactDealerStateSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class ContactDealerValidateStateError extends ContactDealerState {
  final Errors errors;

  const ContactDealerValidateStateError(this.errors);

  @override
  List<Object> get props => [errors];
}


class ContactDealerStateError extends ContactDealerState {
  final String message;
  final int statusCode;

  const ContactDealerStateError(this.message, this.statusCode);

  @override
  List<Object> get props => [message, statusCode];
}