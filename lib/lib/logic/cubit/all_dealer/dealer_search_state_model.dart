// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable

import 'package:carsbnb/logic/cubit/all_dealer/all_dealer_state.dart';
import 'package:equatable/equatable.dart';

class DealerSearchStateModel extends Equatable {
  final String search;
  final String location;
  final String languageCode;
  int initialPage;
  bool isListEmpty;
  int currentIndex;
  final AllDealerState allDealerState;
  DealerSearchStateModel({
    required this.search,
    required this.location,
    this.languageCode = 'en',
    this.initialPage = 1,
    this.currentIndex = 0,
    this.isListEmpty = false,
    this.allDealerState = const AllDealerInitial(),
  });

  DealerSearchStateModel copyWith({
    String? search,
    String? location,
    String? languageCode,
    int? initialPage,
    int? currentIndex,
    bool? isListEmpty,
    AllDealerState? allDealerState,
  }) {
    return DealerSearchStateModel(
      search: search ?? this.search,
      location: location ?? this.location,
      languageCode: languageCode ?? this.languageCode,
      initialPage: initialPage ?? this.initialPage,
      currentIndex: currentIndex ?? this.currentIndex,
      isListEmpty: isListEmpty ?? this.isListEmpty,
      allDealerState: allDealerState ?? this.allDealerState,
    );
  }

  factory DealerSearchStateModel.init() {
    return DealerSearchStateModel(
        search: '',
        location: '',
        initialPage: 1,
        isListEmpty: false,
        allDealerState: const AllDealerInitial()
    );
  }

  factory DealerSearchStateModel.reset() {
    return DealerSearchStateModel(
        search: '',
        location: '',
        initialPage: 1,
        isListEmpty: false,
        allDealerState: const AllDealerInitial()
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      search,
      location,
      languageCode,
      initialPage,
      isListEmpty,
      currentIndex,
      allDealerState,
    ];
  }
}
