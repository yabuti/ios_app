import 'package:carsbnb/data/model/termsCo/terms_condition_model.dart';
import 'package:carsbnb/logic/cubit/language_code_state.dart';
import 'package:carsbnb/logic/cubit/termsPolicy/terms_state.dart';
import 'package:carsbnb/logic/repository/review_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/login/login_bloc.dart';

class TermsPolicyCubit extends Cubit<LanguageCodeState> {
  final ReviewRepository _repository;
  final LoginBloc _loginBloc;

  TermsPolicyCubit({
    required ReviewRepository repository,
    required LoginBloc loginBloc,
  })
      : _repository = repository,
        _loginBloc = loginBloc,
        super( LanguageCodeState());

  TermsModel? terms;


  Future<void> getTermsCondition() async {
    emit(state.copyWith(termsPolicyState:  GetTermsStateLoading()));
    final result = await _repository.getTermsCondition(_loginBloc.state.languageCode);
    result.fold((failure) {
      final errorState =
      GetTermsStateError(failure.message, failure.statusCode);
      emit(state.copyWith(termsPolicyState: errorState));
    }, (success) {
      terms = success;
      final successState = GetTermsStateLoaded(success);
      emit(state.copyWith(termsPolicyState: successState));
    });
  }


  Future<void> getPrivacyPolicy() async {
    emit(state.copyWith(termsPolicyState:  GetTermsStateLoading()));
    final result = await _repository.getPrivacyPolicy(_loginBloc.state.languageCode);
    result.fold((failure) {
      final errorState =
      GetTermsStateError(failure.message, failure.statusCode);
      emit(state.copyWith(termsPolicyState: errorState));
    }, (success) {
      terms = success;
      final successState = GetTermsStateLoaded(success);
      emit(state.copyWith(termsPolicyState: successState));
    });
  }

}