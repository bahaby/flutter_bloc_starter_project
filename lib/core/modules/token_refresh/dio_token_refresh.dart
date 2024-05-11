import 'dart:convert';

import 'package:dio/dio.dart';
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
      shouldRefresh: (response) {
        return _isAccessTokenShoudBeRefreshed(currentAccessToken) ||
            response?.statusCode == 401;
      },
      tokenHeader: (token) {
        currentAccessToken = token.accessToken;
        return {'Authorization': '${token.tokenType} ${token.accessToken}'};
      },
    );
  }
  var currentAccessToken = '';
  final TokenStorage<AuthModel> _secureStorage;
  final HiveStorage _hiveStorage;
  late final Fresh<AuthModel> _fresh;

  Fresh<AuthModel> get fresh => _fresh;

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

  bool _isAccessTokenShoudBeRefreshed(String accessToken) {
    try {
      final parts = accessToken.split('.');
      if (parts.length != 3) {
        return true;
      }

      final payload = json.decode(
        utf8.decode(
          base64Url.decode(
            base64Url.normalize(parts[1]),
          ),
        ),
      );

      final exp = payload['exp'];
      if (exp == null) return true;

      ///TODO: This should be 1 min or less. This is for dummyjson api to simulate refresh token
      const durationOffset = 1439;
      final nowPlus =
          DateTime.now().add(const Duration(minutes: durationOffset));

      return DateTime.fromMillisecondsSinceEpoch(exp * 1000).isBefore(nowPlus);
    } catch (e) {
      return true;
    }
  }
}
