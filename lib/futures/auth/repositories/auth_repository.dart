import 'dart:async';

import 'package:dio_refresh/dio_refresh.dart';
import 'package:flutter_bloc_starter_project/core/modules/token_manager/secure_token_manager.dart';
import 'package:flutter_bloc_starter_project/core/utils/helpers/jwt_helper.dart';

import '../../app/models/alert_model.dart';
import '../../app/models/auth_model.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../../../core/exception/exception_handler.dart';
import '../data_sources/auth_remote_data_source.dart';

enum AuthStatus { initial, authenticated, unauthenticated }

abstract interface class AuthRepository {
  Future<Either<AlertModel, AuthModel>> login({
    required String email,
    required String password,
  });
  void initializeAuthStatus();
  Future<Either<AlertModel, AuthModel>> getUser();

  Stream<AuthModel?> get loggedUser;
  Stream<AuthStatus> get authStatus;

  Future<Either<AlertModel, void>> logout();
  void setLoggedUser({required AuthModel? user});
}

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _authRemoteDataSource;
  final SecureTokenManager _tokenManager;

  AuthRepositoryImpl({
    required this._authRemoteDataSource,
    required this._tokenManager,
  });

  final _loggedUserController = StreamController<AuthModel?>.broadcast();
  final _authStatusController = StreamController<AuthStatus>.broadcast();

  @override
  Stream<AuthModel?> get loggedUser {
    return _loggedUserController.stream;
  }

  @override
  Stream<AuthStatus> get authStatus => _authStatusController.stream;

  @override
  Future<Either<AlertModel, AuthModel>> login({
    required String email,
    required String password,
  }) {
    return exceptionHandler(() async {
      final result = await _authRemoteDataSource.login(
        email: email,
        password: password,
      );
      _onAuthSuccess(result);
      return right(result);
    });
  }

  @override
  Future<Either<AlertModel, void>> logout() async {
    return exceptionHandler(() async {
      var result = await _authRemoteDataSource.logout();
      setLoggedUser(user: null);
      await _tokenManager.clearToken();
      return right(result);
    });
  }

  @override
  void setLoggedUser({required AuthModel? user}) {
    _loggedUserController.add(user);
    _authStatusController.add(
      user != null ? AuthStatus.authenticated : AuthStatus.unauthenticated,
    );
  }

  @override
  Future<Either<AlertModel, AuthModel>> getUser() async {
    return exceptionHandler(() async {
      final user = await _loggedUserController.stream.first;
      if (user != null) {
        return right(user);
      }

      final result = await _authRemoteDataSource.getLoggedUser();
      return right(result);
    });
  }

  @override
  Future<void> initializeAuthStatus() async {
    final accessToken = _tokenManager.accessToken;
    final refreshToken = _tokenManager.refreshToken;

    if (accessToken == null || refreshToken == null) {
      _authStatusController.add(AuthStatus.unauthenticated);
      return;
    }

    final isRefreshTokenExpiring = JwtHelper.isTokenExpiring(refreshToken);
    if (isRefreshTokenExpiring) {
      await _tokenManager.clearToken(); // Clear corrupted/stale state
      _authStatusController.add(AuthStatus.unauthenticated);
      return;
    }

    final user = await _authRemoteDataSource.getLoggedUser();
    setLoggedUser(user: user);
    _authStatusController.add(AuthStatus.authenticated);
  }

  Future<void> _onAuthSuccess(AuthModel auth) async {
    _tokenManager.persistAndSetToken(
      TokenStore(
        accessToken: auth.accessToken,
        refreshToken: auth.refreshToken,
      ),
    );
    setLoggedUser(user: auth);
  }
}
