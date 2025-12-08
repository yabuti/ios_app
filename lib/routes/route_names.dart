import 'package:carsbnb/data/model/home/home_model.dart';
import 'package:carsbnb/presentation/screen/authentication/forgot_password_otp.dart';
import 'package:carsbnb/presentation/screen/authentication/forgot_password_screen.dart';
import 'package:carsbnb/presentation/screen/authentication/new_password_screen.dart';
import 'package:carsbnb/presentation/screen/authentication/otp_screen.dart';
import 'package:carsbnb/presentation/screen/authentication/registration_screen.dart';
import 'package:carsbnb/presentation/screen/compare_screen/compare_screen.dart';
import 'package:carsbnb/presentation/screen/details_screen/components/booking_form.dart';
import 'package:carsbnb/presentation/screen/details_screen/details_screen.dart';
import 'package:carsbnb/presentation/screen/home/components/become_dealer_screen.dart';
import 'package:carsbnb/presentation/screen/home/components/brand_screen.dart';
import 'package:carsbnb/presentation/screen/home/home_screen.dart';
import 'package:carsbnb/presentation/screen/kyc/kyc_verify_screen.dart';
import 'package:carsbnb/presentation/screen/main_screen/main_screen.dart';
import 'package:carsbnb/presentation/screen/manage_car/add_car_screen.dart';
import 'package:carsbnb/presentation/screen/manage_car/manage_car_screen.dart';
import 'package:carsbnb/presentation/screen/more_screen/components/change_password.dart';
import 'package:carsbnb/presentation/screen/more_screen/components/contactus_screen.dart';
import 'package:carsbnb/presentation/screen/more_screen/components/language_screen.dart';
import 'package:carsbnb/presentation/screen/more_screen/components/privacy_policy_screen.dart';
import 'package:carsbnb/presentation/screen/more_screen/components/edit_profile_screen.dart';
import 'package:carsbnb/presentation/screen/more_screen/components/review_screen.dart';
import 'package:carsbnb/presentation/screen/more_screen/components/terms_condition_screen.dart';
import 'package:carsbnb/presentation/screen/payment/flutterwave_payment_screen.dart';
import 'package:carsbnb/presentation/screen/payment/instamojo_payment_screen.dart';
import 'package:carsbnb/presentation/screen/payment/mollie_payment_screen.dart';
import 'package:carsbnb/presentation/screen/payment/paySatck_payment_screen.dart';
import 'package:carsbnb/presentation/screen/payment/paypal_payment_screen.dart';
import 'package:carsbnb/presentation/screen/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import '../presentation/screen/authentication/login_screen.dart';
import '../presentation/screen/dealear_screen/all_dealer_screen.dart';
import '../presentation/screen/dealear_screen/dealer_profile_screen.dart';
import '../presentation/screen/kyc/kyc_view_screen.dart';
import '../presentation/screen/manage_car/components/purpose_select_screen.dart';
import '../presentation/screen/on_boarding/on_boarding_screen.dart';
import '../presentation/screen/payment/razorpay_payment_screen.dart';
import '../presentation/screen/splash_screen/splash_screen.dart';
import 'package:carsbnb/presentation/spare_parts/spare_parts_screen.dart';
import 'package:carsbnb/presentation/delivery/delivery_screen.dart';
import 'package:carsbnb/presentation/screen/all_car_screen/all_car_screen.dart'
    as all_car_screen_page;
import 'package:carsbnb/presentation/screen/pre_order/pre_order_screen.dart'
    as pre_order_page;

