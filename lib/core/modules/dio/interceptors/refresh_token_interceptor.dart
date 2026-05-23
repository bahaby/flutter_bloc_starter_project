import 'package:dio/dio.dart';
import 'package:dio_refresh/dio_refresh.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc_starter_project/core/modules/token_manager/secure_token_manager.dart';
import 'package:flutter_bloc_starter_project/core/utils/helpers/jwt_helper.dart';
import 'package:flutter_bloc_starter_project/core/utils/methods/aliases.dart';

class RefreshTokenInterceptor extends DioRefreshInterceptor {
  RefreshTokenInterceptor(SecureTokenManager tokenManager)
    : super(
        tokenManager: tokenManager.manager,
        authHeader: (tokenStore) {
          if (tokenStore.accessToken == null) {
            return {};
          }
          return {'Authorization': 'Bearer ${tokenStore.accessToken}'};
        },
        shouldRefresh: (response) =>
            _shouldRefresh(response, tokenManager.manager),
        onRefresh: (dio, tokenStore) async {
          final response = await dio.post(
            '${env.restApiUrl}auth/refresh',
            data: {
              'expiresInMins': 1440,
              'refreshToken': tokenStore.refreshToken,
            },
          );
          final newTokens = TokenStore(
            accessToken: response.data['accessToken'],
            refreshToken: response.data['refreshToken'],
          );
          // Persist the new tokens securely and update the in-memory token manager
          await tokenManager.persistAndSetToken(newTokens);
          return newTokens;
        },
        onRefreshFailedCallback: (error) {
          throw ErrorDescription('Token refresh failed: $error');
        },
      );

  static bool _shouldRefresh(Response? response, TokenManager tokenManager) {
    final isAccessTokenShouldBeRefreshed = JwtHelper.isTokenExpiring(
      tokenManager.accessToken,
      //TODO: This should be 1 min or less. This is for dummyjson api to simulate refresh token
      durationOffset: const Duration(minutes: 1439),
    );
    return isAccessTokenShouldBeRefreshed || response?.statusCode == 401;
  }
}
