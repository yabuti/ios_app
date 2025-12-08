import 'package:equatable/equatable.dart';

import '../../../data/model/home/dealer_details_model.dart';


abstract class DealerDetailsState extends Equatable {
  const DealerDetailsState();

  @override
  List<Object> get props => [];
}
class DealerDetailsInitial extends DealerDetailsState {
  const DealerDetailsInitial();

  @override
  List<Object> get props => [];
}

class DealerDetailsStateLoading extends DealerDetailsState {}

class DealerDetailsStateLoaded extends DealerDetailsState {
  final DealerDetailsModel dealerDetailsModel;

  const DealerDetailsStateLoaded(this.dealerDetailsModel);

  @override
  List<Object> get props => [dealerDetailsModel];
}

class DealerDetailsStateError extends DealerDetailsState {
  final String message;
  final int statusCode;

  const DealerDetailsStateError(this.message, this.statusCode);

  @override
  List<Object> get props => [message, statusCode];
}

