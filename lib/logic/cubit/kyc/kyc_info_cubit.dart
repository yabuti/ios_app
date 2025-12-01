import 'package:blackdiamondcar/data/model/kyc/kyc_model.dart';
import 'package:blackdiamondcar/logic/cubit/kyc/kyc_info_state.dart';
import 'package:blackdiamondcar/logic/repository/kyc_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/data_provider/remote_url.dart';
import '../../../data/model/kyc/kyc_submit_state_model.dart';
import '../../../presentation/errors/failure.dart';
import '../../../utils/utils.dart';
import '../../bloc/login/login_bloc.dart';

class KycInfoCubit extends Cubit<KycSubmitStateModel> {
  final KycRepository _repository;
  final LoginBloc _loginBloc;

  KycInfoCubit({
    required KycRepository repository,
    required LoginBloc loginBloc,
  })  : _repository = repository,
        _loginBloc = loginBloc,
        super( KycSubmitStateModel.init());

  KYCModel? kycModel;



  void messageChange(String value) {
    emit(state.copyWith(
        message: value, kycInfoState: const KycInfoInitial()));
  }

  void kycIdChange(String value) {
    emit(state.copyWith(id: value, kycInfoState: const KycInfoInitial()));
  }

  void fileChange(String text) {
    emit(state.copyWith(file: text, kycInfoState: const KycInfoInitial()));
  }

  Future<void> getKycInfo() async {
    if (_loginBloc.userInformation?.accessToken.isNotEmpty ?? false) {
      emit(state.copyWith(kycInfoState: GetKycInfoStateLoading()));
      final uri = Utils.tokenWithCode(
        RemoteUrls.getKycInfo,
        _loginBloc.userInformation!.accessToken,
        _loginBloc.state.languageCode,
      );
      final result = await _repository.getKycInfo(uri);
      result.fold((failure) {
        final errorState =
        GetKycInfoStateError(failure.message, failure.statusCode);
        emit(state.copyWith(kycInfoState: errorState));
      }, (success) {
        kycModel = success;
        final successState = GetKycInfoStateLoaded(success);
        emit(state.copyWith(kycInfoState: successState));
      });
    }
    else{
      const errors = GetKycInfoStateError('', 401);
      emit(state.copyWith(kycInfoState: errors));
    }
  }



  Future<void> submitKycVerify() async {
    print('Kyc-verify-body ${state.toMap()}');
    emit(state.copyWith(kycInfoState: KycVerifyStateLoading()));
    final uri = Utils.tokenWithCode(RemoteUrls.submitKycInfo,
        _loginBloc.userInformation!.accessToken, _loginBloc.state.languageCode);
    final result = await _repository.submitKycVerify(uri, state);
    result.fold(
          (failure) {
        if (failure is InvalidAuthData) {
          final errorState = KycVerifyValidateError(failure.errors);
          emit(state.copyWith(kycInfoState: errorState));
        } else {
          final errors =
          KycVerifyStateError(failure.message, failure.statusCode);
          emit(state.copyWith(kycInfoState: errors));
        }
      },
          (success) {
        emit(state.copyWith(
            kycInfoState: KycVerifySubmitStateSuccess(success)));
      },
    );
  }

  Future<void> clearAllField() async {
    emit(KycSubmitStateModel.reset());
  }
}
