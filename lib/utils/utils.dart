import 'dart:async';
import 'dart:convert';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:carsbnb/data/model/booking_history/booking_history_model.dart';
import 'package:carsbnb/data/model/subscription/transaction_model.dart';
import 'package:carsbnb/data/model/website_model/website_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:html/parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../data/model/auth/login_state_model.dart';
import '../logic/bloc/login/login_bloc.dart';
import '../logic/cubit/currency/currency_cubit.dart';
import '../logic/cubit/website_setup/website_setup/website_setup_cubit.dart';
import '../routes/route_names.dart';
import '../widgets/custom_text.dart';
import 'constraints.dart';

class Utils {

  static Uri tokenWithCodePage(
      String url, String token, String langCode, String page) {
    return Uri.parse('$url?').replace(
        queryParameters: {'token': token, 'lang_code': langCode, "page": page});
  }

  static Uri tokenWithCode(String url, String token, String langCode) {
    return Uri.parse('$url?')
        .replace(queryParameters: {'token': token, 'lang_code': langCode});
  }

  static Uri onlyCode(String url,  String langCode) {
    return Uri.parse('$url?')
        .replace(queryParameters: { 'lang_code': langCode});
  }

  static Uri tokenWithQuery(String url, String token, String langCode,
      {Map<String, dynamic>? extraParams}) {
    final baseUri = Uri.parse('$url?');
    final queryParams = {
      'token': token,
      'lang_code': langCode,
      ...extraParams!,
    };
    return baseUri.replace(queryParameters: queryParams);
  }

