import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/data_provider/remote_url.dart';
import '../../../presentation/errors/errors_model.dart';
import '../../../presentation/errors/failure.dart';
import '../../../utils/utils.dart';
import '../../bloc/login/login_bloc.dart';
import '../../repository/auth_repository.dart';
import 'forgot_password_state_model.dart';

part 'forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<PasswordStateModel> {
  final AuthRepository _authRepository;
  final LoginBloc _loginBloc;

  ForgotPasswordCubit({
    required AuthRepository authRepository,
    required LoginBloc loginBloc,
  })
      : _authRepository = authRepository,
        _loginBloc = loginBloc,
        super(PasswordStateModel.init());

  void changeEmail(String text) {
    emit(state.copyWith(
        email: text, passwordState: const ForgotPasswordStateInitial()));
  }

  void changeCode(String text) {
    emit(state.copyWith(
        code: text, passwordState: const ForgotPasswordStateInitial()));
  }

  void passwordChange(String text) {
    emit(state.copyWith(
        password: text, passwordState: const ForgotPasswordStateInitial()));
  }

  void changeConfirmPassword(String text) {
    emit(state.copyWith(
        confirmPassword: text, passwordState: const ForgotPasswordStateInitial()));
  }


  void oldPassword(String text) {
    emit(state.copyWith(
        oldPassword: text, passwordState: const ForgotPasswordStateInitial()));
  }

  void changeNewPassword(String text) {
    emit(state.copyWith(
        newPassword: text,
        passwordState: const ForgotPasswordStateInitial()));
  }

  void showPassword() {
    emit(state.copyWith(
        showPassword: !state.showPassword,
        passwordState: const ForgotPasswordStateInitial()));
  }

  void showOldPassword() {
    emit(state.copyWith(
        showOldPassword: !state.showOldPassword,
        passwordState: const ForgotPasswordStateInitial()));
  }

  void showConfirmPassword() {
    emit(state.copyWith(
        showConfirmPassword: !state.showConfirmPassword,
        passwordState: const ForgotPasswordStateInitial()));
  }

  Future<void> forgotPassWord() async {
    emit(state.copyWith(passwordState: const ForgotPasswordStateLoading()));
    // final body = {"email": state.email};
    // print('email-body $body');
    final result = await _authRepository.forgotPassword(state);
    result.fold(
      (failure) {
        if (failure is InvalidAuthData) {
          final errors = ForgotPasswordFormValidateError(failure.errors);
          emit(state.copyWith(passwordState: errors));
        } else {
          final errors =
              ForgotPasswordStateError(failure.message, failure.statusCode);
          emit(state.copyWith(passwordState: errors));
        }
      },
      (data) {
        emit(state.copyWith(passwordState: ForgotPasswordStateLoaded(data)));
      },
    );
  }

  Future<void> setForgotPassword() async {
    emit(state.copyWith(passwordState: const SetPasswordStateLoading()));
    final result = await _authRepository.setResetPassword(state);
    result.fold(
      (failure) {
        if (failure is InvalidAuthData) {
          final errors = SetPasswordFormValidateError(failure.errors);
          emit(state.copyWith(passwordState: errors));
        } else {
          final errors =
          SetPasswordStateError(failure.message, failure.statusCode);
          emit(state.copyWith(passwordState: errors));
        }
      },
      (data) {
        emit(state.copyWith(passwordState: SetForgotPasswordLoaded(data)));
      },
    );
  }

  Future<void> changePassword() async {
    emit(state.copyWith(passwordState: const UpdatePasswordStateLoading()));
    final uri = Utils.tokenWithCode(
      RemoteUrls.updatePassword,
      _loginBloc.userInformation!.accessToken,
      _loginBloc.state.languageCode,
    );
    final result = await _authRepository.updatePassword(state, uri);
    result.fold(
          (failure) {
        if (failure is InvalidAuthData) {
          final errors = UpdatePasswordFormValidateError(failure.errors);
          emit(state.copyWith(passwordState: errors));
        } else {
          final errors =
          UpdatePasswordStateError(failure.message, failure.statusCode);
          emit(state.copyWith(passwordState: errors));
        }
      },
          (data) {
        emit(state.copyWith(passwordState: UpdatePasswordStateLoaded(data)));
      },
    );
  }


  Future<void> forgotOtpVerify() async {

    emit(state.copyWith(passwordState: const VerifyingForgotPasswordLoading()));
    final result = await _authRepository.forgotOtpVerify(state);
    result.fold(
          (failure) {
          final errors =
          VerifyingForgotPasswordError(failure.message,);
          emit(state.copyWith(passwordState: errors));
      },
          (data) {
        emit(state.copyWith(passwordState: VerifyingForgotPasswordLoaded(data)));
      },
    );
  }





  void verifyForgotPasswordCode() {
    emit(state.copyWith(passwordState: const VerifyingForgotPasswordLoading()));
    Future.delayed(
      const Duration(milliseconds: 1500),
      () {
        emit(state.copyWith(
            passwordState: const VerifyingForgotPasswordCodeLoaded()));
      },
    );
  }

  void clear() {
    emit(state.clear());
  }
}
