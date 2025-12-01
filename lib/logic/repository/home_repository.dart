import 'package:dartz/dartz.dart';
import '../../data/data_provider/remote_data_source.dart';
import '../../data/model/home/home_model.dart';
import '../../data/model/cars_details/car_details_model.dart';
import '../../data/model/home/dealer_details_model.dart';
import '../../data/model/home/home_model.dart' as home_city;
import '../../data/model/search_attribute/search_attribute_model.dart'
    as search_attr;
import '../../presentation/errors/exception.dart';
import '../../presentation/errors/failure.dart';

abstract class HomeRepository {
  Future<Either<Failure, HomeModel>> getHomeData(String langCode);
  Future<Either<Failure, CarDetailsModel>> carDetails(
      String langCode, String id);
  Future<Either<Failure, DealerDetailsModel>> dealerDetails(
      String langCode, String userName);
  Future<Either<Failure, List<FeaturedCars>>> getAllCarList(Uri url);
  Future<Either<Failure, List<Dealers>>> getAllDealerList(Uri url);
  Future<Either<Failure, search_attr.SearchAttributeModel>> getSearchAttribute(
      Uri url);
  Future<Either<Failure, home_city.CityModel>> getDealerCity(Uri url);
  Future<Either<Failure, String>> contactDealer(
      String langCode, String id, Map<String, dynamic> body);
  Future<Either<Failure, String>> contactMessage(
      String langCode, Map<String, dynamic> body);
  Future<Either<Failure, String>> submitPreOrder({
    required String name,
    required String phone,
    required String deliveryDate,
    required String type,
    String? userMessage,
    int? carId,
    int? cityId,
    int? countryId,
  });
  Future<Either<Failure, List<String>>> getSparePartCategories();
}

class HomeRepositoryImpl implements HomeRepository {
  final RemoteDataSources remoteDataSource;

  const HomeRepositoryImpl({required this.remoteDataSource});

  Either<Failure, T> _handleException<T>(dynamic e) {
    if (e is ServerException) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
    return Left(GenericFailure(e.toString()));
  }

  @override
  Future<Either<Failure, HomeModel>> getHomeData(String langCode) async {
    try {
      final result = await remoteDataSource.getHomeData(langCode);
      return Right(HomeModel.fromMap(result));
    } catch (e) {
      return _handleException<HomeModel>(e);
    }
  }

  @override
  Future<Either<Failure, CarDetailsModel>> carDetails(
      String langCode, String id) async {
    try {
      final result = await remoteDataSource.getCarsDetails(langCode, id);
      
      // Handle the response structure - API returns {"car": {...}}
      // Create a minimal CarDetailsModel with just the car data
      final carDetailsMap = {
        'car': result['car'],
        'galleries': result['galleries'] ?? [],
        'car_features': result['car_features'] ?? [],
        'related_listings': result['related_listings'] ?? [],
        'dealer': result['dealer'],
        'reviews': result['reviews'] ?? [],
        'total_dealer_rating': result['total_dealer_rating'] ?? 0,
        'average_rating': result['average_rating'] ?? 0.0,
        'cities': result['cities'] ?? [],
        'bookedDates': result['bookedDates'] ?? [],
        'min_booking_date': result['min_booking_date'] ?? 0,
      };
      
      return Right(CarDetailsModel.fromMap(carDetailsMap));
    } catch (e) {
      return _handleException<CarDetailsModel>(e);
    }
  }

  @override
  Future<Either<Failure, DealerDetailsModel>> dealerDetails(
      String langCode, String userName) async {
    try {
      final result =
          await remoteDataSource.getDealerDetails(langCode, userName);
      return Right(DealerDetailsModel.fromMap(result));
    } catch (e) {
      return _handleException<DealerDetailsModel>(e);
    }
  }

  @override
  Future<Either<Failure, List<FeaturedCars>>> getAllCarList(Uri url) async {
    try {
      final result = await remoteDataSource.getAllCarsList(url);
      final cars = result['cars']['data'] as List;
      return Right(cars.map((e) => FeaturedCars.fromMap(e)).toList());
    } catch (e) {
      return _handleException<List<FeaturedCars>>(e);
    }
  }

  @override
  Future<Either<Failure, List<Dealers>>> getAllDealerList(Uri url) async {
    try {
      final result = await remoteDataSource.getAllDealerList(url);
      final dealers = result['dealers']['data'] as List;
      return Right(dealers.map((e) => Dealers.fromMap(e)).toList());
    } catch (e) {
      return _handleException<List<Dealers>>(e);
    }
  }

  @override
  Future<Either<Failure, search_attr.SearchAttributeModel>> getSearchAttribute(
      Uri url) async {
    try {
      final result = await remoteDataSource.getSearchAttribute(url);
      return Right(search_attr.SearchAttributeModel.fromMap(result));
    } catch (e) {
      return _handleException<search_attr.SearchAttributeModel>(e);
    }
  }

  @override
  Future<Either<Failure, home_city.CityModel>> getDealerCity(Uri url) async {
    try {
      final result = await remoteDataSource.getDealerCity(url);
      return Right(home_city.CityModel.fromMap(result));
    } catch (e) {
      return _handleException<home_city.CityModel>(e);
    }
  }

  @override
  Future<Either<Failure, String>> contactDealer(
      String langCode, String id, Map<String, dynamic> body) async {
    try {
      final result = await remoteDataSource.contactDealer(langCode, id, body);
      return Right(result);
    } catch (e) {
      return _handleException<String>(e);
    }
  }

  @override
  Future<Either<Failure, String>> contactMessage(
      String langCode, Map<String, dynamic> body) async {
    try {
      final result = await remoteDataSource.contactMessage(langCode, body);
      return Right(result);
    } catch (e) {
      return _handleException<String>(e);
    }
  }

  @override
  Future<Either<Failure, String>> submitPreOrder({
    required String name,
    required String phone,
    required String deliveryDate,
    required String type,
    String? userMessage,
    int? carId,
    int? cityId,
    int? countryId,
  }) async {
    try {
      final result = await remoteDataSource.submitPreOrder(
        name: name,
        phone: phone,
        deliveryDate: deliveryDate,
        type: type,
        userMessage: userMessage,
        carId: carId,
        cityId: cityId,
        countryId: countryId,
      );
      return Right(result);
    } catch (e) {
      return _handleException<String>(e);
    }
  }

  @override
  Future<Either<Failure, List<String>>> getSparePartCategories() async {
    try {
      final result = await remoteDataSource.getSparePartCategories();
      return Right(result);
    } catch (e) {
      return _handleException<List<String>>(e);
    }
  }
}

class GenericFailure extends Failure {
  const GenericFailure(super.message);
}
