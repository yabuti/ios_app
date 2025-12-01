import 'package:blackdiamondcar/data/model/termsCo/terms_condition_model.dart';
import 'package:equatable/equatable.dart';

class TermsPolicyState extends Equatable {
  const TermsPolicyState();

  @override
  List<Object> get props => [];
}

class TermsPolicyInitial extends TermsPolicyState {
  const TermsPolicyInitial();

  @override
  List<Object> get props => [];
}

class GetTermsStateLoading extends TermsPolicyState {}

class GetTermsStateLoaded extends TermsPolicyState {
  final TermsModel terms;

  const GetTermsStateLoaded(this.terms);

  @override
  List<Object> get props => [terms];
}

class GetTermsStateError extends TermsPolicyState {
  final String message;
  final int statusCode;

  const GetTermsStateError(this.message, this.statusCode);

  @override
  List<Object> get props => [message, statusCode];
}