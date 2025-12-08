import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/data_provider/remote_url.dart';
import '../../../../data/model/website_model/website_model.dart';
import '../../../repository/website_setup_repository.dart';


part 'website_setup_state.dart';

class WebsiteSetupCubit extends Cubit<WebsiteSetupState> {
  final WebsiteSetupRepository _repository;

  // final LoginBloc _loginBloc;

  // WebsiteSetupCubit({required WebsiteSetupRepository repository,required LoginBloc loginBloc})
  //     : _repository = repository,  _loginBloc = loginBloc,
  //       super(WebsiteSetupLoading()) {
  //   //initWebsite();
  //   // getWebsiteSetupData();
  // }
  WebsiteSetupCubit({required WebsiteSetupRepository repository})
      : _repository = repository,
        super(WebsiteSetupInitial());

  //initWebsite();
  // getWebsiteSetupData('en');

  WebsiteModel? setting;

  bool get showOnBoarding =>
      _repository.checkOnBoarding().fold((l) => false, (r) => true);

  Future<void> cacheOnBoarding() async {
    final result = await _repository.cachedOnBoarding();
    result.fold((l) => false, (r) => r);
  }

  // void initWebsite() async {
  //   emit(WebsiteSetupLoading());
  //
  //   final result = _repository.getCatchWebsiteSetupData();
  //   result.fold(
  //       (l) => emit(
  //             WebsiteSetupError(l.message, l.statusCode),
  //           ), (success) {
  //     setting = success;
  //     emit(WebsiteSetupLoaded(success));
  //   });
  // }

  Future<void> getWebsiteSetupData(String langCode) async {
    emit(WebsiteSetupLoading());
    final uri = Uri.parse(RemoteUrls.websiteSetup)
         .replace(queryParameters: {'lang_code': langCode});

    final result = await _repository.getWebsiteSetupData(uri);
    result.fold((l) {
      emit(WebsiteSetupError(l.message, l.statusCode));
    }, (success) {
      setting = success;
      emit(WebsiteSetupLoaded(success));
    });
  }
}
