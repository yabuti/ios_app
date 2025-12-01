import 'package:blackdiamondcar/logic/cubit/all_dealer/all_dealer_cubit.dart';
import 'package:blackdiamondcar/logic/cubit/all_dealer/all_dealer_state.dart';
import 'package:blackdiamondcar/utils/k_images.dart';
import 'package:blackdiamondcar/widgets/custom_image.dart';
import 'package:blackdiamondcar/widgets/custom_text.dart';
import 'package:blackdiamondcar/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/model/home/home_model.dart';
import '../../../logic/cubit/all_dealer/dealer_search_state_model.dart';
import '../../../utils/constraints.dart';
import '../../../utils/utils.dart';
import '../../../widgets/fetch_error_text.dart';
import '../../../widgets/loading_widget.dart';
import '../home/components/top_dealer_section.dart';
import 'package:blackdiamondcar/data/model/home/home_model.dart'
    as home_model; // for City, CityModel, FeaturedCars
import 'package:blackdiamondcar/logic/cubit/all_cars/all_cars_cubit.dart';

class AllDealerScreen extends StatefulWidget {
  const AllDealerScreen({super.key});

  @override
  State<AllDealerScreen> createState() => _AllDealerScreenState();
}

class _AllDealerScreenState extends State<AllDealerScreen> {
  bool _showSearch = false;
  late AllDealerCubit allDealerCubit;

  @override
  void initState() {
    allDealerCubit = context.read<AllDealerCubit>();
    allDealerCubit.getAllDealersList();
    allDealerCubit.getDealerSearch();
    _scrollController.addListener(_onScroll);
    super.initState();
  }

  final _scrollController = ScrollController();

  @override
  void dispose() {
    if (allDealerCubit.state.initialPage > 1) {
      allDealerCubit.initPage();
    }
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    debugPrint('scrolling-called');
    if (_scrollController.position.atEdge) {
      if (_scrollController.position.pixels != 0.0) {
        if (allDealerCubit.state.isListEmpty == false) {
          allDealerCubit.getAllDealersList();
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CustomText(
          text: "Car Dealer",
          fontSize: 18.0,
          fontWeight: FontWeight.w500,
        ),
        actions: [
          Padding(
            padding: Utils.only(right: 20.0),
            child: GestureDetector(
                onTap: () {
                  setState(() {
                    _showSearch = !_showSearch;
                    if (_showSearch == false) {
                      allDealerCubit.clearFilters();
                    }
                  });
                },
                child: CustomImage(
                    path:
                        _showSearch ? KImages.closeBox : KImages.dealerSearch)),
          ),
        ],
      ),
      body: BlocConsumer<AllDealerCubit, DealerSearchStateModel>(
          listener: (context, state) {
        final dealer = state.allDealerState;
        if (dealer is AllDealerStateError) {
          if (dealer.statusCode == 503 ||
              allDealerCubit.allDealerModel.isNotEmpty) {
            Utils.failureSnackBar(context, dealer.message);
          }
        }
      }, builder: (context, state) {
        final dealer = state.allDealerState;
        if (dealer is AllDealerStateLoading &&
            allDealerCubit.state.initialPage == 1) {
          return const LoadingWidget();
        } else if (dealer is AllDealerStateError) {
          if (dealer.statusCode == 503 ||
              allDealerCubit.allDealerModel.isNotEmpty) {
            return LoadedData(
              dealers: allDealerCubit.allDealerModel,
              controller: _scrollController,
              showSearch: _showSearch, // Pass the _showSearch state
            );
          } else {
            return FetchErrorText(text: dealer.message);
          }
        } else if (dealer is AllDealerStateLoaded) {
          return LoadedData(
            dealers: allDealerCubit.allDealerModel,
            controller: _scrollController,
            showSearch: _showSearch, // Pass the _showSearch state
          );
        } else if (dealer is AllDealerStateMoreLoaded) {
          return LoadedData(
            dealers: allDealerCubit.allDealerModel,
            controller: _scrollController,
            showSearch: _showSearch, // Pass the _showSearch state
          );
        } else if (allDealerCubit.allDealerModel.isNotEmpty) {
          return LoadedData(
            dealers: allDealerCubit.allDealerModel,
            controller: _scrollController,
            showSearch: _showSearch, // Pass the _showSearch state
          );
        } else {
          return const FetchErrorText(text: '');
        }
      }),
    );
  }
}

class LoadedData extends StatefulWidget {
  const LoadedData({
    super.key,
    required this.dealers,
    required this.controller,
    required this.showSearch, // Add this parameter
  });

