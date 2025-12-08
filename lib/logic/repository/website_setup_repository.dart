import 'package:dartz/dartz.dart';

import '../../data/data_provider/local_data_source.dart';
import '../../data/data_provider/remote_data_source.dart';
import '../../data/model/website_model/website_model.dart';
import '../../presentation/errors/exception.dart';
import '../../presentation/errors/failure.dart';

abstract class WebsiteSetupRepository {
  Future<Either<Failure, WebsiteModel>> getWebsiteSetupData(Uri uri);

   //Either<Failure, WebsiteModel> getCatchWebsiteSetupData();
  //
  Either<Failure, bool> checkOnBoarding();

  Future<Either<Failure, bool>> cachedOnBoarding();
}

class WebsiteSetupRepositoryImpl implements WebsiteSetupRepository {
  final RemoteDataSources remoteDataSource;
  final LocalDataSources localDataSource;

  const WebsiteSetupRepositoryImpl(
      {required this.remoteDataSource,
        required this.localDataSource
      });

  @override
  Future<Either<Failure, WebsiteModel>> getWebsiteSetupData(Uri uri) async {
    try {
      final result = await remoteDataSource.getWebsiteSetup(uri);
      final data = WebsiteModel.fromMap(result);
      return Right(data);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  // @override
  // Either<Failure, WebsiteModel> getCatchWebsiteSetupData() {
  //   try {
  //     final result = localDataSource.getCatchWebsiteSetupData();
  //     return Right(result);
  //   } on DatabaseException catch (e) {
  //     return Left(DatabaseFailure(e.message));
  //   }
  // }

  @override
  Future<Either<Failure, bool>> cachedOnBoarding() async {
    try {
      final result = await localDataSource.cachedOnBoarding();
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }

  @override
  Either<Failure, bool> checkOnBoarding() {
    try {
      return Right(localDataSource.checkOnBoarding());
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }
}