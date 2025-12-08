import 'package:dartz/dartz.dart';
import '../../data/data_provider/remote_data_source.dart';
import '../../data/model/auth/user_response_model.dart';
import '../../data/model/dashboard/dashboard_model.dart';
import '../../presentation/errors/exception.dart';
import '../../presentation/errors/failure.dart';

abstract class UserDashboardRepository {
  Future<Either<Failure, DashboardModel>> getUserDashboard(Uri url);
  Future<Either<Failure, User>> getProfileData(Uri url);
  Future<Either<Failure, User>> updateProfileInfo(User body, Uri url);
}

class UserDashboardRepositoryImpl implements UserDashboardRepository {
  final RemoteDataSources remoteDataSource;

  const UserDashboardRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, DashboardModel>> getUserDashboard(Uri url) async {
    try {
      final result = await remoteDataSource.getUserDashboard(url);
      final data = DashboardModel.fromMap(result);
      return Right(data);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, User>> getProfileData(Uri url) async {
    try {
      final result = await remoteDataSource.getProfileData(url); // fixed
      final data = User.fromMap(result['user']); // get user map
      return Right(data);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, User>> updateProfileInfo(User body, Uri url) async {
    try {
      final result = await remoteDataSource.updateProfile(body, url);

      // Assuming API returns JSON with 'user' key
      final data = User.fromMap(result['user']);
      return Right(data);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    } on InvalidAuthData catch (e) {
      return Left(InvalidAuthData(e.errors));
    }
  }
}
