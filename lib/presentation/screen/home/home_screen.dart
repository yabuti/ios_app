import 'package:carsbnb/logic/cubit/home/home_cubit.dart';
import 'package:carsbnb/logic/cubit/home/home_state.dart';
import 'package:carsbnb/logic/cubit/language_code_state.dart';
import 'package:carsbnb/widgets/page_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../utils/utils.dart';
import '../../../widgets/fetch_error_text.dart';
import '../../../widgets/loading_widget.dart';
import 'components/brand_screen.dart';
import 'components/feature_rent_car.dart';
import 'components/home_app_bar.dart';
import 'components/popular_car_screen.dart';
import 'components/slider_section.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late HomeCubit hCubit;

  @override
  void initState() {
    super.initState();
    hCubit = context.read<HomeCubit>();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageRefresh(
        onRefresh: ()async{
          hCubit.getHomeData();
        },
        child: BlocConsumer<HomeCubit, LanguageCodeState>(
            listener: (context, state) {
          final home = state.homeState;
          if (home is HomeStateError) {
            if (home.statusCode == 503 || hCubit.homeModel == null) {
              hCubit.getHomeData();
            }
          }
        }, builder: (context, state) {
          final home = state.homeState;
          if (home is HomeStateLoading) {
            return const LoadingWidget();
          } else if (home is HomeStateError) {
            if (home.statusCode == 503 || hCubit.homeModel != null) {
              return const LoadedHomeData();
            } else {
              return FetchErrorText(text: home.message);
            }
          } else if (home is HomeStateLoaded) {
            return const LoadedHomeData();
          }
          if (hCubit.homeModel != null) {
            return const LoadedHomeData();
          } else {
            return const FetchErrorText(text: 'Something Went Wrong');
          }
        }),
      ),
    );
  }
}

class LoadedHomeData extends StatelessWidget {
  const LoadedHomeData({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final hCubit = context.read<HomeCubit>();
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
      child: CustomScrollView(
        slivers: [
          const HomeAppBar(),
          SliderSection(slider: hCubit.homeModel!.sliders!),
          BrandScreen(brands: hCubit.homeModel!.brands!),
          SliverToBoxAdapter(
            child: Utils.verticalSpace(26.0),
          ),
          FeatureCarScreen(featuredCars: hCubit.homeModel!.featuredCars!),
          SliverToBoxAdapter(
            child: Utils.verticalSpace(26.0),
          ),
          PopularCarScreen(latestCars: hCubit.homeModel!.latestCars!),
          SliverToBoxAdapter(
            child: Utils.verticalSpace(26.0),
          ),
        ],
      ),
    );
  }
}
