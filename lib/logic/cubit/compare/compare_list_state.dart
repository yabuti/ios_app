import 'package:carsbnb/data/model/compare/compare_list_model.dart';
import 'package:equatable/equatable.dart';

import '../../../presentation/errors/errors_model.dart';

class CompareListState extends Equatable {
  const CompareListState();

  @override
  List<Object> get props => [];
}

class CompareListInitial extends CompareListState {
  const CompareListInitial();

  @override
  List<Object> get props => [];
}

class GetCompareListStateLoading extends CompareListState {}

class GetCompareListStateLoaded extends CompareListState {
  final CompareListModel compareListModel;

  const GetCompareListStateLoaded(this.compareListModel);

  @override
  List<Object> get props => [compareListModel];
}

class GetCompareListStateError extends CompareListState {
  final String message;
  final int statusCode;

  const GetCompareListStateError(this.message, this.statusCode);

  @override
  List<Object> get props => [message, statusCode];
}

/// add compare

class AddCompareStateLoading extends CompareListState {
  const AddCompareStateLoading();
}

class AddCompareStateSuccess extends CompareListState {
  final String message;

  const AddCompareStateSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class AddCompareValidateStateError extends CompareListState {
  final Errors errors;

  const AddCompareValidateStateError(this.errors);

  @override
  List<Object> get props => [errors];
}


class AddCompareStateError extends CompareListState {
  final String message;
  final int statusCode;

  const AddCompareStateError(this.message, this.statusCode);

  @override
  List<Object> get props => [message, statusCode];
}

/// remove compare

class RemoveCompareSuccess extends CompareListState {
  final String message;

  // final WishListModel wishlistModel;

  const RemoveCompareSuccess(this.message);

  @override
  List<Object> get props => [message];
}