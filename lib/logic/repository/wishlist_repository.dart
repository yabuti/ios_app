import 'package:blackdiamondcar/data/model/home/home_model.dart';
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
      final data =
          List<FeaturedCars>.from(wish.map((e) => FeaturedCars.fromMap(e)))
              .toList();
      return Right(data);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
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
