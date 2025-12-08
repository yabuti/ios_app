import 'package:carsbnb/data/model/home/home_model.dart';
import 'package:dartz/dartz.dart';
import '../../data/data_provider/remote_data_source.dart';
import '../../presentation/errors/exception.dart';
import '../../presentation/errors/failure.dart';

abstract class WishlistRepository {
  Future<Either<Failure, List<FeaturedCars>>> getWishList(Uri url);

  Future<Either<Failure, String>> addWishList(Uri url);

  Future<Either<Failure, String>> removeWishList(Uri url);
}

class WishlistRepositoryImpl implements WishlistRepository {
  final RemoteDataSources remoteDataSource;

  const WishlistRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<FeaturedCars>>> getWishList(Uri url) async {
    try {
      final result = await remoteDataSource.getWishList(url);
      final wish = result['cars'] as List;
      
      // Filter out any cars that fail to parse
      final data = <FeaturedCars>[];
      for (var carData in wish) {
        try {
          final car = FeaturedCars.fromMap(carData);
          data.add(car);
        } catch (e) {
          // Skip cars that fail to parse (e.g., missing translations)
          print('Skipping car due to parse error: $e');
          continue;
        }
      }
      
      return Right(data);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    } catch (e) {
      return Left(ServerFailure('Failed to load wishlist: ${e.toString()}', 500));
    }
  }

  @override
  Future<Either<Failure, String>> addWishList(Uri url) async {
    try {
      final result = await remoteDataSource.addWishList(url);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, String>> removeWishList(Uri url) async {
    try {
      final result = await remoteDataSource.removeWishList(url);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }
}
