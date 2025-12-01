import 'package:blackdiamondcar/data/model/website_model/website_model.dart';
import 'package:blackdiamondcar/logic/cubit/website_setup/website_setup/website_setup_cubit.dart';
import 'package:blackdiamondcar/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../logic/bloc/login/login_bloc.dart';
import '../../../../logic/cubit/currency/currency_cubit.dart';
import '../../../../utils/utils.dart';
import '../../../../widgets/custom_form.dart';
import '../../../../widgets/custom_text.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  late WebsiteSetupCubit wCubit;
  late CurrencyCubit cCubit;
  late LoginBloc loginBloc;
  LanguageList? _languageList;
  CurrencyList? _currencyList;

  @override
  void initState() {
    super.initState();
    wCubit = context.read<WebsiteSetupCubit>();
    cCubit = context.read<CurrencyCubit>();
    loginBloc = context.read<LoginBloc>();

    // Set initial values for language and currency
    if (wCubit.setting != null) {
      _languageList = wCubit.setting!.languageList!.firstWhere(
        (lang) => lang.langCode == loginBloc.state.languageCode,
        orElse: () => wCubit.setting!.languageList!.first,
      );
      _currencyList = wCubit.setting!.currencyList!.firstWhere(
        (currency) => currency.currencyCode == cCubit.state.currencyCode,
        orElse: () => wCubit.setting!.currencyList!.first,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Language & Currency"),
      body: Padding(
        padding: Utils.symmetric(),
        child: Column(
          children: [
            BlocBuilder<WebsiteSetupCubit, WebsiteSetupState>(
              builder: (context, state) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (wCubit.setting != null &&
                        wCubit.setting!.languageList!.isNotEmpty)
                      CustomForm(
                        label: 'Language',
                        bottomSpace: 14.0,
                        child: DropdownButtonFormField<LanguageList>(
                          hint: const CustomText(text: "Language"),
                          isDense: true,
                          isExpanded: true,
                          value: _languageList,
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
                          onChanged: (value) {
                            if (value == null) return;
                            setState(() {
                              _languageList = value;
                            });

                            loginBloc.add(LoginEventLanguageCode(value.langCode));

                            if (value.langCode != loginBloc.state.languageCode) {
                              // cCubit.clearLanguage();
                              cCubit.addNewLanguage(value);
                              loginBloc.add(LoginEventLanguageCode(value.langCode));
                              context.read<WebsiteSetupCubit>().getWebsiteSetupData(value.langCode);

                              // websiteCubit.loadWebSetting(cCubit.state.languages.first.langCode);
                              // context.read<CreateInfoCubit>().getCreateInfo('sale',cCubit.state.languages.first.langCode);
                              // context.read<HomeCubit>().getHomeData(cCubit.state.languages.first.langCode);

                            }

                          },
                          items: wCubit.setting!.languageList!
                              .map<DropdownMenuItem<LanguageList>>(
                                (LanguageList value) =>
                                    DropdownMenuItem<LanguageList>(
                                  value: value,
                                  child: CustomText(text: value.langName),
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
            BlocBuilder<WebsiteSetupCubit, WebsiteSetupState>(
              builder: (context, state) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (wCubit.setting != null &&
                        wCubit.setting!.currencyList!.isNotEmpty)
                      CustomForm(
                        label: 'Currency',
                        bottomSpace: 14.0,
                        child: DropdownButtonFormField<CurrencyList>(
                          hint: const CustomText(text: "Currency"),
                          isDense: true,
                          isExpanded: true,
                          value: _currencyList,
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
                          onChanged: (value) {
                            if (value == null) return;
                            setState(() {
                              _currencyList = value;
                            });
                            cCubit
                              ..clearCurrency()
                              ..addNewCurrency(value)
                              ..getRealtimeCurrency();
                          },
                          items: wCubit.setting!.currencyList!
                              .map<DropdownMenuItem<CurrencyList>>(
                                (CurrencyList value) =>
                                    DropdownMenuItem<CurrencyList>(
                                  value: value,
                                  child: CustomText(text: value.currencyName),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
