import 'package:blackdiamondcar/data/model/compare/compare_list_model.dart';
import 'package:blackdiamondcar/logic/cubit/compare/compare_list_state.dart';
import 'package:blackdiamondcar/logic/repository/compare_reposotory.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/data_provider/remote_url.dart';
import '../../../presentation/errors/failure.dart';
import '../../../utils/utils.dart';
import '../../bloc/login/login_bloc.dart';
import '../language_code_state.dart';

class CompareCubit extends Cubit<LanguageCodeState> {
  final CompareRepository _repository;
  final LoginBloc _loginBloc;

  CompareCubit({
    required CompareRepository repository,
    required LoginBloc loginBloc,
  })
      : _repository = repository,
        _loginBloc = loginBloc,
        super(LanguageCodeState());

  CompareListModel? compareListModel;


  Future<void> getCompareList() async {
    if (_loginBloc.userInformation?.accessToken.isNotEmpty ?? false) {
      emit(state.copyWith(compareListState: GetCompareListStateLoading()));
      final uri = Utils.tokenWithCode(
        RemoteUrls.compareList,
        _loginBloc.userInformation!.accessToken,
        _loginBloc.state.languageCode,
      );
      final result = await _repository.getCompareList(uri);
      result.fold((failure) {
        final errorState =
        GetCompareListStateError(failure.message, failure.statusCode);
        emit(state.copyWith(compareListState: errorState));
      }, (success) {
        compareListModel = success;
        final successState = GetCompareListStateLoaded(success);
        emit(state.copyWith(compareListState: successState));
      });
    }
    else{
      const errors = GetCompareListStateError('', 401);
      emit(state.copyWith(compareListState: errors));
    }
  }



  Future<void> addCompare( Map<String, dynamic> body) async {
    emit(state.copyWith(compareListState: const AddCompareStateLoading()));
    final uri = Utils.tokenWithCode(
      RemoteUrls.addCompareList,
      _loginBloc.userInformation!.accessToken,
      _loginBloc.state.languageCode,
    );
    final result = await _repository.addCompareList(
        uri,  body);
    result.fold((failure) {
      if (failure is InvalidAuthData) {
        final errorState = AddCompareValidateStateError(failure.errors);
        emit(state.copyWith(compareListState: errorState));
      } else {
        final errorState =
        AddCompareStateError(failure.message, failure.statusCode);
        emit(state.copyWith(compareListState: errorState));
      }
    }, (success) {
      final successState = AddCompareStateSuccess(success);
      emit(state.copyWith(compareListState: successState));
    });
  }


  Future<void> removeCompareList(String id) async {
    emit(state.copyWith(compareListState: const AddCompareStateLoading()));
    final uri = Utils.tokenWithCode(RemoteUrls.removeCompareList(id),
        _loginBloc.userInformation!.accessToken, _loginBloc.state.languageCode);
    final result = await _repository.removeCompareList(uri);
    result.fold((failure) {
      final errorState =
      AddCompareStateError(failure.message, failure.statusCode);
      emit(state.copyWith(compareListState: errorState));
    }, (success) {
      compareListModel!.compareList?.removeWhere((item) => item.id.toString() == id);
      final successState = RemoveCompareSuccess(success);
      emit(state.copyWith(compareListState: successState));
    });
  }

}