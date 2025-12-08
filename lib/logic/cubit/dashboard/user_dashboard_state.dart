import 'package:carsbnb/data/model/dashboard/dashboard_model.dart';
import 'package:equatable/equatable.dart';

class UserDashboardState extends Equatable {
  const UserDashboardState();

  @override
  List<Object> get props => [];
}

class UserDashboardInitial extends UserDashboardState {
  const UserDashboardInitial();

  @override
  List<Object> get props => [];
}

class UserDashboardStateLoading extends UserDashboardState {}

class UserDashboardStateLoaded extends UserDashboardState {
  final DashboardModel dashboardModel;

  const UserDashboardStateLoaded(this.dashboardModel);

  @override
  List<Object> get props => [dashboardModel];
}

class UserDashboardStateError extends UserDashboardState {
  final String message;
  final int statusCode;

  const UserDashboardStateError(this.message, this.statusCode);

  @override
  List<Object> get props => [message, statusCode];
}
