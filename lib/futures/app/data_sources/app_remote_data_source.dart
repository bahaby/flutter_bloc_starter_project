import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_bloc_starter_project/core/exception/exceptions.dart';
import 'package:flutter_bloc_starter_project/core/generated/translations.g.dart';
import 'package:injectable/injectable.dart';

abstract interface class AppRemoteDataSource {
  Future<void> logout();
  Future<Map<String, dynamic>> translateOverrides(AppLocale locale);
}

@LazySingleton(as: AppRemoteDataSource)
class AppRemoteDataSourceImpl implements AppRemoteDataSource {
  static const String _logoutPath = 'auth/logout';
  static const String _translateOverridesPath = 'translations/overrides';

  final Dio _client;
  AppRemoteDataSourceImpl({required Dio client}) : _client = client;

  @override
  Future<void> logout() async {
    // var result = await _client.post(_logoutPath);
    return Future.value(null);
  }

  // map format should be like this: { "auth": { "login_button": "Login" } } check jsons in the localization folder
  @override
  Future<Map<String, dynamic>> translateOverrides(AppLocale locale) async {
    var response =
        await _client.get('$_translateOverridesPath/${locale.languageCode}');
    try {
      return json.decode(response.data);
    } catch (_) {
      throw JsonSerializationException(
          type: JsonSerializationExceptionType.invalidJson);
    }
  }
}
