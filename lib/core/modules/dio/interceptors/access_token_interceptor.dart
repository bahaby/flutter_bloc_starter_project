import 'package:dio/dio.dart';
import 'package:dio_refresh/dio_refresh.dart';

class AccessTokenInterceptor extends Interceptor {
  final TokenManager _tokenManager;

  AccessTokenInterceptor(this._tokenManager);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final token = _tokenManager.accessToken;

    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    super.onRequest(options, handler);
  }
}
