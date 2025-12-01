import 'package:blackdiamondcar/data/model/kyc/kyc_model.dart';
import 'package:equatable/equatable.dart';

import '../../../presentation/errors/errors_model.dart';


class KycInfoState extends Equatable {
  const KycInfoState();

  @override
  List<Object> get props => [];
}

class KycInfoInitial extends KycInfoState {
  const KycInfoInitial();

  @override
  List<Object> get props => [];
}

class GetKycInfoStateLoading extends KycInfoState {}

class GetKycInfoStateLoaded extends KycInfoState {
  final KYCModel kycModel;

  const GetKycInfoStateLoaded(this.kycModel);

  @override
  List<Object> get props => [kycModel];
}

class GetKycInfoStateError extends KycInfoState {
  final String message;
  final int statusCode;

  const GetKycInfoStateError(this.message, this.statusCode);

  @override
  List<Object> get props => [message, statusCode];
}




class KycVerifyStateLoading extends KycInfoState {}

class KycVerifySubmitStateSuccess extends KycInfoState {
  final String message;

  const KycVerifySubmitStateSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class KycVerifyValidateError extends KycInfoState {
  final Errors errors;

  const KycVerifyValidateError(this.errors);

  @override
  List<Object> get props => [errors];
}

class KycVerifyStateError extends KycInfoState {
  final String message;
  final int statusCode;

  const KycVerifyStateError(this.message, this.statusCode);

  @override
  List<Object> get props => [message, statusCode];
}