import 'package:blackdiamondcar/data/model/review/review_list_model.dart';
import 'package:blackdiamondcar/data/model/termsCo/terms_condition_model.dart';
import 'package:dartz/dartz.dart';
import '../../data/data_provider/remote_data_source.dart';
import '../../presentation/errors/exception.dart';
import '../../presentation/errors/failure.dart';

abstract class ReviewRepository {
  Future<Either<Failure, List<ReviewListModel>>> getAllReview(Uri url);

  // Future<Either<dynamic, String>> submitKycVerify(
  //     Uri url,
  //     KycSubmitStateModel data,
  //     );

  Future<Either<Failure, TermsModel>> getTermsCondition(String langCode);

  Future<Either<Failure, TermsModel>> getPrivacyPolicy(String langCode);

  Future<Either<Failure, String>> storeReview(
      Uri url, Map<String, dynamic> body);

}

class ReviewRepositoryImpl implements ReviewRepository {
  final RemoteDataSources remoteDataSource;

  const ReviewRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<ReviewListModel>>> getAllReview(Uri url) async {
    try {
      final result = await remoteDataSource.getAllReview(url);
      final wish = result['reviews'] as List;
      final data = List<ReviewListModel>.from(
          wish.map((e) => ReviewListModel.fromMap(e))).toList();
      return Right(data);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  // @override
  // Future<Either<dynamic, String>> submitKycVerify(
  //     Uri url,
  //     KycSubmitStateModel data,
  //     ) async {
  //   try {
  //     final result = await remoteDataSource.submitKycVerify(url, data);
  //     return Right(result);
  //   } on ServerException catch (e) {
  //     return Left(ServerFailure(e.message, e.statusCode));
  //   } on InvalidAuthData catch (e) {
  //     return Left(InvalidAuthData(e.errors));
  //   }
  // }

  @override
  Future<Either<Failure, TermsModel>> getTermsCondition(String langCode) async {
    try {
      final result = await remoteDataSource.getTermsCondition(langCode);
      final data = TermsModel.fromMap(result['terms_condition']);
      return Right(data);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, TermsModel>> getPrivacyPolicy(String langCode) async {
    try {
      final result = await remoteDataSource.getPrivacyPolicy(langCode);
      final data = TermsModel.fromMap(result['privacy_policy']);
      return Right(data);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, String>> storeReview(
      Uri url, Map<String, dynamic> body) async {
    try {
      final result = await remoteDataSource.storeReview(url,body);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    } on InvalidAuthData catch (e) {
      return Left(InvalidAuthData(e.errors));
    }
  }

}
