import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import '../../data/data_provider/local_data_source.dart';
import '../../data/data_provider/remote_data_source.dart';
import '../../data/model/auth/login_state_model.dart';
import '../../data/model/auth/register_state_model.dart';
import '../../data/model/auth/user_response_model.dart';
import '../../presentation/errors/exception.dart';
import '../../presentation/errors/failure.dart';
import '../cubit/forgot_password/forgot_password_state_model.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserResponseModel>> login(LoginStateModel body);
  Future<Either<Failure, String>> logout(Uri uri);
  Either<Failure, UserResponseModel> getExistingUserInfo();

  Future<Either<Failure, String>> signUp(RegisterStateModel body);
  Future<Either<Failure, String>> verifyRegOtp(RegisterStateModel body);
  Future<Either<Failure, String>> forgotPassword(PasswordStateModel body);
  Future<Either<Failure, String>> forgotOtpVerify(PasswordStateModel body);
  Future<Either<Failure, String>> setResetPassword(PasswordStateModel body);
  Future<Either<Failure, String>> updatePassword(
      PasswordStateModel body, Uri url);
}

class AuthRepositoryImpl implements AuthRepository {
  final RemoteDataSources remoteDataSources;
  final LocalDataSources localDataSources;

  AuthRepositoryImpl({
    required this.remoteDataSources,
    required this.localDataSources,
  });

  /// LOGIN
  @override
  Future<Either<Failure, UserResponseModel>> login(LoginStateModel body) async {
    try {
      final result =
          await remoteDataSources.login(body); // returns Map<String, dynamic>
      
      debugPrint('📱 Auth Repository - Login result: $result');
      
      // Handle if response is wrapped in 'data' field (common in Laravel APIs)
      final responseData = result['data'] ?? result;
      
      debugPrint('📱 Auth Repository - Parsing response data');
      
      final response = UserResponseModel.fromMap(
        responseData is Map<String, dynamic> ? responseData : result,
      );

      debugPrint('📱 Auth Repository - User parsed successfully: ${response.user.name}');

      // Cache user data locally
      localDataSources.cacheUserResponse(response);

      debugPrint('📱 Auth Repository - Login complete');

      return Right(response);
    } on InvalidAuthData catch (e) {
      debugPrint('❌ Auth Repository - Invalid auth data: ${e.errors}');
      return Left(InvalidAuthData(e.errors));
    } on ServerException catch (e) {
      debugPrint('❌ Auth Repository - Server exception: ${e.message}');
      return Left(ServerFailure(e.message, e.statusCode));
    } catch (e, stackTrace) {
      debugPrint('❌ Auth Repository - Unexpected error: $e');
      debugPrint('Stack trace: $stackTrace');
      return Left(ServerFailure('Unexpected error: $e', 500));
    }
  }

  /// GET EXISTING USER DATA
  @override
  Either<Failure, UserResponseModel> getExistingUserInfo() {
    try {
      final result = localDataSources.getExistingUserInfo();
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }

  /// LOGOUT
  @override
  Future<Either<Failure, String>> logout(Uri uri) async {
    try {
      final logout = await remoteDataSources.logout(uri);
      localDataSources.clearUserResponse();
      return Right(logout['message'] ?? 'Logout successful');
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    } catch (e) {
      return Left(ServerFailure('Unexpected error: $e', 500));
    }
  }

  /// SIGN UP / REGISTRATION
  @override
  Future<Either<Failure, String>> signUp(RegisterStateModel body) async {
    try {
      debugPrint('📝 Calling registration API...');
      final result = await remoteDataSources.register(body);
      debugPrint('📝 Registration API response: $result');
      final message = result['message'] ?? 'Registration successful';
      debugPrint('📝 Returning success with message: $message');
      return Right(message);
    } on InvalidAuthData catch (e) {
      debugPrint('❌ Registration validation error: ${e.errors}');
      return Left(InvalidAuthData(e.errors));
    } on ServerException catch (e) {
      debugPrint('❌ Registration server error: ${e.message}');
      return Left(ServerFailure(e.message, e.statusCode));
    } catch (e) {
      debugPrint('❌ Registration unexpected error: $e');
      return Left(ServerFailure('Unexpected error: $e', 500));
    }
  }

  @override
  Future<Either<Failure, String>> verifyRegOtp(RegisterStateModel body) async {
    try {
      final result = await remoteDataSources.otpVerify(body);
      return Right(result['message'] ?? 'OTP verified successfully');
    } on InvalidAuthData catch (e) {
      return Left(InvalidAuthData(e.errors));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    } catch (e) {
      return Left(ServerFailure('Unexpected error: $e', 500));
    }
  }

  @override
  Future<Either<Failure, String>> forgotPassword(
      PasswordStateModel body) async {
    try {
      final result = await remoteDataSources.forgotPassword(body);
      return Right(result['message'] ?? 'OTP sent');
    } on InvalidAuthData catch (e) {
      return Left(InvalidAuthData(e.errors));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    } catch (e) {
      return Left(ServerFailure('Unexpected error: $e', 500));
    }
  }

  @override
  Future<Either<Failure, String>> forgotOtpVerify(
      PasswordStateModel body) async {
    try {
      final result = await remoteDataSources.forgotOtpVerify(body);
      return Right(result['message'] ?? 'OTP verified');
    } on InvalidAuthData catch (e) {
      return Left(InvalidAuthData(e.errors));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    } catch (e) {
      return Left(ServerFailure('Unexpected error: $e', 500));
    }
  }

  @override
  Future<Either<Failure, String>> setResetPassword(
      PasswordStateModel body) async {
    try {
      final result = await remoteDataSources.setResetPassword(body);
      return Right(result['message'] ?? 'Password reset successfully');
    } on InvalidAuthData catch (e) {
      return Left(InvalidAuthData(e.errors));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    } catch (e) {
      return Left(ServerFailure('Unexpected error: $e', 500));
    }
  }

  @override
  Future<Either<Failure, String>> updatePassword(
      PasswordStateModel body, Uri url) async {
    try {
      final result = await remoteDataSources.updatePassword(body, url);
      return Right(result['message'] ?? 'Password updated successfully');
    } on InvalidAuthData catch (e) {
      return Left(InvalidAuthData(e.errors));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    } catch (e) {
      return Left(ServerFailure('Unexpected error: $e', 500));
    }
  }
}