class RouteNames {
  static const String splashScreen = '/splashScreen';
  static const String onBoardingScreen = '/onBoardingScreen';
  static const String loginScreen = '/loginScreen';
  static const String registrationScreen = '/registrationScreen';
  static const String forgotPasswordScreen = '/forgotPasswordScreen';
  static const String otpScreen = '/otpScreen';
  static const String forgotPasswordOtpScreen = '/forgotPasswordOtpScreen';
  static const String newPasswordScreen = '/newPasswordScreen';
  static const String mainScreen = '/mainScreen';
  static const String dashboardScreen = '/dashboard';
  static const String registerScreen = '/register';
  static const String homeScreen = '/homeScreen';
  static const String allBrandScreen = '/allBrandScreen';
  static const String featureCarScreen = '/featureCarScreen';
  static const String allCarScreen = '/allCarScreen';
  static const String detailsCarScreen = '/detailsCarScreen';
  static const String bookingFormScreen = '/bookingFormScreen';
  static const String paymentScreen = '/paymentScreen';
  static const String becomeVendorScreen = '/becomeVendorScreen';
  static const String reviewScreen = '/reviewScreen';
  static const String editProfileScreen = '/editProfileScreen';
  static const String changePassword = '/changePassword';
  static const String privacyPolicyScreen = '/privacyPolicyScreen';
  static const String termsConditionScreen = '/termsConditionScreen';
  static const String manageCarScreen = '/manageCarScreen';
  static const String addCarScreen = '/addCarScreen';
  static const String profileScreen = '/profileScreen';
  static const String kycScreen = '/kycScreen';
  static const String kycViewScreen = '/kycViewScreen';
  static const String carDealer = '/carDealer';
  static const String dealerProfileScreen = '/dealerProfileScreen';
  static const String compareScreen = '/compareScreen';
  static const String contactScreen = '/contactScreen';
  static const String languageScreen = '/languageScreen';
  static const String purposeSelectScreen = '/purposeSelectScreen';
  static const String paypalPaymentScreen = '/paypalPaymentScreen';
  static const String razorpayPaymentScreen = '/razorpayPaymentScreen';
  static const String flutterWavePaymentScreen = '/flutterWavePaymentScreen';
  static const String payStackPaymentScreen = '/payStackPaymentScreen';
  static const String molliePaymentScreen = '/molliePaymentScreen';
  static const String instamojoPaymentScreen = '/instamojoPaymentScreen';
  static const String sparePartsScreen = '/spare-parts';
  static const String deliveryScreen = '/delivery';
  static const String preOrderScreen = '/preOrder';
  static Route<dynamic> generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.splashScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const SplashScreen());

      case RouteNames.onBoardingScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const OnBoardingScreen());

      case RouteNames.loginScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const LoginScreen());

      case RouteNames.registrationScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const RegistrationScreen());

      case RouteNames.forgotPasswordScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const ForgotPasswordScreen());

      case RouteNames.otpScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const OtpScreen());

      case RouteNames.forgotPasswordOtpScreen:
        return MaterialPageRoute(
            settings: settings,
            builder: (_) => const ForgotPasswordOtpScreen());

      case RouteNames.newPasswordScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const NewPasswordScreen());

      case RouteNames.mainScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const MainScreen());

      case RouteNames.homeScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const HomeScreen());

      case RouteNames.allBrandScreen:
        final brand = settings.arguments as List<Brands>;
        return MaterialPageRoute(
            settings: settings,
            builder: (_) => AllBrandScreen(
                  brands: brand,
                ));

      // case RouteNames.featureCarScreen:
      //   return MaterialPageRoute(
      //       settings: settings, builder: (_) => const FeatureCarScreen());
      case RouteNames.allCarScreen:
        return MaterialPageRoute(
            settings: settings,
            builder: (_) => const all_car_screen_page.AllCarScreen());
      case RouteNames.detailsCarScreen:
        final id = settings.arguments as String;
        return MaterialPageRoute(
            settings: settings,
            builder: (_) => DetailsCarScreen(
                  id: id,
                ));

      case RouteNames.bookingFormScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const BookingForm());

      case RouteNames.becomeVendorScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const BecomeVendorScreen());
      case dashboardScreen:
        return MaterialPageRoute(builder: (_) => const MainScreen());
      case registerScreen:
        return MaterialPageRoute(builder: (_) => const RegistrationScreen());
      case RouteNames.reviewScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const ReviewScreen());

      case RouteNames.editProfileScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const EditProfileScreen());

      case RouteNames.changePassword:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const ChangePassword());

      case RouteNames.privacyPolicyScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const PrivacyPolicyScreen());

      case RouteNames.termsConditionScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const TermsConditionScreen());

      case RouteNames.manageCarScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const ManageCarScreen());

      case RouteNames.addCarScreen:
        final id = settings.arguments as String;
        return MaterialPageRoute(
            settings: settings,
            builder: (_) => AddCarScreen(
                  id: id,
                ));

      case RouteNames.purposeSelectScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const PurposeSelectScreen());

      case RouteNames.profileScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const ProfileScreen());

      case RouteNames.kycScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const KycVerificationScreen());

      case RouteNames.kycViewScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const KycViewScreen());

      case RouteNames.carDealer:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const AllDealerScreen());

      case RouteNames.dealerProfileScreen:
        final name = settings.arguments as String;
        return MaterialPageRoute(
            settings: settings,
            builder: (_) => DealerProfileScreen(
                  userName: name,
                ));
      case RouteNames.sparePartsScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const SparePartsScreen());

      case RouteNames.deliveryScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const DeliveryScreen());
      case RouteNames.preOrderScreen:
        return MaterialPageRoute(
            settings: settings,
            builder: (_) => const pre_order_page.PreOrderScreen());

      case RouteNames.compareScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const CompareScreen());

      case RouteNames.contactScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const ContactusScreen());

      case RouteNames.languageScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const LanguageScreen());

      case RouteNames.paypalPaymentScreen:
        final url = settings.arguments as String;
        return MaterialPageRoute(
            settings: settings, builder: (_) => PaypalScreen(url: url));

      case RouteNames.razorpayPaymentScreen:
        final url = settings.arguments as String;
        return MaterialPageRoute(
            settings: settings, builder: (_) => RazorpayScreen(url: url));

      case RouteNames.flutterWavePaymentScreen:
        final url = settings.arguments as String;
        return MaterialPageRoute(
            settings: settings, builder: (_) => FlutterWaveScreen(url: url));

      case RouteNames.payStackPaymentScreen:
        final url = settings.arguments as String;
        return MaterialPageRoute(
            settings: settings,
            builder: (_) => PaystackPaymentScreen(url: url));

      case RouteNames.molliePaymentScreen:
        final url = settings.arguments as String;
        return MaterialPageRoute(
            settings: settings, builder: (_) => MolliePaymentScreen(url: url));

      case RouteNames.instamojoPaymentScreen:
        final url = settings.arguments as String;
        return MaterialPageRoute(
            settings: settings,
            builder: (_) => InstamojoPaymentScreen(url: url));

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No Route Found ${settings.name}'),
            ),
          ),
        );
    }
  }
}
