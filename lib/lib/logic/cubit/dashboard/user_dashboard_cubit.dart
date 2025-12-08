import 'package:carsbnb/data/model/dashboard/dashboard_model.dart';
import 'package:carsbnb/logic/cubit/dashboard/user_dashboard_state.dart';
import 'package:carsbnb/logic/repository/user_dashboard_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/data_provider/remote_url.dart';
import '../../../utils/utils.dart';
import '../../bloc/login/login_bloc.dart';
import '../language_code_state.dart';

class UserDashboardCubit extends Cubit<LanguageCodeState> {
  final UserDashboardRepository _dashboardRepository;
  final LoginBloc _loginBloc;

  UserDashboardCubit({
    required UserDashboardRepository dashboardRepository,
    required LoginBloc loginBloc,
  })  : _dashboardRepository = dashboardRepository,
        _loginBloc = loginBloc,
        super(LanguageCodeState());

  DashboardModel? dashboardModel;

  Future<void> getUserDashboard() async {
    emit(state.copyWith(userDashboardState: UserDashboardStateLoading()));
    final uri = Utils.tokenWithCode(
      RemoteUrls.getUserDashboard,
      _loginBloc.userInformation!.accessToken,
      _loginBloc.state.languageCode,
    );

    final result = await _dashboardRepository.getUserDashboard(uri);
    result.fold((failure) {
      final errorState =
          UserDashboardStateError(failure.message, failure.statusCode);
      emit(state.copyWith(userDashboardState: errorState));
    }, (success) {
      dashboardModel = success;
      final successState = UserDashboardStateLoaded(success);

      emit(state.copyWith(userDashboardState: successState));
    });
  }
}
