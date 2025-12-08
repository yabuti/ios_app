import 'dart:async';
import 'package:carsbnb/data/model/search_attribute/search_attribute_model.dart';
import 'package:carsbnb/logic/cubit/all_cars/all_cars_cubit.dart';
import 'package:carsbnb/logic/cubit/all_cars/all_cars_state.dart';
import 'package:carsbnb/presentation/screen/all_car_screen/components/feature_selector.dart';
import 'package:carsbnb/widgets/custom_app_bar.dart';
import 'package:carsbnb/widgets/custom_text.dart';
import 'package:carsbnb/widgets/loading_widget.dart';
import 'package:carsbnb/widgets/page_refresh.dart';
import 'package:carsbnb/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/model/home/home_model.dart';
import '../../../logic/cubit/all_cars/all_car_state_model.dart';
import '../../../utils/constraints.dart';
import '../../../utils/k_images.dart';
import '../../../utils/language_string.dart';
import '../../../utils/utils.dart';
import '../../../widgets/custom_form.dart';
import '../../../widgets/custom_image.dart';
import '../../../widgets/fetch_error_text.dart';
import '../home/components/popular_card.dart';
import 'components/condition_selector.dart';
import 'components/purpose_selector.dart';
import 'package:carsbnb/data/model/home/home_model.dart'
    as home_model; // for City, CityModel, FeaturedCars

class AllCarScreen extends StatefulWidget {
  const AllCarScreen({super.key, this.visibleLeading = true});

  final bool visibleLeading;

  @override
  State<AllCarScreen> createState() => _AllCarScreenState();
}

class _AllCarScreenState extends State<AllCarScreen> {
  late AllCarsCubit aCCubit;

  @override
  void initState() {
    aCCubit = context.read<AllCarsCubit>();
    aCCubit.getAllCarsList();
    _scrollController.addListener(_onScroll);
    super.initState();
  }

  final _scrollController = ScrollController();

  @override
  void dispose() {
    if (aCCubit.state.initialPage > 1) {
      aCCubit.initPage();
    }
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    debugPrint('scrolling-called');
    if (_scrollController.position.atEdge) {
      if (_scrollController.position.pixels != 0.0) {
        if (aCCubit.state.isListEmpty == false) {
          aCCubit.getAllCarsList();
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: Utils.translatedText(context, Language.carListing),
        visibleLeading: widget.visibleLeading,
      ),
      body: PageRefresh(
        onRefresh: () async {
          if (aCCubit.state.initialPage > 1) {
            aCCubit.initPage();
          }
          aCCubit.getAllCarsList();
        },
        child: BlocConsumer<AllCarsCubit, CarSearchStateModel>(
            listener: (context, state) {
          final cars = state.allCarsState;
          if (cars is AllCarsStateError) {
            if (cars.statusCode == 503 || aCCubit.allCarsModel.isNotEmpty) {
              Utils.failureSnackBar(context, cars.message);
            }
          }
        }, builder: (context, state) {
          final cars = state.allCarsState;
          if (cars is AllCarsStateLoading && aCCubit.state.initialPage == 1) {
            return const LoadingWidget();
          } else if (cars is AllCarsStateError) {
            if (cars.statusCode == 503 || aCCubit.allCarsModel.isNotEmpty) {
              return LoadedData(
                cars: aCCubit.allCarsModel,
                controller: _scrollController,
              );
            } else {
              return FetchErrorText(text: cars.message);
            }
          } else if (cars is AllCarsStateLoaded) {
            return LoadedData(
              cars: aCCubit.allCarsModel,
              controller: _scrollController,
            );
          } else if (cars is AllCarsStateMoreLoaded) {
            return LoadedData(
              cars: aCCubit.allCarsModel,
              controller: _scrollController,
            );
          } else if (aCCubit.allCarsModel.isNotEmpty) {
            return LoadedData(
              cars: aCCubit.allCarsModel,
              controller: _scrollController,
            );
          } else {
            return const FetchErrorText(text: 'Something Went Wrong');
          }
        }),
      ),
    );
  }
}

class LoadedData extends StatefulWidget {
  const LoadedData({
    super.key,
    required this.cars,
    required this.controller,
  });

