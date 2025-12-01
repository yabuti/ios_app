part of 'currency_cubit.dart';

abstract class CurrencyState extends Equatable {
  const CurrencyState();

  @override
  List<Object> get props => [];
}

class CurrencyInitial extends CurrencyState {
  const CurrencyInitial();
}

class CurrenciesLoad extends CurrencyState {
  final List<CurrencyList> currencies;

  const CurrenciesLoad(this.currencies);

  @override
  List<Object> get props => [currencies];
}

class CurrencyRealtimeLoading extends CurrencyState {}
class CurrencyRealtimeError extends CurrencyState {
  final String message;
  final int statusCode;

  const CurrencyRealtimeError(this.message,this.statusCode);

  @override
  List<Object> get props => [message,statusCode];
}
class CurrencyRealtimeLoaded extends CurrencyState {
  final double currency;

  const CurrencyRealtimeLoaded(this.currency);

  @override
  List<Object> get props => [currency];
}


// class LanguageLoad extends CurrencyState {
//   final List<LanguageListModel> languages;
//
//   const LanguageLoad(this.languages);
//
//   @override
//   List<Object> get props => [languages];
// }
