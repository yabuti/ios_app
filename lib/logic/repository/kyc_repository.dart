
import 'package:blackdiamondcar/data/model/kyc/kyc_model.dart';
import 'package:dartz/dartz.dart';
import '../../data/data_provider/remote_data_source.dart';
import '../../data/model/kyc/kyc_submit_state_model.dart';
import '../../presentation/errors/exception.dart';
import '../../presentation/errors/failure.dart';

abstract class KycRepository {

  Future<Either<Failure, KYCModel>> getKycInfo(Uri url);

  Future<Either<dynamic, String>> submitKycVerify(
      Uri url,
      KycSubmitStateModel data,
      );

}

class KycRepositoryImpl implements KycRepository {
  final RemoteDataSources remoteDataSource;

  const KycRepositoryImpl({required this.remoteDataSource});


  @override
  Future<Either<Failure, KYCModel>> getKycInfo(Uri url) async {
    try {
      final result = await remoteDataSource.getKycInfo(url);
      final data = KYCModel.fromMap(result);
      return Right(data);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }


  @override
  Future<Either<dynamic, String>> submitKycVerify(
      Uri url,
      KycSubmitStateModel data,
      ) async {
    try {
      final result = await remoteDataSource.submitKycVerify(url, data);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    } on InvalidAuthData catch (e) {
      return Left(InvalidAuthData(e.errors));
    }
  }

}
