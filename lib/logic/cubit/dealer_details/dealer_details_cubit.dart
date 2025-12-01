import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/model/home/dealer_details_model.dart';
import '../../bloc/login/login_bloc.dart';
import '../../repository/home_repository.dart';
import '../language_code_state.dart';
import 'dealer_details_state.dart';

class DealerDetailsCubit extends Cubit<LanguageCodeState> {
  final HomeRepository _homeRepository;
  final LoginBloc _loginBloc;
  DealerDetailsCubit({
    required HomeRepository homeRepository,
    required LoginBloc loginBloc,
  })  : _homeRepository = homeRepository,
        _loginBloc = loginBloc,
        super(LanguageCodeState());

  DealerDetailsModel? dealerDetailsModel;

  Future<void> getDealerDetails(String userName) async {
    emit(state.copyWith(dealerDetailsState: DealerDetailsStateLoading()));
    final result = await _homeRepository.dealerDetails(_loginBloc.state.languageCode, userName);
    result.fold((failure) {
      final errorState =
          DealerDetailsStateError(failure.message, failure.statusCode);
      emit(state.copyWith(dealerDetailsState: errorState));
    }, (success) {
      dealerDetailsModel = success;
      final successState = DealerDetailsStateLoaded(success);

      emit(state.copyWith(dealerDetailsState: successState));
    });
  }
}
