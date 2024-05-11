import 'package:dio/dio.dart';
import 'exceptions.dart';

class BadNetworkException extends DioException with TranslatableException {
  BadNetworkException({required super.requestOptions});
  @override
  String get translationKey => 'core.errors.others.noInternetConnection';
}

class InternalServerException extends DioException with TranslatableException {
  InternalServerException({required super.requestOptions});

  @override
  String get translationKey => 'core.errors.others.serverFailure';
}

class UnknownServerException extends DioException with TranslatableException {
  UnknownServerException({required super.requestOptions});

  @override
  String get translationKey => 'core.errors.others.anUnknownError';
}

class UnauthorizedException extends DioException with TranslatableException {
  UnauthorizedException({required super.requestOptions});

  @override
  String get translationKey => 'core.errors.others.unauthorized';
}

class InvalidJsonFormatException extends DioException
    with TranslatableException {
  InvalidJsonFormatException({required super.requestOptions});

  @override
  String get translationKey => 'core.errors.others.communicationError';
}

class ApiCodeException extends DioException implements TranslatableException {
  ApiCodeException({
    required this.code,
    required super.requestOptions,
    super.response,
    super.error,
    super.type,
  });
  final String code;

  @override
  String get translationKey => 'core.apiErrorCodes.c$code';
}

class ApiMessageException extends DioException {
  ApiMessageException({
    required this.errorMessage,
    required super.requestOptions,
    super.response,
    super.error,
    super.type,
  });

  final String errorMessage;
}
