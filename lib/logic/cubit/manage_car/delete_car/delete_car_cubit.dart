import 'package:carsbnb/logic/cubit/manage_car/delete_car/delete_car_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/data_provider/remote_url.dart';
import '../../../../data/model/home/home_model.dart';
import '../../../../utils/utils.dart';
import '../../../bloc/login/login_bloc.dart';
import '../../../repository/user_carList_repository.dart';

class DeleteCarCubit extends Cubit<DeleteCarState> {
  final UserCarListRepository _repository;
  final LoginBloc _loginBloc;

  DeleteCarCubit({
    required UserCarListRepository repository,
    required LoginBloc loginBloc,
  })
      : _repository = repository,
        _loginBloc = loginBloc,
        super(const DeleteCarInitial());

  List<FeaturedCars>? allCarModel;

  Future<void> deleteCar(String id) async {
    emit( DeleteCarStateLoading());
    final uri = Utils.tokenWithCode(RemoteUrls.deleteCar(id),
        _loginBloc.userInformation!.accessToken, _loginBloc.state.languageCode);
    final result = await _repository.deleteCar(uri);
    result.fold((failure) {
      final errorState =
      DeleteCarStateError(failure.message, failure.statusCode);
      emit(errorState);
    }, (success) {
      allCarModel?.removeWhere((item) => item.id.toString() == id);
      final successState = DeleteCarStateSuccess(success);
      emit(successState);
    });
  }

}