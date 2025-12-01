import 'package:carousel_slider/carousel_slider.dart';
import 'package:blackdiamondcar/data/data_provider/remote_url.dart';
import 'package:blackdiamondcar/data/model/search_attribute/search_attribute_model.dart';
import 'package:blackdiamondcar/logic/cubit/car_details/car_details_cubit.dart';
import 'package:blackdiamondcar/logic/cubit/car_details/car_details_state.dart';
import 'package:blackdiamondcar/logic/cubit/compare/compare_list_cubit.dart';
import 'package:blackdiamondcar/logic/cubit/compare/compare_list_state.dart';
import 'package:blackdiamondcar/logic/cubit/contact_dealer/contact_dealer_cubit.dart';
import 'package:blackdiamondcar/logic/cubit/contact_dealer/contact_dealer_state.dart';
import 'package:blackdiamondcar/logic/cubit/language_code_state.dart';
import 'package:blackdiamondcar/logic/cubit/review/review_state.dart';
import 'package:blackdiamondcar/utils/language_string.dart';
import 'package:blackdiamondcar/widgets/circle_image.dart';
import 'package:blackdiamondcar/widgets/custom_app_bar.dart';
import 'package:blackdiamondcar/widgets/custom_image.dart';
import 'package:blackdiamondcar/widgets/fetch_error_text.dart';
import 'package:blackdiamondcar/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:readmore/readmore.dart';
import 'dart:math'; // Add this import
import 'package:webview_flutter/webview_flutter.dart'; // Add this import
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../../../data/model/cars_details/car_details_model.dart';
import '../../../logic/cubit/review/review_cubit.dart';
import '../../../logic/cubit/wishlist/wishlist_cubit.dart';
import '../../../utils/constraints.dart';
import '../../../utils/k_images.dart';
import '../../../utils/utils.dart';
import '../../../widgets/custom_form.dart';
import '../../../widgets/custom_text.dart';
import '../../../widgets/primary_button.dart';
import '../more_screen/components/review_screen.dart';
import 'components/google_map_view.dart';

class DetailsCarScreen extends StatefulWidget {
  const DetailsCarScreen({super.key, required this.id});

  final String id;

  @override
  State<DetailsCarScreen> createState() => _DetailsCarScreenState();
}

class _DetailsCarScreenState extends State<DetailsCarScreen> {
  late CarDetailsCubit detailsCubit;

  bool isFavorite = false;
  late WishlistCubit wishList;

  @override
  void initState() {
    detailsCubit = context.read<CarDetailsCubit>();
    detailsCubit.getCarDetails(widget.id);
    wishList = context.read<WishlistCubit>();
    wishList.getWishlist();
    // Initialize `isFavorite` here if needed, for example:
    isFavorite = checkIfFavorite();
    super.initState();
  }

  bool checkIfFavorite() {
    // Safely check if the item is in the wishlist
    if (wishList.wishlistModel == null) return false;
    return wishList.wishlistModel!
        .any((item) => item.id.toString() == widget.id);
  }