  final List<FeaturedCars> cars;
  final ScrollController controller;

  @override
  State<LoadedData> createState() => _LoadedDataState();
}

class _LoadedDataState extends State<LoadedData> {
  late AllCarsCubit carsCubit;
  CountryModel? _countryModel;
  Brands? _brands;
  home_model.City? _cities;
  Timer? _debounce;
  late List<FeaturedCars> _displayedList;
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _displayedList = widget.cars;
    carsCubit = context.read<AllCarsCubit>();
    _searchController = TextEditingController(text: carsCubit.state.search);

    _searchController.addListener(() {
      setState(() {}); // Rebuild to show/hide the suffix icon dynamically
    });
  }

  @override
  void dispose() {
    _debounce?.cancel(); // Cancel debounce timer
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    // Cancel any existing debounce timer
    if (_debounce?.isActive ?? false) _debounce?.cancel();

    // Set up a new debounce timer with 1 second delay
    _debounce = Timer(const Duration(seconds: 1), () {
      if (query.isNotEmpty) {
        // API call logic after user stops typing
        carsCubit.keyChange(query); // Update cubit state
        carsCubit.applyFilters(); // Call API with query
      } else {
        // If the query is empty, reset the displayed list to initial data
        setState(() {
          _displayedList = widget.cars;
        });
      }
    });
  }

