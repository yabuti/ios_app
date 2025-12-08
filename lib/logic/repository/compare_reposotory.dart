
import 'package:carsbnb/data/model/compare/compare_list_model.dart';
import 'package:dartz/dartz.dart';
import '../../data/data_provider/remote_data_source.dart';
import '../../presentation/errors/exception.dart';
import '../../presentation/errors/failure.dart';

abstract class CompareRepository {

  Future<Either<Failure, CompareListModel>> getCompareList(Uri url);

  Future<Either<Failure, String>> addCompareList(
      Uri url, Map<String, dynamic> body);

  Future<Either<Failure, String>> removeCompareList(Uri url);
}

class CompareRepositoryImpl implements CompareRepository {
  final RemoteDataSources remoteDataSource;

  const CompareRepositoryImpl({required this.remoteDataSource});


  @override
  Future<Either<Failure, CompareListModel>> getCompareList(Uri url) async {
    try {
      final result = await remoteDataSource.getCompareList(url);
      final data = CompareListModel.fromMap(result);
      return Right(data);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }


  @override
  Future<Either<Failure, String>> addCompareList(
      Uri url, Map<String, dynamic> body) async {
    try {
      final result = await remoteDataSource.addCompareList(url,body);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    } on InvalidAuthData catch (e) {
      return Left(InvalidAuthData(e.errors));
    }
  }

  @override
  Future<Either<Failure, String>> removeCompareList(Uri url) async {
    try {
      final result = await remoteDataSource.removeCompareList(url);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

}
