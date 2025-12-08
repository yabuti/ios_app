import 'failure.dart';

/// ------------------- Server Exception -------------------
class ServerException implements Exception {
  final String message;
  final int statusCode;

  const ServerException(this.message, [this.statusCode = 404]);

  @override
  String toString() =>
      'ServerException(message: $message, statusCode: $statusCode)';
}

/// ------------------- Local Database Exception -------------------
class DatabaseException implements Exception {
  final String message;

  const DatabaseException(this.message);

  @override
  String toString() => 'DatabaseException(message: $message)';
}

/// ------------------- Specific Server Exceptions -------------------

/// Default fetch data exception
class FetchDataException extends ServerException {
  const FetchDataException(super.message, [super.statusCode = 666]);
}

/// Unsupported Media Type
class DataFormatException extends ServerException {
  const DataFormatException(super.message, [super.statusCode = 415]);
}

/// Bad Request (Client error)
class BadRequestException extends ServerException {
  const BadRequestException(super.message, [super.statusCode = 400]);
}

/// Unauthorized Access
class UnauthorisedException extends ServerException {
  const UnauthorisedException(super.message, [super.statusCode = 401]);
}

/// Invalid Input for Auth / Form
class InvalidInputException extends InvalidAuthData {
  const InvalidInputException(super.errors, [int statusCode = 400]);
}

/// Internal Server Error
class InternalServerException extends ServerException {
  const InternalServerException(super.message, [super.statusCode = 500]);
}

/// Network errors (connection issues)
class NetworkException extends ServerException {
  const NetworkException(super.message, [super.statusCode = 511]);
}

/// Unknown / Unhandled Exceptions
class UnknownException extends ServerException {
  const UnknownException(super.message, [super.statusCode = 500]);
}

/// Error converting objects to model
class ObjectToModelException extends ServerException {
  const ObjectToModelException(super.message, [super.statusCode = 600]);
}