  void _clearSearch() {
    _searchController.clear(); // Clear input text
    carsCubit.clearFilters(); // Clear filters in cubit
    // carsCubit.getAllCarsList(); // Refresh cars list
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    double childAspectRatio = size.width / (size.height / 1.46);

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
        controller: widget.controller,
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: Utils.symmetric(),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      // initialValue: carsCubit.state.search,
                      controller: _searchController,
                      onChanged: _onSearchChanged,
                      decoration: InputDecoration(
                        hintText: 'Search here...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4.0),
                          borderSide:
                              const BorderSide(color: borderColor, width: 1),
                        ),
                        suffixIcon: _searchController.text.isNotEmpty
                            ? GestureDetector(
                                onTap: _clearSearch,
                                child:
                                    const Icon(Icons.close, color: Colors.grey),
                              )
                            : null,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4.0),
                          borderSide:
                              const BorderSide(color: borderColor, width: 1),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4.0),
                          borderSide:
                              const BorderSide(color: borderColor, width: 1),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 14.0, horizontal: 20.0),
                      ),
                    ),
                  ),
                  Utils.horizontalSpace(12.0),
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                          isScrollControlled: true,
                          context: context,
                          builder: (context) {
                            return Container(
                              height: size.height * 0.8,
                              padding: Utils.symmetric(v: 20.0),
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        CustomText(
                                          text: Utils.translatedText(
                                              context, Language.searchFilter),
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        GestureDetector(
                                            onTap: () {
                                              Navigator.pop(context);
                                            },
                                            child: const CustomImage(
                                                path: KImages.closeBox))
                                      ],
                                    ),
                                    Utils.verticalSpace(16.0),
                                    BlocBuilder<AllCarsCubit,
                                        CarSearchStateModel>(
                                      builder: (context, state) {
                                        return Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            if (carsCubit
                                                        .searchAttributeModel !=
                                                    null &&
                                                carsCubit.searchAttributeModel!
                                                    .country!.isNotEmpty)
                                              CustomForm(
                                                label: 'Location',
                                                bottomSpace: 14.0,
                                                child: DropdownButtonFormField<
                                                    CountryModel>(
                                                  hint: const CustomText(
                                                      text: "location"),
                                                  isDense: true,
                                                  isExpanded: true,
                                                  initialValue: _countryModel,
                                                  icon: const Icon(Icons
                                                      .keyboard_arrow_down),
                                                  decoration: InputDecoration(
                                                    isDense: true,
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  Utils.radius(
                                                                      10.0))),
                                                    ),
                                                    contentPadding:
                                                        const EdgeInsets
                                                            .fromLTRB(16.0,
                                                            20.0, 20.0, 10.0),
                                                  ),
                                                  onTap: () =>
                                                      Utils.closeKeyBoard(
                                                          context),
                                                  onChanged: (value) {
                                                    if (value == null) return;
                                                    setState(() {
                                                      _countryModel = value;
                                                      _cities =
                                                          null; // Reset city model
                                                    });
                                                    carsCubit.countryChange(
                                                        value.id.toString());
                                                    carsCubit.getCity(
                                                        value.id.toString());
                                                  },
                                                  items: carsCubit
                                                      .searchAttributeModel!
                                                      .country!
                                                      .map<
                                                          DropdownMenuItem<
                                                              CountryModel>>(
                                                        (CountryModel value) =>
                                                            DropdownMenuItem<
                                                                CountryModel>(
                                                          value: value,
                                                          child: CustomText(
                                                              text: value.name),
                                                        ),
                                                      )
                                                      .toList(),
                                                ),
                                              ),
                                          ],
                                        );
                                      },
                                    ),
                                    BlocBuilder<AllCarsCubit,
                                        CarSearchStateModel>(
                                      builder: (context, state) {
                                        return Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            if (carsCubit.cityModel != null &&
                                                carsCubit.cityModel!.cities!
                                                    .isNotEmpty)
                                              CustomForm(
                                                  label: 'Select Your City',
                                                  bottomSpace: 14.0,
                                                  child:
                                                      DropdownButtonFormField<
                                                          home_model.City>(
                                                    hint: const CustomText(
                                                        text: "City"),
                                                    isDense: true,
                                                    isExpanded: true,
                                                    initialValue:
                                                        _cities, // _cities should be of type home_model.City?
                                                    icon: const Icon(Icons
                                                        .keyboard_arrow_down),
                                                    decoration: InputDecoration(
                                                      isDense: true,
                                                      border:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                          Radius.circular(
                                                              Utils.radius(
                                                                  10.0)),
                                                        ),
                                                      ),
                                                      contentPadding:
                                                          const EdgeInsets
                                                              .fromLTRB(16.0,
                                                              20.0, 20.0, 10.0),
                                                    ),
                                                    onTap: () =>
                                                        Utils.closeKeyBoard(
                                                            context),
                                                    onChanged: (value) {
                                                      if (value == null) return;
                                                      setState(() {
                                                        _cities = value;
                                                      });
                                                      carsCubit.locationChange(value
                                                          .id
                                                          .toString()); // use value.id from City
                                                    },
                                                    items: carsCubit
                                                        .cityModel!.cities!
                                                        .map<
                                                            DropdownMenuItem<
                                                                home_model
                                                                .City>>(
                                                          (home_model.City
                                                                  value) =>
                                                              DropdownMenuItem<
                                                                  home_model
                                                                  .City>(
                                                            value: value,
                                                            child: CustomText(
                                                                text:
                                                                    value.name),
                                                          ),
                                                        )
                                                        .toList(),
                                                  )),
                                          ],
                                        );
                                      },
                                    ),
                                    BlocBuilder<AllCarsCubit,
                                        CarSearchStateModel>(
                                      builder: (context, state) {
                                        // Update the category and subcategory models based on current state
                                        if (state.brands.isNotEmpty &&
                                            carsCubit.searchAttributeModel!
                                                .brands!.isNotEmpty) {
                                          // Use `orElse` to avoid "No element" error if not found
                                          _brands = carsCubit
                                              .searchAttributeModel!.brands!
                                              .firstWhere(
                                            (e) =>
                                                e.id.toString() == state.brands,
                                            orElse: () => carsCubit
                                                .searchAttributeModel!
                                                .brands!
                                                .first,
                                          );
                                        }
                                        return Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            if (carsCubit
                                                        .searchAttributeModel !=
                                                    null &&
                                                carsCubit.searchAttributeModel!
                                                    .brands!.isNotEmpty)
                                              CustomForm(
                                                label: 'Select Your Brand',
                                                bottomSpace: 14.0,
                                                child: DropdownButtonFormField<
                                                    Brands>(
                                                  hint: const CustomText(
                                                      text: "Brand"),
                                                  isDense: true,
                                                  isExpanded: true,
                                                  initialValue: _brands,
                                                  icon: const Icon(Icons
                                                      .keyboard_arrow_down),
                                                  decoration: InputDecoration(
                                                    isDense: true,
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  Utils.radius(
                                                                      10.0))),
                                                    ),
                                                    contentPadding:
                                                        const EdgeInsets
                                                            .fromLTRB(16.0,
                                                            20.0, 20.0, 10.0),
                                                  ),
                                                  onTap: () =>
                                                      Utils.closeKeyBoard(
                                                          context),
                                                  onChanged: (value) {
                                                    if (value == null) return;
                                                    setState(() {
                                                      _brands = value;
                                                    });
                                                    carsCubit.brandChange(
                                                        value.id.toString());
                                                  },
                                                  items: carsCubit
                                                      .searchAttributeModel!
                                                      .brands!
                                                      .map<
                                                          DropdownMenuItem<
                                                              Brands>>(
                                                        (Brands value) =>
                                                            DropdownMenuItem<
                                                                Brands>(
                                                          value: value,
                                                          child: CustomText(
                                                              text: value.name),
                                                        ),
                                                      )
                                                      .toList(),
                                                ),
                                              ),
                                          ],
                                        );
                                      },
                                    ),
                                    Utils.verticalSpace(10.0),
                                    ConditionSelector(
                                      carsCubit: carsCubit,
                                    ),
                                    Utils.verticalSpace(10.0),
                                    PurposeSelector(
                                      carsCubit: carsCubit,
                                    ),
                                    Utils.verticalSpace(10.0),
                                    FeatureSelector(carsCubit: carsCubit),
                                    Utils.verticalSpace(10.0),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: PrimaryButton(
                                              text: Utils.translatedText(
                                                  context,
                                                  Language.applyFilter),
                                              onPressed: () {
                                                //  applyFilters;
                                                carsCubit.applyFilters();
                                                Navigator.pop(context);
                                              }),
                                        ),
                                        Utils.horizontalSpace(20.0),
                                        Expanded(
                                            child: GestureDetector(
                                                onTap: () {
                                                  carsCubit.clearFilters();
                                                  Navigator.pop(context);
                                                },
                                                child: const CustomText(
                                                  text: "Clear",
                                                  fontSize: 16.0,
                                                  color: Color(0xFFFF3838),
                                                )))
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                          });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.0),
                          color: whiteColor),
                      child: Padding(
                        padding: Utils.all(value: 12.0),
                        child: const CustomImage(path: KImages.filterIcon),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(child: Utils.verticalSpace(14.0)),
          widget.cars.isNotEmpty
              ? SliverPadding(
                  padding: Utils.symmetric(h: 20.0),
                  sliver: SliverGrid(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 12.0,
                      crossAxisSpacing: 12.0,
                      childAspectRatio: childAspectRatio,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        final car = widget.cars[index];
                        return PopularCarCard(
                          cars: car,
                        );
                      },
                      childCount: widget.cars.length,
                    ),
                  ),
                )
              : SliverToBoxAdapter(
                  child: Column(
                  children: [
                    Utils.verticalSpace(40.0),
                    const CustomImage(path: KImages.emptyImage),
                    Utils.verticalSpace(10.0),
                    Center(
                        child: CustomText(
                      text: Utils.translatedText(context, Language.carNotFound),
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    )),
                  ],
                )),
          SliverToBoxAdapter(child: Utils.verticalSpace(14.0)),
        ],
      ),
    );
  }
}