  void toggleFavorite() async {
    if (isFavorite) {
      // Safely find wishlist item
      if (wishList.wishlistModel != null) {
        try {
          final wishlistItem = wishList.wishlistModel!
              .firstWhere((item) => item.id.toString() == widget.id);
          await wishList.removeWishlist(wishlistItem.id.toString());
        } catch (e) {
          // Item not found, ignore
        }
      }
    } else {
      await wishList.addToWishlist(widget.id.toString());
      setState(() {
        wishList.getWishlist();
      });
    }

    setState(() {
      isFavorite = !isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: Utils.translatedText(context, Language.carDetails),
        action: [
          Padding(
            padding: Utils.only(right: 20.0),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    if (Utils.isLoggedIn(context)) {
                      final body = {
                        'car_id': widget.id.toString(),
                      };
                      context.read<CompareCubit>().addCompare(body);
                    } else {
                      Utils.showSnackBarWithLogin(context);
                    }
                  },
                  child: Container(
                    padding: Utils.all(value: 10.0),
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: Color(0xFFEEF2F6)),
                    child: const CustomImage(
                      path: KImages.compare,
                      color: blackColor,
                    ),
                  ),
                ),
                Utils.horizontalSpace(10.0),
                GestureDetector(
                  onTap: () {
                    if (Utils.isLoggedIn(context)) {
                      toggleFavorite();
                    } else {
                      Utils.showSnackBarWithLogin(context);
                    }
                  },
                  child: Container(
                    padding: Utils.all(value: 10.0),
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: Color(0xFFEEF2F6)),
                    child: CustomImage(
                        path: isFavorite
                            ? KImages.loveActiveIcon
                            : KImages.loveIcon),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<ContactDealerCubit, LanguageCodeState>(
            listener: (context, state) {
              final contact = state.contactDealerState;
              if (contact is ContactDealerStateLoading) {
                Utils.loadingDialog(context);
              } else {
                Utils.closeDialog(context);
                if (contact is ContactDealerStateError) {
                  Utils.failureSnackBar(context, contact.message);
                } else if (contact is ContactDealerStateSuccess) {
                  Utils.successSnackBar(context, contact.message);
                  Navigator.pop(context);
                }
              }
            },
          ),
          BlocListener<CompareCubit, LanguageCodeState>(
            listener: (context, state) {
              final contact = state.compareListState;
              if (contact is AddCompareStateLoading) {
                Utils.loadingDialog(context);
              } else {
                Utils.closeDialog(context);
                if (contact is AddCompareStateError) {
                  Utils.failureSnackBar(context, contact.message);
                } else if (contact is AddCompareStateSuccess) {
                  Utils.successSnackBar(context, contact.message);
                  Navigator.pop(context);
                }
              }
            },
          ),
          BlocListener<ReviewCubit, LanguageCodeState>(
            listener: (context, state) {
              final contact = state.reviewListState;
              if (contact is StoreReviewStateLoading) {
                Utils.loadingDialog(context);
              } else {
                Utils.closeDialog(context);
                if (contact is StoreReviewStateError) {
                  Utils.failureSnackBar(context, contact.message);
                } else if (contact is StoreReviewStateSuccess) {
                  Utils.successSnackBar(context, contact.message);
                }
              }
            },
          ),
        ],
        child: BlocConsumer<CarDetailsCubit, LanguageCodeState>(
            listener: (context, state) {
          final details = state.carDetailsState;
          if (details is CarDetailsStateError) {
            if (details.statusCode == 503 ||
                detailsCubit.detailsModel == null) {
              Utils.failureSnackBar(context, details.message);
              // detailsCubit.getCarDetails(widget.id);
            }
          }
        }, builder: (context, state) {
          final details = state.carDetailsState;
          if (details is CarDetailsStateLoading) {
            return const LoadingWidget();
          } else if (details is CarDetailsStateError) {
            return FetchErrorText(text: details.message);
          } else if (details is CarDetailsStateLoaded) {
            return LoadedDetailsData(
              data: details.carDetailsModel,
            );
          } else {
            return const FetchErrorText(text: "Something went wrong");
          }
        }),
      ),
      bottomNavigationBar: const ContactDealerWidget(),
    );
  }
}

class ContactDealerWidget extends StatefulWidget {
  const ContactDealerWidget({
    super.key,
  });

  @override
  State<ContactDealerWidget> createState() => _ContactDealerWidgetState();
}

