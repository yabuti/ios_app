part of 'website_setup_cubit.dart';

abstract class WebsiteSetupState extends Equatable {
  const WebsiteSetupState();

  @override
  List<Object> get props => [];
}

class WebsiteSetupInitial extends WebsiteSetupState {}

class WebsiteSetupLoading extends WebsiteSetupState {}

class WebsiteSetupLoaded extends WebsiteSetupState {
  final WebsiteModel? websiteSetup;

  const WebsiteSetupLoaded(this.websiteSetup);

  @override
  List<Object> get props => [websiteSetup!];
}

class WebsiteSetupError extends WebsiteSetupState {
  final String message;
  final int statusCode;

  const WebsiteSetupError(this.message, this.statusCode);

  @override
  List<Object> get props => [message, statusCode];
}
