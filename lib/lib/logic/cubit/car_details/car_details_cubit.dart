import 'package:carsbnb/data/model/cars_details/car_details_model.dart';
import 'package:carsbnb/logic/cubit/car_details/car_details_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/login/login_bloc.dart';
import '../../repository/home_repository.dart';
import '../language_code_state.dart';

class CarDetailsCubit extends Cubit<LanguageCodeState> {
  final HomeRepository _homeRepository;
  final LoginBloc _loginBloc;

  CarDetailsCubit({
    required HomeRepository homeRepository,
    required LoginBloc loginBloc,
  })  : _homeRepository = homeRepository,
        _loginBloc = loginBloc,
        super(LanguageCodeState());

  CarDetailsModel? detailsModel;

  Future<void> getCarDetails(String id) async {
    emit(state.copyWith(carDetailsState: CarDetailsStateLoading()));
    final result = await _homeRepository.carDetails(_loginBloc.state.languageCode, id);
    result.fold((failure) {
      final errorState =
          CarDetailsStateError(failure.message, failure.statusCode);
      emit(state.copyWith(carDetailsState: errorState));
    }, (success) {
      detailsModel = success;
      final successState = CarDetailsStateLoaded(success);

      emit(state.copyWith(carDetailsState: successState));
    });
  }
}
