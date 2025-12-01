import 'package:blackdiamondcar/data/model/home/home_model.dart';
import 'package:blackdiamondcar/logic/bloc/login/login_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../utils/utils.dart';
import '../../repository/home_repository.dart';
import 'all_dealer_state.dart';
import 'dealer_search_state_model.dart';
import '../../../data/data_provider/remote_url.dart';

class AllDealerCubit extends Cubit<DealerSearchStateModel> {
  final HomeRepository _homeRepository;
  final LoginBloc _loginBloc;

  AllDealerCubit({
    required HomeRepository homeRepository,
    required LoginBloc loginBloc,
  })  : _homeRepository = homeRepository,
        _loginBloc = loginBloc,
        super(DealerSearchStateModel.init());

  CityModel? cityModel;
  List<Dealers> allDealerModel = [];

  /// Update search keyword
  void keyChange(String text) {
    emit(state.copyWith(search: text));
  }

  /// Update location filter
  void locationChange(String text) {
    emit(state.copyWith(location: text));
  }

  /// Fetch all dealers with pagination
  Future<void> getAllDealersList() async {
    emit(state.copyWith(allDealerState: AllDealerStateLoading()));

    final urlString = Utils.dealerWithCodeSearch(
      RemoteUrls.allDealer,
      state.initialPage.toString(),
      state.location,
      state.search,
      _loginBloc.state.languageCode,
    );

    try {
      // Pass urlString as String directly
      final result = await _homeRepository.getAllDealerList(urlString);

      result.fold(
        (failure) {
          emit(state.copyWith(
            allDealerState: AllDealerStateError(
              failure.message,
              failure.statusCode,
            ),
          ));
        },
        (success) {
          if (state.initialPage == 1) {
            allDealerModel = success;
            emit(state.copyWith(
                allDealerState: AllDealerStateLoaded(allDealerModel)));
          } else {
            allDealerModel.addAll(success);
            emit(state.copyWith(
                allDealerState: AllDealerStateMoreLoaded(allDealerModel)));
          }

          state.initialPage++;
          if (success.isEmpty && state.initialPage != 1) {
            emit(state.copyWith(isListEmpty: true));
          }
        },
      );
    } catch (e) {
      emit(state.copyWith(
        allDealerState: AllDealerStateError(e.toString(), 500),
      ));
    }
  }

  /// Apply filters and refresh the list
  Future<void> applyFilters() async {
    state.initialPage = 1;
    allDealerModel = [];
    await getAllDealersList();
  }

  /// Clear filters and refresh
  void clearFilters() {
    emit(state.copyWith(location: '', search: ''));
    applyFilters();
  }

  /// Fetch dealer cities
  Future<void> getDealerSearch() async {
    emit(state.copyWith(allDealerState: GetDealerCityStateLoading()));

    final urlString = Utils.tokenWithCode(
      RemoteUrls.getDealerCity,
      _loginBloc.userInformation!.accessToken,
      _loginBloc.state.languageCode,
    );

    try {
      // Pass urlString as String, not Uri
      final result = await _homeRepository.getDealerCity(urlString);

      result.fold(
        (failure) {
          emit(state.copyWith(
            allDealerState: GetDealerCityStateError(
              failure.message,
              failure.statusCode,
            ),
          ));
        },
        (success) {
          cityModel = success;
          emit(state.copyWith(
            allDealerState: GetDealerCityStateLoaded(success),
          ));
        },
      );
    } catch (e) {
      emit(state.copyWith(
        allDealerState: GetDealerCityStateError(e.toString(), 500),
      ));
    }
  }

  /// Initialize pagination
  void initPage() {
    emit(state.copyWith(initialPage: 1, isListEmpty: false));
  }
}
