import 'package:carsbnb/logic/bloc/login/login_bloc.dart';
import 'package:carsbnb/logic/cubit/contact_dealer/contact_dealer_state.dart';
import 'package:carsbnb/logic/repository/home_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../presentation/errors/failure.dart';
import '../language_code_state.dart';

class ContactDealerCubit extends Cubit<LanguageCodeState> {
  final HomeRepository _repository;
  final LoginBloc _loginBloc;

  ContactDealerCubit({
    required HomeRepository repository,
    required LoginBloc loginBloc,

  })
      : _repository = repository,
        _loginBloc = loginBloc,
        super(LanguageCodeState());



  Future<void> contactDealer( String id, Map<String, dynamic> body) async {
    print("contactDealer: $body");
    emit(state.copyWith(contactDealerState: const ContactDealerStateLoading()));


    final result = await _repository.contactDealer(
        _loginBloc.state.languageCode, id, body);
    result.fold((failure) {
      if (failure is InvalidAuthData) {
        final errorState = ContactDealerValidateStateError(failure.errors);
        emit(state.copyWith(contactDealerState: errorState));
      } else {
        final errorState =
        ContactDealerStateError(failure.message, failure.statusCode);
        emit(state.copyWith(contactDealerState: errorState));
      }
    }, (success) {
      final successState = ContactDealerStateSuccess(success);
      emit(state.copyWith(contactDealerState: successState));
    });
  }
}