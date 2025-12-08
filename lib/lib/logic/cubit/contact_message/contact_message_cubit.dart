import 'package:carsbnb/logic/cubit/contact_message/contact_message_state.dart';
import 'package:carsbnb/logic/repository/home_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../presentation/errors/failure.dart';
import '../../bloc/login/login_bloc.dart';
import '../language_code_state.dart';

class ContactMessageCubit extends Cubit<LanguageCodeState> {
  final HomeRepository _repository;
  final LoginBloc _loginBloc;
  ContactMessageCubit({required HomeRepository repository,required LoginBloc loginBloc,})
      : _repository = repository,
        _loginBloc = loginBloc,
        super(LanguageCodeState());



  Future<void> contactMessage( Map<String, dynamic> body) async {
    print("contactMessage: $body");
    emit(state.copyWith(contactMessageState: const ContactMessageStateLoading()));
    final result = await _repository.contactMessage(
        _loginBloc.state.languageCode,  body);
    result.fold((failure) {
      if (failure is InvalidAuthData) {
        final errorState = ContactMessageValidateStateError(failure.errors);
        emit(state.copyWith(contactMessageState: errorState));
      } else {
        final errorState =
        ContactMessageStateError(failure.message, failure.statusCode);
        emit(state.copyWith(contactMessageState: errorState));
      }
    }, (success) {
      final successState = ContactMessageStateSuccess(success);
      emit(state.copyWith(contactMessageState: successState));
    });
  }
}