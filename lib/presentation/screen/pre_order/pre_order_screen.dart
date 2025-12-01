import 'dart:convert';
import 'package:blackdiamondcar/data/model/search_attribute/search_attribute_model.dart';
import 'package:blackdiamondcar/logic/cubit/all_cars/all_cars_cubit.dart';
import 'package:blackdiamondcar/logic/cubit/all_cars/all_cars_state.dart';
import 'package:blackdiamondcar/presentation/screen/all_car_screen/components/feature_selector.dart';
import 'package:blackdiamondcar/widgets/custom_app_bar.dart';
import 'package:blackdiamondcar/widgets/custom_text.dart';
import 'package:blackdiamondcar/widgets/loading_widget.dart';
import 'package:blackdiamondcar/widgets/page_refresh.dart';
import 'package:blackdiamondcar/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../data/model/home/home_model.dart';
import '../../../logic/cubit/all_cars/all_car_state_model.dart';
import '../../../utils/constraints.dart';
import '../../../utils/k_images.dart';
import '../../../utils/language_string.dart';
import '../../../utils/utils.dart';
import '../../../widgets/custom_form.dart';
import '../../../widgets/custom_image.dart';
import '../../../widgets/fetch_error_text.dart';
import '../all_car_screen/components/condition_selector.dart';
import '../all_car_screen/components/purpose_selector.dart';
import '../home/components/popular_card.dart';
import 'package:blackdiamondcar/data/model/home/home_model.dart' as home_model;

class PreOrderScreen extends StatefulWidget {
  const PreOrderScreen({super.key, this.visibleLeading = true});

  final bool visibleLeading;

  @override
  State<PreOrderScreen> createState() => _PreOrderScreenState();
}

class _PreOrderScreenState extends State<PreOrderScreen> {
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
        title: "Pre-Order Form", // <-- change here
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

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _deliveryDateController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  String? _selectedBrand; // fixed missing semicolon
  DateTime? _selectedDate;

  List<String> _brandsList = [];

