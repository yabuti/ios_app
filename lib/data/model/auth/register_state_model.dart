import 'dart:convert';
import 'package:equatable/equatable.dart';
import '../../../logic/cubit/register/register_state.dart';

class RegisterStateModel extends Equatable {
  final String email;
  final String name;
  final String phone;
  final String password;
  final String confirmPassword;
  final String otp;
  final String languageCode;
  final bool showPassword;
  final bool showConPassword;
  final RegisterState registerState;

  const RegisterStateModel({
    required this.email,
    required this.name,
    required this.phone,
    required this.password,
    required this.confirmPassword,
    required this.otp,
    this.languageCode = 'en',
    this.showPassword = true,
    this.showConPassword = true,
    this.registerState = const RegisterInitial(),
  });

  RegisterStateModel copyWith({
    String? email,
    String? name,
    String? phone,
    String? password,
    String? confirmPassword,
    String? otp,
    String? languageCode,
    bool? showPassword,
    bool? showConPassword,
    RegisterState? registerState,
  }) {
    return RegisterStateModel(
      email: email ?? this.email,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      otp: otp ?? this.otp,
      languageCode: languageCode ?? this.languageCode,
      showPassword: showPassword ?? this.showPassword,
      showConPassword: showConPassword ?? this.showConPassword,
      registerState: registerState ?? this.registerState,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email.isEmpty ? '$phone@blackdiamondcar.com' : email, // Auto-generate email from phone if empty
      'name': name,
      'phone': phone,
      'password': password,
      'password_confirmation': confirmPassword,
      'otp': otp,
    };
  }

  factory RegisterStateModel.fromMap(Map<String, dynamic> map) {
    return RegisterStateModel(
      email: map['email'] ?? '',
      name: map['name'] ?? '',
      phone: map['phone'] ?? '',
      password: map['password'] ?? '',
      confirmPassword: map['password_confirmation'] ?? '',
      otp: map['otp'] ?? '',
    );
  }

  RegisterStateModel clear() {
    return const RegisterStateModel(
      email: '',
      name: '',
      phone: '',
      password: '',
      confirmPassword: '',
      otp: '',
      showPassword: true,
      showConPassword: true,
      registerState: RegisterInitial(),
    );
  }

  static RegisterStateModel init() => const RegisterStateModel(
        email: '',
        name: '',
        phone: '',
        password: '',
        confirmPassword: '',
        otp: '',
        showPassword: true,
        showConPassword: true,
        registerState: RegisterInitial(),
      );

  String toJson() => json.encode(toMap());

  factory RegisterStateModel.fromJson(String source) =>
      RegisterStateModel.fromMap(json.decode(source));

  @override
  List<Object> get props => [
        email,
        name,
        phone,
        password,
        confirmPassword,
        otp,
        languageCode,
        showPassword,
        showConPassword,
        registerState,
      ];
}
