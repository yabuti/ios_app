import 'package:carsbnb/data/model/withdraw/withdraw_model.dart';
import 'package:dartz/dartz.dart';
import '../../data/data_provider/remote_data_source.dart';
import '../../presentation/errors/exception.dart';
import '../../presentation/errors/failure.dart';

abstract class WithdrawRepository {
  Future<Either<Failure, List<WithdrawModel>>> getWithdrawList(Uri url);
}

class WithdrawRepositoryImpl implements WithdrawRepository {
  final RemoteDataSources remoteDataSource;

  const WithdrawRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<WithdrawModel>>> getWithdrawList(Uri url) async {
    try {
      final result = await remoteDataSource.getUserWithdraw(url);
      final wish = result['withdraws']['data'] as List;
      final data =
          List<WithdrawModel>.from(wish.map((e) => WithdrawModel.fromMap(e)))
              .toList();
      return Right(data);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }
}
