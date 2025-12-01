import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/data_provider/remote_url.dart';
import '../../../data/model/auth/user_response_model.dart';
import '../../../presentation/errors/failure.dart';
import '../../../utils/utils.dart';
import '../../bloc/login/login_bloc.dart';
import '../../repository/user_dashboard_repository.dart';
import 'profile_state.dart';

class ProfileCubit extends Cubit<User> {
  final UserDashboardRepository _repository;
  final LoginBloc _loginBloc;

  ProfileCubit({
    required UserDashboardRepository repository,
    required LoginBloc loginBloc,
  })  : _repository = repository,
        _loginBloc = loginBloc,
        super(User.init());

  // field update
  void nameChange(String text) => emit(state.copyWith(name: text));
  void emailChange(String text) => emit(state.copyWith(email: text));
  void phoneChange(String text) => emit(state.copyWith(phone: text));
  void designationChange(String text) =>
      emit(state.copyWith(designation: text));
  void addressChange(String text) => emit(state.copyWith(address: text));
  void imageChange(String text) => emit(state.copyWith(tempImage: text));
  void bannerImageChange(String text) =>
      emit(state.copyWith(bannerTempImage: text));

  // ==========================
  // GET PROFILE DATA
  // ==========================
  Future<void> getProfileInfo() async {
    emit(state.copyWith(profileState: GetProfileDataStateLoading()));

    try {
      final uri = Utils.tokenWithCode(
        RemoteUrls.getProfileData,
        _loginBloc.userInformation!.accessToken,
        _loginBloc.state.languageCode,
      );

      final result = await _repository.getProfileData(uri);

      result.fold((failure) {
        emit(state.copyWith(
          profileState: GetProfileDataStateError(
            failure.message,
            failure.statusCode,
          ),
        ));
      }, (user) {
        emit(user.copyWith(
          profileState: GetProfileDataStateLoaded(user),
        ));
      });
    } catch (e) {
      emit(state.copyWith(
        profileState: GetProfileDataStateError(
          "Something went wrong: $e",
          500,
        ),
      ));
    }
  }

  // ==========================
  // UPDATE PROFILE
  // ==========================
  Future<void> updateUserInfo() async {
    emit(state.copyWith(profileState: UpdateProfileStateLoading()));

    final uri = Utils.tokenWithQuery(
      RemoteUrls.updateProfile,
      _loginBloc.userInformation!.accessToken,
      _loginBloc.state.languageCode,
      extraParams: {'_method': 'PUT'},
    );

    try {
      final result = await _repository.updateProfileInfo(state, uri);

      result.fold((failure) {
        if (failure is InvalidAuthData) {
          emit(state.copyWith(
            profileState: UpdateProfileStateFormValidate(failure.errors),
          ));
        } else {
          emit(state.copyWith(
            profileState:
                UpdateProfileStateError(failure.message, failure.statusCode),
          ));
        }
      }, (user) {
        emit(user.copyWith(
          profileState: const UpdateProfileStateLoaded(
            "Profile updated successfully",
          ),
        ));
      });
    } catch (e) {
      emit(state.copyWith(
        profileState: UpdateProfileStateError("Something went wrong: $e", 500),
      ));
    }
  }
}
