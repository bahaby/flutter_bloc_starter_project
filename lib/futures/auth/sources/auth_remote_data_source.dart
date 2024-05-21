import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_bloc_starter_project/core/exception/dio_exceptions.dart';
import 'package:injectable/injectable.dart';

import '../../../core/exception/exception_handler.dart';
import '../../app/models/auth_model.dart';
import '../../app/models/user_model.dart';

abstract interface class AuthRemoteDataSource {
  Future<AuthModel> login({
    required String email,
    required String password,
  });
  Future<UserModel> getLoggedUser();
}

@LazySingleton(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  static const String _loginPath = 'auth/login';
  static const String _userPath = 'auth/me';

  final Dio _client;
  AuthRemoteDataSourceImpl({required Dio client}) : _client = client;

  @override
  Future<AuthModel> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _client.post(
        _loginPath,
        data: {
          'username': email,
          'password': password,
          'expiresInMins': 1440,
        },
      );

      final auth = AuthModel(
        tokenType: 'Bearer',
        accessToken: response.data['token'] ?? '',
        refreshToken: response.data['token'] ?? '',
        user: UserModel.initial(),
      );

      return auth;
    } on ApiMessageException catch (e) {
      // this is for example only, you can handle api errors in interceptors
      // I'm simulating error code response
      if (e.errorMessage == 'Invalid credentials') {
        throw ApiCodeException(
            code: "100001", requestOptions: e.requestOptions);
      }
      rethrow;
    }
  }

  @override
  Future<UserModel> getLoggedUser() async {
    final response = await _client.get(_userPath);

    final user = fromJsonHandler(
      () => UserModel.fromJson(response.data),
      payload: response.data,
    );

    return user;
  }
}
