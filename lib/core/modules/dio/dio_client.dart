import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc_starter_project/core/modules/dio/interceptors/access_token_interceptor.dart';
import 'package:flutter_bloc_starter_project/core/modules/dio/interceptors/refresh_token_interceptor.dart';
import 'package:flutter_bloc_starter_project/core/modules/token_manager/secure_token_manager.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:sentry_dio/sentry_dio.dart';

import '../../utils/constants.dart';
import '../../utils/methods/aliases.dart';
import 'interceptors/api_error_interceptor.dart';
import 'interceptors/bad_network_error_interceptor.dart';
import 'interceptors/internal_server_error_interceptor.dart';
import 'interceptors/unauthorized_interceptor.dart';

Dio initDioClient(
  InternetConnection networkInfo,
  SecureTokenManager secureTokenManager,
) {
  final dio = Dio();

  if (Platform.isAndroid || Platform.isIOS) {
    /// Allows https requests for older devices.
    (dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () {
      return HttpClient()
        ..badCertificateCallback =
            (X509Certificate cert, String host, int port) {
              return true;
            };
    };
  }

  dio.options.baseUrl = env.restApiUrl;
  dio.options.headers['Accept-Language'] = kIsWeb
      ? 'en-US'
      : Platform.localeName.substring(0, 2);
  dio.options.connectTimeout = constants.api.timeOutDuration;
  dio.options.receiveTimeout = constants.api.timeOutDuration;
  dio.interceptors.add(BadNetworkErrorInterceptor(networkInfo));
  dio.interceptors.add(AccessTokenInterceptor(secureTokenManager.manager));
  dio.interceptors.add(RefreshTokenInterceptor(secureTokenManager));
  dio.interceptors.add(InternalServerErrorInterceptor());
  dio.interceptors.add(UnauthorizedInterceptor());
  dio.interceptors.add(ApiErrorInterceptor());

  dio.addSentry();

  if (env.debugApiClient) {
    dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
        maxWidth: constants.debug.maxLogLines,
      ),
    );
  }

  return dio;
}
