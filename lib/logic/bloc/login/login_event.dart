part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object?> get props => [];
}

// Phone input event (replaces email)
class LoginEventUserPhone extends LoginEvent {
  final String phone;

  const LoginEventUserPhone(this.phone);

  @override
  List<Object> get props => [phone];
}

// Password input event
class LoginEventPassword extends LoginEvent {
  final String password;

  const LoginEventPassword(this.password);

  @override
  List<Object> get props => [password];
}

// Toggle Remember Me / Save credentials
class LoginEventSaveCredential extends LoginEvent {
  final bool isActive;

  const LoginEventSaveCredential({required this.isActive});

  @override
  List<Object> get props => [isActive];
}

// Show / hide password
class ShowPasswordEvent extends LoginEvent {
  final bool show;

  const ShowPasswordEvent(this.show);

  @override
  List<Object> get props => [show];
}

// Set language code
class LoginEventLanguageCode extends LoginEvent {
  final String languageCode;

  const LoginEventLanguageCode(this.languageCode);

  @override
  List<Object> get props => [languageCode];
}

// Set currency icon
class LoginEventCurrencyIcon extends LoginEvent {
  final String currencyIcon;

  const LoginEventCurrencyIcon(this.currencyIcon);

  @override
  List<Object> get props => [currencyIcon];
}

// Submit login
class LoginEventSubmit extends LoginEvent {
  const LoginEventSubmit();
}

// Logout
class LoginEventLogout extends LoginEvent {
  const LoginEventLogout();
}

// Save user credential event (alternative version)
class SaveUserCredentialEvent extends LoginEvent {
  final bool isActive;
  const SaveUserCredentialEvent(this.isActive);

  @override
  List<Object> get props => [isActive];
}

// Toggle Remember Me checkbox
class LoginEventRememberMe extends LoginEvent {
  const LoginEventRememberMe();
}
