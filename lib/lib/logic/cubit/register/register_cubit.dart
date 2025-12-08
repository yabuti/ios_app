import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/model/auth/register_state_model.dart';
import '../../../data/model/auth/login_state_model.dart';
import '../../../logic/cubit/register/register_state.dart';
import '../../../logic/repository/auth_repository.dart';
import '../../../presentation/errors/failure.dart';
import '../../bloc/login/login_bloc.dart';

class RegisterCubit extends Cubit<RegisterStateModel> {
  final AuthRepository _repository;
  final LoginBloc? _loginBloc;

  RegisterCubit({
    required AuthRepository authRepository,
    LoginBloc? loginBloc,
  })  : _repository = authRepository,
        _loginBloc = loginBloc,
        super(RegisterStateModel.init());

  // --- Field changes ---
  void changeName(String text) =>
      emit(state.copyWith(name: text, registerState: const RegisterInitial()));

  void changeEmail(String text) =>
      emit(state.copyWith(email: text, registerState: const RegisterInitial()));

  void changePassword(String text) => emit(
      state.copyWith(password: text, registerState: const RegisterInitial()));

  void changePhone(String text) =>
      emit(state.copyWith(phone: text, registerState: const RegisterInitial()));

  void changeConPassword(String text) => emit(state.copyWith(
      confirmPassword: text, registerState: const RegisterInitial()));

  void showPassword() => emit(state.copyWith(
      showPassword: !state.showPassword,
      registerState: const RegisterInitial()));

  void showConfirmPassword() => emit(state.copyWith(
      showConPassword: !state.showConPassword,
      registerState: const RegisterInitial()));

  void otpChange(String text) => emit(state.copyWith(otp: text));

  // --- User Registration ---
  Future<void> userRegister() async {
    debugPrint('🚀 Starting registration...');
    // Emit loading first
    emit(state.copyWith(registerState: RegisterStateLoading()));

    final signUpResult = await _repository.signUp(state);
    
    debugPrint('🚀 Registration result received');

    signUpResult.fold(
      // --- Registration failed ---
      (failure) {
        debugPrint('❌ Registration FAILED: ${failure.message}');
        if (failure is InvalidAuthData) {
          emit(state.copyWith(
              registerState: RegisterValidateStateError(failure.errors)));
        } else {
          emit(state.copyWith(
              registerState: RegisterStateError(
                  failure.message, failure.statusCode)));
        }
      },
      // --- Registration success ---
      (successMessage) async {
        // Registration successful!
        debugPrint('✅ Registration SUCCESS: $successMessage');
        debugPrint('✅ About to emit RegisterStateSuccess...');
        
        // IMMEDIATELY emit success and navigate - don't wait for auto-login
        emit(state.copyWith(
            registerState: RegisterStateSuccess(
                "Account created successfully! Welcome!")));
        
        debugPrint('✅ RegisterStateSuccess EMITTED!');
        
        // Then try auto-login in background (optional)
        debugPrint('Attempting auto-login with phone: ${state.phone}');
        await Future.delayed(const Duration(milliseconds: 500));

        try {
          final loginResult = await _repository.login(
            LoginStateModel(phone: state.phone, password: state.password),
          );

          loginResult.fold(
            // --- Auto-login failed ---
            (loginFailure) {
              debugPrint('Auto-login failed: ${loginFailure.message}');
              // Already navigated, just log the failure
            },
            // --- Auto-login success ---
            (user) async {
              debugPrint('Auto-login successful for user: ${user.user.name}');
              
              // Cache user data
              if (_repository is AuthRepositoryImpl) {
                await _repository
                    .localDataSources
                    .cacheUserResponse(user);
              }

              // Update LoginBloc if available to reflect logged in state
              if (_loginBloc != null) {
                // Trigger login event to update LoginBloc state
                _loginBloc.add(LoginEventUserPhone(state.phone));
                _loginBloc.add(LoginEventPassword(state.password));
                // Submit login to update LoginBloc with user data
                _loginBloc.add(const LoginEventSubmit());
              }
            },
          );
        } catch (e) {
          debugPrint('Auto-login error: $e');
          // Already navigated, just log the error
        }
      },
    );
  }

  // --- OTP Verification ---
  Future<void> verifyRegOtp() async {
    emit(state.copyWith(registerState: RegisterOtpStateLoading()));

    final result = await _repository.verifyRegOtp(state);

    result.fold(
      (failure) {
        emit(state.copyWith(
            registerState:
                RegisterOtpStateError(failure.message, failure.statusCode)));
      },
      (success) {
        emit(state.copyWith(registerState: RegisterOtpStateSuccess(success)));
      },
    );
  }

  // --- Clear all fields ---
  Future<void> clearAllField() async {
    emit(RegisterStateModel.init());
  }
}
