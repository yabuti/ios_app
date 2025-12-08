import 'package:carsbnb/data/model/review/review_list_model.dart';
import 'package:equatable/equatable.dart';

import '../../../presentation/errors/errors_model.dart';


class ReviewListState extends Equatable {
  const ReviewListState();

  @override
  List<Object> get props => [];
}

class ReviewListInitial extends ReviewListState {
  const ReviewListInitial();

  @override
  List<Object> get props => [];
}

class GetReviewListStateLoading extends ReviewListState {}

class GetReviewListStateLoaded extends ReviewListState {
  final List<ReviewListModel> reviewList;

  const GetReviewListStateLoaded(this.reviewList);

  @override
  List<Object> get props => [reviewList];
}

class GetReviewListStateError extends ReviewListState {
  final String message;
  final int statusCode;

  const GetReviewListStateError(this.message, this.statusCode);

  @override
  List<Object> get props => [message, statusCode];
}



class StoreReviewStateLoading extends ReviewListState {
  const StoreReviewStateLoading();
}

class StoreReviewStateSuccess extends ReviewListState {
  final String message;

  const StoreReviewStateSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class StoreReviewValidateStateError extends ReviewListState {
  final Errors errors;

  const StoreReviewValidateStateError(this.errors);

  @override
  List<Object> get props => [errors];
}


class StoreReviewStateError extends ReviewListState {
  final String message;
  final int statusCode;

  const StoreReviewStateError(this.message, this.statusCode);

  @override
  List<Object> get props => [message, statusCode];
}


// class KycVerifyStateLoading extends ReviewListState {}
//
// class KycVerifySubmitStateSuccess extends ReviewListState {
//   final String message;
//
//   const KycVerifySubmitStateSuccess(this.message);
//
//   @override
//   List<Object> get props => [message];
// }
//
// class KycVerifyValidateError extends ReviewListState {
//   final Errors errors;
//
//   const KycVerifyValidateError(this.errors);
//
//   @override
//   List<Object> get props => [errors];
// }
//
// class KycVerifyStateError extends ReviewListState {
//   final String message;
//   final int statusCode;
//
//   const KycVerifyStateError(this.message, this.statusCode);
//
//   @override
//   List<Object> get props => [message, statusCode];
// }