  final List<Dealers> dealers;
  final ScrollController controller;
  final bool showSearch; // Add this parameter

  @override
  State<LoadedData> createState() => _LoadedDataState();
}

class _LoadedDataState extends State<LoadedData> {
  late AllDealerCubit adCubit;
  late TextEditingController _searchController;
  home_model.City? _cities;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    adCubit = context.read<AllDealerCubit>();
    _searchController = TextEditingController();
  }

  void _clearSearch() {
    _searchController.clear(); // Clear input text
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Utils.symmetric(),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: blackColor.withOpacity(0.05),
              blurRadius: 30,
              offset: const Offset(0, 2),
              spreadRadius: 0,
            )
          ],
        ),
        child: Column(
          children: [
            if (widget.showSearch) // Use the passed parameter
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: whiteColor),
                child: Padding(
                  padding: Utils.all(value: 14.0),
                  child: Column(
                    children: [
                      TextFormField(
                        onChanged: adCubit.keyChange,
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
                                  child: const Icon(Icons.close,
                                      color: Colors.grey),
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
                      Utils.verticalSpace(10.0),
                      BlocBuilder<AllDealerCubit, DealerSearchStateModel>(
                        builder: (context, state) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (adCubit.cityModel != null &&
                                  adCubit.cityModel!.cities!.isNotEmpty)
                                DropdownButtonFormField<home_model.City>(
                                  hint: const CustomText(text: "City"),
                                  isDense: true,
                                  isExpanded: true,
                                  value: _cities,
                                  icon: const Icon(Icons.keyboard_arrow_down),
                                  decoration: InputDecoration(
                                    isDense: true,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(Utils.radius(10.0))),
                                    ),
                                    contentPadding: const EdgeInsets.fromLTRB(
                                        16.0, 20.0, 20.0, 10.0),
                                  ),
                                  onTap: () => Utils.closeKeyBoard(context),
                                  onChanged: (home_model.City? value) {
                                    if (value == null) return;
                                    setState(() {
                                      _cities = value;
                                    });
                                    context
                                        .read<AllCarsCubit>()
                                        .locationChange(value.id.toString());
                                  },
                                  items: context
                                      .read<AllCarsCubit>()
                                      .cityModel!
                                      .cities!
                                      .map<DropdownMenuItem<home_model.City>>(
                                        (home_model.City value) =>
                                            DropdownMenuItem<home_model.City>(
                                          value: value,
                                          child: CustomText(text: value.name),
                                        ),
                                      )
                                      .toList(),
                                ),
                            ],
                          );
                        },
                      ),
                      Utils.verticalSpace(10.0),
                      PrimaryButton(
                          text: "Search Now",
                          onPressed: () {
                            adCubit.applyFilters();
                          })
                    ],
                  ),
                ),
              ),
            Utils.verticalSpace(10.0),
            if (widget.dealers.isNotEmpty) ...[
              Expanded(
                child: ListView.builder(
                  itemCount: widget.dealers.length,
                  itemBuilder: (BuildContext context, int index) {
                    final dealer = widget.dealers[index];
                    return Padding(
                      padding: Utils.only(bottom: 10.0),
                      child: DealersCard(
                        dealer: dealer,
                      ),
                    );
                  },
                ),
              ),
            ] else ...[
              Column(
                children: [
                  Utils.verticalSpace(40.0),
                  const CustomImage(path: KImages.emptyImage),
                  Utils.verticalSpace(30.0),
                  const CustomText(
                    text: "Car Dealer Not Found",
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  )
                ],
              )
            ]
          ],
        ),
      ),
    );
  }
}
