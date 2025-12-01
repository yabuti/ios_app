import 'dart:convert';
import 'package:blackdiamondcar/data/model/home/home_model.dart' as home_model;
import 'package:blackdiamondcar/data/model/search_attribute/search_attribute_model.dart'
    as search_attr;
import 'package:blackdiamondcar/logic/bloc/login/login_bloc.dart';
import 'package:blackdiamondcar/logic/cubit/all_cars/all_cars_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/data_provider/remote_url.dart';
import '../../../utils/utils.dart';
import '../../repository/home_repository.dart';
import 'all_car_state_model.dart';

class AllCarsCubit extends Cubit<CarSearchStateModel> {
  final HomeRepository _homeRepository;
  final LoginBloc _loginBloc;

  AllCarsCubit({
    required HomeRepository homeRepository,
    required LoginBloc loginBloc,
  })  : _homeRepository = homeRepository,
        _loginBloc = loginBloc,
        super(CarSearchStateModel.init());

  List<home_model.FeaturedCars> allCarsModel = [];
  search_attr.SearchAttributeModel? searchAttributeModel;
  home_model.CityModel? cityModel;

  // Filters
  void keyChange(String text) => emit(state.copyWith(search: text));
  void locationChange(String text) => emit(state.copyWith(location: text));
  void countryChange(String text) => emit(state.copyWith(countryId: text));
  void brandChange(String text) => emit(state.copyWith(brands: text));
  void conditionChange(List<String> selected) =>
      emit(state.copyWith(condition: selected));
  void purposeChange(List<String> selected) =>
      emit(state.copyWith(purpose: selected));
  void featureChange(List<String> selected) =>
      emit(state.copyWith(feature: selected));

  // Get All Cars
  Future<void> getAllCarsList() async {
    emit(state.copyWith(allCarsState: AllCarsStateLoading()));

    final uri = Utils.tokenWithCodeSearch(
      RemoteUrls.allCarList,
      state.initialPage.toString(),
      state.brands.toString(),
      state.location,
      state.countryId,
      state.search,
      _loginBloc.state.languageCode,
      state.feature,
      state.purpose,
      state.condition,
    );

    final result = await _homeRepository.getAllCarList(uri);

    result.fold(
      (failure) {
        emit(state.copyWith(
          allCarsState: AllCarsStateError(failure.message, failure.statusCode),
        ));
      },
      (success) {
        if (state.initialPage == 1) {
          allCarsModel = success;
          emit(state.copyWith(allCarsState: AllCarsStateLoaded(allCarsModel)));
        } else {
          allCarsModel.addAll(success);
          emit(state.copyWith(
              allCarsState: AllCarsStateMoreLoaded(allCarsModel)));
        }

        state.initialPage++;

        if (success.isEmpty && state.initialPage != 1) {
          emit(state.copyWith(isListEmpty: true));
        }
      },
    );
  }

  Future<void> applyFilters() async {
    state.initialPage = 1;
    allCarsModel = [];
    await getAllCarsList();
  }

  void clearFilters() {
    emit(state.copyWith(
      location: '',
      countryId: '',
      brands: '',
      search: '',
      feature: [],
      purpose: [],
      condition: [],
    ));
    applyFilters();
  }

  // Load Search Attributes
  Future<void> getSearchAttribute() async {
    emit(state.copyWith(allCarsState: GetSearchAttributeStateLoading()));

    final uri = Utils.onlyCode(
      RemoteUrls.getSearchAttribute,
      _loginBloc.state.languageCode,
    );

    final result = await _homeRepository.getSearchAttribute(uri);

    result.fold(
      (failure) {
        emit(state.copyWith(
          allCarsState:
              GetSearchAttributeStateError(failure.message, failure.statusCode),
        ));
      },
      (success) {
        searchAttributeModel = success;
        emit(state.copyWith(
          allCarsState: GetSearchAttributeStateLoaded(success),
        ));
      },
    );
  }

  // FIXED getCity => using getDealerCity() because your repository has no getCity()
  Future<void> getCity(String id) async {
    emit(state.copyWith(allCarsState: GetCityStateLoading()));

    final uri = Utils.tokenWithCode(
      RemoteUrls.getCity(id),
      _loginBloc.userInformation!.accessToken,
      _loginBloc.state.languageCode,
    );

    final result = await _homeRepository.getDealerCity(uri);

    result.fold(
      (failure) {
        emit(state.copyWith(
          allCarsState: GetCityStateError(failure.message, failure.statusCode),
        ));
      },
      (success) {
        cityModel = success;
        emit(state.copyWith(allCarsState: GetCityStateLoaded(success)));
      },
    );
  }

  void initPage() => emit(state.copyWith(initialPage: 1, isListEmpty: false));

  // FIXED: submitPreOrder (removed wrong parameter)
  Future<bool> submitPreOrder({
    required String name,
    required String phone,
    required String deliveryDate,
    required String type,
    required String carBrand, // kept so UI doesn't break
    String? carDescription,
    int? carId,
    int? cityId,
    int? countryId,
    String? userMessage,
  }) async {
    emit(state.copyWith(allCarsState: AllCarsStateLoading()));

    final result = await _homeRepository.submitPreOrder(
      name: name,
      phone: phone,
      deliveryDate: deliveryDate,
      type: type,
      userMessage: carDescription ?? userMessage,
      carId: carId,
      cityId: cityId,
      countryId: countryId,
    );

    return result.fold(
      (failure) {
        emit(state.copyWith(
          allCarsState: AllCarsStateError(failure.message, failure.statusCode),
        ));
        return false;
      },
      (successString) {
        try {
          final jsonData = jsonDecode(successString);
          if (jsonData['status'] == 'success') return true;

          emit(state.copyWith(
            allCarsState:
                AllCarsStateError(jsonData['message'] ?? "Error", 400),
          ));
          return false;
        } catch (_) {
          return true;
        }
      },
    );
  }
}
