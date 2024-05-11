import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../exception/dio_exceptions.dart';

class ApiErrorInterceptor extends Interceptor {
  @override
  Future<void> onError(
      DioException err, ErrorInterceptorHandler handler) async {
    //TODO: need to be configured for api
    if (err.response != null &&
        err.response!.statusCode != null &&
        err.response!.statusCode! >= 400 &&
        err.response!.statusCode! < 500) {
      try {
        final response =
            json.decode(err.response.toString()) as Map<String, dynamic>;
        final message = response['message'] as String?;
        final code = response['code'] as String?;

        if (code != null) {
          return handler.reject(ApiCodeException(
            code: code,
            requestOptions: err.requestOptions,
            response: err.response,
            error: err.error,
            type: err.type,
          ));
        } else if (message != null) {
          return handler.reject(ApiMessageException(
            errorMessage: message,
            requestOptions: err.requestOptions,
            response: err.response,
            error: err.error,
            type: err.type,
          ));
        }
        return handler
            .reject(UnknownServerException(requestOptions: err.requestOptions));
      } catch (e) {
        handler.reject(
            InternalServerException(requestOptions: err.requestOptions));
      }
    }

    return handler.next(err);
  }
}
