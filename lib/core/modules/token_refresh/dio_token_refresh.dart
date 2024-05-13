import 'package:dio/dio.dart';
import 'package:flutter_bloc_starter_project/core/utils/helpers/jwt_helper.dart';
import '../hive_storage/hive_storage.dart';
import '../../utils/methods/aliases.dart';
import 'package:fresh_dio/fresh_dio.dart';
import 'package:injectable/injectable.dart';

import '../../../futures/app/models/auth_model.dart';

@singleton
class DioTokenRefresh {
  DioTokenRefresh(
    this._secureStorage,
    this._hiveStorage,
  ) {
    _fresh = Fresh<AuthModel>(
      tokenStorage: _secureStorage,
      refreshToken: _refreshToken,
      shouldRefresh: _shouldRefresh,
      tokenHeader: (token) {
        currentAccessToken = token.accessToken;
        return {'Authorization': '${token.tokenType} ${token.accessToken}'};
      },
    );
  }
  String? currentAccessToken;
  final TokenStorage<AuthModel> _secureStorage;
  final HiveStorage _hiveStorage;
  late final Fresh<AuthModel> _fresh;

  Fresh<AuthModel> get fresh => _fresh;

  bool _shouldRefresh(Response? response) {
    final isAccessTokenShouldBeRefreshed = JwtHelper.isTokenExpiring(
      currentAccessToken,
      //TODO: This should be 1 min or less. This is for dummyjson api to simulate refresh token
      durationOffset: const Duration(minutes: 1439),
    );
    return isAccessTokenShouldBeRefreshed || response?.statusCode == 401;
  }

  Future<AuthModel> _refreshToken(AuthModel? token, Dio client) async {
    if (token == null) {
      throw RevokeTokenException();
    }
    //TODO: Implement refresh token for your api
    try {
      final response = await client.post(
        '${env.restApiUrl}auth/refresh',
        data: {'expiresInMins': 1440},
        options: Options(
          headers: {
            'Authorization': '${token.tokenType} ${token.refreshToken}',
          },
        ),
      );

      final newToken = AuthModel(
        accessToken: response.data['token'],
        refreshToken: response.data['token'],
        tokenType: 'Bearer',
        user: token.user,
      );

      return newToken;
    } catch (e) {
      _fresh.clearToken();
      _hiveStorage.clearAll();
      throw RevokeTokenException();
    }
  }
}
