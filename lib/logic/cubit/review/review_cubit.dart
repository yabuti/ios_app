import 'package:carsbnb/data/model/review/review_list_model.dart';
import 'package:carsbnb/logic/cubit/language_code_state.dart';
import 'package:carsbnb/logic/cubit/review/review_state.dart';
import 'package:carsbnb/logic/repository/review_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/data_provider/remote_url.dart';
import '../../../presentation/errors/failure.dart';
import '../../../utils/utils.dart';
import '../../bloc/login/login_bloc.dart';

class ReviewCubit extends Cubit<LanguageCodeState> {
  final ReviewRepository _repository;
  final LoginBloc _loginBloc;

  ReviewCubit({
    required ReviewRepository repository,
    required LoginBloc loginBloc,
  })
      : _repository = repository,
        _loginBloc = loginBloc,
        super(LanguageCodeState());

  List<ReviewListModel>? reviewList = [];


  Future<void> getReviewList() async {
    emit(state.copyWith(reviewListState: GetReviewListStateLoading()));
    final uri = Utils.tokenWithCode(
      RemoteUrls.getAllReview,
      _loginBloc.userInformation!.accessToken,
      _loginBloc.state.languageCode,
    );
    final result = await _repository.getAllReview(uri);
    result.fold((failure) {
      final errorState =
      GetReviewListStateError(failure.message, failure.statusCode);
      emit(state.copyWith(reviewListState: errorState));
    }, (success) {
      reviewList = success;
      final successState = GetReviewListStateLoaded(success);
      emit(state.copyWith(reviewListState: successState));
    });
  }



  Future<void> storeReview( Map<String, dynamic> body) async {
    print("contactMessage: $body");
    emit(state.copyWith(reviewListState: const StoreReviewStateLoading()));
    final uri = Utils.tokenWithCode(
      RemoteUrls.storeReview,
      _loginBloc.userInformation!.accessToken,
      _loginBloc.state.languageCode,
    );
    final result = await _repository.storeReview(
        uri,  body);
    result.fold((failure) {
      if (failure is InvalidAuthData) {
        final errorState = StoreReviewValidateStateError(failure.errors);
        emit(state.copyWith(reviewListState: errorState));
      } else {
        final errorState =
        StoreReviewStateError(failure.message, failure.statusCode);
        emit(state.copyWith(reviewListState: errorState));
      }
    }, (success) {
      final successState = StoreReviewStateSuccess(success);
      emit(state.copyWith(reviewListState: successState));
    });
  }

}