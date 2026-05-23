import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_bloc_starter_project/core/exception/dio_exceptions.dart';
import 'package:injectable/injectable.dart';

import '../../../core/exception/exception_handler.dart';
import '../../app/models/auth_model.dart';

abstract interface class AuthRemoteDataSource {
  Future<AuthModel> login({required String email, required String password});
  Future<void> logout();
  Future<AuthModel> getLoggedUser();
}

@LazySingleton(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  static const String _loginPath = 'auth/login';
  static const String _logoutPath = 'auth/logout';
  static const String _userPath = 'auth/me';

  final Dio _client;
  AuthRemoteDataSourceImpl({required this._client});

  @override
  Future<AuthModel> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _client.post(
        _loginPath,
        data: {'username': email, 'password': password, 'expiresInMins': 1440},
      );

      final auth = AuthModel(
        tokenType: 'Bearer',
        accessToken: response.data['accessToken'] ?? '',
        refreshToken: response.data['refreshToken'] ?? '',
        id: response.data['id'] ?? 0,
        username: response.data['username'] ?? '',
        email: response.data['email'] ?? '',
        image: response.data['image'] ?? '',
      );

      return auth;
    } on ApiMessageException catch (e) {
      // this is for example only, you can handle api errors in interceptors
      // I'm simulating error code response
      if (e.errorMessage == 'Invalid credentials') {
        throw ApiCodeException(
          code: "100001",
          requestOptions: e.requestOptions,
        );
      }
      rethrow;
    }
  }

  @override
  Future<void> logout() async {
    // var result = await _client.post(_logoutPath);
    return Future.value(null);
  }

  @override
  Future<AuthModel> getLoggedUser() async {
    final response = await _client.get(_userPath);

    final user = fromJsonHandler(
      () => AuthModel.fromJson(response.data),
      payload: response.data,
    );

    return user;
  }
}
