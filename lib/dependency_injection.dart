import 'package:carsbnb/logic/bloc/login/login_bloc.dart';
import 'package:carsbnb/logic/cubit/all_cars/all_cars_cubit.dart';
import 'package:carsbnb/logic/cubit/all_dealer/all_dealer_cubit.dart';
import 'package:carsbnb/logic/cubit/compare/compare_list_cubit.dart';
import 'package:carsbnb/logic/cubit/contact_dealer/contact_dealer_cubit.dart';
import 'package:carsbnb/logic/cubit/contact_message/contact_message_cubit.dart';
import 'package:carsbnb/logic/cubit/currency/currency_cubit.dart';

import 'package:carsbnb/logic/cubit/dashboard/user_dashboard_cubit.dart';
import 'package:carsbnb/logic/cubit/dealer_details/dealer_details_cubit.dart';
import 'package:carsbnb/logic/cubit/forgot_password/forgot_password_cubit.dart';
import 'package:carsbnb/logic/cubit/home/home_cubit.dart';
import 'package:carsbnb/logic/cubit/kyc/kyc_info_cubit.dart';
import 'package:carsbnb/logic/cubit/manage_car/delete_car/delete_car_cubit.dart';
import 'package:carsbnb/logic/cubit/manage_car/getCarCreatedata/car_create_data_cubit.dart';
import 'package:carsbnb/logic/cubit/manage_car/manage_car_cubit.dart';
import 'package:carsbnb/logic/cubit/profile/profile_cubit.dart';
import 'package:carsbnb/logic/cubit/register/register_cubit.dart';
import 'package:carsbnb/logic/cubit/review/review_cubit.dart';
import 'package:carsbnb/logic/cubit/termsPolicy/terms_cubit.dart';
import 'package:carsbnb/logic/cubit/user_cars_list/user_cars_cubit.dart';
import 'package:carsbnb/logic/cubit/website_setup/website_setup/website_setup_cubit.dart';
import 'package:carsbnb/logic/cubit/wishlist/wishlist_cubit.dart';
import 'package:carsbnb/logic/repository/auth_repository.dart';
import 'package:carsbnb/logic/repository/compare_reposotory.dart';
import 'package:carsbnb/logic/repository/home_repository.dart';
import 'package:carsbnb/logic/repository/kyc_repository.dart';
import 'package:carsbnb/logic/repository/review_repository.dart';
import 'package:carsbnb/logic/repository/user_carList_repository.dart';
import 'package:carsbnb/logic/repository/user_dashboard_repository.dart';
import 'package:carsbnb/logic/repository/website_setup_repository.dart';
import 'package:carsbnb/logic/repository/wishlist_repository.dart';
import 'package:carsbnb/logic/repository/withdraw_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data/data_provider/local_data_source.dart';
import 'data/data_provider/remote_data_source.dart';
import 'logic/bloc/internet_status/internet_status_bloc.dart';
import 'logic/cubit/car_details/car_details_cubit.dart';

class DInjector {
  static late final SharedPreferences _sharedPreferences;

  static Future<void> initDB() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  static final repositoryProvider = <RepositoryProvider>[
    RepositoryProvider<Client>(
      create: (context) => Client(),
    ),
    RepositoryProvider<SharedPreferences>(
      create: (context) => _sharedPreferences,
    ),
    RepositoryProvider<RemoteDataSources>(
      create: (context) => RemoteDataSourcesImpl(
        client: context.read(),
      ),
    ),
    RepositoryProvider<LocalDataSources>(
      create: (context) => LocalDataSourcesImpl(
        sharedPreferences: context.read(),
      ),
    ),
    RepositoryProvider<WebsiteSetupRepository>(
      create: (context) => WebsiteSetupRepositoryImpl(
        remoteDataSource: context.read(),
        localDataSource: context.read(),
      ),
    ),
    RepositoryProvider<AuthRepository>(
      create: (context) => AuthRepositoryImpl(
        remoteDataSources: context.read(),
        localDataSources: context.read(),
      ),
    ),
    RepositoryProvider<HomeRepository>(
      create: (context) => HomeRepositoryImpl(
        remoteDataSource: context.read(),
      ),
    ),
    RepositoryProvider<WishlistRepository>(
      create: (context) => WishlistRepositoryImpl(
        remoteDataSource: context.read(),
      ),
    ),

    RepositoryProvider<UserDashboardRepository>(
      create: (context) => UserDashboardRepositoryImpl(
        remoteDataSource: context.read(),
      ),
    ),

    RepositoryProvider<WithdrawRepository>(
      create: (context) => WithdrawRepositoryImpl(
        remoteDataSource: context.read(),
      ),
    ),


    RepositoryProvider<UserCarListRepository>(
      create: (context) => UserCarListRepositoryImpl(
        remoteDataSource: context.read(),
      ),
    ),

    RepositoryProvider<KycRepository>(
      create: (context) => KycRepositoryImpl(
        remoteDataSource: context.read(),
      ),
    ),

    RepositoryProvider<ReviewRepository>(
      create: (context) => ReviewRepositoryImpl(
        remoteDataSource: context.read(),
      ),
    ),

    RepositoryProvider<CompareRepository>(
      create: (context) => CompareRepositoryImpl(
        remoteDataSource: context.read(),
      ),
    ),

  ];

