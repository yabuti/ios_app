import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/model/home/home_model.dart';
import '../../bloc/login/login_bloc.dart';
import '../../repository/home_repository.dart';
import '../language_code_state.dart';
import 'home_state.dart';


class HomeCubit extends Cubit<LanguageCodeState> {
  final HomeRepository _homeRepository;
  final LoginBloc _loginBloc;

  HomeCubit({
    required HomeRepository homeRepository,
    required LoginBloc loginBloc,
  })  : _homeRepository = homeRepository,
      _loginBloc = loginBloc,
        super( LanguageCodeState()) {
    getHomeData();
  }

  HomeModel? homeModel;

  Future<void> getHomeData() async {
    emit(state.copyWith(homeState: HomeStateLoading()));

    final result = await _homeRepository.getHomeData(_loginBloc.state.languageCode);
    result.fold((failure) {
      final errorState = HomeStateError(failure.message, failure.statusCode);
      emit(state.copyWith(homeState: errorState));
    }, (success) {
      homeModel = success;
    //  storeSliderData();
     // print("slider data: ${slidersData.length}");
      final successState = HomeStateLoaded(success);

      emit(state.copyWith(homeState: successState));
    });
  }

  // storeSliderData(){
  //   slidersData.clear();
  //   if(homeModel != null && homeModel!.slider != null){
  //     final s= homeModel!.slider;
  //     slidersData.add(TempSliderModel(image:s!.home1FeatureImage , header:s.home1Header , title:s.home1Title ));
  //     slidersData.add(TempSliderModel(image:s.home2FeatureImage , header:s.home2Header , title:s.home2Title ));
  //     slidersData.add(TempSliderModel(image:s.home3FeatureImage , header:s.home3Header , title:s.home3Title ));
  //   }
  // }


}