  static List<TextInputFormatter> inputFormatter = [
    FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,4}$'))
  ];


  // static Uri tokenWithCodeSearch(
  //     String url, String page, String brand, String location, String search, String langCode, List<String> carTypes, ) {
  //   return Uri.parse('$url?').replace(
  //       queryParameters: {"page": page, "brand": brand, "location": location, "search":search, 'lang_code': langCode,},
  //
  //
  //   );
  // }
  static Uri tokenWithCodeSearch(
      String url,
      String page,
      String brand,
      String location,
      String countryId,
      String search,
      String langCode,
      List<String> feature, // Change the type to List<String>
      List<String> purpose,
      List<String> condition,
      ) {
    // Map query parameters, including the car types
    final queryParams = {
      "page": page,
      "brand": brand,
      "country_id": countryId,
      "location": location,
      "search": search,
      "lang_code": langCode,
    };

    // Add features to the query parameters if it's not empty
    if (feature.isNotEmpty) {
      for (int i = 0; i < feature.length; i++) {
        queryParams["features[$i]"] = feature[i]; // Use the feature directly
      }
    }

    if (purpose.isNotEmpty) {
      for (int i = 0; i < purpose.length; i++) {
        queryParams["purpose[$i]"] = purpose[i];
      }
    }

    if (condition.isNotEmpty) {
      for (int i = 0; i < condition.length; i++) {
        queryParams["condition[$i]"] = condition[i];
      }
    }

    return Uri.parse('$url?').replace(queryParameters: queryParams);
  }


  static Uri dealerWithCodeSearch(
      String url,
      String page,
      String location,
      String search,
      String langCode,
      ) {
    // Map query parameters, including the car types
    final queryParams = {
      "page": page,
      "location": location,
      "search": search,
      "lang_code": langCode,
    };
    return Uri.parse('$url?').replace(queryParameters: queryParams);
  }



  static FutureOr logoutFunction(BuildContext context)  {
    context.read<LoginBloc>().add(const LoginEventLogout());
  }


  static Widget logout({required Widget child}) {
    return BlocListener<LoginBloc, LoginStateModel>(
      listener: (context, state) {
        final logout = state.loginState;
        if (logout is LoginStateLogoutLoading) {
          Utils.loadingDialog(context);
        } else {
          Utils.closeDialog(context);
          if (logout is LoginStateLogoutError) {
            Utils.errorSnackBar(context, logout.message);
          } else if (logout is LoginStateLogoutLoaded) {
            Utils.showSnackBar(context, logout.message);
            Navigator.pushNamedAndRemoveUntil(
              context,
              RouteNames.loginScreen,
                  (route) => false,
            );
          }
        }
      },
      child: child,
    );
  }



  static bool isLoggedIn(BuildContext context) {
    final login = context.read<LoginBloc>();
    if(login.userInformation != null){
      return true;
    }else{
      return false;
    }
  }

  static void showSnackBarWithLogin(BuildContext context, [String? msg,Color textColor = whiteColor]) {
    final snackBar = SnackBar(
      duration: const Duration(milliseconds: 1600),
      content: CustomText(text: Utils.translatedText(context, msg??'Please login first'), color: textColor),
      action: SnackBarAction(
        label: Utils.translatedText(context, 'Login'),
        onPressed: (){
          Navigator.pushNamedAndRemoveUntil(
            context,
            RouteNames.loginScreen,
                (route) => false,
          );
        },
      ),
    );
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }



  static String convertToSlug(String input) {
    return input.toLowerCase().replaceAll(RegExp(r'[^a-zA-Z\d]+'), '-');
  }

  static List<dynamic> parseJsonToString(String? text, [bool isTags = true]) {
    List tags = [];

    if (text != null && text.isNotEmpty) {
      if (isTags) {
        List<dynamic> parsedJson = jsonDecode(text);
        tags = parsedJson.map((tag) => tag['value']).toList();
       // print(tags);
      } else {
        List<dynamic> parsedJson = jsonDecode(text);
        tags = parsedJson.map((tag) => tag).toList();
        //print(tags);
      }
    }
    return tags;
  }


  static bool _isDialogShowing(BuildContext context) {
    return ModalRoute.of(context)?.isCurrent != true;
  }

  static void closeDialog(BuildContext context) {
    if (_isDialogShowing(context)) {
      Navigator.of(context, rootNavigator: true).pop();
    }
  }

  //   static bool _isDialogShowing(BuildContext context) =>
  //     ModalRoute.of(context)?.isCurrent != true;
  // static void closeDialog(BuildContext context) {
  //   if (_isDialogShowing(context)) {
  //     Navigator.pop(context);
  //   }
  // }

  static void loadingDialog(
      BuildContext context, {
        bool barrierDismissible = false,
      }) {
    // closeDialog(context);
    showCustomDialog(
      context,
      child: Container(
        height: 120,
        padding: const EdgeInsets.all(20),
        child: const Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(color: primaryColor),
              SizedBox(width: 15),
              Text('Please wait a moment')
            ],
          ),
        ),
      ),
      barrierDismissible: barrierDismissible,
    );
  }


  static Future showCustomDialog(
      BuildContext context, {
        Widget? child,
        bool barrierDismissible = false,
        Color bgColor = whiteColor,
      }) {
    return showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: bgColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: child,
        );
      },
    );
  }

  static Future<String?> pickSingleImage() async {
    final ImagePicker picker = ImagePicker();
    // Pick an image
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      return image.path;
    }
    return null;
  }

  static Future<List<String?>> pickMultipleImage() async {
    final ImagePicker picker = ImagePicker();
    final List<String> imageList = [];
    final List<XFile?> images = await picker.pickMultiImage();
    if (images.isNotEmpty) {
      // imageList.addAll(images);
      //  return images.map((e) => imageList.add(e!.path)).toList();
      for (var i in images) {
        imageList.add(i!.path.toString());
      }
      debugPrint('picked images: ${imageList.length}');
      return imageList;
    }
    return [];
  }

  static Size mediaQuery(BuildContext context) => MediaQuery.of(context).size;

  static Widget verticalSpace(double size) {
    return SizedBox(height: size.h);
  }

  static Widget horizontalSpace(double size) {
    return SizedBox(width: size.w);
  }

  static double hSize(double size) {
    return size.w;
  }

  static double vSize(double size) {
    return size.h;
  }

  static Widget horizontalLine(){
   return Container(
      height: 1,
      width: double.infinity,
      color: const Color(0xFFEEF2F6),
    );
  }



  static EdgeInsets only({
    double left = 0.0,
    double top = 0.0,
    double right = 0.0,
    double bottom = 0.0,
  }) {
    return EdgeInsets.only(
        left: left.w, top: top.h, right: right.w, bottom: bottom.h);
  }

  static BorderRadius borderRadius({double r = 10.0}) {
    return BorderRadius.circular(Utils.radius(r));
  }

  static EdgeInsets all({double value = 0.0}) {
    return EdgeInsets.all(value.dm);
  }

  static double vPadding({double size = 20.0}) {
    return size.h;
  }

  static double hPadding({double size = 20.0}) {
    return size.w;
  }

  static EdgeInsets symmetric({double h = 20.0, v = 0.0}) {
    return EdgeInsets.symmetric(
        horizontal: Utils.hPadding(size: h), vertical: Utils.vPadding(size: v));
  }

  static double radius(double radius) {
    return radius.sp;
  }

  static void closeKeyBoard(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  static String htmlTextConverter(String text) {
    var document = parse(text);
    String convertedText = parse(document.body!.text).documentElement!.text;
    return convertedText;
  }


  static String formatRelativeTime(String timestamp) {
    // Parse the timestamp into a DateTime object
    DateTime dateTime = DateTime.parse(timestamp);

    dateTime = dateTime.toLocal();
    // Get the current time
    DateTime now = DateTime.now();

    // Format the relative time
    return timeago.format(dateTime, locale: 'en'); // You can change the locale if needed
  }

  static String formatDateTime(String timestamp) {
    // Parse the timestamp into a DateTime object
    DateTime dateTime = DateTime.parse(timestamp);

    // Format the date and time
   // String formattedDate = DateFormat('yyyy-MM-dd').format(dateTime); // Example: 2024-11-20
      String formattedDate = DateFormat('MMM dd yyyy').format(dateTime); // Example: Mar 03 2024
    String formattedTime = DateFormat('hh:mm a').format(dateTime);   // Example: 09:16 AM

    return formattedDate;
  }


  // static String formatAmount(BuildContext context, var price, [int radix = 1]) {
  //   // final cCubit = context.read<CurrencyCubit>();
  //   // final sCubit = context.read<SettingCubit>();
  //   // if (cCubit.state.currencies.isNotEmpty) {
  //   //   return Utils.convertCurrency(
  //   //       price, context, cCubit.state.currencies.first, radix);
  //   // } else {
  //   //   if (sCubit.settingModel != null &&
  //   //       sCubit.settingModel!.setting.currencyIcon.isNotEmpty) {
  //   //     String currency = sCubit.settingModel!.setting.currencyIcon;
  //   //     final p = price.toString();
  //   //     return '$currency$p';
  //   //   } else {
  //   //     final p = price.toString();
  //   //     return '\$$p';
  //   //   }
  //   return '\$$price';
  // }
  static String priceSeparator(double value, {String locale = 'en_US', String symbol = '', int radix = 2}) {
    try {
      final formatter = NumberFormat.currency(
        locale: locale,
        symbol: symbol,
        decimalDigits: radix,
      );
      return formatter.format(value);
    } catch (e) {
      return value.toStringAsFixed(radix);
    }
  }

  static String convertCurrency(BuildContext context, var price, CurrencyList c, [int radix = 2]) {

    final cCubit = context.read<CurrencyCubit>();
    final newCurrency = c.currencyRate;
    // final newCurrency = cCubit.state.currencyRate != 0.0?cCubit.state.currencyRate: c.currencyRate;
    // debugPrint('new-currency-rate $newCurrency');
    if (c.status.toLowerCase() == 'active' && (c.currencyPosition.toLowerCase() == 'after_price')) {
      if (price is double) {
        final result = price * newCurrency;
        return '${priceSeparator(result, symbol: '', radix: radix)}${c.currencyIcon}';
      }
      if (price is String) {
        final r = double.tryParse(price) ?? 0.0;
        final p = r * newCurrency;
        return '${priceSeparator(p, symbol: '', radix: radix)}${c.currencyIcon}';
      }
      if (price is int) {
        final p = price * newCurrency;
        return '${priceSeparator(p, symbol: '', radix: radix)}${c.currencyIcon}';
      } else {
        final p = price * newCurrency;
        return '${priceSeparator(p, symbol: '', radix: radix)}${c.currencyIcon}';
      }
    } else {
      if (price is double) {
        final result = price * newCurrency;
        return '${c.currencyIcon}${priceSeparator(result, symbol: '', radix: radix)}';
      }
      if (price is String) {
        final r = double.tryParse(price) ?? 0.0;
        final p = r * newCurrency;
        return '${c.currencyIcon}${priceSeparator(p, symbol: '', radix: radix)}';
      }
      if (price is int) {
        final p = price * newCurrency;
        return '${c.currencyIcon}${priceSeparator(p, symbol: '', radix: radix)}';
      }
      final p = price * newCurrency;
      return '${c.currencyIcon}${priceSeparator(p, symbol: '')}';
    }
  }

  static String formatAmount(BuildContext context, var price, [int radix = 2]) {
    final cCubit = context.read<CurrencyCubit>();
    final appSetting = context.read<WebsiteSetupCubit>();

    if (cCubit.state.currencies.isNotEmpty) {
      return Utils.convertCurrency(context, price, cCubit.state.currencies.first, radix);
    } else if (appSetting.setting?.setting != null) {
      const currency = '\$';
      // final currency = appSetting.settingModel?.setting?.currencyIcon ?? '\$';
      if (price is double) {
        return priceSeparator(price, symbol: currency, radix: radix);
      }
      if (price is String) {
        final parsedPrice = double.tryParse(price) ?? 0.0;
        return priceSeparator(parsedPrice, symbol: currency, radix: radix);
      }
      if (price is int) {
        return priceSeparator(price.toDouble(), symbol: currency, radix: radix);
      }
      return priceSeparator(0.0, symbol: currency, radix: radix);
    }
    // Fallback option with a default currency symbol
    else {
      const currency = '\$';
      if (price is double) {
        return priceSeparator(price, symbol: currency, radix: radix);
      }
      if (price is String) {
        final parsedPrice = double.tryParse(price) ?? 0.0;
        return priceSeparator(parsedPrice, symbol: currency, radix: radix);
      }
      if (price is int) {
        return priceSeparator(price.toDouble(), symbol: currency, radix: radix);
      }
      return priceSeparator(0.0, symbol: currency, radix: radix);
    }
  }



  static String translatedText(BuildContext context, String key,
      [bool lower = false]) {
    final webSetting = context.read<WebsiteSetupCubit>().setting;
    if (lower == true) {
      if (webSetting != null && webSetting.language![key] != null) {
        return webSetting.language![key]!.toLowerCase();
      } else {
        return key.toLowerCase();
      }
    } else {
      if (webSetting != null && webSetting.language![key] != null) {
        return '${webSetting.language![key]}';
      } else {
        return key;
      }
    }
  }

  static void showSnackBar(BuildContext context, String msg,
      [Color textColor = whiteColor]) {
    final snackBar = SnackBar(
        duration: const Duration(milliseconds: 1200),
        content: Text(msg, style: TextStyle(color: textColor)));
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  static Future<bool?> errorSnackBar(BuildContext context, String msg,
      [Color bgColor = redColor,
        ToastGravity gravity = ToastGravity.BOTTOM]) async {
    return Fluttertoast.showToast(
      msg: msg,
      backgroundColor: bgColor,
      fontSize: 16.0,
      textColor: whiteColor,
      gravity: gravity,
      toastLength: Toast.LENGTH_LONG,
    );
  }


  static void warningSnackBar (BuildContext context,String message){
    final snackBar =   SnackBar(
      /// need to set following properties for best effect of awesome_snackbar_content
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: 'Warning!',
        message:message,
        contentType: ContentType.warning,
      ),
    );
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  static void failureSnackBar (BuildContext context,String message){
    final snackBar =   SnackBar(
      /// need to set following properties for best effect of awesome_snackbar_content
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: 'Oh Hey!!',
        message:message,
        contentType: ContentType.failure,
      ),
    );
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  static void successSnackBar (BuildContext context,String message){
    final snackBar =   SnackBar(
      /// need to set following properties for best effect of awesome_snackbar_content
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: 'Oh Hey!!',
        message:message,
        contentType: ContentType.success,
      ),
    );
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }




  static Color bookingBgColor(BookingHistoryModel book) {
    switch (book.status) {
      case 0 || 3 || 4:
        return const Color(0xFFFBEBEB);
      case 1 || 2 || 5 || 6:
        return const Color(0xFFE9FFF9);
      default:
        return transparent;
    }
  }


  static Color bookingTextColor(BookingHistoryModel book) {
    switch (book.status) {
      case 0 || 3 || 4:
        return const Color(0xFFFF3838);
      case 1 || 2 || 5 || 6:
        return const Color(0xFF00C194);
      default:
        return transparent;
    }
  }



  static String bookingText(BuildContext context, BookingHistoryModel book) {
    switch (book.status) {
      case 0:
        return Utils.translatedText(context, 'Awaiting');
      case 1 :
        return Utils.translatedText(context, 'Accepted');
      case 2 :
        return Utils.translatedText(context, 'Completed');
      case 3 :
        return Utils.translatedText(context, 'Cancel by user');
      case 4 :
        return Utils.translatedText(context, 'Cancel by dealer');
      case 5 :
        return Utils.translatedText(context, 'Refunded');
      case 6 :
        return Utils.translatedText(context, 'On Way');
      default:
        return 'Nothing';
    }
  }


  static Color transactionColor(TransactionModel transaction) {
    switch (transaction.status) {
      case "active":
        return const Color(0xFFE5FFF3);
      case "expired":
        return const Color(0xFFFFE8E8);
      case "pending":
        return  const Color(0xFFF7CB73);
      default:
        return transparent;
    }
  }

  static Color transactionTextColor(TransactionModel transaction) {
    switch (transaction.status) {
      case "active":
        return const Color(0xFF00C065);
      case "expired":
        return const Color(0xFFEE3536);
      case "pending":
        return const Color(0xFFE9FFF9);
      default:
        return transparent;
    }
  }

  static String transactionText(BuildContext context,TransactionModel transaction) {
    switch (transaction.status) {
      case "active":
        return Utils.translatedText(context, 'Active');
      case "expired":
        return Utils.translatedText(context, 'Expired');
      case "pending":
        return Utils.translatedText(context, 'Pending');
      default:
        return 'Nothing';
    }
  }

}
