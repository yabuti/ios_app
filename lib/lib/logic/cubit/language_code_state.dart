import 'dart:convert';
import 'package:carsbnb/logic/cubit/car_details/car_details_state.dart';
import 'package:carsbnb/logic/cubit/compare/compare_list_state.dart';
import 'package:carsbnb/logic/cubit/contact_dealer/contact_dealer_state.dart';
import 'package:carsbnb/logic/cubit/contact_message/contact_message_state.dart';
import 'package:carsbnb/logic/cubit/dashboard/user_dashboard_state.dart';
import 'package:carsbnb/logic/cubit/review/review_state.dart';
import 'package:carsbnb/logic/cubit/termsPolicy/terms_state.dart';
import 'package:carsbnb/logic/cubit/user_cars_list/user_cars_state.dart';
import 'package:equatable/equatable.dart';
import 'dealer_details/dealer_details_state.dart';
import 'home/home_state.dart';
import 'manage_car/getCarCreatedata/car_create_data_state.dart';

// ignore_for_file: must_be_immutable
class LanguageCodeState extends Equatable {
  final String languageCode;
  int initialPage;
  bool isListEmpty;
  int currentIndex;
  final String token;
  final HomeState homeState;

  // final AllCarsState allCarsState;
  final CarDetailsState carDetailsState;
  final DealerDetailsState dealerDetailsState;
  final UserDashboardState userDashboardState;
  final UserCarsListState userCarsListState;
  final ReviewListState reviewListState;
  final TermsPolicyState termsPolicyState;
  final ContactDealerState contactDealerState;
  final ContactMessageState contactMessageState;
  final CompareListState compareListState;
  final CarCreateDataState carCreateDataState;

  LanguageCodeState({
    this.languageCode = 'en',
    this.initialPage = 1,
    this.currentIndex = 0,
    this.isListEmpty = false,
    this.token = '',
    this.homeState = const HomeInitial(),
    //  this.allCarsState = const AllCarsInitial(),
    this.carDetailsState = const CarDetailsInitial(),
    this.dealerDetailsState = const DealerDetailsInitial(),
    this.userDashboardState = const UserDashboardInitial(),
    this.userCarsListState = const UserCarsInitial(),
    this.reviewListState = const ReviewListInitial(),
    this.termsPolicyState = const TermsPolicyInitial(),
    this.contactDealerState = const ContactDealerInitial(),
    this.contactMessageState = const ContactMessageInitial(),
    this.compareListState = const CompareListInitial(),
    this.carCreateDataState = const CarCreateDataInitial(),
  });

  LanguageCodeState copyWith({
    String? languageCode,
    int? initialPage,
    int? currentIndex,
    bool? isListEmpty,
    String? token,
    HomeState? homeState,
    // AllCarsState? allCarsState,
    CarDetailsState? carDetailsState,
    DealerDetailsState? dealerDetailsState,
    UserDashboardState? userDashboardState,
    UserCarsListState? userCarsListState,
    ReviewListState? reviewListState,
    TermsPolicyState? termsPolicyState,
    ContactDealerState? contactDealerState,
    ContactMessageState? contactMessageState,
    CompareListState? compareListState,
    CarCreateDataState? carCreateDataState,
  }) {
    return LanguageCodeState(
      languageCode: languageCode ?? this.languageCode,
      initialPage: initialPage ?? this.initialPage,
      currentIndex: currentIndex ?? this.currentIndex,
      isListEmpty: isListEmpty ?? this.isListEmpty,
      token: token ?? this.token,
      homeState: homeState ?? this.homeState,
      // allCarsState: allCarsState ?? this.allCarsState,
      carDetailsState: carDetailsState ?? this.carDetailsState,
      dealerDetailsState: dealerDetailsState ?? this.dealerDetailsState,
      userDashboardState: userDashboardState ?? this.userDashboardState,
      userCarsListState: userCarsListState ?? this.userCarsListState,
      reviewListState: reviewListState ?? this.reviewListState,
      termsPolicyState: termsPolicyState ?? this.termsPolicyState,
      contactDealerState: contactDealerState ?? this.contactDealerState,
      contactMessageState: contactMessageState ?? this.contactMessageState,
      compareListState: compareListState ?? this.compareListState,
      carCreateDataState: carCreateDataState ?? this.carCreateDataState,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'lang_code': languageCode,
      'token': token,
    };
  }

  factory LanguageCodeState.fromMap(Map<String, dynamic> map) {
    return LanguageCodeState(
      languageCode: map['lang_code'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory LanguageCodeState.fromJson(String source) =>
      LanguageCodeState.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [
        languageCode,
        initialPage,
        isListEmpty,
        currentIndex,
        token,
        homeState,
        //  allCarsState,
        carDetailsState,
        dealerDetailsState,
        userDashboardState,
        userCarsListState,
        reviewListState,
        termsPolicyState,
        contactDealerState,
        contactMessageState,
        compareListState,
        carCreateDataState,
      ];
}