  static final blocProviders = <BlocProvider>[
    BlocProvider<InternetStatusBloc>(
      create: (context) => InternetStatusBloc(),
    ),

    BlocProvider<WebsiteSetupCubit>(
      create: (context) => WebsiteSetupCubit(
        repository: context.read(),
      ),
    ),

    BlocProvider<LoginBloc>(
      create: (context) => LoginBloc(
        repository: context.read(),
      ),
    ),

    BlocProvider<HomeCubit>(
      create: (context) => HomeCubit(
        loginBloc:context.read(),
        homeRepository: context.read(),
      ),
    ),
    BlocProvider<AllCarsCubit>(
      create: (context) => AllCarsCubit(
        homeRepository: context.read(),
        loginBloc: context.read(),
      ),
    ),

    BlocProvider<CarDetailsCubit>(
      create: (context) => CarDetailsCubit(
        homeRepository: context.read(),
        loginBloc:context.read(),
      ),
    ),

    BlocProvider<WishlistCubit>(
      create: (context) => WishlistCubit(
        wishlistRepository: context.read(),
        loginBloc: context.read(),
      ),
    ),


    BlocProvider<UserDashboardCubit>(
      create: (context) => UserDashboardCubit(
        dashboardRepository: context.read(),
        loginBloc: context.read(),
      ),
    ),

    BlocProvider<UserCarsCubit>(
      create: (context) => UserCarsCubit(
        userCarListRepository: context.read(),
        loginBloc: context.read(),
      ),
    ),

    BlocProvider<ManageCarCubit>(
      create: (context) => ManageCarCubit(
        repository: context.read(),
        loginBloc: context.read(),
      ),
    ),

    BlocProvider<DeleteCarCubit>(
      create: (context) => DeleteCarCubit(
        repository: context.read(),
        loginBloc: context.read(),
      ),
    ),

    BlocProvider<KycInfoCubit>(
      create: (context) => KycInfoCubit(
        repository: context.read(),
        loginBloc: context.read(),
      ),
    ),

    BlocProvider<ReviewCubit>(
      create: (context) => ReviewCubit(
        repository: context.read(),
        loginBloc: context.read(),
      ),
    ),

    BlocProvider<TermsPolicyCubit>(
      create: (context) => TermsPolicyCubit(
        repository: context.read(),
        loginBloc: context.read(),
      ),
    ),

    BlocProvider<ProfileCubit>(
      create: (context) => ProfileCubit(
        repository: context.read(),
        loginBloc: context.read(),
      ),
    ),

    BlocProvider<RegisterCubit>(
      create: (context) => RegisterCubit(
        authRepository: context.read(),
        loginBloc: context.read(),
      ),
    ),

    BlocProvider<DealerDetailsCubit>(
      create: (context) => DealerDetailsCubit(
        homeRepository: context.read(),
        loginBloc: context.read(),
      ),
    ),

    BlocProvider<ForgotPasswordCubit>(
      create: (context) => ForgotPasswordCubit(
        authRepository: context.read(),
        loginBloc: context.read(),
      ),
    ),

    BlocProvider<ContactDealerCubit>(
      create: (context) => ContactDealerCubit(
        repository: context.read(),
        loginBloc: context.read(),
      ),
    ),

    BlocProvider<ContactMessageCubit>(
      create: (context) => ContactMessageCubit(
        repository: context.read(),
        loginBloc: context.read(),
      ),
    ),

    BlocProvider<AllDealerCubit>(
      create: (context) => AllDealerCubit(
        homeRepository: context.read(),
        loginBloc: context.read(),
      ),
    ),

    BlocProvider<CompareCubit>(
      create: (context) => CompareCubit(
        repository: context.read(),
        loginBloc: context.read(),
      ),
    ),

    BlocProvider<CarCreateDataCubit>(
      create: (context) => CarCreateDataCubit(
        repository: context.read(),
        loginBloc: context.read(),
      ),
    ),

    BlocProvider<CurrencyCubit>(
      create: (context) => CurrencyCubit(

      ),
    ),

    // BlocProvider<PasswordCubit>(
    //   create: (BuildContext context) => PasswordCubit(),
    // ),
  ];
}
