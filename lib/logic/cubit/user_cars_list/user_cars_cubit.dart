import 'package:carsbnb/data/model/home/home_model.dart';
import 'package:carsbnb/logic/cubit/user_cars_list/user_cars_state.dart';
import 'package:carsbnb/logic/repository/user_carList_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/data_provider/remote_url.dart';
import '../../../utils/utils.dart';
import '../../bloc/login/login_bloc.dart';
import '../language_code_state.dart';

class UserCarsCubit extends Cubit<LanguageCodeState> {
  final UserCarListRepository _carListRepository;
  final LoginBloc _loginBloc;

  UserCarsCubit({
    required UserCarListRepository userCarListRepository,
    required LoginBloc loginBloc,
  })  : _carListRepository = userCarListRepository,
        _loginBloc = loginBloc,
        super(LanguageCodeState());

  List<FeaturedCars>? allCarsModel = [];

  Future<void> getUserCarsList() async {
    emit(state.copyWith(userCarsListState: UserCarsListStateLoading()));
    final uri = Utils.tokenWithCodePage(
        RemoteUrls.getUserCarList,
        _loginBloc.userInformation!.accessToken,
        _loginBloc.state.languageCode,
        state.initialPage.toString());
    final result = await _carListRepository.getCarList(uri);
    result.fold((failure) {
      final errorState =
          UserCarsListStateError(failure.message, failure.statusCode);
      emit(state.copyWith(userCarsListState: errorState));
    }, (success) {
      if (state.initialPage == 1) {
        allCarsModel = success;
        final loaded = UserCarsListStateLoaded(allCarsModel!);
        emit(state.copyWith(userCarsListState: loaded));
      } else {
        allCarsModel!.addAll(success);
        final loaded = UserCarsListStateMoreLoaded(allCarsModel!);
        emit(state.copyWith(userCarsListState: loaded));
      }
      state.initialPage++;
      if (success.isEmpty && state.initialPage != 1) {
        emit(state.copyWith(isListEmpty: true));
      }
    });
  }

  void initPage() {
    emit(state.copyWith(initialPage: 1, isListEmpty: false));
  }

  void initState() {

    emit(state.copyWith(userCarsListState: const UserCarsInitial ()));

  }
}