class _ContactDealerWidgetState extends State<ContactDealerWidget> {
  late CarDetailsCubit detailsCubit;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    detailsCubit = context.read<CarDetailsCubit>();
  }

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController subjectController = TextEditingController();
  final TextEditingController messageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Utils.symmetric(h: 20.0, v: 10.0),
      child: PrimaryButton(
        text: Utils.translatedText(context, Language.contactDealer),
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return Dialog(
                  backgroundColor: whiteColor,
                  insetPadding: const EdgeInsets.symmetric(horizontal: 14.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: Utils.symmetric(v: 10.0, h: 0.0),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF3F7FC),
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          child: CustomText(
                            text: detailsCubit.detailsModel!.dealer!.name,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Padding(
                            padding: Utils.symmetric(v: 10.0),
                            child: Column(
                              children: [
                                CustomForm(
                                    label: Utils.translatedText(
                                        context, Language.name),
                                    child: TextFormField(
                                      controller: nameController,
                                      decoration: const InputDecoration(
                                        hintText: 'name',
                                      ),
                                      keyboardType: TextInputType.emailAddress,
                                    )),
                                Utils.verticalSpace(10.0),
                                CustomForm(
                                    label: Utils.translatedText(
                                        context, Language.email),
                                    child: TextFormField(
                                      controller: emailController,
                                      decoration: const InputDecoration(
                                        hintText: 'email',
                                      ),
                                      keyboardType: TextInputType.emailAddress,
                                    )),
                                Utils.verticalSpace(10.0),
                                CustomForm(
                                    label: Utils.translatedText(
                                        context, Language.subject),
                                    child: TextFormField(
                                      controller: subjectController,
                                      decoration: const InputDecoration(
                                        hintText: 'subject',
                                      ),
                                      keyboardType: TextInputType.emailAddress,
                                    )),
                                Utils.verticalSpace(10.0),
                                CustomForm(
                                    label: Utils.translatedText(
                                        context, Language.bookingNote),
                                    child: TextFormField(
                                      controller: messageController,
                                      decoration: const InputDecoration(
                                        hintText: 'Write something',
                                      ),
                                      maxLines: 4,
                                      keyboardType: TextInputType.emailAddress,
                                    )),
                                Utils.verticalSpace(20.0),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: Container(
                                        padding:
                                            Utils.symmetric(h: 50.0, v: 17.0),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          border: Border.all(color: redColor),
                                        ),
                                        child: const CustomText(text: "Cancel"),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        final body = {
                                          'message':
                                              messageController.text.trim(),
                                          'name': nameController.text.trim(),
                                          'email': emailController.text.trim(),
                                          'subject':
                                              subjectController.text.trim(),
                                        };
                                        context
                                            .read<ContactDealerCubit>()
                                            .contactDealer(
                                                detailsCubit
                                                    .detailsModel!.dealer!.id
                                                    .toString(),
                                                body);
                                        nameController.clear();
                                        emailController.clear();
                                        subjectController.clear();
                                        messageController.clear();
                                      },
                                      child: Container(
                                        padding:
                                            Utils.symmetric(h: 25.0, v: 17.0),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          color: primaryColor,
                                        ),
                                        child: CustomText(
                                          text: Utils.translatedText(
                                              context, Language.sendMessage),
                                          color: whiteColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Utils.verticalSpace(20.0),
                              ],
                            ))
                      ],
                    ),
                  ),
                );
              });
        },
      ),
    );
  }
}

class LoadedDetailsData extends StatefulWidget {
  const LoadedDetailsData({
    super.key,
    required this.data,
  });

  final CarDetailsModel data;

  @override
  State<LoadedDetailsData> createState() => _LoadedDetailsDataState();
}

class _LoadedDetailsDataState extends State<LoadedDetailsData> {
  final int initialPage = 1;
  int _currentIndex = 1;

  // bool isFavorite = false;
  // late WishlistCubit wishList;
  int _selectedRating = 0;

  final TextEditingController _loanAmountController = TextEditingController();
  final TextEditingController _interestRateController = TextEditingController();
  final TextEditingController _loanTermController = TextEditingController();

  TextEditingController reviewController = TextEditingController();
  TextEditingController reviewNumberController = TextEditingController();

  double _monthlyAmount = 0.0;
  double _totalInterest = 0.0;
  double _totalAmount = 0.0;

  late WebViewController controller;

  void initController() {
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..enableZoom(true);
  }

  String getVideoId(String id) {
    return "https://www.youtube.com/embed/$id";
  }

  @override
  void initState() {
    super.initState();
    initController();
    _controller = YoutubePlayerController(
      initialVideoId: widget.data.car!.videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );
    // Enable virtual display for WebView
  }

