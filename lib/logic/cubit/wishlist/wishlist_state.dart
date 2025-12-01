import 'package:blackdiamondcar/data/model/home/home_model.dart';
import 'package:equatable/equatable.dart';

class WishlistState extends Equatable {
  const WishlistState();

  @override
  List<Object> get props => [];
}

class WishlistInitial extends WishlistState {
  const WishlistInitial();

  @override
  List<Object> get props => [];
}

class WishlistStateLoading extends WishlistState {}

class WishlistStateLoaded extends WishlistState {
  final List<FeaturedCars> wishlistModel;

  const WishlistStateLoaded(this.wishlistModel);

  @override
  List<Object> get props => [wishlistModel];
}

class WishlistStateError extends WishlistState {
  final String message;
  final int statusCode;

  const WishlistStateError(this.message, this.statusCode);

  @override
  List<Object> get props => [message, statusCode];
}




class WishListAddedLoaded extends WishlistState {
  final String message;

  const WishListAddedLoaded(this.message);

  @override
  List<Object> get props => [message];
}

class WishListRemoveLoaded extends WishlistState {
  final String message;

  // final WishListModel wishlistModel;

  const WishListRemoveLoaded(this.message);

  @override
  List<Object> get props => [message];
}

class WishListDeleteSuccess extends WishlistState {
  const WishListDeleteSuccess(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}

class WishListStateSuccess extends WishlistState {
  final String message;

  const WishListStateSuccess(this.message);

  @override
  List<Object> get props => [message];
}