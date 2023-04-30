class AppException implements Exception {
  final int? statusCode;
  final String message;
  dynamic errors;

  AppException({required this.message, this.errors, this.statusCode}) : super();

  @override
  String toString() {
    return message;
  }
}

class FetchDataException extends AppException {
  FetchDataException({required String message, dynamic error, int? statusCode})
      : super(message: message, errors: error, statusCode: statusCode);
}

class BadRequestException extends AppException {
  BadRequestException({required String message, dynamic error, int? statusCode})
      : super(message: message, errors: error, statusCode: statusCode);
}

class ServerErrorException extends AppException {
  ServerErrorException({required String message, dynamic error, int? statusCode})
      : super(message: message, errors: error, statusCode: statusCode);
}

class UnauthorisedException extends AppException {
  UnauthorisedException({required String message, dynamic error, int? statusCode})
      : super(message: message, errors: error, statusCode: statusCode);
}

class InvalidInputException extends AppException {
  InvalidInputException({required String message, dynamic error, int? statusCode})
      : super(message: message, errors: error, statusCode: statusCode);
}

class ResourceNotFoundException extends AppException {
  ResourceNotFoundException({required String message, dynamic error, int? statusCode})
      : super(message: message, errors: error, statusCode: statusCode);
}

class NoInternetException extends AppException {
  NoInternetException({required String message, dynamic error, int? statusCode})
      : super(message: message, errors: error, statusCode: statusCode);
}

class ConnectionTimeout extends AppException {
  ConnectionTimeout() : super(message: 'Connection Timeout', statusCode: 0);
}

class ReceiveTimeout extends AppException {
  ReceiveTimeout() : super(message: 'Receive Timeout', statusCode: 0);
}
