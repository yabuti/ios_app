import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'forgot_password_cubit.dart';

class PasswordStateModel extends Equatable {
  final String email;
  final String code;
  final String password;
  final String confirmPassword;
  final String oldPassword;
  final String newPassword;
  final bool showPassword;
  final bool showOldPassword;
  final bool showConfirmPassword;
  final String languageCode;
  final ForgotPasswordState passwordState;

  const PasswordStateModel({
    this.email = '',
    this.code = '',
    this.oldPassword = '',
    this.newPassword = '',
    this.password = '',
    this.confirmPassword = '',
    this.showPassword = true,
    this.showOldPassword = true,
    this.showConfirmPassword = true,
    this.languageCode = 'en',

    this.passwordState = const ForgotPasswordStateInitial(),
  });

  PasswordStateModel copyWith({
    String? email,
    String? code,
    String? oldPassword,
    String? newPassword,
    String? password,
    String? confirmPassword,
    bool? showPassword,
    bool? showOldPassword,
    bool? showConfirmPassword,
    String? languageCode,

    ForgotPasswordState? passwordState,
  }) {
    return PasswordStateModel(
      email: email ?? this.email,
      code: code ?? this.code,
      oldPassword: oldPassword ?? this.oldPassword,
      newPassword: newPassword ?? this.newPassword,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      showPassword: showPassword ?? this.showPassword,
      showOldPassword: showOldPassword ?? this.showOldPassword,
      showConfirmPassword: showConfirmPassword ?? this.showConfirmPassword,
      languageCode: languageCode ?? this.languageCode,
      passwordState: passwordState ?? this.passwordState,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'otp': code,
      'current_password': oldPassword,
      'new_password': newPassword,
      'password': password,
      'password_confirmation': confirmPassword,
      // 'showPassword': showPassword,
      // 'showConfirmPassword': showConfirmPassword,
    };
  }

  static PasswordStateModel init() {
    return const PasswordStateModel(
      email: '',
      code: '',
      oldPassword: '',
      newPassword: '',
      password: '',
      confirmPassword: '',
      showPassword: true,
      showOldPassword: true,
      showConfirmPassword: true,
      passwordState: ForgotPasswordStateInitial(),
    );
  }

  PasswordStateModel clear() {
    return const PasswordStateModel(
      email: '',
      code: '',
      oldPassword: '',
      newPassword: '',
      password: '',
      confirmPassword: '',
      showPassword: true,
      showOldPassword: true,
      showConfirmPassword: true,
      passwordState: ForgotPasswordStateInitial(),
    );
  }

  factory PasswordStateModel.fromMap(Map<String, dynamic> map) {
    return PasswordStateModel(
      email: map['email'] ?? '',
      code: map['otp'] ?? '',
      oldPassword: map['current_password'] ?? '',
      newPassword: map['new_password'] ?? '',
      password: map['password'] ?? '',
      confirmPassword: map['password_confirmation'] ?? '',
      showPassword: map['showPassword'] ?? false,
      showConfirmPassword: map['showConfirmPassword'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory PasswordStateModel.fromJson(String source) =>
      PasswordStateModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PasswordStateModel(email: $email, code: $code, password: $password,  confirm_password: $confirmPassword,new_password: $newPassword,old_password: $oldPassword, showPassword: $showPassword, showConfirmPassword: $showConfirmPassword, passwordState: $passwordState)';
  }

  @override
  List<Object> get props {
    return [
      email,
      code,
      oldPassword,
      newPassword,
      showPassword,
      showConfirmPassword,
      showOldPassword,
      passwordState,
      password,
      languageCode,
      confirmPassword
    ];
  }
}
