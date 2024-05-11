import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../exception/exception_handler.dart';
import 'package:fresh_dio/fresh_dio.dart';
import 'package:injectable/injectable.dart';

import '../../../futures/app/models/auth_model.dart';

@LazySingleton(as: TokenStorage)
class SecureAuthStorage extends TokenStorage<AuthModel> {
  SecureAuthStorage(this._secureStorage);

  final FlutterSecureStorage _secureStorage;
  static const String _key = 'auth_storage';

  @override
  Future<void> delete() async {
    await _secureStorage.delete(key: _key);
  }

  @override
  Future<AuthModel?> read() async {
    final auth = await _secureStorage.read(key: _key);

    if (auth != null) {
      return fromJsonHandler(
        () => AuthModel.fromJson(jsonDecode(auth) as Map<String, dynamic>),
        payload: auth,
      );
    }

    return null;
  }

  @override
  Future<void> write(AuthModel token) async {
    await _secureStorage.write(key: _key, value: jsonEncode(token.toJson()));
  }
}