  void _calculateLoan() {
    final double loanAmount =
        double.tryParse(_loanAmountController.text) ?? 0.0;
    final double interestRate =
        double.tryParse(_interestRateController.text) ?? 0.0;
    final int loanTerm = int.tryParse(_loanTermController.text) ?? 0;

    if (loanAmount > 0 && interestRate > 0 && loanTerm > 0) {
      final double monthlyInterestRate = interestRate / 100 / 12;
      final int numberOfPayments = loanTerm * 12;

      setState(() {
        _monthlyAmount = loanAmount *
            monthlyInterestRate /
            (1 - pow(1 + monthlyInterestRate, -numberOfPayments));
        _totalAmount = _monthlyAmount * numberOfPayments;
        _totalInterest = _totalAmount - loanAmount;
      });
    }
  }

  void _resetLoanCalculator() {
    print("call");
    _loanAmountController.clear();
    _interestRateController.clear();
    _loanTermController.clear();
    setState(() {
      _monthlyAmount = 0.0;
      _totalInterest = 0.0;
      _totalAmount = 0.0;
    });
  }

  late YoutubePlayerController _controller;

  @override
  Widget build(BuildContext context) {
    print("video id: ${getVideoId(widget.data.car!.videoId)}");
    return Padding(
      padding: Utils.symmetric(),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                CarouselSlider(
                  options: CarouselOptions(
                    height: 210.0,
                    viewportFraction: 1.0,
                    initialPage: _currentIndex,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 3),
                    autoPlayAnimationDuration: const Duration(seconds: 1),
                    autoPlayCurve: Curves.easeInOut,
                    enlargeCenterPage: true,
                    onPageChanged: callbackFunction,
                    scrollDirection: Axis.horizontal,
                  ),
                  items: widget.data.galleries!.map((e) {
                    return Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0)),
                      //margin: Utils.symmetric(h: 10.0),
                      width: double.infinity,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: CustomImage(
                          path: RemoteUrls.imageUrl(e.image),
                          fit: BoxFit.cover,
                        ),
                        // child: Image.network(e.image),
                      ),
                    );
                  }).toList(),
                ),
                Positioned(
                    bottom: 10.0,
                    left: 0.0,
                    right: 0.0,
                    child: _buildDotIndicator()),
                Positioned(
                    left: 14.0,
                    top: 14.0,
                    child: Container(
                      padding: Utils.symmetric(h: 6.0, v: 2.5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.0),
                          color: primaryColor),
                      child: const CustomText(
                        text: "New",
                        color: whiteColor,
                        fontSize: 14.0,
                      ),
                    )),
              ],
            ),
            Utils.verticalSpace(20.0),
            if (widget.data.dealer != null)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: primaryColor,
                            ),
                            shape: BoxShape.circle),
                        child: CircleImage(
                            image: RemoteUrls.imageUrl(widget.data.dealer!.image),
                            size: 25.0),
                      ),
                      Utils.horizontalSpace(10.0),
                      CustomText(text: widget.data.dealer!.name, fontSize: 14.0),
                    ],
                  ),
                  CustomText(
                    text: widget.data.dealer!.address,
                    fontSize: 14.0,
                    maxLine: 1,
                  ),
                ],
              ),
            Utils.verticalSpace(8.0),
            CustomText(
              text: widget.data.car!.title,
              fontSize: 18.0,
              fontWeight: FontWeight.w500,
              maxLine: 2,
            ),
            Utils.verticalSpace(12.0),
            CustomText(
              text: Utils.formatAmount(context, widget.data.car!.regularPrice),
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: textColor,
            ),
            Utils.verticalSpace(20.0),
            CustomText(
              text: Utils.translatedText(context, Language.descriptionOverview),
              fontWeight: FontWeight.w500,
              fontSize: 16.0,
            ),
            Utils.verticalSpace(10.0),
            Utils.horizontalLine(),
            Utils.verticalSpace(10.0),
            ReadMoreText(
              Utils.htmlTextConverter(widget.data.car!.description),
              trimLength: 195,
              trimCollapsedText: 'View More',
              moreStyle: const TextStyle(
                  fontSize: 16.0, color: textColor, height: 1.6),
              lessStyle:
                  const TextStyle(fontSize: 16.0, color: redColor, height: 1.6),
              style: const TextStyle(
                fontSize: 14.0,
                color: blackColor,
              ),
            ),
            Utils.verticalSpace(16.0),
            CustomText(
              text: Utils.translatedText(context, Language.keyInformation),
              fontWeight: FontWeight.w500,
              fontSize: 16.0,
            ),
            Utils.verticalSpace(10.0),
            Utils.horizontalLine(),
            Utils.verticalSpace(10.0),
            Table(
              columnWidths: const {
                2: IntrinsicColumnWidth(), // For label column
                1: FlexColumnWidth(), // For value column
              },
              children: [
                _buildTableRow(
                  KImages.bodyType,
                  Utils.translatedText(context, Language.bodyType),
                  widget.data.car!.bodyType,
                ),
                _buildTableRow(
                  KImages.engineSize,
                  Utils.translatedText(context, Language.engineSize),
                  widget.data.car!.engineSize,
                ),
                _buildTableRow(
                  KImages.driver,
                  Utils.translatedText(context, Language.drive),
                  widget.data.car!.drive,
                ),
                _buildTableRow(
                    KImages.interiorColor,
                    Utils.translatedText(context, Language.exteriorColor),
                    widget.data.car!.exteriorColor),
                _buildTableRow(
                    KImages.calenderIcon,
                    Utils.translatedText(context, Language.year),
                    widget.data.car!.year),
                _buildTableRow(
                    KImages.condition,
                    Utils.translatedText(context, Language.condition),
                    widget.data.car!.condition),
                _buildTableRow(
                    KImages.mileage,
                    Utils.translatedText(context, Language.mileage),
                    widget.data.car!.mileage),
                _buildTableRow(
                    KImages.owners,
                    Utils.translatedText(context, Language.noOwners),
                    widget.data.car!.numberOfOwner),
                _buildTableRow(
                    KImages.fuelType,
                    Utils.translatedText(context, Language.fuelType),
                    widget.data.car!.fuelType),
                _buildTableRow(
                    KImages.transmission,
                    Utils.translatedText(context, Language.transmission),
                    widget.data.car!.transmission),
                _buildTableRow(
                    KImages.sellerType,
                    Utils.translatedText(context, Language.sellerType),
                    widget.data.car!.sellerType),
              ],
            ),
            Utils.verticalSpace(10.0),
            Stack(
              clipBehavior: Clip.none,
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: const CustomImage(
                      path: KImages.bannersImage,
                      fit: BoxFit.cover,
                      height: 196.0,
                      width: double.infinity,
                    )),
                Positioned(
                    top: 30.0,
                    left: 20.0,
                    right: 20.0,
                    child: Column(
                      children: [
                        CustomText(
                          text: Utils.translatedText(
                              context, Language.autoLoanCalculator),
                          fontWeight: FontWeight.w700,
                          fontSize: 16.0,
                          color: whiteColor,
                          textAlign: TextAlign.center,
                        ),
                        Utils.verticalSpace(10.0),
                        const CustomText(
                          text:
                              "Auto loan calculator simplifies payments, interest, and total cost estimation.",
                          fontSize: 14.0,
                          color: whiteColor,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    )),
                Positioned(
                  bottom: 16.0,
                  right: 80.0,
                  left: 80.0,
                  child: GestureDetector(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return StatefulBuilder(
                              builder: (context, setState) {
                                return Dialog(
                                  backgroundColor: whiteColor,
                                  insetPadding: const EdgeInsets.symmetric(
                                      horizontal: 14.0),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4.0),
                                  ),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Container(
                                          padding:
                                              Utils.symmetric(v: 10.0, h: 20.0),
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            color: const Color(0xFFF3F7FC),
                                            borderRadius:
                                                BorderRadius.circular(4.0),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              CustomText(
                                                text: Utils.translatedText(
                                                    context,
                                                    Language.loanCalculator),
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600,
                                                textAlign: TextAlign.center,
                                              ),
                                              GestureDetector(
                                                  onTap: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: const CustomImage(
                                                      path: KImages
                                                          .rounderClose)),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                            padding: Utils.symmetric(v: 10.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                CustomText(
                                                  text: Utils.translatedText(
                                                      context,
                                                      Language.loanCalculator),
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                                Utils.verticalSpace(10.0),
                                                const CustomText(
                                                  text:
                                                      "You can calculate monthly loan amount using this calculator",
                                                  maxLine: 2,
                                                ),
                                                Utils.verticalSpace(16.0),
                                                CustomForm(
                                                    label: "Loan Amount",
                                                    child: TextFormField(
                                                      keyboardType:
                                                          const TextInputType
                                                              .numberWithOptions(
                                                              decimal: true),
                                                      inputFormatters:
                                                          Utils.inputFormatter,
                                                      controller:
                                                          _loanAmountController,
                                                      decoration:
                                                          const InputDecoration(
                                                        prefixIcon: Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 10.0,
                                                                  right: 10.0),
                                                          child: CustomImage(
                                                            path: KImages
                                                                .coinDollar,
                                                            height: 28.0,
                                                          ),
                                                        ),
                                                        prefixIconConstraints:
                                                            BoxConstraints(
                                                          minWidth: 0,
                                                          minHeight: 0,
                                                        ),
                                                        hintText: 'amount here',
                                                      ),
                                                    )),
                                                Utils.verticalSpace(10.0),
                                                CustomForm(
                                                    label: "Interest Rate",
                                                    child: TextFormField(
                                                      controller:
                                                          _interestRateController,
                                                      keyboardType:
                                                          const TextInputType
                                                              .numberWithOptions(
                                                              decimal: true),
                                                      inputFormatters:
                                                          Utils.inputFormatter,
                                                      decoration:
                                                          const InputDecoration(
                                                        prefixIcon: Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 10.0,
                                                                  right: 10.0),
                                                          child: CustomImage(
                                                            path: KImages
                                                                .percentage,
                                                            height: 20.0,
                                                          ),
                                                        ),
                                                        prefixIconConstraints:
                                                            BoxConstraints(
                                                          minWidth: 0,
                                                          minHeight: 0,
                                                        ),
                                                        hintText:
                                                            'percentage here',
                                                      ),
                                                    )),
                                                Utils.verticalSpace(10.0),
                                                CustomForm(
                                                    label: "Loan Tern in Year",
                                                    child: TextFormField(
                                                      controller:
                                                          _loanTermController,
                                                      keyboardType:
                                                          const TextInputType
                                                              .numberWithOptions(
                                                              decimal: true),
                                                      inputFormatters:
                                                          Utils.inputFormatter,
                                                      decoration:
                                                          const InputDecoration(
                                                        prefixIcon: Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 10.0,
                                                                  right: 10.0),
                                                          child: CustomImage(
                                                            path: KImages
                                                                .calender,
                                                            height: 28.0,
                                                          ),
                                                        ),
                                                        prefixIconConstraints:
                                                            BoxConstraints(
                                                          minWidth: 0,
                                                          minHeight: 0,
                                                        ),
                                                        hintText:
                                                            'number of year',
                                                      ),
                                                    )),
                                                Utils.verticalSpace(20.0),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        const CustomImage(
                                                            path:
                                                                KImages.reset),
                                                        Utils.horizontalSpace(
                                                            4.0),
                                                        GestureDetector(
                                                          onTap: () {
                                                            setState(() {
                                                              _resetLoanCalculator();
                                                            });
                                                          },
                                                          child: const CustomText(
                                                              text:
                                                                  "Reset Now"),
                                                        ),
                                                      ],
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          _calculateLoan();
                                                        });
                                                      },
                                                      child: Container(
                                                        padding:
                                                            Utils.symmetric(
                                                                h: 40.0,
                                                                v: 12.0),
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.0),
                                                          color: const Color(
                                                              0xFFE9D634),
                                                        ),
                                                        child: const CustomText(
                                                          text:
                                                              "Loan Calculate",
                                                          color: whiteColor,
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                Utils.verticalSpace(20.0),
                                                Utils.horizontalLine(),
                                                Utils.verticalSpace(10.0),
                                                loanInfo(
                                                  text: "Monthly Amount",
                                                  amount: _monthlyAmount
                                                      .toStringAsFixed(2),
                                                ),
                                                loanInfo(
                                                  text: "Total Interest",
                                                  amount: _totalInterest
                                                      .toStringAsFixed(2),
                                                ),
                                                Utils.verticalSpace(10.0),
                                                Utils.horizontalLine(),
                                                Utils.verticalSpace(10.0),
                                                loanInfo(
                                                  text: "Total Amount",
                                                  amount: _totalAmount
                                                      .toStringAsFixed(2),
                                                ),
                                              ],
                                            ))
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          });
                    },
                    child: Container(
                      padding: Utils.symmetric(h: 26.0, v: 12.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: primaryColor),
                      child: CustomText(
                        text: Utils.translatedText(
                            context, Language.loanCalculator),
                        color: whiteColor,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Utils.verticalSpace(16.0),
            CustomText(
              text: Utils.translatedText(context, Language.features),
              fontWeight: FontWeight.w500,
              fontSize: 16.0,
            ),
            Utils.verticalSpace(10.0),
            Utils.horizontalLine(),
            Utils.verticalSpace(10.0),
            Column(
              children: [
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 8.0,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                  ),
                  itemCount:
                      Utils.parseJsonToString(widget.data.car!.features, false)
                          .length,
                  itemBuilder: (context, index) {
                    final featureId = Utils.parseJsonToString(
                        widget.data.car!.features, false)[index];
                    final feature = widget.data.features!.firstWhere(
                      (f) => f.id.toString() == featureId,
                      orElse: () => const Features(
                        id: 0,
                        createdAt: "",
                        updatedAt: "",
                        name: 'Unknown',
                      ),
                    );
                    return Row(
                      children: [
                        const CustomImage(path: KImages.done, height: 12.0),
                        Utils.horizontalSpace(12.0),
                        CustomText(
                          text: feature.name,
                          color: const Color(0xFF6B6C6C),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
            Utils.verticalSpace(16.0),
            CustomText(
              text: Utils.translatedText(context, Language.video),
              fontWeight: FontWeight.w500,
              fontSize: 16.0,
            ),
            Utils.verticalSpace(10.0),
            Utils.horizontalLine(),
            Utils.verticalSpace(16.0),
            const CustomText(
                text:
                    "It is a long established fact that a reader will our as be distracted by the readable content.",
                color: Color(0xFF6B6C6C)),
            Utils.verticalSpace(10.0),
            YoutubePlayer(
              controller: _controller,
              liveUIColor: Colors.amber,
            ),
            // SizedBox(
            //   height: 200.0,
            //   child: WebViewWidget(
            //     controller: controller..loadRequest(Uri.parse(getVideoId(widget.data.car!.videoId))),
            //   ),
            // ),

            Utils.verticalSpace(16.0),
            CustomText(
              text: Utils.translatedText(context, Language.location),
              fontWeight: FontWeight.w500,
              fontSize: 16.0,
            ),
            Utils.verticalSpace(10.0),
            Utils.horizontalLine(),
            Utils.verticalSpace(10.0),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomImage(path: KImages.locationIcon),
                Utils.horizontalSpace(6.0),
                Expanded(
                  child: CustomText(
                      text: widget.data.car!.address,
                      maxLine: 2,
                      color: Color(0xFF6B6C6C)),
                ),
              ],
            ),
            Utils.verticalSpace(10.0),
            GoogleMapView(
              googleMapHtml: widget.data.car!.googleMap,
            ),
            Utils.verticalSpace(20.0),
            CustomText(
              text: Utils.translatedText(context, Language.reviews),
              fontWeight: FontWeight.w500,
              fontSize: 16.0,
            ),
            Utils.verticalSpace(10.0),
            Utils.horizontalLine(),
            Utils.verticalSpace(10.0),
            if (widget.data.reviews!.isEmpty)
              const CustomText(
                text: "Review not found",
                fontSize: 16.0,
                textAlign: TextAlign.center,
                color: Colors.grey,
              )
            else
              ...List.generate(widget.data.reviews!.length, (index) {
                final review = widget.data.reviews![index];
                return ReviewCard(review: review);
              }),
            Utils.verticalSpace(6.0),
            Container(
              padding: Utils.symmetric(v: 20.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: const Color(0xFFF8FAFC),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: Utils.translatedText(context, Language.sendReviews),
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                  ),
                  Utils.verticalSpace(10.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: List.generate(5, (index) {
                          return IconButton(
                            icon: Icon(
                              index < _selectedRating
                                  ? Icons.star
                                  : Icons.star_border,
                              color: index < _selectedRating
                                  ? Colors.amber
                                  : Colors.grey,
                            ),
                            onPressed: () {
                              setState(() {
                                _selectedRating = index + 1;
                              });
                            },
                          );
                        }),
                      ),
                      Utils.verticalSpace(10.0),
                      TextFormField(
                        controller: reviewController,
                        maxLines: 4,
                        decoration: const InputDecoration(
                          hintText: 'Write Your Feedback',
                          fillColor: whiteColor,
                        ),
                        keyboardType: TextInputType.text,
                      ),
                      Utils.verticalSpace(10.0),
                      GestureDetector(
                        onTap: () {
                          if (Utils.isLoggedIn(context)) {
                            final comment = reviewController.text;
                            final rating = _selectedRating;
                            final body = {
                              'rating': rating.toString(),
                              'comment': comment,
                              'car_id': widget.data.car!.id.toString(),
                            };
                            context.read<ReviewCubit>().storeReview(body);
                            reviewController.clear();
                            _selectedRating = 0;
                          } else {
                            Utils.showSnackBarWithLogin(context);
                          }
                        },

                        // onTap: () {
                        //   final comment = reviewController.text;
                        //   final rating = _selectedRating;
                        //   final body = {
                        //     'rating': rating.toString(),
                        //     'comment': comment,
                        //     'car_id': widget.data.car!.id.toString(),
                        //   };
                        //   context.read<ReviewCubit>().storeReview(body);
                        //   reviewController.clear();
                        //   _selectedRating =0;
                        // },
                        child: Container(
                          padding: Utils.symmetric(h: 40.0, v: 12.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: const Color(0xFFE9D634),
                          ),
                          child: CustomText(
                            text: Utils.translatedText(
                                context, Language.submitNow),
                            color: whiteColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  TableRow _buildTableRow(String icon, String label, String value) {
    return TableRow(
      children: [
        Padding(
            padding: const EdgeInsets.symmetric(vertical: 6.0),
            child: Row(
              children: [
                CustomImage(path: icon),
                Utils.horizontalSpace(8.0),
                CustomText(
                  text: label,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: sTextColor,
                ),
              ],
            )),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 6.0),
          child: Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 14.0,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }

  void callbackFunction(int index, CarouselPageChangedReason reason) {
    setState(() {
      _currentIndex = index;
    });
  }

  Widget _buildDotIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        widget.data.galleries!.length,
        (index) {
          final i = _currentIndex == index;
          return AnimatedContainer(
            duration: const Duration(seconds: 1),
            height: Utils.vSize(6.0),
            width: Utils.hSize(i ? 24.0 : 6.0),
            margin: Utils.only(right: 4.0),
            decoration: BoxDecoration(
              color: i ? primaryColor : greyColor,
              borderRadius: BorderRadius.circular(i ? 50.0 : 5.0),
              //shape: i ? BoxShape.rectangle : BoxShape.circle,
            ),
          );
        },
      ),
    );
  }
}

class loanInfo extends StatelessWidget {
  const loanInfo({
    super.key,
    required this.text,
    required this.amount,
  });

  final String text;
  final String amount;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomText(
          text: text,
          color: Color(0xFF6B6C6C),
        ),
        CustomText(
          text: amount,
          fontWeight: FontWeight.w600,
          fontSize: 16.0,
          color: Color(0xFFE9D634),
        ),
      ],
    );
  }
}
