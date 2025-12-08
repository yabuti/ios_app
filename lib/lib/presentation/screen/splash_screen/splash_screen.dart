import 'package:carsbnb/logic/cubit/website_setup/website_setup/website_setup_cubit.dart';
import 'package:carsbnb/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../logic/bloc/internet_status/internet_status_bloc.dart';
import '../../../logic/bloc/login/login_bloc.dart';
import '../../../routes/route_names.dart';
import '../../../utils/k_images.dart';
import '../../../widgets/custom_image.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final loginBloc = context.read<LoginBloc>();
    final settingCubit = context.read<WebsiteSetupCubit>();
    return Scaffold(
      body: MultiBlocListener(
        listeners: [
          BlocListener<InternetStatusBloc, InternetStatusState>(
            listener: (context, state) {
              if (state is InternetStatusBackState) {
                settingCubit.getWebsiteSetupData(loginBloc.state.languageCode);
              } else if (state is InternetStatusLostState) {
                debugPrint('no internet');
                Utils.showSnackBar(context, state.message);
              }
            },
          ),
          BlocListener<WebsiteSetupCubit, WebsiteSetupState>(
            listener: (context, state) {
              if (state is WebsiteSetupLoaded) {
                final setting = state.websiteSetup;
                final languages = setting!.languageList;
                final currencies = setting.currencyList;

                ///temporary language code store
                if (languages!.isNotEmpty) {
                  for (int i = 0; i < languages.length; i++) {
                    final defaultLanguage = languages[i].isDefault;
                    if (defaultLanguage.toLowerCase() == 'yes') {
                      final langCode = languages[i].langCode;
                      loginBloc.add(LoginEventLanguageCode(langCode));
                    }
                  }
                } else {
                  loginBloc.add(const LoginEventLanguageCode('en'));
                }

                ///temporary currency icon store
                if (currencies!.isNotEmpty) {
                  for (int i = 0; i < currencies.length; i++) {
                    final defaultCurrency = currencies[i].isDefault;
                    if (defaultCurrency.toLowerCase() == 'yes') {
                      final currencyCode = currencies[i].currencyIcon;
                      loginBloc.add(LoginEventCurrencyIcon(currencyCode));
                    }
                  }
                } else {
                  loginBloc.add(const LoginEventCurrencyIcon('\$'));
                }

                ///navigating routes
                if (loginBloc.isLoggedIn) {
                  Navigator.pushNamedAndRemoveUntil(
                      context, RouteNames.mainScreen, (route) => false);
                } else if (settingCubit.showOnBoarding) {
                  Navigator.pushNamedAndRemoveUntil(
                      context, RouteNames.loginScreen, (route) => false);
                } else {
                  Navigator.pushNamedAndRemoveUntil(
                      context, RouteNames.onBoardingScreen, (route) => false);
                }
              } else if (state is WebsiteSetupError) {
                Utils.errorSnackBar(context, state.message);
              }
            },
          ),
        ],
        child: _splashWidget(),
      ),
    );
  }

  Widget _splashWidget() {
    return const Center(
      child: SizedBox(
        // height: double.infinity,
        // width: double.infinity,
        child: CustomImage(
          path: KImages.appLogo,
          fit: BoxFit.cover,
          height: 150,
          width: 150,
        ),
      ),
    );
  }
}
