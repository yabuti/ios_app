import 'dart:convert';
import 'package:equatable/equatable.dart';

// Forward declaration - LoginState classes will be imported where needed
abstract class LoginState extends Equatable {
  const LoginState();
}

class LoginStateInitial extends LoginState {
  const LoginStateInitial();
  @override
  List<Object?> get props => [];
}

class LoginStateLoading extends LoginState {
  const LoginStateLoading();
  @override
  List<Object?> get props => [];
}

class LoginStateLogoutLoading extends LoginState {
  const LoginStateLogoutLoading();
  @override
  List<Object?> get props => [];
}

class LoginStateLogoutLoaded extends LoginState {
  final String message;
  final int statusCode;
  const LoginStateLogoutLoaded(this.message, this.statusCode);
  @override
  List<Object?> get props => [message, statusCode];
}

class LoginStateLogoutError extends LoginState {
  final String message;
  final int statusCode;
  const LoginStateLogoutError(this.message, this.statusCode);
  @override
  List<Object?> get props => [message, statusCode];
}

class LoginStateLoaded extends LoginState {
  final dynamic userResponseModel;
  const LoginStateLoaded({required this.userResponseModel});
  @override
  List<Object?> get props => [userResponseModel];
}

class LoginStateError extends LoginState {
  final String message;
  final int statusCode;
  const LoginStateError({required this.message, required this.statusCode});
  @override
  List<Object?> get props => [message, statusCode];
}

class LoginStateFormValidate extends LoginState {
  final dynamic errors;
  const LoginStateFormValidate(this.errors);
  @override
  List<Object?> get props => [errors];
}

class LoginStateModel extends Equatable {
  final String phone;
  final String password;
  final bool isActive;
  final bool show;
  final String languageCode;
  final String currencyCode;
  final String currencyIcon;
  final LoginState loginState;

  const LoginStateModel({
    this.phone = '',
    this.password = '',
    this.languageCode = 'en',
    this.currencyCode = '',
    this.currencyIcon = '',
    this.isActive = false,
    this.show = true,
    this.loginState = const LoginStateInitial(),
  });

  LoginStateModel copyWith({
    String? phone,
    String? password,
    String? languageCode,
    String? currencyCode,
    String? currencyIcon,
    bool? isActive,
    bool? show,
    LoginState? loginState,
  }) {
    return LoginStateModel(
      phone: phone ?? this.phone,
      password: password ?? this.password,
      languageCode: languageCode ?? this.languageCode,
      currencyCode: currencyCode ?? this.currencyCode,
      currencyIcon: currencyIcon ?? this.currencyIcon,
      isActive: isActive ?? this.isActive,
      show: show ?? this.show,
      loginState: loginState ?? this.loginState,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'phone': phone.trim(),
      'password': password,
    };
  }

  factory LoginStateModel.fromMap(Map<String, dynamic> map) {
    return LoginStateModel(
      phone: map['phone'] ?? '',
      password: map['password'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory LoginStateModel.fromJson(String source) =>
      LoginStateModel.fromMap(json.decode(source));

  @override
  List<Object> get props => [
        phone,
        password,
        languageCode,
        currencyCode,
        currencyIcon,
        isActive,
        show,
        loginState,
      ];
}
