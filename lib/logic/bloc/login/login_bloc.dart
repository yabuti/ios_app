import 'dart:async';
import 'dart:developer';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/data_provider/remote_url.dart';
import '../../../data/model/auth/login_state_model.dart';
import '../../../data/model/auth/user_response_model.dart';
import '../../../presentation/errors/failure.dart';
import '../../repository/auth_repository.dart';

part 'login_event.dart';

class LoginBloc extends Bloc<LoginEvent, LoginStateModel> {
  final AuthRepository _repository;
  UserResponseModel? _userResponse;

  bool get isLoggedIn =>
      _userResponse != null && _userResponse!.accessToken.isNotEmpty;

  UserResponseModel? get userInformation => _userResponse;

  LoginBloc({required AuthRepository repository})
      : _repository = repository,
        super(const LoginStateModel()) {
    _loadSavedUser();

    // Input events
    on<LoginEventUserPhone>((event, emit) {
      emit(state.copyWith(
          phone: event.phone, loginState: const LoginStateInitial()));
    });

    on<LoginEventPassword>((event, emit) {
      emit(state.copyWith(
          password: event.password, loginState: const LoginStateInitial()));
    });

    on<SaveUserCredentialEvent>(_saveCredential);

    on<ShowPasswordEvent>((event, emit) {
      emit(state.copyWith(
          show: !event.show, loginState: const LoginStateInitial()));
    });

    on<LoginEventLanguageCode>((event, emit) {
      emit(state.copyWith(languageCode: event.languageCode));
    });

    on<LoginEventCurrencyIcon>((event, emit) {
      emit(state.copyWith(currencyIcon: event.currencyIcon));
    });

    on<LoginEventRememberMe>((event, emit) {
      emit(state.copyWith(isActive: !state.isActive));
    });

    // Main login/logout events
    on<LoginEventSubmit>(_loginEvent);
    on<LoginEventLogout>(_logoutEvent);
  }

  /// Load saved user info from SharedPreferences
  /// Auto-login if token exists (persistent login)
  Future<void> _loadSavedUser() async {
    try {
      final pref = await SharedPreferences.getInstance();
      
      // MIGRATION: Check if old 'token' key exists and migrate to 'accessToken'
      final oldToken = pref.getString('token');
      if (oldToken != null && oldToken.isNotEmpty) {
        await pref.setString('accessToken', oldToken);
        await pref.remove('token');
        log('Migrated old token to accessToken', name: 'LoginBloc');
      }
      
      // Check if token exists (user is logged in)
      final token = pref.getString('accessToken');
      
      if (token == null || token.isEmpty) {
        log('No token found - user must login', name: 'LoginBloc');
        return;
      }
      
      // Load user data from SharedPreferences (all with safe defaults)
      final tokenType = pref.getString('tokenType') ?? 'Bearer';
      final expiresIn = pref.getInt('expiresIn') ?? 3600;
      final userType = pref.getString('userType') ?? 'user';
      final savedPhone = pref.getString('phone') ?? '';
      final userId = pref.getInt('userId') ?? 0;
      final userName = pref.getString('userName') ?? '';
      final userEmail = pref.getString('email') ?? '';
      final username = pref.getString('username') ?? '';

      final user = User(
        id: userId,
        name: userName,
        phone: savedPhone,
        email: userEmail,
        username: username,
      );

      _userResponse = UserResponseModel(
        accessToken: token,
        tokenType: tokenType,
        expiresIn: expiresIn,
        user: user,
        userType: userType,
      );

      emit(state.copyWith(
          loginState: LoginStateLoaded(userResponseModel: _userResponse)));
      log('Auto-logged in - token found', name: 'LoginBloc');
    } catch (e, stackTrace) {
      log('Error loading saved user: $e', name: 'LoginBloc', error: e, stackTrace: stackTrace);
      // If there's an error, just don't auto-login (user will need to login manually)
    }
  }

  /// Save user credentials
  Future<void> _saveCredential(
      SaveUserCredentialEvent event, Emitter<LoginStateModel> emit) async {
    try {
      final pref = await SharedPreferences.getInstance();
      if (event.isActive &&
          _userResponse != null &&
          _userResponse!.accessToken.isNotEmpty) {
        await pref.setString('accessToken', _userResponse!.accessToken);
        await pref.setString('tokenType', _userResponse!.tokenType);
        await pref.setInt('expiresIn', _userResponse!.expiresIn);
        await pref.setString('userType', _userResponse!.userType);
        await pref.setInt('userId', _userResponse!.user.id);
        await pref.setString('userName', _userResponse!.user.name);
        await pref.setString('phone', state.phone);
        await pref.setString('password', state.password);
        await pref.setString('email', _userResponse!.user.email);
        await pref.setString('username', _userResponse!.user.username);
      } else {
        await _clearCredentials();
      }
    } catch (e) {
      debugPrint('Error saving credentials: ${e.toString()}');
    }
  }

  /// Login event
  Future<void> _loginEvent(
      LoginEventSubmit event, Emitter<LoginStateModel> emit) async {
    emit(state.copyWith(loginState: LoginStateLoading()));

    final result = await _repository.login(state); // API call
    
    // Handle failure
    if (result.isLeft()) {
      final failure = result.fold((l) => l, (r) => null);
      if (failure != null) {
        if (failure is InvalidAuthData) {
          emit(state.copyWith(
              loginState: LoginStateFormValidate(failure.errors)));
        } else {
          emit(state.copyWith(
              loginState: LoginStateError(
                  message: failure.message, statusCode: failure.statusCode)));
        }
      }
      return;
    }
    
    // Handle success
    final success = result.fold((l) => null, (r) => r);
    if (success != null) {
      _userResponse = success;
      
      // Emit success state
      // Note: Credentials are already saved by the repository's localDataSources.cacheUserResponse()
      emit(state.copyWith(
          loginState: LoginStateLoaded(userResponseModel: success)));
    }
  }

  /// Clear stored credentials
  Future<void> _clearCredentials() async {
    final pref = await SharedPreferences.getInstance();
    await pref.remove('accessToken');
    await pref.remove('tokenType');
    await pref.remove('expiresIn');
    await pref.remove('userType');
    await pref.remove('userId');
    await pref.remove('userName');
    await pref.remove('phone');
    await pref.remove('password');
    await pref.remove('email');
    await pref.remove('username');
  }

  /// Logout
  Future<void> _logoutEvent(
      LoginEventLogout event, Emitter<LoginStateModel> emit) async {
    emit(state.copyWith(loginState: LoginStateLogoutLoading()));

    final url = Uri.parse(RemoteUrls.logout).replace(queryParameters: {
      'token': _userResponse?.accessToken ?? '',
      'lang_code': state.languageCode,
    });

    final result = await _repository.logout(url);

    // Clear ALL credentials including Remember Me data
    await _clearCredentials();
    _userResponse = null;
    
    // Reset state to initial (clear phone, password, remember me checkbox)
    emit(const LoginStateModel());
    
    log('User logged out - all credentials cleared', name: 'LoginBloc');

    result.fold(
      (failure) {
        emit(state.copyWith(
            loginState: const LoginStateLogoutLoaded('Logout success', 200)));
      },
      (message) {
        emit(state.copyWith(loginState: LoginStateLogoutLoaded(message, 200)));
      },
    );
  }
}
