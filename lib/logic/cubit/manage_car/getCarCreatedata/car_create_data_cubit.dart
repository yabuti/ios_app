import 'package:blackdiamondcar/logic/cubit/language_code_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/data_provider/remote_url.dart';
import '../../../../data/model/car/car_create_data_model.dart';
import '../../../../utils/utils.dart';
import '../../../bloc/login/login_bloc.dart';
import '../../../repository/user_carList_repository.dart';
import 'car_create_data_state.dart';

class CarCreateDataCubit extends Cubit<LanguageCodeState> {
  final UserCarListRepository _repository;
  final LoginBloc _loginBloc;

  CarCreateDataCubit({
    required UserCarListRepository repository,
    required LoginBloc loginBloc,
  })
      : _repository = repository,
        _loginBloc = loginBloc,
        super(LanguageCodeState());

  CarCreateDataModel? carCreateDataModel;

  Future<void> getCarCreateData() async {
    print("call get create car data");
    emit(state.copyWith(carCreateDataState: GetCarCreateDataLoading()));
    final uri = Utils.tokenWithCode(
      RemoteUrls.getCarCreateData,
      _loginBloc.userInformation!.accessToken,
      _loginBloc.state.languageCode,
    );
    final result = await _repository.getCarCreateData(uri);
    result.fold((failure) {
      final errorState =
      GetCarCreateDataError(failure.message, failure.statusCode);
      emit(state.copyWith(carCreateDataState: errorState));
    }, (success) {
      carCreateDataModel = success;
      final successState = GetCarCreateDataLoaded(success);

      emit(state.copyWith(carCreateDataState: successState));
    });
  }


}