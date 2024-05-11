import 'package:dio/dio.dart';

import '../../../exception/dio_exceptions.dart';

class UnauthorizedInterceptor extends Interceptor {
  @override
  Future<void> onError(
      DioException err, ErrorInterceptorHandler handler) async {
    if (err.response != null &&
        err.response!.statusCode != null &&
        err.response!.statusCode! == 403) {
      return handler.reject(
        UnauthorizedException(requestOptions: err.requestOptions),
      );
    }

    return handler.next(err);
  }
}
