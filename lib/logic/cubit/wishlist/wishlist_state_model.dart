// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
import 'dart:convert';

import 'package:carsbnb/logic/cubit/wishlist/wishlist_state.dart';
import 'package:equatable/equatable.dart';

class WishlistStateModel extends Equatable {
  final String id;
  final List<int> wishIds;
  int initialPage;
  bool isListEmpty;
  int currentIndex;
  final WishlistState wishlistState;

  WishlistStateModel({
    this.id = '',
    this.wishIds = const <int>[],
    this.initialPage = 1,
    this.currentIndex = 0,
    this.isListEmpty = false,
    this.wishlistState = const WishlistInitial(),
  });

  WishlistStateModel copyWith({
    String? id,
    WishlistState? wishlistState,
    List<int>? wishIds,
    int? initialPage,
    int? currentIndex,
    bool? isListEmpty,
  }) {
    return WishlistStateModel(
      id: id ?? this.id,
      wishlistState: wishlistState ?? this.wishlistState,
      initialPage: initialPage ?? this.initialPage,
      currentIndex: currentIndex ?? this.currentIndex,
      isListEmpty: isListEmpty ?? this.isListEmpty,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'event_id': id,
    };
  }

  factory WishlistStateModel.fromMap(Map<String, dynamic> map) {
    return WishlistStateModel(
      id: map['event_id'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory WishlistStateModel.fromJson(String source) =>
      WishlistStateModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [
        id,
        wishlistState,
        initialPage,
        isListEmpty,
        currentIndex,
      ];
}