  @override
  void initState() {
    super.initState();
    carsCubit = context.read<AllCarsCubit>();
    // Get brand names list safely
    _brandsList =
        carsCubit.searchAttributeModel?.brands?.map((e) => e.name).toList() ??
            [];
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    double childAspectRatio = size.width / (size.height / 1.46);

    return CustomScrollView(
      controller: widget.controller,
      slivers: [
        // Filter Button Row
        SliverToBoxAdapter(
          child: Padding(
            padding: Utils.symmetric(),
            child: Row(
              children: [
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
                                        onTap: () => Navigator.pop(context),
                                        child: const CustomImage(
                                            path: KImages.closeBox),
                                      )
                                    ],
                                  ),
                                  Utils.verticalSpace(16.0),
                                  // Country, City, Brand, Condition, Purpose, Feature selectors
                                  if (carsCubit.searchAttributeModel !=
                                      null) ...[
                                    if (carsCubit.searchAttributeModel!.country!
                                        .isNotEmpty)
                                      CustomForm(
                                        label: 'Location',
                                        bottomSpace: 14.0,
                                        child: DropdownButtonFormField<
                                            CountryModel>(
                                          hint: const CustomText(
                                              text: "Location"),
                                          isDense: true,
                                          isExpanded: true,
                                          value: _countryModel,
                                          icon: const Icon(
                                              Icons.keyboard_arrow_down),
                                          decoration: InputDecoration(
                                            isDense: true,
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            contentPadding:
                                                const EdgeInsets.fromLTRB(
                                                    16.0, 20.0, 20.0, 10.0),
                                          ),
                                          onChanged: (value) {
                                            if (value == null) return;
                                            setState(() {
                                              _countryModel = value;
                                              _cities = null;
                                            });
                                            carsCubit.countryChange(
                                                value.id.toString());
                                            carsCubit
                                                .getCity(value.id.toString());
                                          },
                                          items: carsCubit
                                              .searchAttributeModel!.country!
                                              .map((CountryModel value) {
                                            return DropdownMenuItem(
                                              value: value,
                                              child:
                                                  CustomText(text: value.name),
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                    if (carsCubit
                                            .cityModel?.cities?.isNotEmpty ??
                                        false)
                                      DropdownButtonFormField<home_model.City>(
                                        hint: const CustomText(text: "City"),
                                        isDense: true,
                                        isExpanded: true,
                                        value: _cities,
                                        icon: const Icon(
                                            Icons.keyboard_arrow_down),
                                        decoration: InputDecoration(
                                          isDense: true,
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          contentPadding:
                                              const EdgeInsets.fromLTRB(
                                                  16.0, 20.0, 20.0, 10.0),
                                        ),
                                        onChanged: (home_model.City? value) {
                                          if (value == null) return;
                                          setState(() {
                                            _cities = value;
                                          });
                                          carsCubit.locationChange(
                                              value.id.toString());
                                        },
                                        items: carsCubit.cityModel!.cities!
                                            .map((home_model.City value) {
                                          return DropdownMenuItem<
                                              home_model.City>(
                                            value: value,
                                            child: CustomText(text: value.name),
                                          );
                                        }).toList(),
                                      ),
                                    // Brand selector
                                    if (carsCubit.searchAttributeModel!.brands!
                                        .isNotEmpty)
                                      CustomForm(
                                        label: 'Select Your Brand',
                                        bottomSpace: 14.0,
                                        child: DropdownButtonFormField<Brands>(
                                          hint: const CustomText(text: "Brand"),
                                          isDense: true,
                                          isExpanded: true,
                                          value: _brands,
                                          icon: const Icon(
                                              Icons.keyboard_arrow_down),
                                          decoration: InputDecoration(
                                            isDense: true,
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            contentPadding:
                                                const EdgeInsets.fromLTRB(
                                                    16.0, 20.0, 20.0, 10.0),
                                          ),
                                          onChanged: (value) {
                                            if (value == null) return;
                                            setState(() {
                                              _brands = value;
                                            });
                                            carsCubit.brandChange(
                                                value.id.toString());
                                          },
                                          items: carsCubit
                                              .searchAttributeModel!.brands!
                                              .map((Brands value) {
                                            return DropdownMenuItem(
                                              value: value,
                                              child:
                                                  CustomText(text: value.name),
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                    Utils.verticalSpace(10.0),
                                    ConditionSelector(carsCubit: carsCubit),
                                    Utils.verticalSpace(10.0),
                                    PurposeSelector(carsCubit: carsCubit),
                                    Utils.verticalSpace(10.0),
                                    FeatureSelector(carsCubit: carsCubit),
                                    Utils.verticalSpace(10.0),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: PrimaryButton(
                                            text: Utils.translatedText(
                                                context, Language.applyFilter),
                                            onPressed: () {
                                              carsCubit.applyFilters();
                                              Navigator.pop(context);
                                            },
                                          ),
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
                                              color: Color(0xFFE9D634),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ]),
                          ),
                        );
                      },
                    );
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
// Pre-Order Form
        SliverToBoxAdapter(
          child: Padding(
            padding: Utils.symmetric(h: 20.0, v: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomText(
                  text: "Pre-Order Form",
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                Utils.verticalSpace(10.0),

                // Name Field
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: "Full Name",
                    border: OutlineInputBorder(),
                  ),
                ),
                Utils.verticalSpace(10.0),

                // Phone Number Field
                TextFormField(
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    labelText: "Phone Number",
                    border: OutlineInputBorder(),
                  ),
                ),
                Utils.verticalSpace(10.0),

                // Car Brand Dropdown
                DropdownButtonFormField<String>(
                  value: _selectedBrand,
                  decoration: const InputDecoration(
                    labelText: "Car Brand",
                    border: OutlineInputBorder(),
                  ),
                  items: _brandsList
                      .map((brand) => DropdownMenuItem(
                            value: brand,
                            child: Text(brand),
                          ))
                      .toList(),
                  onChanged: (val) {
                    setState(() {
                      _selectedBrand = val;
                    });
                  },
                ),
                Utils.verticalSpace(10.0),

                // Car Description
                TextFormField(
                  controller: _descriptionController,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    labelText: "Car Description",
                    border: OutlineInputBorder(),
                  ),
                ),
                Utils.verticalSpace(10.0),

                // Preferred Delivery Date
                TextFormField(
                  controller: _deliveryDateController,
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: "Preferred Delivery Date",
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.calendar_today),
                      onPressed: () async {
                        DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: _selectedDate ?? DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2100),
                        );
                        if (picked != null && mounted) {
                          setState(() {
                            _selectedDate = picked;
                            _deliveryDateController.text =
                                "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
                          });
                        }
                      },
                    ),
                  ),
                ),
                Utils.verticalSpace(10.0),

                // Submit Button
                PrimaryButton(
                  text: "Submit Pre-Order",
                  onPressed: () async {
                    final name = _nameController.text.trim();
                    final phone = _phoneController.text.trim();
                    final deliveryDate = _deliveryDateController.text.trim();
                    final brand = _selectedBrand;
                    final description = _descriptionController.text.trim();

                    if (name.isEmpty ||
                        phone.isEmpty ||
                        deliveryDate.isEmpty ||
                        brand == null) {
                      Utils.failureSnackBar(context, "Please fill all fields");
                      return;
                    }

                    final isMounted = mounted;

                    try {
                      // Direct API call to preorder/submit endpoint
                      final prefs = await SharedPreferences.getInstance();
                      final token = prefs.getString('accessToken');
                      
                      final url = Uri.parse("https://blackdiamondcar.com/api/preorder/submit");
                      
                      var body = jsonEncode({
                        'user_name': name,
                        'user_phone': phone,
                        'preferred_delivery_date': deliveryDate,
                        'category': brand, // Car brand goes here
                        'requested_vehicle': brand, // Car brand also goes here
                        'user_message': description, // Car description goes here
                        'type': 'preorder',
                      });

                      debugPrint('📦 Pre-order URL: $url');
                      debugPrint('📦 Pre-order data: $body');

                      final response = await http.post(
                        url,
                        headers: {
                          'Content-Type': 'application/json',
                          'Accept': 'application/json',
                          if (token != null && token.isNotEmpty)
                            'Authorization': 'Bearer $token',
                        },
                        body: body,
                      ).timeout(
                        const Duration(seconds: 30),
                        onTimeout: () {
                          throw Exception('Request timed out');
                        },
                      );

                      debugPrint('📦 Pre-order status: ${response.statusCode}');
                      debugPrint('📦 Pre-order response: ${response.body}');

                      if (!isMounted) return;

                      final res = jsonDecode(response.body);

                      if (response.statusCode == 201 || response.statusCode == 200) {
                        Utils.successSnackBar(
                            context, "Pre-Order submitted successfully!");

                        // Clear fields
                        _nameController.clear();
                        _phoneController.clear();
                        _deliveryDateController.clear();
                        _descriptionController.clear();
                        setState(() {
                          _selectedBrand = null;
                          _selectedDate = null;
                        });
                      } else {
                        Utils.failureSnackBar(
                            context, res['message'] ?? "Failed to submit Pre-Order");
                      }
                    } catch (e) {
                      if (!isMounted) return;
                      Utils.failureSnackBar(
                          context, "Error: $e");
                      debugPrint("Pre-Order Error: $e");
                    }
                  },
                ),

                Utils.verticalSpace(20.0),
              ],
            ),
          ),
        ),

        // Car Grid
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
                      return PopularCarCard(cars: car);
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
                        text:
                            Utils.translatedText(context, Language.carNotFound),
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
        SliverToBoxAdapter(child: Utils.verticalSpace(14.0)),
      ],
    );
  }
}
