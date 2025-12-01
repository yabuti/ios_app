import 'package:blackdiamondcar/data/model/car/car_state_model.dart';
import 'package:blackdiamondcar/data/model/home/home_model.dart';
import 'package:dartz/dartz.dart';
import '../../data/data_provider/remote_data_source.dart';
import '../../data/model/car/car_create_data_model.dart';
import '../../data/model/car/create_model_response.dart';
import '../../data/model/car/getCarEditDataModel.dart';
import '../../presentation/errors/exception.dart';
import '../../presentation/errors/failure.dart';

abstract class UserCarListRepository {
  Future<Either<Failure, List<FeaturedCars>>> getCarList(Uri url);

  Future<Either<Failure, CarCreateDataModel>> getCarCreateData(Uri url);

  Future<Either<Failure, CarEditDataModel>> getCarEditData(Uri url);

  Future<Either<dynamic, CreateModelResponse>> addCars(
    CarsStateModel body,
    Uri url,
  );

  Future<Either<dynamic, CreateModelResponse>> updateBasicCar(
      CarsStateModel body,
      Uri url,
      );

  Future<Either<dynamic, CreateModelResponse>> keyFeatureUpdateCars(
      CarsStateModel body,
      Uri url,
      );

  Future<Either<dynamic, CreateModelResponse>> featureUpdateCars(
      CarsStateModel body,
      Uri url,
      );

  Future<Either<dynamic, CreateModelResponse>> addressUpdateCars(
      CarsStateModel body,
      Uri url,
      );

  Future<Either<dynamic, CreateModelResponse>> galleryUpdateCars(
      CarsStateModel body,
      Uri url,
      );

  Future<Either<Failure, String>> deleteCar(Uri url);
}

class UserCarListRepositoryImpl implements UserCarListRepository {
  final RemoteDataSources remoteDataSource;

  const UserCarListRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<FeaturedCars>>> getCarList(Uri url) async {
    try {
      // FIXED: Use correct method name
      final result = await remoteDataSource.getUserCarList(url);
      
      // DEBUG: Print the response
      print('🚗 CAR LIST API RESPONSE: $result');
      print('🚗 Response type: ${result.runtimeType}');
      print('🚗 Response keys: ${result is Map ? result.keys.toList() : "Not a map"}');
      
      // FIXED: Handle different response structures
      List<dynamic> carsList;
      
      // Check if response has nested structure
      if (result['cars'] != null && result['cars']['data'] != null) {
        // Structure: { "cars": { "data": [...] } }
        print('🚗 Using structure: cars.data');
        carsList = result['cars']['data'] as List;
      } else if (result['data'] != null) {
        // Structure: { "data": [...] }
        print('🚗 Using structure: data');
        carsList = result['data'] as List;
      } else if (result is List) {
        // Structure: [...]
        print('🚗 Using structure: direct array');
        carsList = result;
      } else {
        // Fallback: assume result is the list
        print('🚗 Using structure: fallback');
        carsList = result as List;
      }
      
      print('🚗 Cars list length: ${carsList.length}');
      
      final data = List<FeaturedCars>.from(
        carsList.map((e) => FeaturedCars.fromMap(e))
      ).toList();
      
      return Right(data);
    } on ServerException catch (e) {
      print('❌ CAR LIST SERVER ERROR: ${e.message} (${e.statusCode})');
      return Left(ServerFailure(e.message, e.statusCode));
    } catch (e, stackTrace) {
      // Catch any parsing errors
      print('❌ CAR LIST PARSING ERROR: $e');
      print('❌ Stack trace: $stackTrace');
      return Left(ServerFailure('Failed to parse car list: $e', 500));
    }
  }

