import 'package:carsbnb/data/model/home/home_model.dart';
import 'package:carsbnb/logic/cubit/wishlist/wishlist_state_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../data/data_provider/remote_url.dart';
import '../../../utils/utils.dart';
import '../../bloc/login/login_bloc.dart';
import '../../repository/wishlist_repository.dart';
import 'wishlist_state.dart';

class WishlistCubit extends Cubit<WishlistStateModel> {
  final WishlistRepository _wishlistRepository;
  final LoginBloc _loginBloc;

  WishlistCubit({
    required WishlistRepository wishlistRepository,
    required LoginBloc loginBloc,
  })  : _wishlistRepository = wishlistRepository,
        _loginBloc = loginBloc,
        super(WishlistStateModel());

  List<FeaturedCars>? wishlistModel;

  Future<void> getWishlist() async {
    // Get token from LoginBloc or SharedPreferences as fallback
    String? token = _loginBloc.userInformation?.accessToken;
    
    // If token is not available in LoginBloc, check SharedPreferences
    if (token == null || token.isEmpty) {
      final prefs = await SharedPreferences.getInstance();
      token = prefs.getString('accessToken');
    }
    
    if (token != null && token.isNotEmpty) {
      emit(state.copyWith(wishlistState: WishlistStateLoading()));

      final uri = Utils.tokenWithCode(RemoteUrls.wishLists,
          token,
          _loginBloc.state.languageCode);
      final result = await _wishlistRepository.getWishList(uri);
      result.fold((failure) {
        final errorState =
        WishlistStateError(failure.message, failure.statusCode);
        emit(state.copyWith(wishlistState: errorState));
      }, (success) {
        wishlistModel = success;
        final successState = WishlistStateLoaded(success);
        emit(state.copyWith(wishlistState: successState));
      });
    } else {
      const errors = WishlistStateError('Unauthenticated. Please login first.', 401);
      emit(state.copyWith(wishlistState: errors));
    }
  }

  Future<void> addToWishlist(String id) async {
    // Get token from LoginBloc or SharedPreferences as fallback
    String? token = _loginBloc.userInformation?.accessToken;
    if (token == null || token.isEmpty) {
      final prefs = await SharedPreferences.getInstance();
      token = prefs.getString('accessToken');
    }
    
    if (token == null || token.isEmpty) {
      emit(state.copyWith(wishlistState: WishlistStateError('Unauthenticated. Please login first.', 401)));
      return;
    }
    
    final uri = Utils.tokenWithCode(RemoteUrls.addWishLists(id),
        token, _loginBloc.state.languageCode);
    final result = await _wishlistRepository.addWishList(uri);
    result.fold((failure) {
      final errorState =
          WishlistStateError(failure.message, failure.statusCode);
      emit(state.copyWith(wishlistState: errorState));
    }, (success) async {
      final successState = WishListAddedLoaded(success);
      emit(state.copyWith(wishlistState: successState));
      
      // Refresh wishlist to get updated list
      await getWishlist();
    });
  }

  Future<void> removeWishlist(String id) async {
    // Get token from LoginBloc or SharedPreferences as fallback
    String? token = _loginBloc.userInformation?.accessToken;
    if (token == null || token.isEmpty) {
      final prefs = await SharedPreferences.getInstance();
      token = prefs.getString('accessToken');
    }
    
    if (token == null || token.isEmpty) {
      emit(state.copyWith(wishlistState: WishlistStateError('Unauthenticated. Please login first.', 401)));
      return;
    }
    
    final uri = Utils.tokenWithCode(RemoteUrls.removeWishLists(id),
        token, _loginBloc.state.languageCode);
    final result = await _wishlistRepository.removeWishList(uri);
    result.fold((failure) {
      final errorState =
          WishlistStateError(failure.message, failure.statusCode);
      emit(state.copyWith(wishlistState: errorState));
    }, (success) async {
      // Remove from local list immediately
      wishlistModel?.removeWhere((item) => item.id.toString() == id);
      final successState = WishListRemoveLoaded(success);
      emit(state.copyWith(wishlistState: successState));
      
      // Refresh wishlist to sync with server
      await getWishlist();
    });
  }


  void initPage() {
    emit(state.copyWith(initialPage: 1, isListEmpty: false));
  }
}
