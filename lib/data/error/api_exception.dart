// ignore_for_file: use_super_parameters
class CustomException implements Exception{
  final String message;
  final bool result;

  const CustomException(this.result,this.message);
}

class ServerException implements Exception {
  final String message;

  final int statusCode;

  const ServerException(this.message, [this.statusCode = 404]);
}

///local database exception
class DatabaseException implements Exception {
  final String message;

  const DatabaseException(this.message);

  @override
  String toString() => 'DatabaseException(message: $message)';
}

/// default exception
class FetchDataException extends ServerException {
  const FetchDataException(String message, [int statusCode = 666])
      : super(message, statusCode);
}

///Unsupported Media Type
class DataFormatException extends ServerException {
  const DataFormatException(String message, [int statusCode = 415])
      : super(message, statusCode);
}

/// The server cannot or will not process the request due to an apparent
/// ///client error (e.g., malformed request syntax, size too large,
/// invalid request message framing, or deceptive request routing
class BadRequestException extends ServerException {
  const BadRequestException(String message, [int statusCode = 400])
      : super(message, statusCode);
}

class UnauthorisedException extends ServerException {
  const UnauthorisedException(String message, [int statusCode = 401])
      : super(message, statusCode);
}

class InvalidInputException extends ServerException {
  const InvalidInputException(String message, [int statusCode = 400])
      : super(message, statusCode);
}

class InternalServerException extends ServerException {
  const InternalServerException(String message, [int statusCode = 500])
      : super(message, statusCode);
}

class NetworkException extends ServerException {
  const NetworkException(String message, [int statusCode = 511])
      : super(message, statusCode);
}

class UnknownException extends ServerException {
  const UnknownException(String message, [int statusCode = 500])
      : super(message, statusCode);
}

class DataNotFoundException extends ServerException {
  const DataNotFoundException(String message, [int statusCode = 210])
      : super(message, statusCode);
}

class ServerResponseException extends ServerException {
  const ServerResponseException(String message, [int statusCode = 201])
      : super(message, statusCode);
}

class ObjectToModelException extends ServerException {
  const ObjectToModelException(String message, [int statusCode = 600])
      : super(message, statusCode);
}