  @override
  Future<Either<Failure, CarCreateDataModel>> getCarCreateData(Uri url) async {
    try {
      final result = await remoteDataSource.getCarCreateData(url);
      print('🚗 CAR CREATE DATA API RESPONSE: $result');
      print('🚗 Response type: ${result.runtimeType}');
      final data = CarCreateDataModel.fromMap(result);
      return Right(data);
    } on ServerException catch (e) {
      print('❌ CAR CREATE DATA SERVER ERROR: ${e.message} (${e.statusCode})');
      return Left(ServerFailure(e.message, e.statusCode));
    } catch (e, stackTrace) {
      print('❌ CAR CREATE DATA PARSING ERROR: $e');
      print('❌ Stack trace: $stackTrace');
      return Left(ServerFailure('Failed to parse car create data: $e', 500));
    }
  }


  @override
  Future<Either<Failure, CarEditDataModel>> getCarEditData(Uri url) async {
    try {
      final result = await remoteDataSource.getCarEditData(url);
      print('🚗 CAR EDIT DATA API RESPONSE: $result');
      print('🚗 Response type: ${result.runtimeType}');
      final data = CarEditDataModel.fromMap(result);
      return Right(data);
    } on ServerException catch (e) {
      print('❌ CAR EDIT DATA SERVER ERROR: ${e.message} (${e.statusCode})');
      return Left(ServerFailure(e.message, e.statusCode));
    } catch (e, stackTrace) {
      print('❌ CAR EDIT DATA PARSING ERROR: $e');
      print('❌ Stack trace: $stackTrace');
      return Left(ServerFailure('Failed to parse car edit data: $e', 500));
    }
  }

  @override
  Future<Either<Failure, CreateModelResponse>> addCars(
    CarsStateModel body,
    Uri url,
  ) async {
    try {
      final result = await remoteDataSource.addCar(body, url);
      final data = CreateModelResponse.fromMap(result);
      return Right(data);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    } on InvalidAuthData catch (e) {
      return Left(InvalidAuthData(e.errors));
    }
  }


  @override
  Future<Either<Failure, CreateModelResponse>> updateBasicCar(CarsStateModel body, Uri url,) async {
    try {
      final result = await remoteDataSource.updateBasicCar(body, url);
      final data = CreateModelResponse.fromMap(result);
      return Right(data);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    } on InvalidAuthData catch (e) {
      return Left(InvalidAuthData(e.errors));
    }
  }

  @override
  Future<Either<Failure, CreateModelResponse>> keyFeatureUpdateCars(CarsStateModel body, Uri url,) async {
    try {
      final result = await remoteDataSource.keyFeatureUpdateCar(body, url);
      final data = CreateModelResponse.fromMap(result);
      return Right(data);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    } on InvalidAuthData catch (e) {
      return Left(InvalidAuthData(e.errors));
    }
  }

  @override
  Future<Either<Failure, CreateModelResponse>> featureUpdateCars(CarsStateModel body, Uri url,) async {
    try {
      final result = await remoteDataSource.featureUpdateCar(body, url);
      final data = CreateModelResponse.fromMap(result);
      return Right(data);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    } on InvalidAuthData catch (e) {
      return Left(InvalidAuthData(e.errors));
    }
  }

  @override
  Future<Either<Failure, CreateModelResponse>> addressUpdateCars(CarsStateModel body, Uri url,) async {
    try {
      final result = await remoteDataSource.addressUpdateCar(body, url);
      final data = CreateModelResponse.fromMap(result);
      return Right(data);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    } on InvalidAuthData catch (e) {
      return Left(InvalidAuthData(e.errors));
    }
  }

  @override
  Future<Either<Failure, CreateModelResponse>> galleryUpdateCars(CarsStateModel body, Uri url,) async {
    try {
      final result = await remoteDataSource.galleryUpdateCar(body, url);
      final data = CreateModelResponse.fromMap(result);
      return Right(data);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    } on InvalidAuthData catch (e) {
      return Left(InvalidAuthData(e.errors));
    }
  }


  @override
  Future<Either<Failure, String>> deleteCar(Uri url) async {
    try {
      final result = await remoteDataSource.deleteCar(url);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }
}
