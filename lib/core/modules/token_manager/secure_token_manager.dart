import 'package:dio_refresh/dio_refresh.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class SecureTokenManager {
  SecureTokenManager(this._manager, this._storage);
  final TokenManager _manager;
  final FlutterSecureStorage _storage;

  static const _accessTokenKey = 'auth_access_token';
  static const _refreshTokenKey = 'auth_refresh_token';

  String? get accessToken => _manager.accessToken;
  String? get refreshToken => _manager.refreshToken;
  TokenManager get manager => _manager;

  @preResolve
  @factoryMethod
  static Future<SecureTokenManager> create(
    TokenManager manager,
    FlutterSecureStorage storage,
  ) async {
    final tokenManager = SecureTokenManager(manager, storage);
    await tokenManager._initialize();
    return tokenManager;
  }

  /// Internal method to load stored tokens into memory on startup
  Future<void> _initialize() async {
    final access = await _storage.read(key: _accessTokenKey);
    final refresh = await _storage.read(key: _refreshTokenKey);

    if (access != null && refresh != null) {
      _manager.setToken(TokenStore(accessToken: access, refreshToken: refresh));
    }
  }

  Future<void> persistAndSetToken(TokenStore tokenStore) async {
    await _storage.write(key: _accessTokenKey, value: tokenStore.accessToken);
    await _storage.write(key: _refreshTokenKey, value: tokenStore.refreshToken);
    _manager.setToken(tokenStore);
  }

  Future<void> clearToken() async {
    await _storage.delete(key: _accessTokenKey);
    await _storage.delete(key: _refreshTokenKey);
    _manager.setToken(TokenStore(accessToken: null, refreshToken: null));
  }
}
