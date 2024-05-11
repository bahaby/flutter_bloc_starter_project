import 'package:dio/dio.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

import '../../../exception/dio_exceptions.dart';

class BadNetworkErrorInterceptor extends Interceptor {
  final InternetConnection networkInfo;

  BadNetworkErrorInterceptor(this.networkInfo);

  @override
  Future<void> onError(
      DioException err, ErrorInterceptorHandler handler) async {
    if (err.response == null && !await networkInfo.hasInternetAccess) {
      return handler.reject(
        BadNetworkException(
          requestOptions: err.requestOptions,
        ),
      );
    }

    return handler.next(err);
  }

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    return handler.next(options);
  }
}
