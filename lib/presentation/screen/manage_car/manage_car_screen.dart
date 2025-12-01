import 'package:blackdiamondcar/data/model/home/home_model.dart';
import 'package:blackdiamondcar/logic/cubit/language_code_state.dart';
import 'package:blackdiamondcar/logic/cubit/manage_car/delete_car/delete_car_cubit.dart';
import 'package:blackdiamondcar/logic/cubit/manage_car/delete_car/delete_car_state.dart';
import 'package:blackdiamondcar/logic/cubit/user_cars_list/user_cars_cubit.dart';
import 'package:blackdiamondcar/logic/cubit/user_cars_list/user_cars_state.dart';
import 'package:blackdiamondcar/widgets/custom_app_bar.dart';
import 'package:blackdiamondcar/widgets/fetch_error_text.dart';
import 'package:blackdiamondcar/widgets/loading_widget.dart';
import 'package:blackdiamondcar/widgets/page_refresh.dart';
import 'package:blackdiamondcar/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../routes/route_names.dart';
import '../../../utils/utils.dart';
import '../../../widgets/custom_text.dart';
import 'components/manage_car_card.dart';

class ManageCarScreen extends StatefulWidget {
  const ManageCarScreen({super.key});

  @override
  State<ManageCarScreen> createState() => _ManageCarScreenState();
}

class _ManageCarScreenState extends State<ManageCarScreen> {
  late UserCarsCubit carsCubit;

  @override
  void initState() {
    super.initState();
    carsCubit = context.read<UserCarsCubit>();
    carsCubit.initPage();
    carsCubit.initState();
    carsCubit.getUserCarsList();
    _scrollController.addListener(_onScroll);
  }

  final _scrollController = ScrollController();

  @override
  void dispose() {
    if (carsCubit.state.initialPage > 1) {
      carsCubit.initPage();
    }
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    debugPrint('scrolling-called');
    if (_scrollController.position.atEdge) {
      if (_scrollController.position.pixels != 0.0) {
        if (carsCubit.state.isListEmpty == false) {
          carsCubit.getUserCarsList();
        }
      }
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Manage Car'),
      body: MultiBlocListener(
        listeners: [
          BlocListener<DeleteCarCubit, DeleteCarState>(
            listener: (context, state) {
              if (state is DeleteCarStateLoading) {
                Utils.loadingDialog(context);
              } else {
                Utils.closeDialog(context);
                if (state is DeleteCarStateError) {
                  Utils.failureSnackBar(context, state.message);
                } else if (state is DeleteCarStateSuccess) {
                  Utils.successSnackBar(context, state.message);
                  carsCubit.initState();
                  carsCubit.initPage();
                  carsCubit.getUserCarsList();


                }
              }
            },
          ),
        ],
        child: PageRefresh(
          onRefresh: () async {
            if (carsCubit.state.initialPage > 1) {
              carsCubit.initPage();
            }
            carsCubit.getUserCarsList();
          },
          child: Utils.logout(
            child: BlocConsumer<UserCarsCubit, LanguageCodeState>(
                listener: (context, state) {
              final car = state.userCarsListState;
              if (car is UserCarsListStateError) {
                if (car.statusCode == 503) {
                  Utils.errorSnackBar(context, car.message);
                }
                if(car.statusCode == 401){
                  Utils.logoutFunction(context);
                }
              }
            }, builder: (context, state) {
              final car = state.userCarsListState;
              if (car is UserCarsListStateLoading) {
                return const LoadingWidget();
              } else if (car is UserCarsListStateError) {
                if (car.statusCode == 503 || carsCubit.allCarsModel == null) {
                  return LoadedCar(
                    cars: carsCubit.allCarsModel!,
                    controller: _scrollController,
                  );
                } else {
                  return FetchErrorText(text: car.message);
                }
              } else if (car is UserCarsListStateLoaded) {
                return LoadedCar(
                  cars: carsCubit.allCarsModel!,
                  controller: _scrollController,
                );
              } else if (car is UserCarsListStateMoreLoaded) {
                return LoadedCar(
                  cars: carsCubit.allCarsModel!,
                  controller: _scrollController,
                );
              }
              if (carsCubit.allCarsModel != null) {
                return LoadedCar(
                  cars: carsCubit.allCarsModel!,
                  controller: _scrollController,
                );
              } else {
                return const FetchErrorText(text: "Something went wrong");
              }
            }),
          ),
        ),
      ),
    );
  }
}

class LoadedCar extends StatelessWidget {
  const LoadedCar({
    super.key,
    required this.cars,
    required this.controller,
  });

  final List<FeaturedCars> cars;
  final ScrollController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Color(0x0A000012),
            blurRadius: 30,
            offset: Offset(0, 2),
            spreadRadius: 0,
          )
        ],
      ),
      child: ListView.builder(
        controller: controller,
        padding: Utils.symmetric(h: 20.0),
        itemCount: cars.length,
        itemBuilder: (BuildContext context, int index) {
          final car = cars[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: ManageCarCard(
              cars: car,
            ),
          );
        },
      ),
    );
  }
}
